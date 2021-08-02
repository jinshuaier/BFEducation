//
//  ZAlertView.h
//  ZhongQiProject
//
//  Created by 郑士峰 on 2017/6/29.
//  Copyright © 2017年 小郑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SVProgressHUD.h>
@interface ZAlertView : NSObject

//刷新 --- 用户可以点击操作其他内容
+ (void)showSVProgressForRefresh;
//刷新 --- 用户不可以点击操作其他内容
+ (void)showSVProgressForRefreshNotClick;
//等待
+ (void)showSVProgressForLoad;
//连接到AppStore
+ (void)showSVProgressForLinkAppStroe;
//上传图片
+ (void)showSVProgressForUpImage;
//自定义文字 --- 用户可以点击操作其他内容
+ (void)showSVProgressForStr:(NSString *)str;
//自定义文字 --- 用户不可以点击操作其他内容
+ (void)showSVProgressNotClickForStr:(NSString *)str;
//自定义图片和文字
+ (void)showSVProgressOnlyTextStatus:(NSString *)statusStr andShowImage:(UIImage *)image;
//成功
+ (void)showSVProgressForSuccess:(NSString *)str;
//失败
+ (void)showSVProgressForErrorStatus:(NSString *)statusStr;
//信息
+ (void)showSVProgressForInfoStatus:(NSString *)statusStr;
//消失
+ (void)dissSVProgress;

@end
