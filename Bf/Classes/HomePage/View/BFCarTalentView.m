//
//  BFCarTalentView.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCarTalentView.h"

@implementation BFCarTalentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.companyJob];
//        [self addSubview:self.companyTip];
        [self addSubview:self.companyName];
        [self addSubview:self.companyTime];
        [self addSubview:self.companyLocation];
        [self addSubview:self.companyYear];
        [self addSubview:self.companyDegree];
        [self addSubview:self.companyLogo];
        [self addSubview:self.companyMoney];
        [self addSubview:self.line];
    }
    return self;
}

-(void)layoutSubviews {
    
    CGSize maximumLabelSize0 = CGSizeMake(200, 20);
    CGSize expectSize0 = [self.companyJob sizeThatFits:maximumLabelSize0];
    self.companyJob.frame = CGRectMake(16, 15, 300, expectSize0.height);
    self.companyTip.frame = CGRectMake(self.companyJob.right + 10, 15, 35, 20);
    self.companyLocation.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(200, 20);
    CGSize expectSize = [self.companyLocation sizeThatFits:maximumLabelSize];
    self.companyLocation.frame = CGRectMake(16, self.companyJob.bottom + 10, expectSize.width, expectSize.height);
    
    CGSize maximumLabelSize1 = CGSizeMake(200, 20);
    CGSize expectSize1 = [self.companyYear sizeThatFits:maximumLabelSize1];
    self.companyYear.frame = CGRectMake(self.companyLocation.right + 4, self.companyJob.bottom + 10, expectSize1.width, expectSize1.height);
    self.companyDegree.frame = CGRectMake(self.companyYear.right + 4, self.companyJob.bottom + 10, 100, 15);
    self.companyMoney.frame = CGRectMake(KScreenW - 16 - 100, 15, 100, 20);
    self.companyTime.frame = CGRectMake(KScreenW - 16 - 100, self.companyMoney.bottom + 10, 100, 20);
    self.companyLogo.frame = CGRectMake(16, self.companyLocation.bottom + 14, 31, 31);
    self.companyLogo.layer.cornerRadius = 31/2;
    self.companyName.frame = CGRectMake(self.companyLogo.right + 9, self.companyLocation.bottom + 14, 200, 31);
    self.line.frame = CGRectMake(16, 125, KScreenW - 32, 0.5f);
}

-(UILabel *)companyJob {
    if (!_companyJob) {
        _companyJob = [[UILabel alloc] init];
        _companyJob.text = @"汽修教师";
        _companyJob.textColor = RGBColor(51, 51, 51);
        _companyJob.textAlignment = NSTextAlignmentLeft;
        _companyJob.font = [UIFont fontWithName:BFfont size:15.0f];
    }
    return _companyJob;
}

-(UILabel *)companyTip {
    if (!_companyTip) {
        _companyTip = [[UILabel alloc] init];
        _companyTip.text = @"急聘";
        _companyTip.layer.borderWidth = 1.0f;
        _companyTip.layer.borderColor = RGBColor(0, 148, 231).CGColor;
        _companyTip.textColor = RGBColor(0, 148, 231);
        _companyTip.textAlignment = NSTextAlignmentCenter;
        _companyTip.font = [UIFont fontWithName:BFfont size:11.0f];
    }
    return _companyTip;
}

-(UILabel *)companyLocation {
    if (!_companyLocation) {
        _companyLocation = [[UILabel alloc] init];
        _companyLocation.text = @"河北邯郸";
        _companyLocation.textColor = RGBColor(153, 153, 153);
        _companyLocation.textAlignment = NSTextAlignmentLeft;
        _companyLocation.font = [UIFont fontWithName:BFfont size:11.0f];
    }
    return _companyLocation;
}

-(UILabel *)companyYear {
    if (!_companyYear) {
        _companyYear = [[UILabel alloc] init];
        _companyYear.text = @"3-5年";
        _companyYear.textColor = RGBColor(153, 153, 153);
        _companyYear.textAlignment = NSTextAlignmentLeft;
        _companyYear.font = [UIFont fontWithName:BFfont size:11.0f];
    }
    return _companyYear;
}

-(UILabel *)companyDegree {
    if (!_companyDegree) {
        _companyDegree = [[UILabel alloc] init];
        _companyDegree.text = @"本科";
        _companyDegree.textColor = RGBColor(153, 153, 153);
        _companyDegree.textAlignment = NSTextAlignmentLeft;
        _companyDegree.font = [UIFont fontWithName:BFfont size:11.0f];
    }
    return _companyDegree;
}

-(UILabel *)companyMoney {
    if (!_companyMoney) {
        _companyMoney = [[UILabel alloc] init];
        _companyMoney.text = @"5000-8000";
        _companyMoney.textColor = RGBColor(0, 148, 231);
        _companyMoney.textAlignment = NSTextAlignmentRight;
        _companyMoney.font = [UIFont fontWithName:BFfont size:15.0f];
    }
    return _companyMoney;
}

-(UILabel *)companyTime {
    if (!_companyTime) {
        _companyTime = [[UILabel alloc] init];
        _companyTime.text = @"01月22日";
        _companyTime.textColor = RGBColor(178, 178, 178);
        _companyTime.textAlignment = NSTextAlignmentRight;
        _companyTime.font = [UIFont fontWithName:BFfont size:11.0f];
    }
    return _companyTime;
}

-(UIImageView *)companyLogo {
    if (!_companyLogo) {
        _companyLogo = [[UIImageView alloc] init];
        _companyLogo.clipsToBounds = YES;
        _companyLogo.image = [UIImage imageNamed:@"logo-2"];
    }
    return _companyLogo;
}

-(UILabel *)companyName {
    if (!_companyName) {
        _companyName = [[UILabel alloc] init];
        _companyName.text = @"河北星星科技有限公司";
        _companyName.textColor = RGBColor(51, 51, 51);
        _companyName.textAlignment = NSTextAlignmentLeft;
        _companyName.font = [UIFont fontWithName:BFfont size:13.0f];
    }
    return _companyName;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = ColorRGBValue(0xefefef);
    }
    return _line;
}

@end
