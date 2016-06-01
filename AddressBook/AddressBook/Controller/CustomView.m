//
//  CustomView.m
//  AddressBook
//
//  Created by Twinkleo on 16/4/11.
//  Copyright © 2016年 Twinkleo. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        UIView * view = [[UIView alloc]init];
        view.frame =CGRectMake(0, 0, frame.size.width, frame.size.height);
        view.hidden = NO;
        view.backgroundColor = [UIColor grayColor];
        [self addSubview:view];
        
        UIImageView * image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"3输入框@2x.png"];
        image.frame = CGRectMake(20, 20, 300, 300);
        [self addSubview:image];
        
       _tf1 = [[UITextField alloc]init];
        _tf1.placeholder = @"姓名必填";
        _tf1.frame = CGRectMake(20, 20, 100, 100);
        [self addSubview:_tf1];
        
        _tf2 = [[UITextField alloc]init];
        _tf2.placeholder = @"姓名必填";
        _tf2.frame = CGRectMake(20, 120, 100, 100);
        [self addSubview:_tf2];
        
        
    }

    return self;
}
@end
