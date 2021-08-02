//
//  BFCompanyWorkDetailCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/15.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCompanyWorkDetailCell.h"

@interface BFCompanyWorkDetailCell()

@end

@implementation BFCompanyWorkDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.workImg];
        [self addSubview:self.workLbl];
        [self addSubview:self.detailLbl];
        [self addSubview:self.line];
        [self addSubview:self.line00];
    }
    return self;
    
}

-(void)layoutSubviews {
    self.workImg.frame = CGRectMake(15, 15, 15, 20);
    self.workLbl.frame = CGRectMake(self.workImg.right + 5, 15, 100, 20);
    self.line00.frame = CGRectMake(15, self.workImg.bottom + 15, KScreenW - 30, 0.50f);
    CGFloat height = [UILabel getHeightByWidth:self.detailLbl.frame.size.width title:self.detailLbl.text font:self.detailLbl.font];
    self.detailLbl.frame = CGRectMake(26, self.line00.bottom + 15, KScreenW - 52, height);
    self.line.frame = CGRectMake(0, self.detailLbl.bottom + 15, KScreenW, 10.0f);
}

-(UIImageView *)workImg {
    if (!_workImg) {
        _workImg = [[UIImageView alloc] init];
        _workImg.image = [UIImage imageNamed:@"职位描述"];
    }
    return _workImg;
}

-(UILabel *)workLbl {
    if (!_workLbl) {
        _workLbl = [[UILabel alloc] init];
        _workLbl.text = @"职位描述";
        _workLbl.textColor = RGBColor(51, 51, 51);
        _workLbl.font = [UIFont fontWithName:BFfont size:16.0f];
    }
    return _workLbl;
}

-(UILabel *)detailLbl {
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] init];
        _detailLbl.text = @"岗位职责:\n1.负责汽车产品检测,待维修车辆的故障判定并进行相关信息的整理和记录;\n2.处理相关来电咨询,及时准确处理所属各类别产品的维修案件的审核;\n3.负责向用户解答相关产品的技术问题;\n4.负责汽车产品检测,待维修车辆的故障判定并进行相关信息的整理和记录;\n5.处理相关来电咨询,及时准确处理所属各类别产品的维修案件的审核;\n6.负责向用户解答相关产品的技术问题;";
        _detailLbl.textColor = RGBColor(102, 102, 102);
        _detailLbl.numberOfLines = 0;
        _detailLbl.lineBreakMode = NSLineBreakByWordWrapping;
        _detailLbl.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _detailLbl;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = ColorRGBValue(0xefefef);
    }
    return _line;
}

-(UIView *)line00 {
    if (!_line00) {
        _line00 = [[UIView alloc] init];
        _line00.backgroundColor = ColorRGBValue(0xefefef);
    }
    return _line00;
}

@end
