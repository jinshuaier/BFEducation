//
//  BFFourCollectionCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/1/10.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFFourCollectionCell.h"

@implementation BFFourCollectionCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _img.frame = CGRectMake(0, 0, (KScreenW - 10 * 3)/2, 95);
        _shadow.frame = CGRectMake(0, _img.bottom - 40, (KScreenW - 10 * 3)/2, 40);
        _comingLbl.frame = CGRectMake(0, 5, 60, 15);
        _number.frame = CGRectMake(_img.right - 150 - 9, _img.bottom - 15 - 3, 150, 15);
        _title.frame = CGRectMake(10, _img.bottom + 10, 106, 20);
        _tipLbl.frame = CGRectMake(_title.right + 4, _img.bottom + 14, 26, 14);
        
        [self.contentView addSubview:_img];
        [self.contentView addSubview:_shadow];
        [self.contentView addSubview:_comingLbl];
        [self.contentView addSubview:_number];
        [self.contentView addSubview:_title];
        [self.contentView addSubview:_tipLbl];
    }
    return self;
}

-(UIImageView *)img {
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        _img.clipsToBounds = YES;
        _img.layer.cornerRadius = 4.0f;
    }
    return _img;
}

-(UIImageView *)shadow {
    if (_shadow == nil) {
        _shadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow"]];
        _shadow.clipsToBounds = YES;
        _shadow.layer.cornerRadius = 4.0f;
    }
    return _shadow;
}

-(UILabel *)comingLbl {
    if (_comingLbl == nil) {
        _comingLbl = [[UILabel alloc] init];
        _comingLbl.textAlignment = NSTextAlignmentCenter;
        _comingLbl.textColor = [UIColor whiteColor];
        _comingLbl.font = [UIFont fontWithName:BFfont size:9.0f];
        _comingLbl.backgroundColor = RGBColor(255, 168, 46);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_comingLbl.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(7, 7)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _comingLbl.bounds;
        maskLayer.path = maskPath.CGPath;
        _comingLbl.layer.mask  = maskLayer;
    }
    return _comingLbl;
}

-(UILabel *)number {
    if (_number == nil) {
        _number.font = [UIFont fontWithName:BFfont size:9.0f];
        _number.textAlignment = NSTextAlignmentRight;
        _number.textColor = [UIColor whiteColor];
    }
    return _number;
}

-(UILabel *)title {
    if (_title == nil) {
        _title.text = @"君越可变气门正时";
        _title.textColor = RGBColor(51, 51, 51);
        _title.font = [UIFont fontWithName:BFfont size:13.0f];
    }
    return _title;
}

-(UILabel *)tipLbl {
    if (_tipLbl == nil) {
        _tipLbl.text = @"New";
        _tipLbl.font = [UIFont systemFontOfSize:7.0f];
        _tipLbl.textAlignment = NSTextAlignmentCenter;
        _tipLbl.textColor = [UIColor whiteColor];
        _tipLbl.backgroundColor = RGBColor(255, 83, 100);
        _tipLbl.layer.masksToBounds = YES;
        _tipLbl.layer.cornerRadius = 7.0f;
    }
    return _tipLbl;
}
@end
