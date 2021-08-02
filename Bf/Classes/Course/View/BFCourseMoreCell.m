//
//  BFCourseMoreCell.m
//  Bf
//
//  Created by 春晓 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCourseMoreCell.h"

@implementation BFCourseMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubviews];
    }
    return self;
}

-(void)createSubviews{
    //自定义的UI
    
    UIButton *moreBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:moreBtn];
    [moreBtn setTitle:@"更多课程 >" forState:(UIControlStateNormal)];
    moreBtn.layer.borderColor = RGBColor(51, 150, 252).CGColor;
    moreBtn.layer.borderWidth = 1.0;
    moreBtn.layer.masksToBounds = YES;
    moreBtn.layer.cornerRadius = 15;
    [moreBtn setTitleColor:RGBColor(51, 150, 252) forState:(UIControlStateNormal)];
    moreBtn.frame = CGRectMake(0, 0, 91, 30);
    moreBtn.centerX = KScreenW / 2.0;
    moreBtn.centerY = 60 / 2.0;
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)moreBtnClick {
    if (_delegate && [_delegate respondsToSelector:@selector(moreCourse:)]) {
        [_delegate moreCourse:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
