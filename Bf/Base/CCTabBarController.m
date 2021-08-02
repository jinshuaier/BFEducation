//
//  CCTabBarController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/11/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "CCTabBarController.h"
#import "CCTabBar.h"
#import "CCNavigationController.h"
#import "BFLatestHomePageViewController.h"//首页
#import "BFCourseListVC.h"
#import "BFCommunityViewController.h"//社区
#import "BFCarTalentsViewController.h"//车人才
#import "BFNewMineViewController.h"//我的
@interface CCTabBarController ()

@end

@implementation CCTabBarController

//很多一次性设置的东西完全可以放在initialize中
+(void)initialize {
    //根据appreance设置所有字体大小和颜色
    NSMutableDictionary *normalDict = [[NSMutableDictionary alloc] init];
    normalDict[NSFontAttributeName] = [UIFont fontWithName:BFfont size:10.0f];
    normalDict[NSForegroundColorAttributeName] = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];;
    
    NSMutableDictionary *selectedDict = [[NSMutableDictionary alloc] init];
    selectedDict[NSFontAttributeName] = [UIFont fontWithName:BFfont size:10.0f];
    selectedDict[NSForegroundColorAttributeName] = [UIColor colorWithRed:0/255.0 green:126/255.0 blue:212/255.0 alpha:1];
    
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalDict forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    
    [self setupChildViewController:[[BFLatestHomePageViewController alloc] init] Title:@"首页" Image:[UIImage imageNamed:@"newsy"] andSelectedImg:[UIImage imageNamed:@"newsy1"]];
    
    [self setupChildViewController:[[BFCommunityViewController alloc] init] Title:@"技术论坛" Image:[UIImage imageNamed:@"newsq"] andSelectedImg:[UIImage imageNamed:@"newsq1"]];
    
    [self setupChildViewController:[[BFCourseListVC alloc] init] Title:@"课堂" Image:[UIImage imageNamed:@"课堂"] andSelectedImg:[UIImage imageNamed:@"课堂iconH"]];

    [self setupChildViewController:[[BFCarTalentsViewController alloc] init] Title:@"车人才" Image:[UIImage imageNamed:@"车人才icon"] andSelectedImg:[UIImage imageNamed:@"车人才iconH"]];

    [self setupChildViewController:[[BFNewMineViewController alloc] init] Title:@"我的" Image:[UIImage imageNamed:@"newwd"] andSelectedImg:[UIImage imageNamed:@"newwd1"]];
    
    
    
    //更换tabBar
    [self setValue:[[CCTabBar alloc] init] forKeyPath:@"tabBar"];
}

//设置子控制器的基本属性
-(void)setupChildViewController:(UIViewController *)vc Title:(NSString *)title Image:(UIImage *)img andSelectedImg:(UIImage *)selectedImg {
    
    //设置文字和图片
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0f];//这行代码其实有很大问题,因为如果这么写的话 就会把四个控制器全都一次性创建,造成内存问题以及请求问题.虽然很方便但是最好别这么写
    vc.tabBarItem.title = title;
    UIImage *settingImg = img;
    //设置图片默认渲染为不渲染
    settingImg = [settingImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = settingImg;
    selectedImg = [selectedImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selectedImg;
    
    if ([self isIPhoneX]) {
        vc.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -30);
        vc.tabBarItem.imageInsets = UIEdgeInsetsMake(-15, 0, 15, 0);
    }
    [self addChildViewController:vc];
    //包装一个导航控制器,让它成为UITabBarController的子控制器
    CCNavigationController *nav = [[CCNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (BOOL)isIPhoneX {
    // 根据安全区域判断
    if (@available(iOS 11.0, *)) {
        CGFloat height = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
        return (height > 0);
    } else {
        return NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
