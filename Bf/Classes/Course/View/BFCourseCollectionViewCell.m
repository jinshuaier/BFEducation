//
//  BFCourseCollectionViewCell.m
//  Bf
//
//  Created by 春晓 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCourseCollectionViewCell.h"

@interface BFCourseCollectionViewCell ()
// img
@property (nonatomic , strong) UIImageView *imgView;
// title
@property (nonatomic , strong) UILabel *titleLabel;
// 播放次数
@property (nonatomic , strong) UILabel *showCountLabel;
@end

@implementation BFCourseCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgView];
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 5;
    _imgView.image = [UIImage imageNamed:@"组3"];
    
    UIImageView *actionImage = [[UIImageView alloc] init];
    actionImage.image = [UIImage imageNamed:@"1播放"];
    actionImage.contentMode = UIViewContentModeScaleAspectFill;
    [_imgView addSubview:actionImage];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"奔驰故障案例100例";
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = RGBColor(51, 51, 51);
    [self.contentView addSubview:_titleLabel];
    
    UIImageView *iconImage = [[UIImageView alloc] init];
    iconImage.image = [UIImage imageNamed:@"播放量"];
    [self.contentView addSubview:iconImage];
    
    _showCountLabel = [[UILabel alloc] init];
    _showCountLabel.text = @"1.6万次播放";
    _showCountLabel.font = [UIFont systemFontOfSize:11];
    _showCountLabel.textColor = RGBColor(161,165,169);
    [self.contentView addSubview:_showCountLabel];
    
    _imgView.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .heightIs(100);
    
    actionImage.sd_layout
    .centerXIs(CollectionCellWidth / 2.0)
    .centerYIs(100 / 2.0)
    .widthIs(40)
    .heightIs(40);
    
    _titleLabel.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(_imgView, 10)
    .rightEqualToView(self.contentView)
    .heightIs(14);
    
    iconImage.sd_layout
    .leftEqualToView(self.contentView)
    .topSpaceToView(_titleLabel, 10)
    .widthIs(9)
    .heightIs(9);
    
    _showCountLabel.sd_layout
    .leftSpaceToView(iconImage,4)
    .topSpaceToView(_titleLabel, 8)
    .rightEqualToView(self.contentView)
    .heightIs(12);
}

- (void)setCourseDict:(NSDictionary *)courseDict{
    _courseDict = courseDict;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_courseDict[@"ccover"]] placeholderImage:[UIImage imageNamed:@"组3"]];
    _titleLabel.text = _courseDict[@"ctitle"];
    if ([_courseDict[@"hotnum"] integerValue] >= 10000) {
        _showCountLabel.text = [NSString stringWithFormat:@"%.2lf万次播放",[_courseDict[@"hotnum"] integerValue] / 10000.0];
    }else{
        _showCountLabel.text = [NSString stringWithFormat:@"%@次播放",_courseDict[@"hotnum"]];
    }
    
}

@end
