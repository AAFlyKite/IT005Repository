//
//  UserModel.m
//  SinaTest
//
//  Created by 于苗 on 16/4/22.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(void)dealloc{
    self.name=nil;
    self.profile_image_url=nil;
    [super dealloc];
}

-(id)initUserDic:(NSDictionary *)dic{
    
    self = [super init];
    if (self) {
       
        self.name = dic[@"name"];
        self.profile_image_url = dic[@"profile_image_url"];
    }
    return self;
}

+(id)createUserModelWithDic:(NSDictionary *)dic{
    
    return [[[self alloc]initUserDic:dic] autorelease];
}
@end
