//
//  BFBaseViewController.h
//  Bf
//
//  Created by 春晓 on 2017/11/22.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFBaseViewController : UIViewController
@property (nonatomic, strong) AppDelegate *appDelegate;
- (void)showHUD:(NSString *)str;
// 强制屏幕旋转
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation;
@end
