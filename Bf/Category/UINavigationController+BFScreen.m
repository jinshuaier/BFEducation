//
//  UINavigationController+BFScreen.m
//  Bf
//
//  Created by 春晓 on 2018/1/2.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "UINavigationController+BFScreen.h"

@implementation UINavigationController (BFScreen)

//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
////    if ([[self visibleViewController] isKindOfClass:NSClassFromString(@"MBLiveViewController")]) {
////        return UIInterfaceOrientationMaskAllButUpsideDown;
////    }else{
////        return UIInterfaceOrientationMaskPortrait;
////    }
//    return UIInterfaceOrientationMaskPortrait;
//}

- (BOOL)shouldAutorotate
{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}

@end
