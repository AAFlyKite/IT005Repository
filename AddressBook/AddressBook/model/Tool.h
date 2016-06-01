//
//  Tool.h
//  AddressBook
//
//  Created by Twinkleo on 16/4/11.
//  Copyright © 2016年 Twinkleo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PeopleModel.h"

@interface Tool : NSObject

+ (void)creatPeople;

+ (NSMutableArray *)selectPeople;

+ (void)insertIntoPeopleWithData:(PeopleModel *)model;

@end
