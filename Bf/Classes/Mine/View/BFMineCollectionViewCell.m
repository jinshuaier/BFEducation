//
//  BFMineCollectionViewCell.m
//  NewTest
//
//  Created by 春晓 on 2017/12/4.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFMineCollectionViewCell.h"

@interface BFMineCollectionViewCell ()
// title
@property (nonatomic , strong) UIButton *titleBtn;
@end

@implementation BFMineCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        [self layout];
    }
    return self;
}

- (void)setupUI{
    _titleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.contentView addSubview:_titleBtn];
    _titleBtn.titleLabel.font = [UIFont systemFontOfSize:PXTOPT(24)];
    _titleBtn.frame = CGRectMake(0, 0, KScreenW / 4.0, 100);
    [_titleBtn setTitleColor:RGBColor(178, 178, 178) forState:(UIControlStateNormal)];
    _titleBtn.userInteractionEnabled = NO;
    [self setButtonContentCenter:_titleBtn];
}

- (void)layout{
    _titleBtn.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightEqualToView(self.contentView);
}

- (void)setTitleDic:(NSDictionary *)titleDic{
    _titleDic = titleDic;
    [_titleBtn setTitle:titleDic[@"title"] forState:(UIControlStateNormal)];
    [_titleBtn setImage:[UIImage imageNamed:titleDic[@"image"]] forState:(UIControlStateNormal)];
    [self setButtonContentCenter:_titleBtn];
}

// 设置按钮图片文字上下显示，居中对齐
-(void)setButtonContentCenter:(UIButton *)button
{
    CGSize imgViewSize,titleSize,btnSize;
    UIEdgeInsets imageViewEdge,titleEdge;
    CGFloat heightSpace = PXTOPT(30);
    
    //设置按钮内边距
    imgViewSize = button.imageView.bounds.size;
    titleSize = button.titleLabel.bounds.size;
    btnSize = button.bounds.size;
    
    imageViewEdge = UIEdgeInsetsMake(-heightSpace,0.0, 0.0, - titleSize.width);
    [button setImageEdgeInsets:imageViewEdge];
    titleEdge = UIEdgeInsetsMake((imgViewSize.height + heightSpace), - imgViewSize.width, 0.0, 0.0);
    [button setTitleEdgeInsets:titleEdge];
}

@end
