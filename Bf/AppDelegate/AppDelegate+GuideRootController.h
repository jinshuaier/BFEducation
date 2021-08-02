//
//  AppDelegate+GuideRootController.h
//  Bf
//
//  Created by 陈大鹰 on 2018/2/5.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (GuideRootController)


/**
 *  首次启动轮播图
 */
- (void)createLoadingScrollView;
/**
 *  tabbar实例
 */
- (void)setTabbarController;

/**
 *  window实例
 */
- (void)setAppWindows;

/**
 *  根视图
 */
- (void)setRootViewController;

@end
