//
//  BFBFMyCourseHavePubCell.m
//  Bf
//
//  Created by 春晓 on 2018/5/24.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFMyCourseHavePubCell.h"
#import "NSString+Extension.h"
#import "BFTimeTransition.h"

@interface BFMyCourseHavePubCell ()

// 封面图
@property (nonatomic , strong) UIImageView *titleImgView;
// 标题
@property (nonatomic , strong) UILabel *titleLabel;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;
// 编辑
@property (nonatomic , strong) UIButton *editBtn;
// 发布
@property (nonatomic , strong) UIButton *publishBtn;
// 下架
@property (nonatomic , strong) UIButton *soldOutBtn;
// tag
@property (nonatomic , strong) UIImageView *tagImgView;
@end

#define TitleWidth (KScreenW - 109 - 30 - 9 - 30)

@implementation BFMyCourseHavePubCell{
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
    _titleImgView.clipsToBounds = YES;
    _titleImgView.layer.masksToBounds = YES;
    _titleImgView.layer.cornerRadius = 4;
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
    _timeLabel.text = @"开课时间 : 3-20 16:00 至 3-20 16:00";
    _timeLabel.font = [UIFont systemFontOfSize:11];
    _timeLabel.textColor = RGBColor(153,153,153);
    [self.contentView addSubview:_timeLabel];
    
    _editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_editBtn setImage:[UIImage imageNamed:@"编辑"] forState:(UIControlStateNormal)];
    [_editBtn setTitle:@"  编辑" forState:UIControlStateNormal];
    _editBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [_editBtn setTitleColor:RGBColor(161, 165, 169) forState:UIControlStateNormal];
    [_editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_editBtn];
    
//    _soldOutBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [_soldOutBtn setImage:[UIImage imageNamed:@"下架"] forState:(UIControlStateNormal)];
//    [_soldOutBtn setTitle:@" 下架" forState:UIControlStateNormal];
//    _soldOutBtn.titleLabel.font = [UIFont systemFontOfSize:11];
//    [_soldOutBtn setTitleColor:RGBColor(161, 165, 169) forState:UIControlStateNormal];
//    [_soldOutBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.contentView addSubview:_soldOutBtn];
    
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
    
    _tagImgView = [[UIImageView alloc] init];
    _tagImgView.image = [UIImage imageNamed:@"回放"];
    _tagImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_tagImgView];
    
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
    .rightSpaceToView(self.contentView, 48);
    
    _tagImgView.sd_layout
    .leftSpaceToView(_titleLabel, 3)
    .topEqualToView(_titleImgView)
    .heightIs(15)
    .widthIs(30);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_titleImgView, 9)
    .topSpaceToView(_titleLabel, 15)
    .heightIs(12)
    .rightSpaceToView(self.contentView, 15);
    
    _editBtn.sd_layout
    .leftSpaceToView(_titleImgView, 9)
    .heightIs(13)
    .widthIs(50)
    .bottomEqualToView(_titleImgView);
    
//    _soldOutBtn.sd_layout
//    .leftSpaceToView(_editBtn, 9)
//    .heightIs(13)
//    .widthIs(50)
//    .bottomEqualToView(_titleImgView);
    
    _publishBtn.sd_layout
    .rightSpaceToView(self.contentView, 9)
    .topSpaceToView(_timeLabel, 3)
    .widthIs(57)
    .bottomEqualToView(_titleImgView);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 15)
    .bottomEqualToView(self.contentView)
    .heightIs(0.5);
    
}

#pragma mark -按钮点击事件-

- (void)editBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(editAction:)]) {
        [_delegate editAction:self];
    }
}

- (void)publishBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(publishAction:)]) {
        [_delegate publishAction:self];
    }
}

- (void)setTitle{
    NSString *str = @"这是一节";
    _titleLabel.text = str;
    CGFloat w = [str widthWithFontSize:14];
    if (w > TitleWidth) {
        w = TitleWidth;
    }
    _titleLabel.sd_resetLayout
    .leftSpaceToView(_titleImgView, 9)
    .topEqualToView(_titleImgView)
    .heightIs(15)
    .widthIs(w);
    
    _tagImgView.sd_resetLayout
    .leftSpaceToView(_titleLabel, 3)
    .topEqualToView(_titleImgView)
    .heightIs(15)
    .widthIs(40);
}

- (void)setDict:(NSDictionary *)dict{
    if (_dict) {
        _dict = nil;
    }
    _dict = dict;
    _titleLabel.text = _dict[@"ctitle"];
    [_titleImgView sd_setImageWithURL:_dict[@"ccover"] placeholderImage:[UIImage imageNamed:@"组3"]];
    _timeLabel.text = [NSString stringWithFormat:@"%@ 至 %@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dict[@"cstarttime"]] dateFormat:@"MM-dd HH:mm"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dict[@"cendtime"]] dateFormat:@"MM-dd HH:mm"]];
    NSInteger state = [_dict[@"state"] integerValue];
    if (state == 1) {// 预告
        _publishBtn.hidden = NO;
        _publishBtn.enabled = YES;
        _tagImgView.image = [UIImage imageNamed:@"即将开始"];
        [_publishBtn setTitleColor:RGBColor(51,150,252) forState:(UIControlStateNormal)];
        _publishBtn.layer.borderColor = RGBColor(51,150,252).CGColor;
        [_publishBtn setTitle:@"开始上课" forState:(UIControlStateNormal)];
        _editBtn.enabled = YES;
    }else if (state == 2) {// 直播
        _publishBtn.hidden = NO;
        _publishBtn.enabled = YES;
        _tagImgView.image = [UIImage imageNamed:@"直播"];
        [_publishBtn setTitleColor:RGBColor(153, 153, 153) forState:(UIControlStateNormal)];
        _publishBtn.layer.borderColor = RGBColor(153, 153, 153).CGColor;
        [_publishBtn setTitle:@"直播中" forState:(UIControlStateNormal)];
        _editBtn.enabled = NO;
    }else if (state == 3) {// 结束
        _publishBtn.hidden = YES;
        _publishBtn.enabled = NO;
        _tagImgView.image = [UIImage imageNamed:@"结束"];
        _editBtn.enabled = NO;
    }else if (state == 4) {// 回放
        _publishBtn.hidden = YES;
        _publishBtn.enabled = NO;
        _tagImgView.image = [UIImage imageNamed:@"回放"];
        _editBtn.enabled = YES;
    }
    
    CGFloat w = [_dict[@"ctitle"] widthWithFontSize:14];
    if (w > TitleWidth) {
        w = TitleWidth;
    }
    _titleLabel.sd_resetLayout
    .leftSpaceToView(_titleImgView, 9)
    .topEqualToView(_titleImgView)
    .heightIs(15)
    .widthIs(w);
    
    _tagImgView.sd_resetLayout
    .leftSpaceToView(_titleLabel, 3)
    .topEqualToView(_titleImgView)
    .heightIs(15)
    .widthIs(40);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
