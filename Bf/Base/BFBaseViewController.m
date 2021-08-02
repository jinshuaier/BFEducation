//
//  BFBaseViewController.m
//  Bf
//
//  Created by 春晓 on 2017/11/22.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFPOPAnimation.h"
#import <MBProgressHUD.h>

@interface BFBaseViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic , strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

// HUD
@property (nonatomic , strong) MBProgressHUD *HUD;
@end

@implementation BFBaseViewController

//1. 先创建一个BaseViewController,给该控制器的view添加拖动手势；

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appDelegate = appDelegate;
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

// 强制屏幕旋转
- (void)interfaceOrientation:(UIInterfaceOrientation)orientation {
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (void)showHUD:(NSString *)str{
    if (_HUD) {
        [_HUD removeFromSuperViewOnHide];
        _HUD = nil;
    }
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.label.text = str;
    _HUD.mode = MBProgressHUDModeText;
    
//    [_HUD showAnimated:YES whileExecutingBlock:^{
//        sleep(1);
//
//    }
//      completionBlock:^{
//          [_HUD removeFromSuperview];
//          _HUD = nil;
//      }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
