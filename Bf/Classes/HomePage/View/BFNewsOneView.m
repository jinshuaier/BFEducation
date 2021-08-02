//
//  BFNewsOneView.m
//  Bf
//
//  Created by 陈大鹰 on 2018/2/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFNewsOneView.h"

@implementation BFNewsOneView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.newsImgOne];
        [self addSubview:self.newsTitleOne];
        [self addSubview:self.newsContentOne];
        [self addSubview:self.line];
    }
    return self;
}

-(void)layoutSubviews {
    self.newsImgOne.frame = CGRectMake(KScreenW - 10 - 107 - 20, 10, 107, 71);
    self.newsTitleOne.frame = CGRectMake(10, 10, KScreenW - 20 - 107 - 10 - 10 - 10, 50);
    self.newsContentOne.frame = CGRectMake(10, self.newsTitleOne.bottom, KScreenW - 20 - 107 - 30, 15);
    self.line.frame = CGRectMake(10, self.newsImgOne.bottom + 10, KScreenW - 40, 0.50f);
}

-(UIImageView *)newsImgOne {
    if (_newsImgOne == nil) {
        _newsImgOne = [[UIImageView alloc] init];
        _newsImgOne.image = [UIImage imageNamed:@"1banner"];
        [_newsImgOne setContentMode:UIViewContentModeScaleAspectFill];
        _newsImgOne.clipsToBounds = YES;
        _newsImgOne.layer.cornerRadius = 4.0f;
    }
    return _newsImgOne;
}

-(UILabel *)newsTitleOne {
    if (_newsTitleOne == nil) {
        _newsTitleOne = [[UILabel alloc] init];
        _newsTitleOne.text = @"汽车零部件企业也需跟进工业4.0 远程数控或成切入点";
        _newsTitleOne.textColor = ColorRGBValue(0x2d63b1);
        _newsTitleOne.font = [UIFont fontWithName:BFfont size:15.0f];
        _newsTitleOne.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightBold];
        _newsTitleOne.numberOfLines = 0;
    }
    return _newsTitleOne;
}

-(UILabel *)newsContentOne {
    if (_newsContentOne == nil) {
        _newsContentOne = [[UILabel alloc] init];
        _newsContentOne.text = @"汽车零部件企业也需跟进工业4.0 远程数控或成切入点";
        _newsContentOne.textColor = RGBColor(153, 153, 153);
        _newsContentOne.font = [UIFont fontWithName:BFfont size:12.0f];
    }
    return _newsContentOne;
}

-(UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBColor(234, 234, 234);
    }
    return _line;
}

@end
