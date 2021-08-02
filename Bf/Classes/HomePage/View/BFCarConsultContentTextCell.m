//
//  BFCarConsultContentTextCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCarConsultContentTextCell.h"

@implementation BFCarConsultContentTextCell

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
//    _contentLabel = [[BFTopLeftLabel alloc] init];
//    _contentLabel.numberOfLines = 0;
//    _contentLabel.textAlignment = NSTextAlignmentLeft;
//    [_contentLabel sizeToFit];
//    _contentLabel.textColor = RGBColor(51, 51, 51);
//    _contentLabel.font = [UIFont fontWithName:BFfont size:14];
//    [self.contentView addSubview:_contentLabel];
//    _contentLabel.sd_layout
//    .leftSpaceToView(self.contentView, PXTOPT(25))
//    .topSpaceToView(self.contentView, PXTOPT(10))
//    .rightSpaceToView(self.contentView, PXTOPT(25))
//    .bottomSpaceToView(self.contentView, PXTOPT(10));
    
    _contentTextField = [[UITextView alloc] init];
//    _contentLabel.numberOfLines = 0;
    _contentTextField.textAlignment = NSTextAlignmentLeft;
    [_contentTextField sizeToFit];
    _contentTextField.textColor = RGBColor(51, 51, 51);
    _contentTextField.scrollEnabled = NO;
    _contentTextField.userInteractionEnabled = NO;
    _contentTextField.font = [UIFont fontWithName:BFfont size:PXTOPT(32.0f)];
    [self.contentView addSubview:_contentTextField];
    _contentTextField.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(25))
    .topSpaceToView(self.contentView, PXTOPT(10))
    .rightSpaceToView(self.contentView, PXTOPT(25))
    .bottomSpaceToView(self.contentView, PXTOPT(10));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
