//
//  AppDelegate+GuideRootController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/2/5.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "AppDelegate+GuideRootController.h"
#import "CCTabBarController.h"
#define kUserDefaults [NSUserDefaults standardUserDefaults]

NSInteger imgNumberStr;
@interface AppDelegate ()<UIScrollViewDelegate>

@end

@implementation AppDelegate (GuideRootController)

- (void)setAppWindows
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

- (void)setRootViewController
{
    if ([kUserDefaults objectForKey:@"isOne"])
    {//不是第一次安装
        [self setTabbarController];
    }
    else
    {
        UIViewController *emptyView = [[UIViewController alloc] init];
        self.window.rootViewController = emptyView;
        [self createLoadingScrollView];
//        self.window.rootViewController = [[CCTabBarController alloc] init];
    }
}



#pragma mark - Windows
- (void)setTabbarController
{
    self.window.rootViewController = [[CCTabBarController alloc] init];
}

#pragma mark - 引导页
- (void)createLoadingScrollView {
    UIScrollView *sc = [[UIScrollView alloc]initWithFrame:self.window.bounds];
    sc.pagingEnabled = YES;
    sc.delegate = self;
    sc.backgroundColor = [UIColor whiteColor];
    sc.showsHorizontalScrollIndicator = NO;
    sc.showsVerticalScrollIndicator = NO;
    [self.window.rootViewController.view addSubview:sc];
    
    [kUserDefaults setObject:@"isOne" forKey:@"isOne"];
    [kUserDefaults synchronize];
//    [self setTabbarController];
    
    [NetworkRequest requestWithUrl:Guide parameters:nil successResponse:^(id data) {
        NSArray *arr = data;
        imgNumberStr = arr.count;
        for (NSInteger i = 0; i<arr.count; i++)
        {
            UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW*i, 0, KScreenW, self.window.frame.size.height)];
            [img sd_setImageWithURL:[NSURL URLWithString:arr[i]]];
            [sc addSubview:img];
            img.userInteractionEnabled = YES;
            if (i == arr.count - 1)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                btn.frame = CGRectMake((self.window.frame.size.width/2)-50, KScreenH-80, 100, 40);
                [btn setTitle:@"开始体验" forState:UIControlStateNormal];
                [btn setTitleColor:RGBColor(103, 190, 248) forState:UIControlStateNormal];
                [btn setBackgroundColor:[UIColor whiteColor]];
                btn.layer.borderWidth = 1;
                btn.layer.cornerRadius = 4.0f;
                btn.layer.borderColor = RGBColor(103, 190, 248).CGColor;
                [btn addTarget:self action:@selector(goToMain) forControlEvents:UIControlEventTouchUpInside];
                [img addSubview:btn];
            }
        }
        sc.contentSize = CGSizeMake(KScreenW*arr.count, self.window.frame.size.height);
    } failureResponse:^(NSError *error) {
        [self setTabbarController];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > KScreenW * imgNumberStr + 30-KScreenW)
    {
        
        [self goToMain];
    }
}

- (void)goToMain
{
    [kUserDefaults setObject:@"isOne" forKey:@"isOne"];
    [kUserDefaults synchronize];
    [self setTabbarController];
}

@end
