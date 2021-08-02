//
//  BFTagEditCell.m
//  Bf
//
//  Created by 春晓 on 2018/5/31.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFTagEditCell.h"

@interface BFTagEditCell()
// bgLabel
@property (nonatomic , strong) UILabel *bgLabel;
// btn
@property (nonatomic , strong) UIButton *delBtn;
@end

@implementation BFTagEditCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _bgLabel = [[UILabel alloc] init];
    _bgLabel.backgroundColor = RGBColor(240, 240, 240);
    [self.contentView addSubview:_bgLabel];
    _bgLabel.text = @"#添加标签#";
    _bgLabel.textColor = RGBColor(153, 153, 153);
    _bgLabel.font = [UIFont systemFontOfSize:12];
    _bgLabel.layer.masksToBounds = YES;
    _bgLabel.layer.cornerRadius = 3;
    _bgLabel.layer.borderWidth = 1.0;
    _bgLabel.textAlignment = NSTextAlignmentCenter;
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.backgroundColor = [UIColor whiteColor];
    _tagLabel.textColor = RGBColor(51, 150, 252);
    [self.contentView addSubview:_tagLabel];
    _tagLabel.font = [UIFont systemFontOfSize:12];
    _tagLabel.text = @"";
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    
    _delBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_delBtn setImage:[UIImage imageNamed:@"授课标签_关闭"] forState:(UIControlStateNormal)];
    [_delBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    _delBtn.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_delBtn];
    
    _bgLabel.sd_layout
    .leftSpaceToView(self.contentView, 1)
    .topSpaceToView(self.contentView, 1)
    .rightSpaceToView(self.contentView, 1)
    .bottomSpaceToView(self.contentView, 1);
    
    _tagLabel.sd_layout
    .leftSpaceToView(self.contentView, 2)
    .topSpaceToView(self.contentView, 2)
    .rightSpaceToView(self.contentView, 20)
    .bottomSpaceToView(self.contentView, 2);
    
    _delBtn.sd_layout
    .leftSpaceToView(_tagLabel, 0)
    .topSpaceToView(self.contentView, 2)
    .rightSpaceToView(self.contentView, 2)
    .bottomSpaceToView(self.contentView, 2);
}

- (void)deleteBtnClick{
    if (_delegate && [_delegate respondsToSelector:@selector(deleteTagWith:)]) {
        [_delegate deleteTagWith:self];
    }
}

- (void)setTagType:(NSInteger)tagType{
    if (tagType == 0) {
        _bgLabel.text = @"#添加标签#";
        _bgLabel.layer.borderColor = RGBColor(248, 248, 248).CGColor;
        _tagLabel.hidden = YES;
        _delBtn.hidden = YES;
    }else{
        _bgLabel.text = @"";
        _bgLabel.layer.borderColor = RGBColor(51,150,252).CGColor;
        _tagLabel.hidden = NO;
        _delBtn.hidden = NO;
    }
}


@end
