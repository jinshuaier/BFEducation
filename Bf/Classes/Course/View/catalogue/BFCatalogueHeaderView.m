//
//  BFCatalogueHeaderView.m
//  NewTest
//
//  Created by 春晓 on 2017/12/1.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCatalogueHeaderView.h"
#include <SDAutoLayout.h>

@implementation BFCatalogueHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.backgroundColor = RGBColor(248,250,252);
    }
    return self;
}

- (void)setupUI{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(30)];
    [self addSubview:_titleLabel];
    _titleLabel.sd_layout
    .leftSpaceToView(self, PXTOPT(20))
    .rightSpaceToView(self, PXTOPT(20))
    .topEqualToView(self)
    .bottomEqualToView(self);
    
    _openButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:_openButton];
    _openButton.sd_layout
    .leftEqualToView(self)
    .rightEqualToView(self)
    .topEqualToView(self)
    .bottomEqualToView(self);
    
    _imgView = [[UIImageView alloc] init];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgView];
    _imgView.sd_layout
    .widthIs(20)
    .rightSpaceToView(self, PXTOPT(30))
    .topEqualToView(self)
    .bottomEqualToView(self);
}

@end
