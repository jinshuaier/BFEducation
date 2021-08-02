//
//  BFJobHunterCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/21.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFJobHunterCell.h"

@interface BFJobHunterCell()
/*求职者头像*/
@property (nonatomic,strong) UIImageView *headImg;
/*求职者名称*/
@property (nonatomic,strong) UILabel *nickname;
/*求职者工作经历*/
@property (nonatomic,strong) UILabel *year;
/*下划线*/
@property (nonatomic,strong) UIView *line;

@end

@implementation BFJobHunterCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.headImg];
        [self addSubview:self.nickname];
        [self addSubview:self.year];
        [self addSubview:self.line];
    }
    return self;
}

-(void)setDataModel:(BFJobHunterModel *)dataModel {
    _dataModel = dataModel;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:dataModel.jRPhoto]];
    self.nickname.text = dataModel.jRName;
    
    NSString *str0 = [NSString stringWithFormat:@"%d",dataModel.jRYear];
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
    self.year.text = [NSString stringWithFormat:@" %@ ",str00];
}

-(void)layoutSubviews {
    self.headImg.frame = CGRectMake(15, 15, 40, 40);
    self.headImg.layer.cornerRadius = 20.0f;
    CGSize maximumLabelSize0 = CGSizeMake(200, 20);
    CGSize expectSize0 = [self.nickname sizeThatFits:maximumLabelSize0];
    self.nickname.frame = CGRectMake(self.headImg.right + 15, 25, expectSize0.width, 20);
    CGSize maximumLabelSize1 = CGSizeMake(200, 20);
    CGSize expectSize1 = [self.year sizeThatFits:maximumLabelSize1];
    self.year.frame = CGRectMake(self.nickname.right + 15, 25, expectSize1.width, 20);
    self.line.frame = CGRectMake(15, self.headImg.bottom + 15, KScreenW - 30, 0.50f);
}

-(UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        _headImg.clipsToBounds = YES;
    }
    return _headImg;
}

-(UILabel *)nickname {
    if (!_nickname) {
        _nickname = [[UILabel alloc] init];
        _nickname.text = @"陈大鹰-美国总统";
        _nickname.textColor = RGBColor(51, 51, 51);
        _nickname.font = [UIFont fontWithName:BFfont size:15.0f];
    }
    return _nickname;
}

-(UILabel *)year {
    if (!_year) {
        _year = [[UILabel alloc] init];
        _year.text = @"3年";
        _year.layer.borderWidth = 1.0f;
        _year.layer.borderColor = RGBColor(0, 148, 231).CGColor;
        _year.textColor = RGBColor(0, 148, 231);
        _year.textAlignment = NSTextAlignmentCenter;
        _year.layer.cornerRadius = 4.0f;
        _year.font = [UIFont fontWithName:BFfont size:11.0f];
    }
    return _year;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBColor(239, 239, 239);
    }
    return _line;
}
@end
