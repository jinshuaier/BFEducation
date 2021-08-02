//
//  BFSerCourseView.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFSerCourseView.h"

@interface BFSerCourseView()

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation BFSerCourseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.postImg];
        [self addSubview:self.postLbl];
        [self addSubview:self.logoImg];
        [self addSubview:self.logoNumber];
        [self addSubview:self.playImg];
    }
    return self;
}

-(void)layoutSubviews {
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appDelegate = appDelegate;
    self.postImg.frame = CGRectMake(15, 15, 125    , 80   );
    self.playImg.frame = CGRectMake(15 + (self.postImg.width - 45    )/2, 15 + (self.postImg.height - 45    )/2, 45    , 45    );
    self.postLbl.frame = CGRectMake(15, self.postImg.bottom + 15, 125    , 15);
    self.logoImg.frame = CGRectMake(15, self.postLbl.bottom + 15, 9    , 11   );
    self.logoNumber.frame = CGRectMake(self.logoImg.right + 5, self.postLbl.bottom + 15, 100    , 11   );
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
        _postLbl.text = @"敬请期待";
        _postLbl.textColor = RGBColor(51, 51, 51);
        _postLbl.font = [UIFont fontWithName:BFfont size:13.0f];
    }
    return _postLbl;
}

-(UIImageView *)logoImg {
    if (_logoImg == nil) {
        _logoImg = [[UIImageView alloc] init];
        _logoImg.image = [UIImage imageNamed:@"播放量"];
        _logoImg.clipsToBounds = YES;
    }
    return _logoImg;
}

-(UILabel *)logoNumber {
    if (_logoNumber == nil) {
        _logoNumber = [[UILabel alloc] init];
        _logoNumber.text = @"0万播放量";
        _logoNumber.textColor = RGBColor(161,165,169);
        _logoNumber.font = [UIFont fontWithName:BFfont size:11.0f];
    }
    return _logoNumber;
}

-(UIImageView *)playImg {
    if (_playImg == nil) {
        _playImg = [[UIImageView alloc] init];
        _playImg.image = [UIImage imageNamed:@"1播放"];
        _playImg.clipsToBounds = YES;
    }
    return _playImg;
}
@end
