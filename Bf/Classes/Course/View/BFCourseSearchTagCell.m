//
//  BFCourseSearchTagCell.m
//  Bf
//
//  Created by 春晓 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCourseSearchTagCell.h"

@implementation BFCourseSearchTagCell

+ (CGSize) getSizeWithText:(NSString*)text
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+4, 28);
}

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _tagLabel = [[UILabel alloc] init];
    _tagLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_tagLabel];
    _tagLabel.textAlignment = NSTextAlignmentCenter;
    _tagLabel.layer.borderColor = CCRGBColor(205, 204, 204).CGColor;
    _tagLabel.textColor = RGBColor(51, 51, 51);
    _tagLabel.layer.borderWidth = 0.5;
    _tagLabel.layer.masksToBounds = YES;
    _tagLabel.layer.cornerRadius = 1;
    
    _tagLabel.sd_layout
    .leftSpaceToView(self.contentView, 0)
    .topSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0);
}

- (void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    if (_isSelect) {
        _tagLabel.layer.borderColor = CCRGBColor(0, 126, 212).CGColor;
        _tagLabel.textColor = RGBColor(0, 126, 212);
    }else{
        _tagLabel.layer.borderColor = CCRGBColor(205, 204, 204).CGColor;
        _tagLabel.textColor = RGBColor(51, 51, 51);
    }
}

@end
