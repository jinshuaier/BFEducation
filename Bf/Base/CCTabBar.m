//
//  CCTabBar.m
//  Bf
//
//  Created by 陈大鹰 on 2017/11/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "CCTabBar.h"
@interface CCTabBar()

@property (nonatomic, strong) UIButton *publishBtn;


@end

@implementation CCTabBar

-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        //设置tabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@""]];
        [self layoutSubviews];
    }
    return self;
}

//重新布局子控件
-(void)layoutSubviews {
    [super layoutSubviews];
    //设置其他item的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonH = self.frame.size.height;
    NSInteger index = 0;
    
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        //计算按钮的X值
        CGFloat buttonX = buttonW * index;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index ++;
    }
}

@end
