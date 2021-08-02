//
//  BFMineHeaderCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMineHeaderCell.h"

@implementation BFMineHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGBColor(0, 164, 255);
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    UIImage *img = [UIImage imageNamed:@"123"];
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.image = img;
    _headerImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_headerImageView];
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 30;
    
    _smallHeaderImageView = [[UIImageView alloc] init];
    _smallHeaderImageView.image = img;
    [self.contentView addSubview:_smallHeaderImageView];
    _smallHeaderImageView.layer.masksToBounds = YES;
    _smallHeaderImageView.layer.cornerRadius = 7.5f;
    
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.text = @"点击修改头像";
    _tagLabel.userInteractionEnabled = YES;
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.textColor = RGBColor(248, 250, 252);
    _tagLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(30)];
    [self.contentView addSubview:_tagLabel];
}

- (void)layoutSubviews{
    _headerImageView.sd_layout
    .centerXIs(KScreenW / 2.0)
    .topSpaceToView(self.contentView, 15)
    .widthIs(60)
    .heightIs(60);
    
    _smallHeaderImageView.sd_layout
    .leftSpaceToView(_headerImageView, 20)
    .topEqualToView(_headerImageView)
    .widthIs(15)
    .heightIs(15);
    
    _tagLabel.sd_layout
    .topSpaceToView(_headerImageView, 10)
    .centerXIs(KScreenW / 2.0)
    .widthIs(100)
    .heightIs(23);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
