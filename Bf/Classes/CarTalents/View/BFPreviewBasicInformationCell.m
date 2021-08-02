//
//  BFPreviewBasicInformationCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/27.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFPreviewBasicInformationCell.h"

@implementation BFPreviewBasicInformationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.degree];
        [self addSubview:self.degree1];
        [self addSubview:self.work];
        [self addSubview:self.work1];
        [self addSubview:self.birth];
        [self addSubview:self.birth1];
        [self addSubview:self.phone];
        [self addSubview:self.phone1];
    }
    return self;
}

-(void)layoutSubviews {
    self.degree.frame = CGRectMake(15, 15, 60, 15);
    self.degree1.frame = CGRectMake(self.degree.right + 15, 15, 200, 15);
    
    self.work.frame = CGRectMake(15, self.degree.bottom + 20, 60, 15);
    self.work1.frame = CGRectMake(self.work.right + 15, self.degree1.bottom + 20, 200, 15);
    
    self.birth.frame = CGRectMake(15, self.work.bottom + 20, 60, 15);
    self.birth1.frame = CGRectMake(self.birth.right + 15, self.work1.bottom + 20, 200, 15);
    
    self.phone.frame = CGRectMake(15, self.birth.bottom + 20, 60, 15);
    self.phone1.frame = CGRectMake(self.phone.right + 15, self.birth1.bottom + 20, 200, 15);
}

-(UILabel *)degree {
    if (!_degree) {
        _degree = [[UILabel alloc] init];
        _degree.text = @"最高学历";
        _degree.textColor = RGBColor(144, 144, 144);
        _degree.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _degree;
}

-(UILabel *)degree1 {
    if (!_degree1) {
        _degree1 = [[UILabel alloc] init];
        _degree1.text = @"博士";
        _degree1.textColor = RGBColor(0, 0, 0);
        _degree1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _degree1;
}

-(UILabel *)work {
    if (!_work) {
        _work = [[UILabel alloc] init];
        _work.text = @"工作经验";
        _work.textColor = RGBColor(144, 144, 144);
        _work.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _work;
}

-(UILabel *)work1 {
    if (!_work1) {
        _work1 = [[UILabel alloc] init];
        _work1.text = @"1-3年";
        _work1.textColor = RGBColor(0, 0, 0);
        _work1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _work1;
}

-(UILabel *)birth {
    if (!_birth) {
        _birth = [[UILabel alloc] init];
        _birth.text = @"出生年份";
        _birth.textColor = RGBColor(144, 144, 144);
        _birth.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _birth;
}

-(UILabel *)birth1 {
    if (!_birth1) {
        _birth1 = [[UILabel alloc] init];
        _birth1.text = @"1992-03";
        _birth1.textColor = RGBColor(0, 0, 0);
        _birth1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _birth1;
}

-(UILabel *)phone {
    if (!_phone) {
        _phone = [[UILabel alloc] init];
        _phone.text = @"联系电话";
        _phone.textColor = RGBColor(144, 144, 144);
        _phone.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _phone;
}

-(UILabel *)phone1 {
    if (!_phone1) {
        _phone1 = [[UILabel alloc] init];
        _phone1.text = @"13161066631";
        _phone1.textColor = RGBColor(0, 0, 0);
        _phone1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _phone1;
}

@end
