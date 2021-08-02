//
//  Config.h
//  GeneralProject
//
//  Created by 陈大鹰 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#ifndef Config_h
#define Config_h

#import "PlayBackViewController.h"
#import "PlayViewController.h"
#import "AppDelegate.h"
#import <Masonry.h>
#import <Availability.h>
#import <UIImageView+WebCache.h>

#import "MJExtension.h"
#import "BFTimeTransition.h"
#import "MBProgressHUD.h"
#import "DWShortSDK.h"
#import "NetworkRequest.h"
#import "NSMutableAttributedString+BFAttributedString.h"
#define WEAKSELF __weak typeof(self) weakSelf = self
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define FIT_WIDTH [UIScreen mainScreen].bounds.size.width/375

#define KSelectBorderColor      [UIColor colorWithRed:0/255.0 green:159/255.0 blue:255/255.0 alpha:1]
#define KUnSelectBorderColor    [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1]
#define KButtonColor            [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
//屏幕宽高
#define KScreenW [UIScreen mainScreen].bounds.size.width
#define KScreenH [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
//占位图
#define PLACEHOLDER [UIImage imageNamed:@"组3"]
// 获得RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//自定义颜色
#define ColorRGBValue(rgbValue)  [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]  //自定义字体颜色
//随机颜色
#define RandomColor [UIColor colorWithRed:(random() % 256 / 255.0f) green:(random() % 256 / 255.0f) blue:(random() % 256 / 255.0f) alpha:1]
//项目主颜色
#define MainColor ColorRGBValue(0x21201f)
//主标题颜色
#define TitleBaseColor ColorRGBValue(0x222222)
//副标题颜色
#define SubTitleColor ColorRGBValue(0x222222)
//时间颜色
#define TimeTextColor ColorRGBValue(0xb4b8bf)
//分割线颜色
#define LineColor ColorRGBValue(0xe8e8e8)
//背景灰
#define GroundGraryColor ColorRGBValue(0xf3f3f3)
//项目主字体大小
#define MainTextFontSize 15.0
//主标题字体大小
#define SubTextFontSize 13.0
//字体类型
#define BFfont @"MicrosoftYaHei"

#endif /* Config_h */


// ==================
//[em2_01]
#define FACE_NAME_HEAD  @"[em2_"
// 表情转义字符的长度（ [em2_占5个长度，xx占2个长度，]占一个长度,共8个长度 ）
#define FACE_NAME_LEN   8
#define FACE_COUNT_ALL  20
#define FACE_COUNT_ROW  3
#define FACE_COUNT_CLU  7
#define IMGWIDTH        28.0f

#define CONTROLLER_INDEX @"index"

#define LIVE_USERID @"Live_UserId"
#define LIVE_ROOMID @"Live_RoomId"
#define LIVE_USERNAME @"Live_UserName"
#define LIVE_PASSWORD @"Live_Password"

#define WATCH_USERID @"Watch_UserId"
#define WATCH_ROOMID @"Watch_RoomId"
#define WATCH_USERNAME @"Watch_UserName"
#define WATCH_PASSWORD @"Watch_Password"

#define PLAYBACK_USERID @"PlayBack_UserId"
#define PLAYBACK_ROOMID @"PlayBack_RoomId"
#define PLAYBACK_LIVEID @"PlayBack_LiveId"
#define PLAYBACK_RECORDID @"PlayBack_RecordId"
#define PLAYBACK_USERNAME @"PlayBack_UserName"
#define PLAYBACK_PASSWORD @"PlayBack_Password"

#define SET_SCREEN_LANDSCAPE @"SetScreenLandscape"
#define SET_BEAUTIFUL @"SetBeautiful"
#define SET_CAMERA_DIRECTION @"SetCameraDirection"
#define SET_SIZE @"SetSize"
#define SET_BITRATE @"SetBitRate"
#define SET_IFRAME @"SetIFrame"
#define SET_SERVER_INDEX @"SetServerIndex"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define KIsiPhoneX [UIScreen mainScreen].bounds.size.height>=812

#define KNavHeight ([UIScreen mainScreen].bounds.size.height>=812?88:64)

#define NativeScale [UIScreen mainScreen].nativeScale
#define NativeBounds [UIScreen mainScreen].nativeBounds

#define SCREEN_SCALE NativeBounds.size.width / 750.0

#define CCGetRealFromPt(x) (x / NativeScale) * SCREEN_SCALE

#define CCGetPxFromPt(x) (x / NativeScale)

#define PXTOPT(px) (px / 2)

//2.获取通知中心
#define CCNotificationCenter [NSNotificationCenter defaultCenter]

//3.设置随机颜色
#define CCRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

//4.设置RGB颜色/设置RGBA颜色
#define CCRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define CCRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
// clear背景颜色
#define CCClearColor [UIColor clearColor]

//5.自定义高效率的 NSLog
#ifdef DEBUG
#define CCLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define CCLog(...)

#endif

//7.设置 view 圆角和边框
#define CCViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

//8.由角度转换弧度 由弧度转换角度
#define CCDegreesToRadian(x) (M_PI * (x) / 180.0)
#define CCRadianToDegrees(radian) (radian*180.0)/(M_PI)

//9.设置加载提示框（第三方框架：Toast）
#define CCToast(str)              CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
[kWindow  makeToast:str duration:0.6 position:CSToastPositionCenter style:style];\
kWindow.userInteractionEnabled = NO; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
kWindow.userInteractionEnabled = YES;\
});\

//10.设置加载提示框（第三方框架：MBProgressHUD）
// 加载
#define kShowNetworkActivityIndicator() [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
// 收起加载
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
// 设置加载
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x

#define kWindow [UIApplication sharedApplication].keyWindow

#define kBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[item removeFromSuperview]; \
UIView * aView = [[UIView alloc] init]; \
aView.frame = [UIScreen mainScreen].bounds; \
aView.tag = 10000; \
aView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3]; \
[kWindow addSubview:aView]; \
} \
} \

#define kShowHUDAndActivity kBackView;[MBProgressHUD showHUDAddedTo:kWindow animated:YES];kShowNetworkActivityIndicator()


#define kHiddenHUD [MBProgressHUD hideAllHUDsForView:kWindow animated:YES]

#define kRemoveBackView         for (UIView *item in kWindow.subviews) { \
if(item.tag == 10000) \
{ \
[UIView animateWithDuration:0.4 animations:^{ \
item.alpha = 0.0; \
} completion:^(BOOL finished) { \
[item removeFromSuperview]; \
}]; \
} \
} \

#define kHiddenHUDAndAvtivity kRemoveBackView;kHiddenHUD;HideNetworkActivityIndicator()


//11.获取view的frame/图片资源
//获取view的frame（不建议使用）
//#define kGetViewWidth(view)  view.frame.size.width
//#define kGetViewHeight(view) view.frame.size.height
//#define kGetViewX(view)      view.frame.origin.x
//#define kGetViewY(view)      view.frame.origin.y

//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]


//12.获取当前语言
#define CCCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//13.使用 ARC 和 MRC
#if __has_feature(objc_arc)
// ARC
#else
// MRC
#endif

//14.判断当前的iPhone设备/系统版本
//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

// 判断是否为 iPhone 4/4s
#define iPhone4_4s NativeBounds.size.width == 640.0f && NativeBounds.size.height == 960.0f

// 判断是否为 iPhone 5/5s/5c/5SE
#define iPhone5_5s_5c_5SE NativeBounds.size.width == 640.0f && NativeBounds.size.height == 1136.0f

// 判断是否为iPhone 6/6s/7
#define iPhone6_6s_7 NativeBounds.size.width == 750.0f && NativeBounds.size.height == 1334.0f

// 判断是否为iPhone 6Plus/6sPlus/7Plus
#define iPhone6Plus_6sPlus_7Plus NativeBounds.size.width == 1242.0f && NativeBounds.size.height == 2208.0f

#define MinSize (iPhone4_4s || iPhone5_5s_5c_5SE || iPhone6_6s_7)
#define MaxSize iPhone6Plus_6sPlus_7Plus

#define FontSize_20 MinSize?10:12
#define FontSize_24 MinSize?12:13
#define FontSize_26 MinSize?13:14
#define FontSize_28 MinSize?14:15
#define FontSize_30 MinSize?15:16
#define FontSize_32 MinSize?16:17
#define FontSize_34 MinSize?17:18
#define FontSize_36 MinSize?18:19
#define FontSize_40 MinSize?20:21
#define FontSize_42 MinSize?21:23
#define FontSize_72 MinSize?36:40

typedef NS_ENUM(NSInteger, NSContentType) {
    NS_CONTENT_TYPE_CHAT,//默认从0开始
    NS_CONTENT_TYPE_QA_QUESTION,
    NS_CONTENT_TYPE_QA_ANSWER,
};

//获取系统版本
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))

//15.判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//16.沙盒目录文件
//获取temp
#define kPathTemp NSTemporaryDirectory()

//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//17.GCD 的宏定义
//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);

//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);

//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);

#define NavigationBarHiddenYES [self.navigationController setNavigationBarHidden:YES animated:YES];

#define NavigationBarHiddenNO [self.navigationController setNavigationBarHidden:NO animated:YES];

#define APPDelegate [UIApplication sharedApplication].delegate

#define SaveToUserDefaults(key,value) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]

#define GetFromUserDefaults(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define StrNotEmpty(str) (str != nil && ![str isEqualToString:@""] && [str length] != 0)




//====================================================================
#ifndef __IPHONE_3_0
#warning "This project uses features only available in iOS SDK 3.0 and later."
#endif

#if DEBUG
#define logtrace() NSLog(@"%s():%d ", __func__, __LINE__)
#define logdebug(format, ...) NSLog(@"%s():%d "format, __func__, __LINE__, ##__VA_ARGS__)
#else
#define logdebug(format, ...)
#define logtrace()
#endif

#define loginfo(format, ...) NSLog(@"%s():%d "format, __func__, __LINE__, ##__VA_ARGS__)

#define logerror(format, ...) NSLog(@"%s():%d ERROR "format, __func__, __LINE__, ##__VA_ARGS__)

#define IsIOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

//弱引用
#define WeakSelf(type)  __weak typeof(type) weak##type = type

//强引用
#define StrongSelf(type)  __strong typeof(type) type = weak##type

// 账户信息

#define DWACCOUNT_USERID @"0B3599769C706E96"
#define DWACCOUNT_APIKEY @"0rhtyutfIUcQcZm0qWrJoioXl2OCj7xK"

#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#endif


#define NoVIPPlayTime      5.0
#define MaxUplodeFileSize  2.0

//输出日志
//#define NSLog(fmt,...) NSLog((@"%s,[行号:%d]" fmt),__PRETTY_FUNCTION__,__LINE__,##__VA_ARGS__)
#define NSLog(format, ...) printf("%s %s [行号:%d]: %s\n",[[NSDate date].description UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String])



#define DWAPPDELEGATE ((AppDelegate*)([[UIApplication sharedApplication] delegate]))

#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"BFSearchhistories.plist"]


// 课程宏定义
#define CollectionColummnMargin  15                                              // 列间距
#define CollectionRowMargin  15                                                  // 行间距
#define CollectionCellWidth  ((KScreenW - (CollectionRowMargin * 3)) / 2)        // cell宽度
