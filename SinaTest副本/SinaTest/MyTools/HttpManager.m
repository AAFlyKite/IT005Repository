//
//  HttpManager.m
//  SinaTest
//
//  Created by 于苗 on 16/4/22.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import "HttpManager.h"
#import "AFNetworking.h"
#import "StatusesModel.h"

#define CLIENT_ID @"client_id"
#define APPKEY @"2522813206"
//这个回调的那个参数名
#define REDICT_URI @"redirect_uri"
#define REDICT_URI_VAULES @"http://www.baidu.com"
#define CLIENT_SECRET @"client_secret"
#define APPSECRET @"0a6f3b420524c0f2d7055113c37759b6"


@implementation HttpManager

//返回一个授权页面的URL
+(NSURL *)getLoginURL{
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?%@=%@&%@=%@&display=mobile",CLIENT_ID,APPKEY,REDICT_URI,REDICT_URI_VAULES]];
    return url;
}
+(void)getTokenByCode:(NSString *)codeStr withCompleteBlock:(void(^)(BOOL succse))myBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", nil];
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:@{CLIENT_ID:APPKEY,CLIENT_SECRET:APPSECRET,@"grant_type":@"authorization_code",@"code":codeStr,REDICT_URI:REDICT_URI_VAULES} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        成功的时候进行解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *token = dic[@"access_token"];
        NSString *time = dic[@"expires_in"];
        NSString *uid = dic[@"uid"];
//        这个方法就是从当前的这个时间算起在加上一个秒数得到的日期就是你token过期的那个日期
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:[time integerValue]];
        [[NSUserDefaults standardUserDefaults]setObject:date forKey:@"timeOut"];
        [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"token"];
        [[NSUserDefaults standardUserDefaults]setObject:uid forKey:@"uid"];
        BOOL b = [[NSUserDefaults standardUserDefaults]synchronize];
        if (myBlock) {
            
            myBlock(b);
        }
        
        
        NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (myBlock) {
            myBlock(NO);
        }
        NSLog(@"====>>>%@",error);
    }];
    
    
}
+(void)getFriendInfo:(void(^)(NSArray *array))myBlock withSinceID:(NSString *)idStr{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json", nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:@{@"access_token":token,@"since_id":idStr} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
       // NSLog(@"----")
        NSArray *statusesArray = dic[@"statuses"];
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *tempDic in statusesArray)
        {
            StatusesModel *obj = [StatusesModel createStatuseDic:tempDic];
            [dataArray addObject:obj];
        }
        if (myBlock) {
            myBlock(dataArray);
        }
        NSLog(@"----->>%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        myBlock(nil);
        NSLog(@"----->>>%@",error);
    }];
    
}
//发送一条微博
+(void)sendSinaInfo:(void(^)(BOOL success))myBlock withContent:(NSString *)content {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
//   [content stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//     [content stringByReplacingPercentEscapesUsingEncoding:<#(NSStringEncoding)#>];
//    这个初始化是直接初始化一个对象并对URL进行编码
    /*NSCharacterSet *character = [NSCharacterSet URLFragmentAllowedCharacterSet];
    [content stringByAddingPercentEncodingWithAllowedCharacters:character];*/
    
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:@{@"access_token":token,@"status":content} success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        调用这个block块只能说明服务器响应了具体的这个借口有没有调成功还要看返回值
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic) {
            
            if (myBlock) {
                myBlock(YES);
            }
        }
        else{
            if (myBlock) {
                myBlock(NO);
            }
        }
        //NSLog(@"=====>>%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if (myBlock) {
            myBlock(NO);
        }
        NSLog(@"=失败====>>>%@",error);
    }];
    
}
+(void)sendSinaImage:(UIImage *)image withContent:(NSString *)content withBlock:(void(^)(BOOL success))myBlock{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    NSString *token = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
//    这个是发送带图片的请求
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:@{@"access_token":token,@"status":content} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image, 0.1);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"pic" mimeType:@"jpg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (dic) {
            if (myBlock) {
                myBlock(YES);
            }
        }
        else{
            
            if (myBlock) {
                myBlock(NO);
            }
            
        }
        
       // NSLog(@"===>>%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        if (myBlock) {
            myBlock(NO);
        }
        NSLog(@"=====>>%@",error);
    }];
    
}



@end
