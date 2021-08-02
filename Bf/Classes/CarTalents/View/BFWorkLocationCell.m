//
//  BFWorkLocationCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/16.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFWorkLocationCell.h"

@interface BFWorkLocationCell()

@end

@implementation BFWorkLocationCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.locationImg];
        [self addSubview:self.locationLbl];
        [self addSubview:self.detailLbl];
        [self addSubview:self.line];
        [self addSubview:self.line00];
    }
    return self;
}

-(void)layoutSubviews {
    self.locationImg.frame = CGRectMake(15, 15, 15, 20);
    self.locationLbl.frame = CGRectMake(self.locationImg.right + 5, 15, 100, 20);
    self.line00.frame = CGRectMake(15, self.locationImg.bottom + 15, KScreenW - 30, 0.50f);
    self.detailLbl.frame = CGRectMake(26, self.line00.bottom + 15, KScreenW - 52, 20);
    self.line.frame = CGRectMake(0, self.detailLbl.bottom + 15, KScreenW, 10.0f);
}

-(UIImageView *)locationImg {
    if (!_locationImg) {
        _locationImg = [[UIImageView alloc] init];
        _locationImg.image = [UIImage imageNamed:@"定位"];
    }
    return _locationImg;
}

-(UILabel *)locationLbl {
    if (!_locationLbl) {
        _locationLbl = [[UILabel alloc] init];
        _locationLbl.text = @"工作地址";
        _locationLbl.textColor = RGBColor(51, 51, 51);
        _locationLbl.font = [UIFont fontWithName:BFfont size:16.0f];
    }
    return _locationLbl;
}

-(UILabel *)detailLbl {
    if (!_detailLbl) {
        _detailLbl = [[UILabel alloc] init];
        _detailLbl.text = @"北京市海淀区韦伯时代中心C座907";
        _detailLbl.textColor = RGBColor(102, 102, 102);
        _detailLbl.font = [UIFont fontWithName:BFfont size:13.0f];
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
