//
//  BFCarCenterView.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCarCenterView.h"
#define imgWidth (KScreenW - 15 * 3)/2

@interface BFCarCenterView()
@property (nonatomic, strong) AppDelegate *appDelegate;
@end
@implementation BFCarCenterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.postImg];
        [self addSubview:self.postLbl];
        [self addSubview:self.icon];
        [self addSubview:self.num];
        [self addSubview:self.playImg];
    }
    return self;
}

-(void)layoutSubviews {
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appDelegate = appDelegate;
    self.postImg.frame = CGRectMake(0, 0, imgWidth, 100    );
    self.postLbl.frame = CGRectMake(0, self.postImg.bottom + 10, imgWidth, 15    );
    self.playImg.frame = CGRectMake((imgWidth - 30)/2, (100 - 30)/2    , 30    , 30    );
    self.icon.frame = CGRectMake(0, self.postLbl.bottom + 10, 9    , 12    );
    self.num.frame = CGRectMake(self.icon.right + 5, self.postLbl.bottom + 10, imgWidth - self.icon.right, 11);
}

-(UIImageView *)postImg {
    if (_postImg == nil) {
        _postImg = [[UIImageView alloc] init];
        _postImg.image = [UIImage imageNamed:@"汽配商务banner"];
        _postImg.layer.cornerRadius = 6.0f;
        _postImg.clipsToBounds = YES;
    }
    return _postImg;
}

-(UILabel *)postLbl {
    if (_postLbl == nil) {
        _postLbl = [[UILabel alloc] init];
        _postLbl.text = @"德国汽车实训系统";
        _postLbl.textColor = RGBColor(51, 51, 51);
        _postLbl.font = [UIFont fontWithName:BFfont size:13.0f];
    }
    return _postLbl;
}

-(UIImageView *)icon {
    if (_icon == nil) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"播放量"];
    }
    return _icon;
}

-(UILabel *)num {
    if (_num == nil) {
        _num = [[UILabel alloc] init];
        _num.text = @"23万次播放";
        _num.textColor = RGBColor(161, 165, 169);
        _num.font = [UIFont fontWithName:BFfont size:11.0f];
    }
    return _num;
}

-(UIImageView *)playImg {
    if (_playImg == nil) {
        _playImg = [[UIImageView alloc] init];
        _playImg.image = [UIImage imageNamed:@"暂停"];
    }
    return _playImg;
}


@end
