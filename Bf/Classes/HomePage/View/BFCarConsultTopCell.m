//
//  BFCarConsultTopCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCarConsultTopCell.h"
@interface BFCarConsultTopCell ()
// 头像
@property (nonatomic , strong) UIImageView *headImageView;
// 名字
@property (nonatomic , strong) UILabel *nameLabel;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;
// 标题
@property (nonatomic , strong) UILabel *titleLabel;
// 正文
@property (nonatomic , strong) UILabel *showNumberLabel;

@end
@implementation BFCarConsultTopCell{
    NSInteger labelLineCount;
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
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = PXTOPT(68 / 2);
    [_headImageView setImage:[UIImage imageNamed:@"123"]];
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(26.0f)];
    _nameLabel.textColor = RGBColor(0, 169, 255);
    _nameLabel.text = @"走钢丝的加菲猫";
    [self.contentView addSubview:_nameLabel];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(20.0f)];
    _timeLabel.textColor = RGBColor(153, 153, 153);
    _timeLabel.text = @"2017-11-23";
    [self.contentView addSubview:_timeLabel];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont fontWithName:BFfont size:25];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textColor = RGBColor(51, 51, 51);
    [self.contentView addSubview:_titleLabel];
    _showNumberLabel = [[UILabel alloc] init];
    _showNumberLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(20.0f)];
    _showNumberLabel.textColor = RGBColor(153, 153, 153);
    _showNumberLabel.numberOfLines = 0;
    _showNumberLabel.text = @"浏览 : 299人";
    [self.contentView addSubview:_showNumberLabel];
    
}

- (void)layout{
    _headImageView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .bottomSpaceToView(self.contentView, PXTOPT(10))
    .widthIs(PXTOPT(68))
    .heightIs(PXTOPT(68));
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(28))
    .topSpaceToView(self.contentView, PXTOPT(38))
    .rightSpaceToView(self.contentView, PXTOPT(28))
    .bottomSpaceToView(_headImageView, PXTOPT(30));
    
    _nameLabel.sd_layout
    .leftSpaceToView(_headImageView, PXTOPT(22))
    .topEqualToView(_headImageView)
    .widthIs(KScreenW - PXTOPT(60 + 68))
    .heightIs(PXTOPT(29));
    
    _timeLabel.sd_layout
    .leftSpaceToView(_headImageView, PXTOPT(20))
    .topSpaceToView(_nameLabel, PXTOPT(14))
    .widthIs(60)
    .heightIs(PXTOPT(21));
    
    _showNumberLabel.sd_layout
    .leftSpaceToView(_timeLabel, PXTOPT(28))
    .topEqualToView(_timeLabel)
    .rightSpaceToView(self.contentView, PXTOPT(28))
    .heightIs(PXTOPT(21));
}


- (void)setCarNewsModel:(BFCarNewsModel *)carNewsModel{
    _carNewsModel = carNewsModel;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:carNewsModel.iPhoto] placeholderImage:[UIImage imageNamed:@"123"]];
    _nameLabel.text = _carNewsModel.iNickName;
    _timeLabel.text = [BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_carNewsModel.pTime] dateFormat:@"YYYY-MM-dd"];
    _titleLabel.text = _carNewsModel.pTitle;
    _showNumberLabel.text = [NSString stringWithFormat:@"浏览 : %ld",_carNewsModel.nNum];
    
//    CGFloat labelHeight = [_titleLabel sizeThatFits:CGSizeMake(KScreenW - PXTOPT(56), MAXFLOAT)].height;
//    labelLineCount = (labelHeight) / 25;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
