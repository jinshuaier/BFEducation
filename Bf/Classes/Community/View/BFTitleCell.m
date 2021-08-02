//
//  BFTempCell.m
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFTitleCell.h"

@implementation BFTitleCell

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
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_nameLabel];
    _bottomLineView = [[UILabel alloc] init];
    _bottomLineView.backgroundColor = RGBColor(0, 126, 212);
    [self.contentView addSubview:_bottomLineView];
}

- (void)layout{
    _bottomLineView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .bottomEqualToView(self.contentView)
    .heightIs(PXTOPT(3.0))
    .widthIs(70);
    
    _nameLabel.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(_bottomLineView)
    .rightEqualToView(_bottomLineView)
    .bottomSpaceToView(_bottomLineView, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
