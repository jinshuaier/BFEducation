//
//  BFExperienceListCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/20.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFExperienceListCell.h"

@implementation BFExperienceListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.timeLineImage];
        [self addSubview:self.timeLine];
        [self addSubview:self.experienceTime];
        [self addSubview:self.company];
        [self addSubview:self.position];
        [self addSubview:self.editBtn];
        [self addSubview:self.experienceContent];
    }
    return self;
}

-(void)setDataModel:(BFWorkExModel *)dataModel {
    _dataModel = dataModel;
    self.experienceTime.text = [NSString stringWithFormat:@"%@ - %@",dataModel.jEStartTimeStr,dataModel.jEEndTimeStr];
    self.company.text = [NSString stringWithFormat:@"%@",dataModel.jECompany];
    self.position.text = [NSString stringWithFormat:@"%@",dataModel.jEJob];
    self.experienceContent.text = [NSString stringWithFormat:@"%@",dataModel.jEContent];
    self.timeLineImage.hidden = YES;
//    if ([self.isLastData isEqualToString:@"1"]) {
//        self.timeLine.hidden = NO;
//    }
//    else {
//        self.timeLine.hidden = YES;
//    }
}

-(void)setDataModel1:(BFEducationExModel *)dataModel1 {
    _dataModel1 = dataModel1;
    self.experienceTime.text = [NSString stringWithFormat:@"%@ - %@",dataModel1.jLStartTimeStr,dataModel1.jLEndTimeStr];
    self.company.text = [NSString stringWithFormat:@"%@",dataModel1.jLSchool];
    self.position.text = [NSString stringWithFormat:@"%@",dataModel1.jLLearn];
    self.timeLineImage.hidden = NO;
//    self.timeLine.hidden = YES;
}

-(void)layoutSubviews {
    self.timeLineImage.frame = CGRectMake(16, 15, 15, 15);
    self.experienceTime.frame = CGRectMake(self.timeLineImage.right + 6.5, 15, 200, 15);
    self.company.frame = CGRectMake(self.timeLineImage.right + 10, self.experienceTime.bottom + 10, KScreenW - self.timeLineImage.right, 20);
    self.position.frame = CGRectMake(self.timeLineImage.right + 10, self.company.bottom + 10, KScreenW - self.timeLineImage.right, 20);
    if ([self.isShow isEqualToString:@"0"]) {
        self.editBtn.hidden = YES;
    }
    else {
        self.editBtn.frame = CGRectMake(KScreenW - 16 - 20, 12.5, 20, 20);
    }
    CGFloat height = [UILabel getHeightByWidth:self.experienceContent.frame.size.width title:self.experienceContent.text font:self.experienceContent.font];
    self.experienceContent.frame = CGRectMake(self.timeLineImage.right + 10, self.position.bottom + 10, KScreenW - 2 * (self.timeLineImage.right + 10), height);
//    self.timeLine.frame = CGRectMake(24, self.timeLineImage.bottom + 5, 0.50f, 60);
}

-(UIImageView *)timeLineImage {
    if (!_timeLineImage) {
        _timeLineImage = [[UIImageView alloc] init];
        _timeLineImage.image = [UIImage imageNamed:@"椭圆2拷贝"];
    }
    return _timeLineImage;
}

-(UIView *)timeLine {
    if (!_timeLine) {
        _timeLine = [[UIView alloc] init];
        _timeLine.backgroundColor = RGBColor(142, 142, 142);
    }
    return _timeLine;
}

-(UILabel *)experienceTime {
    if (!_experienceTime) {
        _experienceTime = [[UILabel alloc] init];
        _experienceTime.textColor = RGBColor(142, 142, 142);
        _experienceTime.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _experienceTime;
}

-(UILabel *)company {
    if (!_company) {
        _company = [[UILabel alloc] init];
        _company.textColor = RGBColor(51, 51, 51);
        _company.font = [UIFont fontWithName:BFfont size:16.0f];
    }
    return _company;
}

-(UILabel *)position {
    if (!_position) {
        _position = [[UILabel alloc] init];
        _position.textColor = RGBColor(51, 51, 51);
        _position.font = [UIFont fontWithName:BFfont size:16.0f];
    }
    return _position;
}

-(UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setBackgroundImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(clickEditAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

-(UILabel *)experienceContent {
    if (!_experienceContent) {
        _experienceContent = [[UILabel alloc] init];
        _experienceContent.text = @"";
        _experienceContent.textColor = RGBColor(102, 102, 102);
        _experienceContent.numberOfLines = 0;
        _experienceContent.lineBreakMode = NSLineBreakByWordWrapping;
        _experienceContent.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _experienceContent;
}

-(void)clickEditAction {
    if (self.pushEditBlock) {
        self.pushEditBlock();
    }
}



@end
