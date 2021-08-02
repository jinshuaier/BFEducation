//
//  BFTopImageCell.m
//  Bf
//
//  Created by 春晓 on 2018/1/2.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFTopImageCell.h"

@implementation BFTopImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)setupUI{
    
    _imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgView];
    
}

- (void)layoutSubviews{
    _imgView.sd_layout
    .leftEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
