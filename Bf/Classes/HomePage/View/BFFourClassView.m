//
//  BFFourClassView.m
//  Bf
//
//  Created by 陈大鹰 on 2018/1/15.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFFourClassView.h"
#define imgWidth (KScreenW - 15 * 3)/2
@implementation BFFourClassView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.classImg];
        [self addSubview:self.playImg];
        [self addSubview:self.classStyle];
        [self addSubview:self.classTitle];
        [self addSubview:self.classTeacher];
        [self addSubview:self.teacherName];
        [self addSubview:self.teacherImg];
        [self addSubview:self.playNumber];
    }
    return self;
}

-(void)layoutSubviews {
    self.classImg.frame = CGRectMake(0, 0, imgWidth, 100);
    self.playImg.frame = CGRectMake((imgWidth - 45)/2, (100 - 45)/2, 45, 45);
    self.classStyle.frame = CGRectMake(0, self.classImg.bottom + 10, 50, 20);
    self.classStyle.layer.cornerRadius = 10.0f;
    self.classTitle.frame = CGRectMake(self.classStyle.right + 5, self.classImg.bottom + 10, imgWidth - self.classStyle.width - 5, 20);
    self.classTeacher.frame = CGRectMake(0, self.classStyle.bottom + 10, 18, 18);
    self.classTeacher.layer.cornerRadius = 9;
    self.teacherName.frame = CGRectMake(self.classTeacher.right + 5, self.classStyle.bottom + 10, 40, 18);
    self.teacherImg.frame = CGRectMake(self.teacherName.right, self.classStyle.bottom + 10, 14, 18);
    self.playNumber.frame = CGRectMake(self.teacherImg.right, self.classStyle.bottom + 10, imgWidth - self.teacherImg.right, 18);
}

-(UIImageView *)classImg {
    if (_classImg == nil) {
        _classImg = [[UIImageView alloc] init];
        _classImg.image = [UIImage imageNamed:@"1banner"];
        [_classImg setContentMode:UIViewContentModeScaleAspectFill];
        _classImg.clipsToBounds = YES;
        _classImg.layer.cornerRadius = 6.0f;
    }
    return _classImg;
}

-(UIImageView *)playImg {
    if (_playImg == nil) {
        _playImg = [[UIImageView alloc] init];
        _playImg.image = [UIImage imageNamed:@"1播放"];
        _playImg.clipsToBounds = YES;
    }
    return _playImg;
}

-(UIButton *)classStyle {
    if (_classStyle == nil) {
        _classStyle = [UIButton buttonWithType:UIButtonTypeCustom];
        _classStyle.backgroundColor = RGBColor(239, 247, 255);
        [_classStyle setImage:[UIImage imageNamed:@"1回放"] forState:UIControlStateNormal];
        _classStyle.clipsToBounds = YES;
    }
    return _classStyle;
}

-(UILabel *)classTitle {
    if (_classTitle == nil) {
        _classTitle = [[UILabel alloc] init];
        _classTitle.text = @"深度解析纯电动车在运行时的各种状态";
        _classTitle.textColor = RGBColor(51, 51, 51);
        _classTitle.font = [UIFont fontWithName:BFfont size:13.0f];
    }
    return _classTitle;
}

-(UIImageView *)classTeacher {
    if (_classTeacher == nil) {
        _classTeacher = [[UIImageView alloc] init];
        _classTeacher.image = [UIImage imageNamed:@"直播课堂-耿永雷"];
        _classTeacher.clipsToBounds = YES;
    }
    return _classTeacher;
}

-(UILabel *)teacherName {
    if (_teacherName == nil) {
        _teacherName = [[UILabel alloc] init];
        _teacherName.text = @"耿永雷";
        _teacherName.textColor = RGBColor(102, 102, 102);
        _teacherName.font = [UIFont fontWithName:BFfont size:12.0f];
    }
    return _teacherName;
}

-(UIImageView *)teacherImg {
    if (_teacherImg == nil) {
        _teacherImg = [[UIImageView alloc] init];
        _teacherImg.image = [UIImage imageNamed:@"认证"];
        _teacherImg.clipsToBounds = YES;
    }
    return _teacherImg;
}

-(UILabel *)playNumber {
    if (_playNumber == nil) {
        _playNumber = [[UILabel alloc] init];
        _playNumber.text = @"1.42万次播放";
        _playNumber.textColor = RGBColor(161, 165, 169);
        _playNumber.font = [UIFont fontWithName:BFfont size:11.0f];
        _playNumber.textAlignment = NSTextAlignmentRight;
    }
    return _playNumber;
}


@end
