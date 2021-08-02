//
//  CCNavigationController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/11/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "CCNavigationController.h"
#import "UINavigationController+BFScreen.h"
#import "BFCarTalentsViewController.h"
#import "BFLatestHomePageViewController.h"
@interface CCNavigationController ()

@end

@implementation CCNavigationController

//当第一次使用这个类的时候才会调用
+ (void)initialize
{
    if (self == [CCNavigationController class]) {
        UINavigationBar *bar = [[UINavigationBar alloc] init];
        bar.barTintColor = [UIColor whiteColor];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count >=1) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        //让按钮往左移动15个单位
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        backButton.size = CGSizeMake(40, 30);
//        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)clickBack {
    [self popViewControllerAnimated:YES];
}

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
