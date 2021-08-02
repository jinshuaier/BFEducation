//
//  UIBarButtonItem+CCExtension.m
//  基本框架
//
//  Created by 陈大鹰 on 2017/6/15.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "UIBarButtonItem+CCExtension.h"
#import "UIView+CCFrame.h"
@implementation UIBarButtonItem (CCExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target andAction:(SEL)action {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //设置按钮尺寸为适应当前图标的尺寸
    button.size = button.currentBackgroundImage.size;
    return [[self alloc] initWithCustomView:button];
}

@end
