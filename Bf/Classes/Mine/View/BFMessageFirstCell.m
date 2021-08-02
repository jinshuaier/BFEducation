//  点赞收藏
//  BFMessageFirstCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMessageFirstCell.h"

@interface BFMessageFirstCell ()
// 头像
@property (nonatomic , strong) UIImageView *headerImageView;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;
// 描述
@property (nonatomic , strong) UILabel *describeLabel;
// 帖子
@property (nonatomic , strong) UILabel *contentLabel;
@end

@implementation BFMessageFirstCell{
    UIView *lineView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBColor(240, 240, 240);
    [self.contentView addSubview:lineView];
    
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_headerImageView];
    _timeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_timeLabel];
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.textColor = RGBColor(0, 164, 255);
    [self.contentView addSubview:_contentLabel];
    _describeLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_describeLabel];
    
    
//    _contentLabel = [[UILabel alloc] init];
//    _countLabel.textColor = [UIColor whiteColor];
//    _countLabel.backgroundColor = [UIColor redColor];
//    _countLabel.layer.masksToBounds = YES;
//    _countLabel.layer.cornerRadius = 10;
//    _countLabel.font = [UIFont fontWithName:BFfont size:10];
//    _countLabel.text = @"99+";
//    [self.contentView addSubview:_countLabel];
}

- (void)layoutSubviews{
    lineView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .heightIs(0.3);
    
    _headerImageView.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(30);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_headerImageView, 20)
    .topSpaceToView(self.contentView, 20)
    .heightIs(15)
    .rightSpaceToView(self.contentView, 20);
    
    _describeLabel.sd_layout
    .leftSpaceToView(_headerImageView, 20)
    .topSpaceToView(_timeLabel, 5)
    .heightIs(20)
    .rightSpaceToView(self.contentView, 20);
    
    _contentLabel.sd_layout
    .leftSpaceToView(_headerImageView, 20)
    .topSpaceToView(_describeLabel, 5)
    .heightIs(20)
    .rightSpaceToView(self.contentView, 20);
}

- (void)setModel:(BFMessageDetailsModel *)model{
    _model = model;
    _headerImageView.image = [UIImage imageNamed:_model.headerImageName];
    _timeLabel.text = _model.timeStr;
    _describeLabel.text = _model.describeStr;
    _contentLabel.text = _model.contentStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
