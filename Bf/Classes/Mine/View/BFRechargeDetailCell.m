//
//  BFRechargeDetailCell.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFRechargeDetailCell.h"

@implementation BFRechargeDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.accountStyle];
        [self addSubview:self.accountLeft];
        [self addSubview:self.accountTime];
        [self addSubview:self.accountPer];
        [self addSubview:self.line];
    }
    return self;
}

-(void)layoutSubviews {
    self.accountStyle.frame = CGRectMake(14, 0, 80, 40);
    self.accountLeft.frame = CGRectMake(14, self.accountStyle.bottom - 10, 200, 40);
    self.accountTime.frame = CGRectMake(KScreenW - 14 - 150, 0, 150, 40);
    self.accountPer.frame = CGRectMake(KScreenW - 14 - 100, self.accountTime.bottom - 10, 100, 40);
    self.line.frame = CGRectMake(14, self.accountLeft.bottom, KScreenW - 28, 0.50f);
}

-(UILabel *)accountStyle {
    if (_accountStyle == nil) {
        _accountStyle = [[UILabel alloc] init];
        _accountStyle.text = @"支出";
        _accountStyle.textColor = [UIColor blackColor];
        _accountStyle.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _accountStyle;
}

-(UILabel *)accountLeft {
    if (_accountLeft == nil) {
        _accountLeft = [[UILabel alloc] init];
        _accountLeft.text = @"余额:2000";
        _accountLeft.textColor = [UIColor blackColor];
        _accountLeft.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _accountLeft;
}

-(UILabel *)accountTime {
    if (_accountTime == nil) {
        _accountTime = [[UILabel alloc] init];
        _accountTime.text = @"2017-12-01";
        _accountTime.textColor = [UIColor grayColor];
        _accountTime.textAlignment = NSTextAlignmentRight;
        _accountTime.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _accountTime;
}

-(UILabel *)accountPer {
    if (_accountPer == nil) {
        _accountPer = [[UILabel alloc] init];
        _accountPer.text = @"-500.00";
        _accountPer.textColor = [UIColor blackColor];
        _accountPer.textAlignment = NSTextAlignmentRight;
        _accountPer.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _accountPer;
}

-(UIView *)line {
    if (_line == nil) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    return _line;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
