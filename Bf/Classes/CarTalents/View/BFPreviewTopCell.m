//
//  BFPreviewTopCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/4.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFPreviewTopCell.h"

@implementation BFPreviewTopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.backView];
        [self addSubview:self.titleOne];
        [self addSubview:self.headImg];
        [self addSubview:self.nickName];
        [self addSubview:self.exResume];
    }
    return self;
}

-(void)layoutSubviews {
    self.backView.frame = CGRectMake(0, 0, KScreenW, 254.0f);
    self.titleOne.frame = CGRectMake(0, 40, KScreenW, 40);
    self.headImg.frame = CGRectMake((KScreenW - 70)/2, self.titleOne.bottom + 15, 70, 70);
    self.headImg.layer.cornerRadius = 35.0f;
    self.nickName.frame = CGRectMake(0, self.headImg.bottom + 15, KScreenW, 30);
    self.exResume.frame = CGRectMake(0, self.nickName.bottom + 10, KScreenW, 25);
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nologin"]];
    }
    return _backView;
}
-(UILabel *)titleOne {
    if (!_titleOne) {
        _titleOne = [[UILabel alloc] init];
        _titleOne.text = @"简历预览";
        _titleOne.textColor = [UIColor whiteColor];
        _titleOne.font = [UIFont fontWithName:BFfont size:17.0f];
        _titleOne.textAlignment = NSTextAlignmentCenter;
    }
    return _titleOne;
}

-(UIImageView *)headImg {
    if (!_headImg) {
        _headImg = [[UIImageView alloc] init];
        _headImg.clipsToBounds = YES;
    }
    return _headImg;
}

-(UILabel *)nickName {
    if (!_nickName) {
        _nickName = [[UILabel alloc] init];
        _nickName.text = @"名称 - 性别";
        _nickName.textColor = RGBColor(220, 243, 254);
        _nickName.font = [UIFont fontWithName:BFfont size:14.0f];
        _nickName.textAlignment = NSTextAlignmentCenter;
    }
    return _nickName;
}

-(UILabel *)exResume {
    if (!_exResume) {
        _exResume = [[UILabel alloc] init];
        _exResume.textAlignment = NSTextAlignmentCenter;
        _exResume.textColor = RGBColor(184, 229, 250);
        _exResume.font = [UIFont fontWithName:BFfont size:16.0f];
        _exResume.userInteractionEnabled = YES;
        _exResume.text = @"个人简历.docx";
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTapAction)];
        [_exResume addGestureRecognizer:ges];
    }
    return _exResume;
}

//
-(void)clickTapAction {
    if (self.pushResumeBlock) {
        self.pushResumeBlock();
    }
}

@end
