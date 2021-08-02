//
//  BFTopRechangeCell.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFTopRechangeCell.h"
///*用户名*/
//@property (nonatomic,strong) UILabel *userNameLabel;
///*用户名输入框*/
//@property (nonatomic,strong) UITextField *userNameField;
///*昵称*/
//@property (nonatomic,strong) UILabel *nickNameLabel;
///*昵称输入框*/
//@property (nonatomic,strong) UITextField *nickNameField;
///*当前余额*/
//@property (nonatomic,strong) UILabel *accountLabel;
///*当前余额输入框*/
//@property (nonatomic,strong) UITextField *accountField;
@implementation BFTopRechangeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.userNameLabel];
        [self addSubview:self.userNameField];
        [self addSubview:self.nickNameLabel];
        [self addSubview:self.nickNameField];
        [self addSubview:self.accountLabel];
        [self addSubview:self.accountField];
    }
    return self;
}

-(void)layoutSubviews {
    self.userNameLabel.frame = CGRectMake(20, 0, 60, 30);
    self.userNameField.frame = CGRectMake(self.userNameLabel.right + 5, 0, KScreenW - 20 - 60 - 5, 30);
    self.nickNameLabel.frame = CGRectMake(20, self.userNameLabel.bottom, 60, 30);
    self.nickNameField.frame = CGRectMake(self.nickNameLabel.right + 5, self.userNameLabel.bottom, KScreenW - 20 - 60 - 5, 30);
    self.accountLabel.frame = CGRectMake(20, self.nickNameLabel.bottom, 60, 30);
    self.accountField.frame = CGRectMake(self.accountLabel.right + 5, self.nickNameLabel.bottom,  KScreenW - 20 - 60 - 5, 30);
}

-(UILabel *)userNameLabel {
    if (_userNameLabel == nil) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.text = @"用户名 : ";
        _userNameLabel.textColor = [UIColor blackColor];
        _userNameLabel.font = [UIFont fontWithName:BFfont size:13.0f];
        _userNameLabel.backgroundColor = [UIColor clearColor];
    }
    return _userNameLabel;
}

-(UITextField *)userNameField {
    if (_userNameField == nil) {
        _userNameField = [[UITextField alloc] init];
        _userNameField.text = @"13161066631";
        _userNameField.textColor = [UIColor grayColor];
        _userNameField.font = [UIFont fontWithName:BFfont size:13.0f];
        _userNameField.backgroundColor = [UIColor clearColor];
    }
    return _userNameField;
}

-(UILabel *)nickNameLabel {
    if (_nickNameLabel == nil) {
        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.text = @"昵称 : ";
        _nickNameLabel.textColor = [UIColor blackColor];
        _nickNameLabel.font = [UIFont fontWithName:BFfont size:13.0f];
        _nickNameLabel.backgroundColor = [UIColor clearColor];
    }
    return _nickNameLabel;
}

-(UITextField *)nickNameField {
    if (_nickNameField == nil) {
        _nickNameField = [[UITextField alloc] init];
        _nickNameField.text = @"寒风中de老腊肉";
        _nickNameField.textColor = [UIColor grayColor];
        _nickNameField.font = [UIFont fontWithName:BFfont size:13.0f];
        _nickNameField.backgroundColor = [UIColor clearColor];
    }
    return _nickNameField;
}

-(UILabel *)accountLabel {
    if (_accountLabel == nil) {
        _accountLabel = [[UILabel alloc] init];
        _accountLabel.text = @"当前余额 : ";
        _accountLabel.textColor = [UIColor blackColor];
        _accountLabel.font = [UIFont fontWithName:BFfont size:13.0f];
        _accountLabel.backgroundColor = [UIColor clearColor];
    }
    return _accountLabel;
}

-(UITextField *)accountField {
    if (_accountField == nil) {
        _accountField = [[UITextField alloc] init];
        _accountField.text = @"8000 (学分)";
        _accountField.textColor = [UIColor grayColor];
        _accountField.font = [UIFont fontWithName:BFfont size:13.0f];
        _accountField.backgroundColor = [UIColor clearColor];
    }
    return _accountField;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
