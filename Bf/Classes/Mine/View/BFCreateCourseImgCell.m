//
//  BFCreateCourseImgCell.m
//  Bf
//
//  Created by 春晓 on 2018/5/23.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCreateCourseImgCell.h"

@interface BFCreateCourseImgCell ()
// 选择图片按钮
@property (nonatomic , strong) UIButton *selectLogoBtn;
@end

@implementation BFCreateCourseImgCell

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
    
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.text = @"课程名称";
    _leftLabel.font = [UIFont systemFontOfSize:14];
    _leftLabel.textColor = RGBColor(51, 51, 51);
    [self.contentView addSubview:_leftLabel];
    
    _logoImgView = [[UIImageView alloc] init];
    _logoImgView.contentMode = UIViewContentModeScaleAspectFill;
    _logoImgView.image = [UIImage imageNamed:@"上传"];
    _logoImgView.layer.borderWidth = 0.5;
    _logoImgView.layer.borderColor = RGBColor(178, 178, 178).CGColor;
    _logoImgView.layer.masksToBounds = YES;
    _logoImgView.layer.cornerRadius = 4;
    [self.contentView addSubview:_logoImgView];
    
    _selectLogoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_selectLogoBtn addTarget:self action:@selector(selectLogoBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_selectLogoBtn];
    
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topEqualToView(self.contentView)
    .heightIs(40)
    .widthIs(200);
    
    _logoImgView.sd_layout
    .leftEqualToView(_leftLabel)
    .topSpaceToView(_leftLabel, 10)
    .bottomSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 15);
    
    _selectLogoBtn.sd_layout
    .leftEqualToView(_leftLabel)
    .topSpaceToView(_leftLabel, 10)
    .bottomSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 15);
}

- (void)selectLogoBtnClick:(UIButton *)btn {
    if (_delegate && [_delegate respondsToSelector:@selector(selectLogoAction)]) {
        [_delegate selectLogoAction];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
