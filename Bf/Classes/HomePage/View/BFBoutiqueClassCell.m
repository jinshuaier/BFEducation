//
//  BFBoutiqueClassCell.m
//  Bf
//
//  Created by 春晓 on 2017/11/24.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBoutiqueClassCell.h"
#import "BFCourseModel.h"
#import "BFSetCourseModel.h"

@interface BFBoutiqueClassCell ()
// 显示图片
@property (nonatomic , strong) UIImageView *imgView;
// 标题
@property (nonatomic , strong) UILabel *titleLabel;
// 描述
@property (nonatomic , strong) UILabel *descriptionLabel;
// 学分
@property (nonatomic , strong) UILabel *creditLabel;
@end

@implementation BFBoutiqueClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    [self.contentView addSubview:_titleLabel];
    _titleLabel.font = [UIFont systemFontOfSize:PXTOPT(28)];
    _titleLabel.textColor = CCRGBColor(51, 51, 51);
    _descriptionLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_descriptionLabel];
    _descriptionLabel.font = [UIFont systemFontOfSize:PXTOPT(22)];
    _descriptionLabel.textColor = CCRGBColor(102, 102, 102);
    _creditLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_creditLabel];
    _creditLabel.font = [UIFont systemFontOfSize:PXTOPT(24)];
    _creditLabel.textColor = CCRGBColor(51, 51, 51);
    _creditLabel.hidden = YES;
}

- (void)layout{
    _imgView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(40))
    .topSpaceToView(self.contentView, PXTOPT(30))
    .widthIs(130)
    .bottomSpaceToView(self.contentView, PXTOPT(30));
    
    _titleLabel.sd_layout
    .leftSpaceToView(_imgView, PXTOPT(10))
    .topSpaceToView(self.contentView, PXTOPT(34))
    .rightSpaceToView(self.contentView, PXTOPT(30))
    .heightIs(PXTOPT(28));
    
    _descriptionLabel.sd_layout
    .leftSpaceToView(_imgView, PXTOPT(26))
    .topSpaceToView(_titleLabel, PXTOPT(22))
    .rightSpaceToView(self.contentView, PXTOPT(30))
    .heightIs(PXTOPT(22));
    
    _creditLabel.sd_layout
    .leftSpaceToView(_imgView, PXTOPT(26))
    .bottomSpaceToView(self.contentView, PXTOPT(30))
    .rightSpaceToView(self.contentView, PXTOPT(30))
    .heightIs(PXTOPT(24));
}

- (void)setCourseModel:(BFCourseModel *)courseModel{
    _courseModel = courseModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_courseModel.cscover] placeholderImage:[UIImage imageNamed:@"组3"]];
    _titleLabel.text = [NSString stringWithFormat:@"【最新发布】%@",_courseModel.ctitle];
    _descriptionLabel.text = _courseModel.descriptionStr;
    _creditLabel.text = [NSString stringWithFormat:@"%ld",_courseModel.cprice];
}

- (void)setSetCourseModel:(BFSetCourseModel *)setCourseModel{
    _setCourseModel = setCourseModel;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:_setCourseModel.cscover] placeholderImage:[UIImage imageNamed:@"组3"]];
    _titleLabel.text = [NSString stringWithFormat:@"【最新发布】%@",_setCourseModel.cstitle];
    _descriptionLabel.text = _setCourseModel.descriptionStr;
    _creditLabel.text = [NSString stringWithFormat:@"%ld",_setCourseModel.csprice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
