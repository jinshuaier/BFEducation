//
//  UIBarButtonItem+CCExtension.h
//  基本框架
//
//  Created by 陈大鹰 on 2017/6/15.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CCExtension)

+(instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target andAction:(SEL)action;

@end
