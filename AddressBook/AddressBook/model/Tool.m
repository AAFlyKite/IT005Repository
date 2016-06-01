//
//  Tool.m
//  AddressBook
//
//  Created by Twinkleo on 16/4/11.
//  Copyright © 2016年 Twinkleo. All rights reserved.
//

#import "Tool.h"
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "PeopleModel.h"
static FMDatabase * _db;
@implementation Tool

+ (void)creatPeople{

    NSString * path =[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/people.sqlite"];
    
    _db = [[FMDatabase databaseWithPath:path]retain];
    
    NSString * creatStr = [NSString stringWithFormat:@"create table people (name text,phone integer)"];
    if ([_db open]) {
        
    
    [_db executeUpdate:creatStr];
        [_db close];
}
}

+ (NSMutableArray *)selectPeople{

    NSMutableArray * arr = @[].mutableCopy;
    NSString * selectStr = @"select * from people";
    [_db open];
    FMResultSet * set = [_db executeQuery:selectStr];
    
    while ([set next]) {
        PeopleModel * model = [[PeopleModel alloc]init];
        model.name = [set stringForColumn:@"name"];
        model.phone = [set intForColumn:@"phone"];
        [arr addObject:model];
        [model release];
    }
    
    [_db close];
    [set close];
    
    
    return arr;


}

+ (void)insertIntoPeopleWithData:(PeopleModel *)model{
    
    

    [_db open];
    NSString * str = [NSString stringWithFormat:@"insert into people (name,text)values('%@',%ld)",model.name,model.phone];
     NSLog(@"------%@",model.name);
       [_db executeUpdate:str];
    if ( [_db executeUpdate:str]) {
          NSLog(@"---%@",model.name);
    }
    
    [_db close];

}
@end
