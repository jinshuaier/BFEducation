//
//  PGIndexBannerSubiew.m
//  NewPagedFlowViewDemo
//
//  Created by Mars on 16/6/18.
//  Copyright © 2016年 Mars. All rights reserved.
//  Designed By PageGuo,
//  QQ:799573715
//  github:https://github.com/PageGuo/NewPagedFlowView

#import "PGIndexBannerSubiew.h"

@implementation PGIndexBannerSubiew

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.mainImageView];
        [self addSubview:self.coverView];
        [self addSubview:self.blackImg];
        [self addSubview:self.mainTip];
        [self addSubview:self.classDescription];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleCellTapAction:)];
        [self addGestureRecognizer:singleTap];
    }
    
    return self;
}

- (void)singleCellTapAction:(UIGestureRecognizer *)gesture {
    if (self.didSelectCellBlock) {
        self.didSelectCellBlock(self.tag, self);
    }
}

- (void)setSubviewsWithSuperViewBounds:(CGRect)superViewBounds {
    
    if (CGRectEqualToRect(self.mainImageView.frame, superViewBounds)) {
        return;
    }
    
    self.mainImageView.frame = superViewBounds;
    self.coverView.frame = self.mainImageView.frame;
    self.blackImg.frame = CGRectMake(self.mainImageView.mj_x, self.mainImageView.bottom - 40, self.mainImageView.width, 40);
    self.mainTip.frame = CGRectMake(10, 10, 60, 20);
    self.mainTip.layer.cornerRadius = 10.0f;
    self.classDescription.frame = CGRectMake(0, self.mainImageView.bottom - 20, self.mainImageView.frame.size.width, 20);
    self.classDescription.textAlignment = NSTextAlignmentCenter;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)coverView {
    if (_coverView == nil) {
        _coverView = [[UIView alloc] init];
    }
    return _coverView;
}

-(UIImageView *)blackImg {
    if (_blackImg == nil) {
        _blackImg = [[UIImageView alloc] init];
        _blackImg.image = [UIImage imageNamed:@"shadow"];
        _blackImg.alpha = 0;
    }
    return _blackImg;
}

-(UIImageView *)mainTip {
    if (_mainTip == nil) {
        _mainTip = [[UIImageView alloc] init];
        _mainTip.clipsToBounds = YES;
    }
    return _mainTip;
}

-(UILabel *)classDescription {
    if (_classDescription == nil) {
        _classDescription = [[UILabel alloc] init];
        _classDescription.textColor = [UIColor whiteColor];
        _classDescription.font = [UIFont fontWithName:BFfont size:13.0f];
        _classDescription.textAlignment = NSTextAlignmentCenter;
    }
    return _classDescription;
}

@end
