//
//  StatusesModel.m
//  SinaTest
//
//  Created by 于苗 on 16/4/22.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import "StatusesModel.h"
#import "UserModel.h"
#import "GDataXMLNode.h"
@implementation StatusesModel

-(void)dealloc{
    self.text=nil;
    self.userObj=nil;
    self.sourceObj=nil;
    self.idStr=nil;
    [super dealloc];
}

-(instancetype)initWithStatuseDic:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.text = dic[@"text"];
        self.idStr = dic[@"idstr"];
        NSDictionary *userDic = dic[@"user"];
        self.userObj = [UserModel createUserModelWithDic:userDic];
        self.sourceObj = [SourceModel createSourceWithString:dic[@"source"]];
        
    }
    return self;
}
+(instancetype)createStatuseDic:(NSDictionary *)dic{
    
    return [[[self alloc]initWithStatuseDic:dic] autorelease];
}

@end
@implementation SourceModel
-(void)dealloc{
    self.sourceString=nil;
    self.href=nil;
    [super dealloc];
}
-(instancetype)initWithSourceString:(NSString *)source{
    
    self = [super init];
    if (self) {
        
        GDataXMLDocument *doc = [[GDataXMLDocument alloc]initWithHTMLString:source error:nil];
//        这个方法是查询名字叫xx的所有节点，第一个参数是你要查询的某个节点的名字
        NSArray *array = [doc nodesForXPath:@"//a" error:nil];
        GDataXMLElement *ele = [array objectAtIndex:0];
        self.sourceString = [ele stringValue];
//        这个方法的作用是根据属性的名字去拿这个属性的值
        GDataXMLNode *node = [ele attributeForName:@"href"];
        self.href = [node stringValue];
        [doc release];
        
    }
    
    return self;
}
+(instancetype)createSourceWithString:(NSString *)source{
    return [[[self alloc]initWithSourceString:source] autorelease];
}
@end








