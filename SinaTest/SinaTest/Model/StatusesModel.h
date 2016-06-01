//
//  StatusesModel.h
//  SinaTest
//
//  Created by 于苗 on 16/4/22.
//  Copyright © 2016年 yumiao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UserModel;
@class SourceModel;
@interface StatusesModel : NSObject

@property (nonatomic,copy)NSString *text;
@property (nonatomic,retain)UserModel *userObj;
@property (nonatomic,retain)SourceModel *sourceObj;
@property (nonatomic,copy)NSString *idStr;
-(instancetype)initWithStatuseDic:(NSDictionary *)dic;
+(instancetype)createStatuseDic:(NSDictionary *)dic;


@end

@interface SourceModel : NSObject
@property (nonatomic,copy)NSString *href;
@property (nonatomic,copy)NSString *sourceString;


-(instancetype)initWithSourceString:(NSString *)source;
+(instancetype)createSourceWithString:(NSString *)source;
@end









