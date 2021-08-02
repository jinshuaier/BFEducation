//
//  BFTipTopCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/2/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFTipTopCell.h"

@implementation BFTipTopCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.headImg];
        [self addSubview:self.headNickname];
        [self addSubview:self.tipTitle];
        [self addSubview:self.tipImg];
        [self addSubview:self.watchImg];
        [self addSubview:self.watchLbl];
        [self addSubview:self.zanImg];
        [self addSubview:self.zanLbl];
        [self addSubview:self.line];
    }
    return self;
}

-(void)layoutSubviews {
    self.headImg.frame = CGRectMake(20, 10, 30, 30);
    self.headImg.layer.cornerRadius = 30/2;
    self.headImg.clipsToBounds = YES;
    self.headNickname.frame = CGRectMake(self.headImg.right + 10, 10, 200, 30);
    self.tipTitle.frame = CGRectMake(20, self.headImg.bottom + 5, KScreenW - 40, 40);
    self.tipImg.frame = CGRectMake(20, self.tipTitle.bottom + 14, KScreenW - 40, 170);
    self.watchImg.frame = CGRectMake(20, self.tipImg.bottom + 12.5, 20, 15);
    self.watchLbl.frame = CGRectMake(self.watchImg.right + 5, self.tipImg.bottom + 10, 40, 20);
    self.zanImg.frame = CGRectMake(self.watchLbl.right, self.tipImg.bottom + 12.5, 20, 15);
    self.zanLbl.frame = CGRectMake(self.zanImg.right + 5, self.tipImg.bottom + 10, 40, 20);
    self.line.frame = CGRectMake(20, self.watchImg.bottom + 10, KScreenW - 40, 0.50f);
}

-(UIImageView *)headImg {
    if (_headImg == nil) {
        _headImg = [[UIImageView alloc] init];
        _headImg.image = PLACEHOLDER;
    }
    return _headImg;
}

-(UILabel *)headNickname {
    if (_headNickname == nil) {
        _headNickname = [[UILabel alloc] init];
        _headNickname.text = @"汽修达人大C罗";
        _headNickname.textColor = RGBColor(153, 153, 153);
        _headNickname.font = [UIFont fontWithName:BFfont size:12.0f];
    }
    return _headNickname;
}

-(UILabel *)tipTitle {
    if (_tipTitle == nil) {
        _tipTitle = [[UILabel alloc] init];
        _tipTitle.text = @"特斯拉常见故障100例！！！";
        _tipTitle.textColor = [UIColor blackColor];
        _tipTitle.font = [UIFont fontWithName:BFfont size:16.0f];
        _tipTitle.numberOfLines = 0;
    }
    return _tipTitle;
}

-(UIImageView *)tipImg {
    if (_tipImg == nil) {
        _tipImg = [[UIImageView alloc] init];
        _tipImg.image = PLACEHOLDER;
        _tipImg.layer.cornerRadius = 5.0f;
        _tipImg.clipsToBounds = YES;
        _tipImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _tipImg;
}

-(UIImageView *)watchImg {
    if (_watchImg == nil) {
        _watchImg = [[UIImageView alloc] init];
        _watchImg.image = [UIImage imageNamed:@"eye"];
    }
    return _watchImg;
}

-(UILabel *)watchLbl {
    if (_watchLbl == nil) {
        _watchLbl = [[UILabel alloc] init];
        _watchLbl.text = @"100";
        _watchLbl.textColor = RGBColor(153, 153, 153);
        _watchLbl.font = [UIFont fontWithName:BFfont size:12.0f];
    }
    return _watchLbl;
}

-(UIImageView *)zanImg {
    if (_zanImg == nil) {
        _zanImg = [[UIImageView alloc] init];
        _zanImg.image = [UIImage imageNamed:@"赞-3拷贝6"];
    }
    return _zanImg;
}

-(UILabel *)zanLbl {
    if (_zanLbl == nil) {
        _zanLbl = [[UILabel alloc] init];
        _zanLbl.text = @"200";
        _zanLbl.textColor = RGBColor(153, 153, 153);
        _zanLbl.font = [UIFont fontWithName:BFfont size:12.0f];
    }
    return _zanLbl;
}

-(UIView *)line {
    if (_line == nil) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGBColor(237, 237, 237);
    }
    return _line;
}
@end
