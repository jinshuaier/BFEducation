//
//  BFMineView.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/24.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFMineView.h"

@interface BFMineView()

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation BFMineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.img];
        [self addSubview:self.title];
        [self addSubview:self.rightImg];
    }
    return self;
}

-(void)layoutSubviews {
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appDelegate = appDelegate;
    
    self.img.frame = CGRectMake(10 , 15  , 17 , 17  );
    self.title.frame = CGRectMake(self.img.right + 5, 13.5  , 200, 20  );
    self.rightImg.frame = CGRectMake((KScreenW - 15 - 15 - 6 - 15), 16  , 6 , 13  );
}

-(UIImageView *)img {
    if (_img == nil) {
        _img = [[UIImageView alloc] init];
        _img.image = [UIImage imageNamed:@"留言"];
    }
    return _img;
}

-(UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc] init];
        _title.text = @"个人设置";
        _title.textColor = RGBColor(51, 51, 51);
        _title.font = [UIFont fontWithName:BFfont size:15.0f];
        _title.textAlignment = NSTextAlignmentLeft;
    }
    return _title;
}

-(UIImageView *)rightImg {
    if (_rightImg == nil) {
        _rightImg = [[UIImageView alloc] init];
        _rightImg.image = [UIImage imageNamed:@"图层8"];
    }
    return _rightImg;
}

@end
