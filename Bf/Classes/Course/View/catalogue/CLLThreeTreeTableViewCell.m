//
//  ThreeTableViewCell.m
//  WLN_Tianxing
//
//  Created by wln100-IOS1 on 15/12/23.
//  Copyright © 2015年 TianXing. All rights reserved.
//

#import "CLLThreeTreeTableViewCell.h"
#import <SDAutoLayout.h>

@implementation CLLThreeTreeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self layout];
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)setupUI{
    _littleTitleLabel = [[UILabel alloc] init];
    _littleTitleLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(24)];
    _littleTitleLabel.textColor = RGBColor(153, 153, 153);
    [self.contentView addSubview:_littleTitleLabel];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(20)];
    _timeLabel.textColor = RGBColor(153, 153, 153);
    [self.contentView addSubview:_timeLabel];
    _titleImgView = [[UIImageView alloc] init];
    _titleImgView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_titleImgView];
}

- (void)layout{
    
    _titleImgView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(66))
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(20);
    
    _littleTitleLabel.sd_layout
    .leftSpaceToView(_titleImgView, PXTOPT(20))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .topEqualToView(self.contentView)
    .heightIs(20);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_titleImgView, PXTOPT(20))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(_littleTitleLabel, PXTOPT(20))
    .heightIs(15);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
