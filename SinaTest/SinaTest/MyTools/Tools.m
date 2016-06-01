//
//  Tools.m
//  SinaTest
//
//  Created by 于苗 on 16/4/22.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(BOOL)isNeedLogin{
    
    NSString *tokenStr = [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    NSDate *timeDate = [[NSUserDefaults standardUserDefaults]objectForKey:@"timeOut"];
    NSDate *nowDate = [NSDate date];
//    compare这个方法是比较两个时间是否相等或大于或小于
    if(NSOrderedAscending==[nowDate compare:timeDate]&&tokenStr){
        return NO;
    }
    return YES;
    
    
    
}







@end
