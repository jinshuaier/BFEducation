//
//  BFCommunityContentCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/28.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCommunityContentCell.h"

@implementation BFCommunityContentCell

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
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(28.0f)];
    _contentLabel.textColor = RGBColor(51, 51, 51);
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = UILineBreakModeCharacterWrap;  //换行模式
    [_contentLabel sizeToFit];
    [self.contentView addSubview:_contentLabel];
}

- (void)layoutSubviews{
    _contentLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(28))
    .topSpaceToView(self.contentView, PXTOPT(10))
    .rightSpaceToView(self.contentView, PXTOPT(28))
    .bottomSpaceToView(self.contentView, PXTOPT(10));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
