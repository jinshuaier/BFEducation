//
//  BFEvaluateCell.m
//  NewTest
//
//  Created by 春晓 on 2017/12/1.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFEvaluateCell.h"
#include "BFTimeTransition.h"

#define EvaluateTextColor RGBColor(197, 197, 197)
@interface BFEvaluateCell ()
// 头像
@property (nonatomic , strong) UIImageView *headerImgView;
// 名字
@property (nonatomic , strong) UILabel *nameLabel;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;
// 评论
@property (nonatomic , strong) UILabel *evaluateLabel;
@end

@implementation BFEvaluateCell{
    UIView *lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self layout];
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    }
    return self;
}

- (void)setupUI{
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineView];
    _headerImgView = [[UIImageView alloc] init];
    _headerImgView.layer.masksToBounds = YES;
    _headerImgView.layer.cornerRadius = 20;
    [self.contentView addSubview:_headerImgView];
    
    _nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLabel];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = RGBColor(153, 153, 153);
    _timeLabel.font = [UIFont fontWithName:BFfont size:10];
    [self.contentView addSubview:_timeLabel];
    _evaluateLabel = [[UILabel alloc] init];
    _evaluateLabel.font = [UIFont fontWithName:BFfont size:14];
    _evaluateLabel.textColor = EvaluateTextColor;
    _evaluateLabel.numberOfLines = 0;
    [self.contentView addSubview:_evaluateLabel];
}

- (void)layout{
    lineView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .topEqualToView(self.contentView)
    .heightIs(0.5f);
    
    _headerImgView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(20))
    .widthIs(40)
    .heightIs(40);
    
    _timeLabel.sd_layout
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(20))
    .widthIs(80)
    .heightIs(40);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_headerImgView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(20))
    .rightSpaceToView(_timeLabel, PXTOPT(20))
    .heightIs(40);
    
    _evaluateLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel, 0)
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .bottomSpaceToView(self.contentView, 5);
}

- (void)setEvaluateModel:(BFEvaluateModel *)evaluateModel{
    _evaluateModel = evaluateModel;
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:_evaluateModel.iPhoto] placeholderImage:[UIImage imageNamed:@"123"]];
    _nameLabel.text = _evaluateModel.iNickName;
    _timeLabel.text = [BFTimeTransition diffTimeTransformEvaluateWithTime:_evaluateModel.pCTime];
    _evaluateLabel.text = _evaluateModel.pCComment;
}

- (void)setCourseEvaluateModel:(BFCourseEvaluateModel *)courseEvaluateModel{
    _courseEvaluateModel = courseEvaluateModel;
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:_courseEvaluateModel.iphoto] placeholderImage:[UIImage imageNamed:@"123"]];
    _nameLabel.text = _courseEvaluateModel.inickname;
    NSString *timeStr = [BFTimeTransition diffTimeTransformEvaluateWithTime:_courseEvaluateModel.cetime];
    _timeLabel.text = timeStr;
    _evaluateLabel.text = _courseEvaluateModel.ceeval;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
