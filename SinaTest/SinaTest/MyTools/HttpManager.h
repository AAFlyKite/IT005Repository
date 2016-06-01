//
//  HttpManager.h
//  SinaTest
//
//  Created by 于苗 on 16/4/22.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HttpManager : NSObject

//返回一个授权页面的URL
+(NSURL *)getLoginURL;
//这个方法是获取token
+(void)getTokenByCode:(NSString *)codeStr withCompleteBlock:(void(^)(BOOL succse))myBlock;
//获取用户及其好友发的微博信息
+(void)getFriendInfo:(void(^)(NSArray *array))myBlock withSinceID:(NSString *)idStr;

//发送一条微博
+(void)sendSinaInfo:(void(^)(BOOL success))myBlock withContent:(NSString *)content;
//发送带图片的微博
+(void)sendSinaImage:(UIImage *)image withContent:(NSString *)content withBlock:(void(^)(BOOL success))myBlock;





@end
