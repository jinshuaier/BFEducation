//
//  BFMineInformateCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/11.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMineInformateCell.h"

@implementation BFMineInformateCell

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
    _titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_titleLabel];
    _contentTextField = [[UITextField alloc] init];
    _contentTextField.textColor = RGBColor(201, 201, 201);
    [_contentTextField setFont:[UIFont fontWithName:BFfont size:PXTOPT(30)]];
    [self.contentView addSubview:_contentTextField];
    _tagBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_tagBtn setTitle:@"修改" forState:(UIControlStateNormal)];
    [_tagBtn.titleLabel setFont:[UIFont fontWithName:BFfont size:PXTOPT(30)]];
    [_tagBtn setTitleColor:RGBColor(201, 201, 201) forState:(UIControlStateNormal)];
    [self.contentView addSubview:_tagBtn];
}

- (void)layoutSubviews{
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(70);
    
    _tagBtn.sd_layout
    .rightSpaceToView(self.contentView, 20)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(50);
    
    _contentTextField.sd_layout
    .leftSpaceToView(_titleLabel, 0)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightSpaceToView(_tagBtn, 0);
}

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    _titleLabel.text = _dict[@"title"];
    _contentTextField.text = _dict[@"content"];
    NSString *isHiddenStr = _dict[@"isHidden"];
    _tagBtn.hidden = [isHiddenStr boolValue];
    if ([_dict[@"title"] isEqualToString:@"密 码:"]) {
        _contentTextField.secureTextEntry = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
