//
//  BFCommunityDetailsMoreCell.m
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCommunityDetailsMoreCell.h"

@implementation BFCommunityDetailsMoreCell{
    UIButton *moreBtn;
    UILabel *moreLabel;
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
    moreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    moreBtn.frame = CGRectMake(0, 0, 100, 40);
//    [moreBtn setImage:[UIImage imageNamed:@"矩形6"] forState:(UIControlStateNormal)];
    moreBtn.userInteractionEnabled = NO;
    [moreBtn setTitle:@"阅读全文" forState:(UIControlStateNormal)];
    [moreBtn setTitleColor:RGBColor(0, 126, 212) forState:(UIControlStateNormal)];
    moreBtn.titleLabel.font = [UIFont fontWithName:BFfont size:15];
    [self.contentView addSubview:moreBtn];
    moreBtn.layer.borderWidth = 1.0f;
    moreBtn.layer.borderColor = RGBColor(0, 126, 212).CGColor;
    moreBtn.layer.masksToBounds = YES;
    moreBtn.layer.cornerRadius = 20;
    
//    moreLabel = [[UILabel alloc] init];
//    moreLabel.text = @"阅读全文";
//    moreLabel.textAlignment = NSTextAlignmentCenter;
//    moreLabel.textColor = RGBColor(0, 126, 212);
//    moreLabel.font = [UIFont fontWithName:BFfont size:15];
//    [self.contentView addSubview:moreLabel];
    moreBtn.sd_layout
    .centerXIs(KScreenW / 2.0)
    .centerYIs(PXTOPT(180 / 2.0))
    .widthIs(100)
    .heightIs(40);
    
//    moreLabel.sd_layout
//    .centerXIs(KScreenW / 2.0)
//    .centerYIs(PXTOPT(180 / 2.0))
//    .widthIs(100)
//    .heightIs(40);
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
