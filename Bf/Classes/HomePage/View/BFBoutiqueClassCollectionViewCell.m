//
//  BFBoutiqueClassCollectionViewCell.m
//  Bf
//
//  Created by 春晓 on 2017/11/24.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBoutiqueClassCollectionViewCell.h"
#import <SDAutoLayout.h>

@interface BFBoutiqueClassCollectionViewCell ()
// 显示图片
@property (nonatomic , strong) UIImageView *imgView;
// 标题
@property (nonatomic , strong) UILabel *titleLabel;
// 描述
@property (nonatomic , strong) UILabel *descriptionLabel;
// 学分
@property (nonatomic , strong) UILabel *creditLabel;
@end
@implementation BFBoutiqueClassCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self sutupUI];
        [self layout];
    }
    return self;
}

- (void)sutupUI{
    _imgView = [[UIImageView alloc] init];
    [self .contentView addSubview:_imgView];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _titleLabel = [[UILabel alloc] init];
    [_imgView addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:PXTOPT(24)];
    _titleLabel.textColor = [UIColor whiteColor];
    _descriptionLabel = [[UILabel alloc] init];
    [_imgView addSubview:_descriptionLabel];
    _descriptionLabel.font = [UIFont systemFontOfSize:PXTOPT(20)];
    _descriptionLabel.textColor = [UIColor whiteColor];
    _creditLabel = [[UILabel alloc] init];
    [_imgView addSubview:_creditLabel];
    _creditLabel.font = [UIFont systemFontOfSize:PXTOPT(20)];
    _creditLabel.textColor = [UIColor whiteColor];
    
    [_titleLabel bringSubviewToFront:_imgView];
    
}

- (void)layout{
    _imgView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(40))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_imgView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(40))
    .rightSpaceToView(_imgView, PXTOPT(20))
    .heightIs(PXTOPT(24));
    
    _descriptionLabel.sd_layout
    .leftSpaceToView(_imgView, PXTOPT(20))
    .topSpaceToView(_titleLabel, PXTOPT(40))
    .rightSpaceToView(_imgView, PXTOPT(20))
    .heightIs(PXTOPT(20));
    
    _creditLabel.sd_layout
    .leftSpaceToView(_imgView, PXTOPT(20))
    .topSpaceToView(_descriptionLabel, PXTOPT(48))
    .rightSpaceToView(_imgView, PXTOPT(20))
    .heightIs(PXTOPT(20));
}

- (void)setCourseModel:(BFCourseModel *)courseModel{
    _courseModel = courseModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_courseModel.cscover] placeholderImage:[UIImage imageNamed:@"组3"]];
    _titleLabel.text = _courseModel.ctitle;
    _descriptionLabel.text = _courseModel.descriptionStr;
    _creditLabel.text = [NSString stringWithFormat:@"%ld",_courseModel.cprice];
}

- (void)setSetCourseModel:(BFSetCourseModel *)setCourseModel{
    _setCourseModel = setCourseModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_setCourseModel.cscover] placeholderImage:[UIImage imageNamed:@"组3"]];
    _titleLabel.text = _setCourseModel.cstitle;
    _descriptionLabel.text = _setCourseModel.descriptionStr;
    _creditLabel.text = [NSString stringWithFormat:@"%ld",_setCourseModel.csprice];
}

@end
