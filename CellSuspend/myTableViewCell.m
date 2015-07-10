//
//  myTableViewCell.m
//  CellSuspend
//
//  Created by liudonghuan on 15/7/9.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import "myTableViewCell.h"

@implementation myTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self addSubview:_title];
    }
    return self;
}


@end
