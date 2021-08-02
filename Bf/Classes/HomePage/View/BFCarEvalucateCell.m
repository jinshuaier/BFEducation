//
//  BFCarEvalucateCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCarEvalucateCell.h"
@interface BFCarEvalucateCell ()
// 头像
@property (nonatomic , strong) UIImageView *headerImgView;
// 名字
@property (nonatomic , strong) UILabel *nameLabel;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;


@end

@implementation BFCarEvalucateCell{
    
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
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 4, KScreenW, 0.5f)];
    _lineView.backgroundColor = RGBColor(231, 229, 229);
    [self.contentView addSubview:_lineView];
    _headerImgView = [[UIImageView alloc] init];
    _headerImgView.layer.masksToBounds = YES;
    _headerImgView.layer.cornerRadius = 20;
    [self.contentView addSubview:_headerImgView];
    _likeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_likeBtn setImage:[UIImage imageNamed:@"赞-3拷贝6"] forState:(UIControlStateNormal)];
    [_likeBtn setTitle:@"0" forState:(UIControlStateNormal)];
    [_likeBtn setTitleColor:RGBColor(153, 153, 153) forState:(UIControlStateNormal)];
    [_likeBtn addTarget:self action:@selector(evaluateLikeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_likeBtn];
    _nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_nameLabel];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.textColor = RGBColor(153, 153, 153);
    _timeLabel.font = [UIFont fontWithName:BFfont size:12];
    [self.contentView addSubview:_timeLabel];
    _evaluateLabel = [[UILabel alloc] init];
    _evaluateLabel.numberOfLines = 0;
    _evaluateLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(28)];
    [self.contentView addSubview:_evaluateLabel];
}

- (void)layoutSubviews{
    _headerImgView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(20))
    .widthIs(40)
    .heightIs(40);
    
    _likeBtn.sd_layout
    .rightSpaceToView(self.contentView, PXTOPT(0))
    .topSpaceToView(self.contentView, PXTOPT(20))
    .widthIs(80)
    .heightIs(40);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_headerImgView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(20))
    .rightSpaceToView(_likeBtn, PXTOPT(20))
    .heightIs(30);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_headerImgView, PXTOPT(20))
    .topSpaceToView(_nameLabel, PXTOPT(8))
    .rightSpaceToView(_likeBtn, PXTOPT(20))
    .heightIs(15);
    
    //    _evaluateLabel.sd_layout
    //    .leftEqualToView(_nameLabel)
    //    .topSpaceToView(_timeLabel, PXTOPT(18))
    //    .rightSpaceToView(self.contentView, PXTOPT(20))
    //    .autoHeightRatio(0); // 设置高度约束
    //    [self setupAutoHeightWithBottomView:_evaluateLabel bottomMargin:20];
    
    _evaluateLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_timeLabel, PXTOPT(10))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .bottomSpaceToView(self.contentView, 5);
}

- (void)setModel:(BFCarEvaluateModel *)model{
    _model = model;
    [_headerImgView sd_setImageWithURL:[NSURL URLWithString:_model.iPhoto] placeholderImage:[UIImage imageNamed:@"123"]];
    _nameLabel.text = _model.iNickName;
    _timeLabel.text = _model.dateTime;
    _evaluateLabel.text = _model.nCComment;
    [_likeBtn setImage:_model.comFlag ? [UIImage imageNamed:@"赞-3拷贝2"] : [UIImage imageNamed:@"赞-3拷贝6"] forState:(UIControlStateNormal)];
    [_likeBtn setTitle:[NSString stringWithFormat:@"%ld",_model.nComCount] forState:(UIControlStateNormal)];
}

- (void)evaluateLikeBtnClick{
    if (_delegate && [_delegate respondsToSelector:@selector(evaluateLikeBtnClick:)]) {
        [_delegate evaluateLikeBtnClick:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
