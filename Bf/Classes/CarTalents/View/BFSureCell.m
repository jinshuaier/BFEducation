//
//  BFSureCell.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/3.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFSureCell.h"

@implementation BFSureCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.sureBtn];
    }
    return self;
}

-(void)layoutSubviews {
    self.sureBtn.frame = CGRectMake(10, 10, KScreenW - 20, 50);
}

-(UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"发送简历" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:RGBColor(0, 148, 231)];
        _sureBtn.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
        [_sureBtn addTarget:self action:@selector(clickSureAction) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.layer.cornerRadius = 4.0f;
    }
    return _sureBtn;
}

-(void)clickSureAction {
    if (self.pushSureBlock) {
        self.pushSureBlock();
    }
}

@end
