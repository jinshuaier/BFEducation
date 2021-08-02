//
//  ZAlertView.m
//  ZhongQiProject
//
//  Created by 郑士峰 on 2017/6/29.
//  Copyright © 2017年 小郑. All rights reserved.
//

#import "ZAlertView.h"

@implementation ZAlertView
+ (void)SVProgressDeafaultStatus{
    [SVProgressHUD  setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
}
+ (void)showSVProgressForRefresh{
    [ZAlertView SVProgressDeafaultStatus];
    [SVProgressHUD showWithStatus:@"正在刷新"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}
+ (void)showSVProgressForRefreshNotClick{
    [ZAlertView SVProgressDeafaultStatus];
    [SVProgressHUD showWithStatus:@"正在刷新"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}
+ (void)showSVProgressForLoad{
    [ZAlertView SVProgressDeafaultStatus];
    [SVProgressHUD showWithStatus:@"正在加载中"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}
+ (void)showSVProgressForLinkAppStroe{
    [ZAlertView SVProgressDeafaultStatus];
    [SVProgressHUD showWithStatus:@"正在连接 App Store"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}
+ (void)showSVProgressForUpImage{
    [ZAlertView SVProgressDeafaultStatus];
    [SVProgressHUD showWithStatus:@"正在上传图片"];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}
+ (void)showSVProgressForStr:(NSString *)str{
    [ZAlertView SVProgressDeafaultStatus];
    [SVProgressHUD showWithStatus:str];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}
+ (void)showSVProgressNotClickForStr:(NSString *)str{
    [ZAlertView SVProgressDeafaultStatus];
    [SVProgressHUD showWithStatus:str];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
}
+ (void)showSVProgressOnlyTextStatus:(NSString *)statusStr andShowImage:(UIImage *)image{
    [ZAlertView SVProgressDeafaultStatus];
    [SVProgressHUD showImage:image status:statusStr];
}
+ (void)showSVProgressOnlyTextStatus:(NSString *)statusStr withSection:(NSInteger)section{
    [SVProgressHUD  setFont:[UIFont systemFontOfSize:14]];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setMinimumDismissTimeInterval:section];
    [SVProgressHUD showImage:nil status:statusStr];
}
+ (void)showSVProgressForSuccess:(NSString *)str{
    [ZAlertView SVProgressDeafaultStatus];
    //    UIImage *image = [UIImage imageNamed:@"success"];
    //    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //    [SVProgressHUD setSuccessImage:image];
    [SVProgressHUD showSuccessWithStatus:str];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}
+ (void)showSVProgressForErrorStatus:(NSString *)statusStr{
    [ZAlertView SVProgressDeafaultStatus];
    //    UIImage *image = [UIImage imageNamed:@"error"];
    //    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //    [SVProgressHUD setErrorImage:image];
    [SVProgressHUD showErrorWithStatus:statusStr];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
    
}
+ (void)showSVProgressForInfoStatus:(NSString *)statusStr{
    [ZAlertView SVProgressDeafaultStatus];
    //    UIImage *image = [UIImage imageNamed:@"info"];
    //    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //    [SVProgressHUD setInfoImage:image];
    [SVProgressHUD showInfoWithStatus:statusStr];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
}
+ (void)dissSVProgress{
    [SVProgressHUD dismiss];
}
+ (UIImage *)getImageWith:(NSString *)str
{
    NSBundle *bundle = [NSBundle bundleForClass:[SVProgressHUD class]];
    NSURL *url = [bundle URLForResource:@"SVProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    UIImage* infoImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"info" ofType:@"png"]];
    UIImage* successImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"success" ofType:@"png"]];
    UIImage* errorImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]];
    UIImage *image;
    if ([str isEqualToString:@"success"]) {
        image = successImage;
    }else if ([str isEqualToString:@"error"]) {
        image = errorImage;
    }else if ([str isEqualToString:@"info"]) {
        image = infoImage;
    }
    return image;
}

@end
