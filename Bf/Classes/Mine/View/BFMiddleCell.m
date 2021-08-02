//
//  BFMiddleCell.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/8.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMiddleCell.h"

@implementation BFMiddleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.Img1];
        [self addSubview:self.Img2];
        [self addSubview:self.Img3];
        [self addSubview:self.Img4];
        [self addSubview:self.moneyField];
        [self addSubview:self.line];
        [self addSubview:self.wxImg];
        [self addSubview:self.wxLabel];
        [self addSubview:self.wxBtn];
        [self addSubview:self.alipayImg];
        [self addSubview:self.alipayLabel];
        [self addSubview:self.alipayBtn];
    }
    return self;
}

-(void)layoutSubviews {
    self.Img1.frame = CGRectMake(20, 20, (KScreenW - 60)/2, 80);
    self.Img2.frame = CGRectMake(40 + (KScreenW - 60)/2, 20, (KScreenW - 60)/2, 80);
    self.Img3.frame = CGRectMake(20, self.Img1.bottom, (KScreenW - 60)/2, 80);
    self.Img4.frame = CGRectMake(40 + (KScreenW - 60)/2, self.Img1.bottom, (KScreenW - 60)/2, 80);
    self.moneyField.frame = CGRectMake(30, self.Img3.bottom + 20, KScreenW - 60, 30);
    self.line.frame = CGRectMake(30, self.moneyField.bottom, KScreenW - 60, 0.30f);
}

-(UIButton *)Img1 {
    if (_Img1 == nil) {
        _Img1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Img1 setImage:[UIImage imageNamed:@"100元"] forState:UIControlStateNormal];
        [_Img1 setImage:[UIImage imageNamed:@"100元不可点击"] forState:UIControlStateSelected];
        [_Img1 addTarget:self action:@selector(clickAction1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Img1;
}

-(UIButton *)Img2 {
    if (_Img2 == nil) {
        _Img2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Img2 setImage:[UIImage imageNamed:@"200元不可点击"] forState:UIControlStateNormal];
        [_Img2 setImage:[UIImage imageNamed:@"200元"] forState:UIControlStateSelected];
        [_Img2 addTarget:self action:@selector(clickAction2) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Img2;
}

-(UIButton *)Img3 {
    if (_Img3 == nil) {
        _Img3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Img3 setImage:[UIImage imageNamed:@"300元不可点击"] forState:UIControlStateNormal];
        [_Img3 setImage:[UIImage imageNamed:@"300元"] forState:UIControlStateSelected];
        [_Img3 addTarget:self action:@selector(clickAction3) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Img3;
}

-(UIButton *)Img4 {
    if (_Img4 == nil) {
        _Img4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Img4 setImage:[UIImage imageNamed:@"1000元不可点击"] forState:UIControlStateNormal];
        [_Img4 setImage:[UIImage imageNamed:@"1000元"] forState:UIControlStateSelected];
        [_Img4 addTarget:self action:@selector(clickAction4) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Img4;
}

-(UITextField *)moneyField {
    if (_moneyField == nil) {
        _moneyField = [[UITextField alloc] init];
        _moneyField.placeholder = @"请输入充值金额";
        _moneyField.textColor = [UIColor grayColor];
        _moneyField.font = [UIFont fontWithName:BFfont size:14.0f];
        _moneyField.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyField;
}

-(UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor lightGrayColor];
    }
    return _line;
}

-(void)clickAction1 {
    if (self.imgBlock1) {
        self.imgBlock1();
    }
}

-(void)clickAction2 {
    if (self.imgBlock2) {
        self.imgBlock2();
    }
}

-(void)clickAction3 {
    if (self.imgBlock3) {
        self.imgBlock3();
    }
}

-(void)clickAction4 {
    if (self.imgBlock4) {
        self.imgBlock4();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
