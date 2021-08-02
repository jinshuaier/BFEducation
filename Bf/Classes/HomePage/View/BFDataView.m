//
//  BFDataView.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/18.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFDataView.h"

@interface BFDataView()

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation BFDataView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dataImage];
        [self addSubview:self.dataTitle];
        [self addSubview:self.download];
    }
    return self;
}

-(void)layoutSubviews {
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appDelegate = appDelegate;
    self.dataImage.frame = CGRectMake(0, 0, 112    , 148.5    );
    self.dataTitle.frame = CGRectMake(0, self.dataImage.bottom + 15, 112    , 15    );
    self.download.frame = CGRectMake((112 - 80)/2    , self.dataTitle.bottom + 15, 80    , 25    );
    self.download.layer.cornerRadius = 12.5    ;
}

-(UIImageView *)dataImage {
    if (_dataImage == nil) {
        _dataImage = [[UIImageView alloc] init];
        _dataImage.image = [UIImage imageNamed:@"原厂资料-奔驰"];
    }
    return _dataImage;
}

-(UILabel *)dataTitle {
    if (_dataTitle == nil) {
        _dataTitle = [[UILabel alloc] init];
        _dataTitle.text = @"奔驰电路图";
        _dataTitle.textColor = RGBColor(51, 51, 51);
        _dataTitle.font = [UIFont fontWithName:BFfont size:12.0f];
        _dataTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _dataTitle;
}

-(UILabel *)download {
    if (_download == nil) {
        _download = [[UILabel alloc] init];
        _download.text = @"在线预览";
        _download.userInteractionEnabled = YES;
        _download.backgroundColor = RGBColor(239, 247, 255);
        _download.textColor = RGBColor(51, 150, 252);
        _download.font = [UIFont fontWithName:BFfont size:11.0f];
        _download.textAlignment = NSTextAlignmentCenter;
        _download.clipsToBounds = YES;
    }
    return _download;
}

@end
