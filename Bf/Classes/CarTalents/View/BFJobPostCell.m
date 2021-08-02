//
//  BFJobPostCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/16.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFJobPostCell.h"

@interface BFJobPostCell()

@end

@implementation BFJobPostCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.postImg];
        [self addSubview:self.postLbl];
        [self addSubview:self.postPeopleName];
        [self addSubview:self.postPeopleImg];
        [self addSubview:self.postPeopleJob];
        [self addSubview:self.line];
        [self addSubview:self.line00];
    }
    return self;
}

-(void)layoutSubviews {
    self.postImg.frame = CGRectMake(15, 15, 15, 20);
    self.postLbl.frame = CGRectMake(self.postImg.right + 5, 15, 100, 20);
    self.line00.frame = CGRectMake(15, self.postImg.bottom + 15, KScreenW - 30, 0.50f);
    self.postPeopleImg.frame = CGRectMake(15, self.line00.bottom + 18, 48, 48);
    self.postPeopleImg.clipsToBounds = YES;
    self.postPeopleImg.layer.cornerRadius = 24.0f;
    self.postPeopleName.frame = CGRectMake(self.postPeopleImg.right + 15, self.line00.bottom + 15, KScreenW - self.postPeopleImg.width - 30, 24);
    self.postPeopleJob.frame = CGRectMake(self.postPeopleImg.right + 15, self.postPeopleName.bottom, KScreenW - self.postPeopleImg.width - 30, 24);
    self.line.frame = CGRectMake(0, self.postPeopleImg.bottom + 15, KScreenW, 10.0f);
}

-(UIImageView *)postImg {
    if (!_postImg) {
        _postImg = [[UIImageView alloc] init];
        _postImg.image = [UIImage imageNamed:@"职位发布者"];
    }
    return _postImg;
}

-(UILabel *)postLbl {
    if (!_postLbl) {
        _postLbl = [[UILabel alloc] init];
        _postLbl.text = @"职位发布者";
        _postLbl.textColor = RGBColor(51, 51, 51);
        _postLbl.font = [UIFont fontWithName:BFfont size:16.0f];
    }
    return _postLbl;
}

-(UIImageView *)postPeopleImg {
    if (!_postPeopleImg) {
        _postPeopleImg = [[UIImageView alloc] init];
        _postPeopleImg.image = [UIImage imageNamed:@"logo-2"];
    }
    return _postPeopleImg;
}

-(UILabel *)postPeopleName {
    if (!_postPeopleName) {
        _postPeopleName = [[UILabel alloc] init];
        _postPeopleName.text = @"陈大鹰";
        _postPeopleName.textColor = RGBColor(51, 51, 51);
        _postPeopleName.font = [UIFont fontWithName:BFfont size:15.0f];
    }
    return _postPeopleName;
}

-(UILabel *)postPeopleJob {
    if (!_postPeopleJob) {
        _postPeopleJob = [[UILabel alloc] init];
        _postPeopleJob.text = @"北方网校·iOS开发工程师";
        _postPeopleJob.textColor = RGBColor(102, 102, 102);
        _postPeopleJob.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _postPeopleJob;
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
