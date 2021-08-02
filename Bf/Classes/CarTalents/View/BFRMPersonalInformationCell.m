//
//  BFRMPersonalInformationCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/22.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFRMPersonalInformationCell.h"

@interface BFRMPersonalInformationCell()


@property (nonatomic,strong) UILabel *sex;

@property (nonatomic,strong) UILabel *birth;

@property (nonatomic,strong) UILabel *degree;

@property (nonatomic,strong) UILabel *workYear;

@property (nonatomic,strong) UILabel *phone;

@property (nonatomic,strong) UILabel *job;

@property (nonatomic,strong) UILabel *money;

@property (nonatomic,strong) UILabel *location;


@end

@implementation BFRMPersonalInformationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.headImg];
        [self addSubview:self.realName];
        
        [self addSubview:self.sex];
        [self addSubview:self.sex1];
        [self addSubview:self.birth];
        [self addSubview:self.birth1];
        
        [self addSubview:self.degree];
        [self addSubview:self.degree1];
        [self addSubview:self.workYear];
        [self addSubview:self.workYear1];
        
        [self addSubview:self.phone];
        [self addSubview:self.phone1];
        [self addSubview:self.job];
        [self addSubview:self.job1];
        
        [self addSubview:self.money];
        [self addSubview:self.money1];
        [self addSubview:self.location];
        [self addSubview:self.location1];
    }
    return self;
}

-(void)layoutSubviews {
    self.headImg.frame = CGRectMake(15, 15, 60, 60);
    self.headImg.layer.cornerRadius = 30.0f;
    self.realName.frame = CGRectMake(self.headImg.right + 15, 35, 200, 20);
    self.sex.frame = CGRectMake(15, self.headImg.bottom + 20, 60, 15);
    self.sex1.frame = CGRectMake(self.sex.right + 15, self.headImg.bottom + 20, 200, 15);
    
    self.birth.frame = CGRectMake(15, self.sex.bottom + 20, 60, 15);
    self.birth1.frame = CGRectMake(self.birth.right + 15, self.sex.bottom + 20, 200, 15);
    
    self.degree.frame = CGRectMake(15, self.birth.bottom + 20, 60, 15);
    self.degree1.frame = CGRectMake(self.degree.right + 15, self.birth.bottom + 20, 200, 15);
    
    self.workYear.frame = CGRectMake(15, self.degree.bottom + 20, 60, 15);
    self.workYear1.frame = CGRectMake(self.workYear.right + 15, self.degree.bottom + 20, 200, 15);
    
    self.phone.frame = CGRectMake(15, self.workYear.bottom + 20, 60, 15);
    self.phone1.frame = CGRectMake(self.phone.right + 15, self.workYear.bottom + 20, 200, 15);
    
    self.job.frame = CGRectMake(15, self.phone.bottom + 20, 60, 15);
    self.job1.frame = CGRectMake(self.job.right + 15, self.phone.bottom + 20, 200, 15);
    
    self.money.frame = CGRectMake(15, self.job.bottom + 20, 60, 15);
    self.money1.frame = CGRectMake(self.money.right + 15, self.job.bottom + 20, 200, 15);
    
    self.location.frame = CGRectMake(15, self.money.bottom + 20, 60, 15);
    self.location1.frame = CGRectMake(self.location.right + 15, self.money.bottom + 20, 200, 15);
}

-(UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        _headImg.image = [UIImage imageNamed:@"logo-2"];
        _headImg.clipsToBounds = YES;
    }
    return _headImg;
}

-(UILabel *)realName {
    if (!_realName) {
        _realName = [[UILabel alloc] init];
        _realName.text = @"陈大鹰";
        _realName.textColor = RGBColor(0, 0, 0);
        _realName.font = [UIFont fontWithName:BFfont size:16.0f];
    }
    return _realName;
}

-(UILabel *)sex {
    if (!_sex) {
        _sex = [[UILabel alloc] init];
        _sex.text = @"性别";
        _sex.textColor = RGBColor(144, 144, 144);
        _sex.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _sex;
}

-(UILabel *)sex1 {
    if (!_sex1) {
        _sex1 = [[UILabel alloc] init];
        _sex1.text = @"男";
        _sex1.textColor = RGBColor(0, 0, 0);
        _sex1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _sex1;
}

-(UILabel *)birth {
    if (!_birth) {
        _birth = [[UILabel alloc] init];
        _birth.text = @"出生日期";
        _birth.textColor = RGBColor(144, 144, 144);
        _birth.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _birth;
}

-(UILabel *)birth1 {
    if (!_birth1) {
        _birth1 = [[UILabel alloc] init];
        _birth1.text = @"1993年";
        _birth1.textColor = RGBColor(0, 0, 0);
        _birth1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _birth1;
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

-(UILabel *)workYear {
    if (!_workYear) {
        _workYear = [[UILabel alloc] init];
        _workYear.text = @"工作时间";
        _workYear.textColor = RGBColor(144, 144, 144);
        _workYear.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _workYear;
}

-(UILabel *)workYear1 {
    if (!_workYear1) {
        _workYear1 = [[UILabel alloc] init];
        _workYear1.text = @"3-5年";
        _workYear1.textColor = RGBColor(0, 0, 0);
        _workYear1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _workYear1;
}

-(UILabel *)phone {
    if (!_phone) {
        _phone = [[UILabel alloc] init];
        _phone.text = @"联系方式";
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

-(UILabel *)job {
    if (!_job) {
        _job = [[UILabel alloc] init];
        _job.text = @"期望职位";
        _job.textColor = RGBColor(144, 144, 144);
        _job.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _job;
}

-(UILabel *)job1 {
    if (!_job1) {
        _job1 = [[UILabel alloc] init];
        _job1.text = @"维修大牛";
        _job1.textColor = RGBColor(0, 0, 0);
        _job1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _job1;
}

-(UILabel *)money {
    if (!_money) {
        _money = [[UILabel alloc] init];
        _money.text = @"期望薪资";
        _money.textColor = RGBColor(144, 144, 144);
        _money.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _money;
}

-(UILabel *)money1 {
    if (!_money1) {
        _money1 = [[UILabel alloc] init];
        _money1.text = @"8000-10000元/月";
        _money1.textColor = RGBColor(0, 0, 0);
        _money1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _money1;
}

-(UILabel *)location {
    if (!_location) {
        _location = [[UILabel alloc] init];
        _location.text = @"求职区域";
        _location.textColor = RGBColor(144, 144, 144);
        _location.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _location;
}

-(UILabel *)location1 {
    if (!_location1) {
        _location1 = [[UILabel alloc] init];
        _location1.text = @"北京";
        _location1.textColor = RGBColor(0, 0, 0);
        _location1.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _location1;
}

@end
