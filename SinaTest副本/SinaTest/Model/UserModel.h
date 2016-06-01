//
//  UserModel.h
//  SinaTest
//
//  Created by 于苗 on 16/4/22.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject


@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *profile_image_url;

-(id)initUserDic:(NSDictionary *)dic;

+(id)createUserModelWithDic:(NSDictionary *)dic;

@end
