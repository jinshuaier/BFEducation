//
//  BFdetailTopCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/15.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFdetailTopCell.h"

@interface BFdetailTopCell()



@end

@implementation BFdetailTopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.companyJob];
        [self addSubview:self.companyMoney];
        [self addSubview:self.line];
        [self addSubview:self.companyLocation];
        [self addSubview:self.companyYear];
        [self addSubview:self.companyDegree];
        [self addSubview:self.companyLogo];
        [self addSubview:self.companyName];
        [self addSubview:self.companyType];
        [self addSubview:self.companyPeople];
        [self addSubview:self.companyTip];
        [self addSubview:self.line1];
    }
    return self;
}

-(void)layoutSubviews {
    self.companyJob.frame = CGRectMake(16, 15, 200, 20);
    self.companyMoney.frame = CGRectMake(KScreenW - 16 - 200, 15, 200, 20);
    
    CGSize maximumLabelSize0 = CGSizeMake(200, 20);
    CGSize expectSize0 = [self.companyLocation sizeThatFits:maximumLabelSize0];
    self.companyLocation.frame = CGRectMake(16, self.companyJob.bottom + 15, expectSize0.width, expectSize0.height);
    
    CGSize maximumLabelSize1 = CGSizeMake(200, 20);
    CGSize expectSize1 = [self.companyYear sizeThatFits:maximumLabelSize1];
    self.companyYear.frame = CGRectMake(self.companyLocation.right + 10, self.companyJob.bottom + 15, expectSize1.width, expectSize1.height);
    
    CGSize maximumLabelSize2 = CGSizeMake(200, 20);
    CGSize expectSize2 = [self.companyDegree sizeThatFits:maximumLabelSize2];
    self.companyDegree.frame = CGRectMake(self.companyYear.right + 10, self.companyJob.bottom + 15, expectSize2.width, expectSize2.height);
    
    self.line.frame = CGRectMake(15, self.companyLocation.bottom + 15, KScreenW - 30, 0.50f);
    
    self.companyLogo.frame = CGRectMake(16, self.line.bottom + 15, 55, 55);
    self.companyLogo.layer.cornerRadius = 55.0/2;
    self.companyName.frame = CGRectMake(self.companyLogo.right + 10, self.line.bottom + 15, KScreenW - self.companyLocation.width - 32, 20);
    
    CGSize maximumLabelSize3 = CGSizeMake(200, 20);
    CGSize expectSize3 = [self.companyType sizeThatFits:maximumLabelSize3];
    self.companyType.frame = CGRectMake(self.companyLogo.right + 10, self.companyName.bottom, expectSize3.width, expectSize3.height);
    self.companyPeople.frame = CGRectMake(self.companyType.right + 10, self.companyName.bottom, 100, 15);
    self.companyTip.frame = CGRectMake(self.companyLogo.right + 10, self.companyType.bottom + 5, 50, 15);
    self.line1.frame = CGRectMake(0, self.companyLogo.bottom + 10, KScreenW, 10.0f);
}

-(UILabel *)companyJob {
    if (!_companyJob) {
        _companyJob = [[UILabel alloc] init];
        _companyJob.text = @"美国总统";
        _companyJob.textColor = RGBColor(51, 51, 51);
        _companyJob.font = [UIFont fontWithName:BFfont size:17.0f];
    }
    return _companyJob;
}

-(UILabel *)companyMoney {
    if (!_companyMoney) {
        _companyMoney = [[UILabel alloc] init];
        _companyMoney.text = @"5000-8000";
        _companyMoney.textColor = RGBColor(0, 148, 231);
        _companyMoney.font = [UIFont fontWithName:BFfont size:16.0f];
        _companyMoney.textAlignment = NSTextAlignmentRight;
    }
    return _companyMoney;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = ColorRGBValue(0xefefef);
    }
    return _line;
}

-(UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc] init];
        _line1.backgroundColor = ColorRGBValue(0xefefef);
    }
    return _line1;
}

-(UIButton *)companyLocation {
    if (!_companyLocation) {
        _companyLocation = [UIButton buttonWithType:UIButtonTypeCustom];
        [_companyLocation setTitle:@" 北京·朝阳区" forState:UIControlStateNormal];
        [_companyLocation setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
        [_companyLocation setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
        _companyLocation.titleLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    }
    return _companyLocation;
}

-(UIButton *)companyYear {
    if (!_companyYear) {
        _companyYear = [UIButton buttonWithType:UIButtonTypeCustom];
        [_companyYear setTitle:@" 1-3年" forState:UIControlStateNormal];
        [_companyYear setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
        [_companyYear setImage:[UIImage imageNamed:@"年限"] forState:UIControlStateNormal];
        _companyYear.titleLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    }
    return _companyYear;
}

-(UIButton *)companyDegree {
    if (!_companyDegree) {
        _companyDegree = [UIButton buttonWithType:UIButtonTypeCustom];
        [_companyDegree setTitle:@" 本科" forState:UIControlStateNormal];
        [_companyDegree setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
        [_companyDegree setImage:[UIImage imageNamed:@"本科"] forState:UIControlStateNormal];
        _companyDegree.titleLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    }
    return _companyDegree;
}

-(UIImageView *)companyLogo {
    if (!_companyLogo) {
        _companyLogo = [[UIImageView alloc] init];
        _companyLogo.image = [UIImage imageNamed:@"logo-2"];
        _companyLogo.clipsToBounds = YES;
    }
    return _companyLogo;
}

-(UILabel *)companyName {
    if (!_companyName) {
        _companyName = [[UILabel alloc] init];
        _companyName.text = @"陈大鹰网络科技有限公司";
        _companyName.textColor = RGBColor(51, 51, 51);
        _companyName.font = [UIFont fontWithName:BFfont size:15.0f];
    }
    return _companyName;
}

-(UILabel *)companyType {
    if (!_companyType) {
        _companyType = [[UILabel alloc] init];
        _companyType.text = @"外资";
        _companyType.textColor = RGBColor(153, 153, 153);
        _companyType.font = [UIFont fontWithName:BFfont size:12.0f];
    }
    return _companyType;
}

-(UILabel *)companyPeople {
    if (!_companyPeople) {
        _companyPeople = [[UILabel alloc] init];
        _companyPeople.text = @"150-500人";
        _companyPeople.textColor = RGBColor(153, 153, 153);
        _companyPeople.font = [UIFont fontWithName:BFfont size:12.0f];
    }
    return _companyPeople;
}

-(UIImageView *)companyTip {
    if (!_companyTip) {
        _companyTip = [[UIImageView alloc] init];
        _companyTip.image = [UIImage imageNamed:@"已认证"];
    }
    return _companyTip;
}

@end
