//
//  BFCollectionViewCell.m
//  Bf
//
//  Created by 春晓 on 2017/11/28.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCollectionViewCell.h"
#import <SDAutoLayout.h>
@interface BFCollectionViewCell ()
// 显示图片
@property (nonatomic , strong) UIImageView *imgView;
// 标题
@property (nonatomic , strong) UILabel *titleLabel;
// 描述
@property (nonatomic , strong) UILabel *descriptionLabel;
// 学分
@property (nonatomic , strong) UILabel *creditLabel;
@end
@implementation BFCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self sutupUI];
        [self layout];
        //        self.contentView.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)sutupUI{
    _imgView = [[UIImageView alloc] init];
    [self .contentView addSubview:_imgView];
    //    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    //    _imgView.clipsToBounds = YES;
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:PXTOPT(24)];
    _titleLabel.textColor = [UIColor whiteColor];
    _descriptionLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_descriptionLabel];
    _descriptionLabel.font = [UIFont systemFontOfSize:PXTOPT(20)];
    _descriptionLabel.textColor = [UIColor whiteColor];
    _creditLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_creditLabel];
    _creditLabel.font = [UIFont systemFontOfSize:PXTOPT(20)];
    _creditLabel.textColor = [UIColor whiteColor];
    _creditLabel.hidden = YES;
    [_titleLabel bringSubviewToFront:_imgView];
    
}

- (void)layout{
    _imgView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(30))
    .topSpaceToView(self.contentView, PXTOPT(40))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .heightIs(PXTOPT(24));
    
    _descriptionLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(30))
    .topSpaceToView(_titleLabel, PXTOPT(15))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .heightIs(PXTOPT(20));
    
    _creditLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(30))
    .topSpaceToView(_descriptionLabel, PXTOPT(48))
    .rightSpaceToView(self.contentView, PXTOPT(20))
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
