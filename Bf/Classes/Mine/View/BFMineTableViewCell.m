//
//  BFMineTableViewCell.m
//  NewTest
//
//  Created by 春晓 on 2017/12/4.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFMineTableViewCell.h"

@interface BFMineTableViewCell ()

// more
@property (nonatomic , strong) UIImageView *moreImgView;
// 标示
@property (nonatomic , strong) UIImageView *tagImgView;
@end

@implementation BFMineTableViewCell{
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
    }
    return self;
}

- (void)setupUI{
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    _moreImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_moreImgView];
    _tagImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_tagImgView];
}

- (void)layout{
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(100);
    
    _moreImgView.sd_layout
    .rightSpaceToView(self.contentView, PXTOPT(34))
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(30);
    
    _tagImgView.sd_layout
    .leftSpaceToView(_titleLabel, PXTOPT(0))
    .topSpaceToView(self.contentView, PXTOPT(10))
    .widthIs(10)
    .heightIs(10);
}

//- (void)setModel:(BFEvaluateModel *)model{
//    _model = model;
//    _headerImgView.image = [UIImage imageNamed:_model.headerImgName];
//    _nameLabel.text = _model.nameStr;
//    _timeLabel.text = _model.timeStr;
//    _evaluateLabel.text = _model.evaluateStr;
//    [_likeBtn setImage:[UIImage imageNamed:@"赞-3拷贝6"] forState:(UIControlStateNormal)];
//    [_likeBtn setTitle:[NSString stringWithFormat:@"%ld",_model.likeCount] forState:(UIControlStateNormal)];
//    [_likeBtn setTitleColor:RGBColor(153, 153, 153) forState:(UIControlStateNormal)];
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
