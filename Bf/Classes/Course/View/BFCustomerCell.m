//
//  BFCustomerCell.m
//  Bf
//
//  Created by 春晓 on 2018/1/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCustomerCell.h"

@implementation BFCustomerCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _headerImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(2.5f, 2.5f, 25, 25)];
        _headerImageView.clipsToBounds = YES;
        _headerImageView.layer.cornerRadius = _headerImageView.width / 2.0f;
        [self.contentView addSubview:_headerImageView];
    }
    return self;
}
@end
