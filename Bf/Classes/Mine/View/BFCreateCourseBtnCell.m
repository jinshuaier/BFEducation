//
//  BFCreateCourseBtnCell.m
//  Bf
//
//  Created by 春晓 on 2018/5/23.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCreateCourseBtnCell.h"

@interface BFCreateCourseBtnCell ()
// 提交按钮
@property (nonatomic , strong) UIButton *commitBtn;
// 取消
@property (nonatomic , strong) UIButton *cancelBtn;
@end

@implementation BFCreateCourseBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    _commitBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_commitBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [_commitBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    _commitBtn.backgroundColor = RGBColor(51, 150, 252);
    _commitBtn.layer.masksToBounds = YES;
    _commitBtn.layer.cornerRadius = 4.0f;
    [_commitBtn addTarget:self action:@selector(commitBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_commitBtn];
    
    _cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [_cancelBtn setTitleColor:RGBColor(51, 51, 51) forState:(UIControlStateNormal)];
    _cancelBtn.backgroundColor = RGBColor(211, 210, 210);
    _cancelBtn.layer.masksToBounds = YES;
    _cancelBtn.layer.cornerRadius = 4.0f;
    [_cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_cancelBtn];
    
    _commitBtn.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 40)
    .bottomSpaceToView(self.contentView, 10)
    .widthIs(KScreenW / 2.0 - 15);
    
    _cancelBtn.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 40)
    .bottomSpaceToView(self.contentView, 10)
    .widthIs(KScreenW / 2.0 - 15);
}

#pragma mark -按钮点击事件-
- (void)commitBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(commitAction)]) {
        [_delegate commitAction];
    }
}

- (void)cancelBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(cancelAction)]) {
        [_delegate cancelAction];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
