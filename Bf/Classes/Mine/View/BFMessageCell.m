//
//  BFMessageCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMessageCell.h"

@interface BFMessageCell ()
// imgView
@property (nonatomic , strong) UIImageView *titleImageView;
// label
@property (nonatomic , strong) UILabel *titleLabel;
// 箭头
@property (nonatomic , strong) UIImageView *moreImageView;
@end

@implementation BFMessageCell{
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
    
    _titleImageView = [[UIImageView alloc] init];
    _titleImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_titleImageView];
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    
    _moreImageView = [[UIImageView alloc] init];
    _moreImageView.contentMode = UIViewContentModeScaleAspectFit;
    _moreImageView.image = [UIImage imageNamed:@"图层8"];
    [self.contentView addSubview:_moreImageView];
    _countLabel = [[UILabel alloc] init];
    _countLabel.textColor = [UIColor whiteColor];
    _countLabel.backgroundColor = [UIColor redColor];
    _countLabel.layer.masksToBounds = YES;
    _countLabel.layer.cornerRadius = 10;
    _countLabel.font = [UIFont fontWithName:BFfont size:10];
    _countLabel.text = @"99+";
    [self.contentView addSubview:_countLabel];
}

- (void)layoutSubviews{
    lineView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .heightIs(0.3);
    
    _titleImageView.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(20);
    
    _moreImageView.sd_layout
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(7);
    
    _countLabel.sd_layout
    .rightSpaceToView(_moreImageView, 5)
    .centerYIs(30)
    .widthIs(20)
    .heightIs(20);
    
    _titleLabel.sd_layout
    .leftSpaceToView(_titleImageView, 20)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightSpaceToView(_countLabel, 0);
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    _titleImageView.image = dict[@"icon"];
    _titleLabel.text = _dict[@"title"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
