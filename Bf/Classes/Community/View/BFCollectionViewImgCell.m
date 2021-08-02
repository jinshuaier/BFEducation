//
//  BFCollectionViewImgCell.m
//  Bf
//
//  Created by 春晓 on 2017/11/27.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCollectionViewImgCell.h"
#import <SDAutoLayout.h>

@interface BFCollectionViewImgCell ()

@end
@implementation BFCollectionViewImgCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgView];
    [_imgView setContentMode:UIViewContentModeScaleAspectFill];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 6;
    _imgView.clipsToBounds = YES;
    _imgView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    _totalCountLabel = [[UILabel alloc] init];
    _totalCountLabel.textAlignment = NSTextAlignmentCenter;
    _totalCountLabel.textColor = [UIColor whiteColor];
    _totalCountLabel.layer.masksToBounds = YES;
    _totalCountLabel.layer.cornerRadius = 6;
    [_totalCountLabel setFont:[UIFont fontWithName:BFfont size:PXTOPT(32)]];
    _totalCountLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [self.contentView addSubview:_totalCountLabel];
    _totalCountLabel.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
}



@end
