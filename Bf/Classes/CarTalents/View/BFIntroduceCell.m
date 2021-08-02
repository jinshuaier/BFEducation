//
//  BFIntroduceCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/23.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFIntroduceCell.h"

@implementation BFIntroduceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.introText];
    }
    return self;
}

-(void)layoutSubviews {
    CGFloat height = [UILabel getHeightByWidth:self.introText.frame.size.width title:self.introText.text font:self.introText.font];
    self.introText.frame = CGRectMake(15, 15, KScreenW - 30, height);
}

-(UILabel *)introText {
    if (!_introText) {
        _introText = [[UILabel alloc] init];
        _introText.text = @"陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦陈大鹰还是非常非常帅的哦";
        _introText.textColor = RGBColor(51, 51, 51);
        _introText.numberOfLines = 0;
        _introText.lineBreakMode = NSLineBreakByWordWrapping;
        _introText.font = [UIFont fontWithName:BFfont size:14.0f];
    }
    return _introText;
}

@end
