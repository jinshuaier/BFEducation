//
//  BFCreateCourseTextSelectCell.m
//  Bf
//
//  Created by 春晓 on 2018/5/23.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCreateCourseTextSelectCell.h"

@interface BFCreateCourseTextSelectCell ()<UITextFieldDelegate>

// 右边的图标
@property (nonatomic , strong) UIImageView *rightImgView;
@end

@implementation BFCreateCourseTextSelectCell{
    UIView *lineView;
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
    _rightImgView = [[UIImageView alloc] init];
    _rightImgView.image = [UIImage imageNamed:@"更多"];
    _rightImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_rightImgView];
    
    _leftLabel = [[UILabel alloc] init];
    _leftLabel.text = @"课程名称";
    _leftLabel.font = [UIFont systemFontOfSize:14];
    _leftLabel.textColor = RGBColor(51, 51, 51);
    [self.contentView addSubview:_leftLabel];
    
    _rightLabel = [[UILabel alloc] init];
    _rightLabel.text = @"请选择";
    _rightLabel.font = [UIFont systemFontOfSize:14];
    _rightLabel.textColor = RGBColor(51, 51, 51);
    _rightLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rightLabel];
    
    _textField = [[UITextField alloc] init];
    _textField.text = @"";
    _textField.textAlignment = NSTextAlignmentRight;
    _textField.placeholder = @"请输入课程标签";
    _textField.font = [UIFont systemFontOfSize:13];
    _textField.textColor = RGBColor(153,153,153);
    _textField.delegate = self;
    [self.contentView addSubview:_textField];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBColor(220, 220, 220);
    [self.contentView addSubview:lineView];
    
    _leftLabel.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(60);
    
    _textField.sd_layout
    .leftSpaceToView(_leftLabel, 15)
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 15);
    
    _rightImgView.sd_layout
    .bottomEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .widthIs(8)
    .rightSpaceToView(self.contentView, 15);
    
    _rightLabel.sd_layout
    .bottomEqualToView(self.contentView)
    .topEqualToView(self.contentView)
    .leftEqualToView(_textField)
    .rightSpaceToView(_rightImgView, 10);
    
    lineView.sd_layout
    .leftSpaceToView(self.contentView, 15)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(0.5);
}

- (void)setCellType:(NSInteger)cellType{
    _cellType = cellType;
    if (_cellType == 0) {
        _rightLabel.hidden = YES;
        _rightImgView.hidden = YES;
        _textField.hidden = NO;
    }else{
        _rightLabel.hidden = NO;
        _rightImgView.hidden = NO;
        _textField.hidden = YES;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (_delegate && [_delegate respondsToSelector:@selector(getTextFieldTextWithTag:withText:)]) {
        [_delegate getTextFieldTextWithTag:_tagType withText:textField.text];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
