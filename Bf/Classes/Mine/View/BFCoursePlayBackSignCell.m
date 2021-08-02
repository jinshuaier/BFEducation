//
//  BFCoursePlayBackSignCell.m
//  Bf
//
//  Created by 春晓 on 2018/5/30.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCoursePlayBackSignCell.h"

@implementation BFCoursePlayBackSignCell

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
    
    
    UILabel *leftLabel = [[UILabel alloc] init];
    leftLabel.text = @"回放视频";
    leftLabel.font = [UIFont systemFontOfSize:14];
    leftLabel.textColor = RGBColor(51, 51, 51);
    [self.contentView addSubview:leftLabel];
    
    self.textLabel.text = @"如需更改回放视频请登录PC版北方职教完成操作";
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.textLabel.textColor = RGBColor(51, 51, 51);
    self.textLabel.numberOfLines = 0;
    [self.contentView addSubview:self.textLabel];
    
    leftLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topEqualToView(self.contentView)
    .heightIs(40)
    .widthIs(200);
    
    self.textLabel.sd_layout
    .leftEqualToView(leftLabel)
    .topSpaceToView(leftLabel, 10)
    .bottomSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 15);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
