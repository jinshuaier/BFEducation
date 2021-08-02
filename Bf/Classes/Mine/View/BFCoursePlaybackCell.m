//
//  BFPlaybackCell.m
//  Bf
//
//  Created by 春晓 on 2018/5/24.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCoursePlaybackCell.h"

@interface BFCoursePlaybackCell ()

// 封面图
@property (nonatomic , strong) UIImageView *titleImgView;
// 标题
@property (nonatomic , strong) UILabel *titleLabel;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;
// 发布
@property (nonatomic , strong) UIButton *publishBtn;

@end

@implementation BFCoursePlaybackCell{
    UIView *lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _titleImgView = [[UIImageView alloc] init];
    _titleImgView.image = [UIImage imageNamed:@"图层12"];
    _titleImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_titleImgView];
    
    UIImageView *actionImage = [[UIImageView alloc] init];
    actionImage.image = [UIImage imageNamed:@"1播放"];
    actionImage.contentMode = UIViewContentModeScaleAspectFit;
    [_titleImgView addSubview:actionImage];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"解析纯电动汽车《驱动电机》";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = RGBColor(51, 51, 51);
    [self.contentView addSubview:_titleLabel];
    
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"开始时间 : 3-20 16:00\n结束时间 : 3-20 16:00";
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _timeLabel.numberOfLines = 0;
    _timeLabel.textColor = RGBColor(153,153,153);
    [self.contentView addSubview:_timeLabel];
    
    _publishBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    _publishBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [_publishBtn setTitleColor:RGBColor(51,150,252) forState:UIControlStateNormal];
    _publishBtn.layer.masksToBounds = YES;
    _publishBtn.layer.cornerRadius = 3;
    _publishBtn.layer.borderWidth = 1.0f;
    _publishBtn.layer.borderColor = RGBColor(51,150,252).CGColor;
    [_publishBtn addTarget:self action:@selector(publishBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_publishBtn];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBColor(240, 240, 240);
    [self.contentView addSubview:lineView];
    
    _titleImgView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topSpaceToView(self.contentView, 10)
    .bottomSpaceToView(self.contentView, 10)
    .widthIs(109);
    
    actionImage.sd_layout
    .centerXIs(109 / 2.0)
    .widthIs(50)
    .topEqualToView(_titleImgView)
    .bottomEqualToView(_titleImgView);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_titleImgView, 9)
    .topEqualToView(_titleImgView)
    .heightIs(15)
    .rightSpaceToView(self.contentView, 15);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_titleImgView, 9)
    .topSpaceToView(_titleLabel, 15)
    .bottomEqualToView(_titleImgView)
    .rightSpaceToView(self.contentView, 15);
    
    _publishBtn.sd_layout
    .rightSpaceToView(self.contentView, 9)
    .heightIs(25)
    .widthIs(57)
    .bottomEqualToView(_titleImgView);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .bottomEqualToView(self.contentView)
    .heightIs(0.5);
}

- (void)publishBtnClick:(UIButton *)btn {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
