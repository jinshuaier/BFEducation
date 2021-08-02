//
//  BFCompanyListCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/2.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCompanyListCell.h"

@interface BFCompanyListCell()
/*招聘职位*/
@property (nonatomic, strong) UILabel *companyJob;
/*招聘标签*/
@property (nonatomic,strong) UILabel *companyTip;
/*招聘地点*/
@property (nonatomic,strong) UILabel *companyLocation;
/*招聘年限*/
@property (nonatomic,strong) UILabel *companyYear;
/*招聘学位*/
@property (nonatomic,strong) UILabel *companyDegree;
/*招聘公司logo*/
@property (nonatomic,strong) UIImageView *companyLogo;
/*招聘公司名称*/
@property (nonatomic,strong) UILabel *companyName;
/*招聘薪水*/
@property (nonatomic,strong) UILabel *companyMoney;
/*招聘日期*/
@property (nonatomic,strong) UILabel *companyTime;
/*招聘状态*/
@property (nonatomic,strong) UIImageView *companyStatus;
/*下划线*/
@property (nonatomic,strong) UIView *line;
@end


@implementation BFCompanyListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.companyJob];
        [self addSubview:self.companyTip];
        [self addSubview:self.companyName];
        [self addSubview:self.companyStatus];
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

-(void)setDataModel:(BFCarTalentsListModel *)dataModel {
    _dataModel = dataModel;
    self.companyTip.hidden = YES;
    self.companyJob.text = dataModel.jWName;
    self.companyName.text = dataModel.jCName;
    if (dataModel.inFlag == 0) {
        self.companyStatus.hidden = YES;
    }
    else {
        self.companyStatus.hidden = NO;
    }
    
    self.companyTime.text = dataModel.jWTimeStr;
    self.companyLocation.text = dataModel.bRName;
    
    NSString *str0 = [NSString stringWithFormat:@"%d",dataModel.jWYear];
    NSString *str00 = @"0";
    if ([str0 isEqualToString:@"0"]) {
        str00 = @"应届生";
    }
    else if ([str0 isEqualToString:@"1"]) {
        str00 = @"1-3年";
    }
    else if ([str0 isEqualToString:@"2"]) {
        str00 = @"3-5年";
    }
    else if ([str0 isEqualToString:@"3"]) {
        str00 = @"5-10年";
    }
    else if ([str0 isEqualToString:@"4"]) {
        str00 = @"10年以上";
    }
    self.companyYear.text = str00;
    
    NSString *str1 = [NSString stringWithFormat:@"%d",dataModel.jWDiploma];
    NSString *str11 = @"0";
    if ([str1 isEqualToString:@"0"]) {
        str11 = @"不限";
    }
    else if ([str1 isEqualToString:@"1"]) {
        str11 = @"中专以下";
    }
    else if ([str1 isEqualToString:@"2"]) {
        str11 = @"高中";
    }
    else if ([str1 isEqualToString:@"3"]) {
        str11 = @"大专";
    }
    else if ([str1 isEqualToString:@"4"]) {
        str11 = @"本科";
    }
    
    self.companyDegree.text = str11;
    [self.companyLogo sd_setImageWithURL:[NSURL URLWithString:dataModel.jCLogo]];
    
    NSString *str2 = [NSString stringWithFormat:@"%d",dataModel.jWMoney];
    NSString *str22 = @"0";
    if ([str2 isEqualToString:@"0"]) {
        str22 = @"面议";
    }
    else if ([str2 isEqualToString:@"1"]) {
        str22 = @"3000元以下";
    }
    else if ([str2 isEqualToString:@"2"]) {
        str22 = @"3000-5000";
    }
    else if ([str2 isEqualToString:@"3"]) {
        str22 = @"5000-7000";
    }
    else if ([str2 isEqualToString:@"4"]) {
        str22 = @"7000-10000";
    }
    else if ([str2 isEqualToString:@"5"]) {
        str22 = @"10000-15000";
    }
    else if ([str2 isEqualToString:@"6"]) {
        str22 = @"15000以上";
    }
    self.companyMoney.text = str22;
}





-(void)setDataModel1:(BFDropInBoxModel *)dataModel1 {
    _dataModel1 = dataModel1;
    self.companyTip.hidden = YES;
    self.companyJob.text = dataModel1.jWName;
    self.companyName.text = dataModel1.jCName;
    if (dataModel1.inFlag == 0) {
        self.companyStatus.hidden = YES;
    }
    else {
        self.companyStatus.hidden = NO;
    }
    
    self.companyTime.text = dataModel1.jWTimeStr;
    self.companyLocation.text = dataModel1.bRName;
    
    NSString *str0 = [NSString stringWithFormat:@"%d",dataModel1.jWYear];
    NSString *str00 = @"0";
    if ([str0 isEqualToString:@"0"]) {
        str00 = @"应届生";
    }
    else if ([str0 isEqualToString:@"1"]) {
        str00 = @"1-3年";
    }
    else if ([str0 isEqualToString:@"2"]) {
        str00 = @"3-5年";
    }
    else if ([str0 isEqualToString:@"3"]) {
        str00 = @"5-10年";
    }
    else if ([str0 isEqualToString:@"4"]) {
        str00 = @"10年以上";
    }
    self.companyYear.text = str00;
    
    NSString *str1 = [NSString stringWithFormat:@"%d",dataModel1.jWDiploma];
    NSString *str11 = @"0";
    if ([str1 isEqualToString:@"0"]) {
        str11 = @"不限";
    }
    else if ([str1 isEqualToString:@"1"]) {
        str11 = @"中专以下";
    }
    else if ([str1 isEqualToString:@"2"]) {
        str11 = @"高中";
    }
    else if ([str1 isEqualToString:@"3"]) {
        str11 = @"大专";
    }
    else if ([str1 isEqualToString:@"4"]) {
        str11 = @"本科";
    }
    
    self.companyDegree.text = str11;
    [self.companyLogo sd_setImageWithURL:[NSURL URLWithString:dataModel1.jCLogo] placeholderImage:[UIImage imageNamed:@"列表"]];
    
    NSString *str2 = [NSString stringWithFormat:@"%d",dataModel1.jWMoney];
    NSString *str22 = @"0";
    if ([str2 isEqualToString:@"0"]) {
        str22 = @"面议";
    }
    else if ([str2 isEqualToString:@"1"]) {
        str22 = @"3000元以下";
    }
    else if ([str2 isEqualToString:@"2"]) {
        str22 = @"3000-5000";
    }
    else if ([str2 isEqualToString:@"3"]) {
        str22 = @"5000-7000";
    }
    else if ([str2 isEqualToString:@"4"]) {
        str22 = @"7000-10000";
    }
    else if ([str2 isEqualToString:@"5"]) {
        str22 = @"10000-15000";
    }
    else if ([str2 isEqualToString:@"6"]) {
        str22 = @"15000以上";
    }
    self.companyMoney.text = str22;
}



-(void)layoutSubviews {
    
    
    CGSize maximumLabelSize0 = CGSizeMake(200, 20);
    CGSize expectSize0 = [self.companyJob sizeThatFits:maximumLabelSize0];
    self.companyJob.frame = CGRectMake(16, 15, expectSize0.width, expectSize0.height);
    self.companyTip.frame = CGRectMake(self.companyJob.right + 10, 30, 35, 20);
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
    self.line.frame = CGRectMake(0, self.companyLogo.bottom + 15, KScreenW, 10.0f);
    self.companyStatus.frame = CGRectMake(KScreenW - 40, self.line.top - 40, 40, 40);
    
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

-(UIImageView *)companyStatus {
    if (!_companyStatus) {
        _companyStatus = [[UIImageView alloc] init];
        _companyStatus.clipsToBounds = YES;
        _companyStatus.image = [UIImage imageNamed:@"已投递拷贝2"];
    }
    return _companyStatus;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = ColorRGBValue(0xefefef);
    }
    return _line;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
