//
//  AppDelegate.m
//  Bf
//
//  Created by 陈大鹰 on 2017/11/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "AppDelegate.h"
#import "CCTabBarController.h"
#import "BFLoginViewController.h"
#import "CCNavigationController.h"
#import "BFBaseViewController.h"
#import "BFCarConsultDetailsVC.h"
#import "BFCourseDetailsVC.h"
#import "BFCommunityDetailsVC.h"

#import "DWAccountViewController.h"
#import "DWUploadViewController.h"
#import "DWPlayerViewController.h"
#import "DWDownloadViewController.h"

#import "DWDownloadSessionManager.h"

// 直播
#import "LoadingView.h"
#import "InformationShowView.h"
#import "BFWatchLiveCourseVC.h"

#import <Bugly/Bugly.h>
#import <UserNotifications/UserNotifications.h>
#import "BFCourseModel.h"
#import "AppDelegate+GuideRootController.h"

#import "LiveShowViewController.h"
#import "LoadingView.h"
#import "InformationShowView.h"
#import "BFWatchLiveCourseVC.h"
#import "BFWatchCourseVC.h"
#import "BFWatchResumeController.h"
#define DWDownloadingItemPlistFilename @"downloadingItems.plist"
#define DWDownloadFinishItemPlistFilename @"downloadFinishItems.plist"

#define DWUploadItemPlistFilename @"uploadItems.plist"

#import "BFCarTalentsViewController.h"//车人才项目
@interface AppDelegate ()<UIAlertViewDelegate,UIScrollViewDelegate,UNUserNotificationCenterDelegate,RequestDataDelegate,CCPushUtilDelegate>
{
    NSDictionary     *nowDict;
}
@property (strong, nonatomic)DWAccountViewController *accountViewController;
@property (strong, nonatomic)DWUploadViewController *uploadViewController;
@property (strong, nonatomic)DWPlayerViewController *playerViewController;
@property (strong, nonatomic)DWDownloadViewController *downloadViewController;
@property (strong, nonatomic)BFCarTalentsViewController *carVC;


// 短信启动参数
@property (nonatomic , strong) NSDictionary *msgOpenDic;
@property (nonatomic , strong) NSNumber *Id;

@property (strong, nonatomic)CCTabBarController *tabBarController;

@property(nonatomic,strong) LoadingView *loadingView;
@property(nonatomic,strong) InformationShowView *informationView;
@property(nonatomic,strong) UILabel *informationLabel;
@property(nonatomic,strong) LiveShowViewController  *LiveShowViewController;
@property(nonatomic,copy) NSString *liveIdStr;
@property(nonatomic,strong) UIView *updateView;
// 直播
@property (nonatomic, assign) Boolean IsHorizontal;
// 分辨率
@property (nonatomic, assign) CGSize size;
// 码率
@property (nonatomic, assign) NSInteger bitRate;
// 帧率
@property (nonatomic, assign) NSInteger frameRate;

@end

@implementation AppDelegate

@synthesize isDownloaded;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DWLog setIsDebugHttpLog:YES];
    [[DWDownloadSessionManager manager] configureBackroundSession];
    [Bugly startWithAppId:@"74148b4cb8"];
    // Override point for customization after application launch.
    self.scaleH = ([UIScreen mainScreen].bounds.size.height)/667.0f;
    self.scaleW = ([UIScreen mainScreen].bounds.size.width)/375.0f;
    [self setRootViewController];
    
    //显示窗口
    [self.window makeKeyAndVisible];
    
    [self networkForCheckIfHasBeenLogin];
    
    [self networkForAppStoreCheckAndUpdateControl];
    
//    [self uMeng];
    
    //存储设备的UUID
    [BFUUIDManager getDeviceID];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5afa98a3f43e48694b000301"];
    //初始化U-Share及第三方平台
    // U-Share 平台设置
    [self configUSharePlatforms];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkIsHaveLiveCourse) name:@"CheckIsHaveLiveCourse" object:nil];
    NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"未运行状态下用户获得的个人信息为:%@",userInfo);
    // 推送
//    [self umPushWithOptions:launchOptions];
    
    return YES;
}

//- (void)umPushWithOptions:(NSDictionary *)launchOptions{
//    // Push组件基本功能配置
//    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
//    [[UIApplication sharedApplication] registerForRemoteNotifications];
//    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
//    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
//    entity.types = UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
//    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
//        if (granted) {
//
//        }else{
//
//        }
//    }];
//}

//// 推送
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
//    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
//                        stringByReplacingOccurrencesOfString: @">" withString: @""]
//                       stringByReplacingOccurrencesOfString: @" " withString: @""];
//    NSLog(@"推送：%@",token);
//    [UMessage registerDeviceToken:deviceToken];
//    SaveToUserDefaults(@"DeviceToken", token);
//}
//
////iOS10以下使用这两个方法接收通知
//-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
//{
//    [UMessage setAutoAlert:NO];
//    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
//        [UMessage didReceiveRemoteNotification:userInfo];
//        NSLog(@"运行状态下didReceiveRemoteNotification方法用户获得的个人信息为:%@",userInfo);
//    }
//    completionHandler(UIBackgroundFetchResultNewData);
//}
//
////iOS10新增：处理前台收到通知的代理方法
//-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
//    NSDictionary * userInfo = notification.request.content.userInfo;
//    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        [UMessage setAutoAlert:NO];
//        //应用处于前台时的远程推送接受
//        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
//        NSLog(@"运行状态下willPresentNotification方法用户获得的个人信息为:%@",userInfo);
//    }else{
//        //应用处于前台时的本地推送接受
//        //        [UMessage setAutoAlert:NO];
//        //        [UMessage didReceiveRemoteNotification:userInfo];
//        NSLog(@"应用处于前台时的本地推送接受用户获得的个人信息为:%@",userInfo);
//    }
//    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
//}
//
////iOS10新增：处理后台点击通知的代理方法
//-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
//    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
//        //应用处于后台时的远程推送接受
//        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
//        NSLog(@"运行状态下didReceiveNotificationResponse方法用户获得的个人信息为:%@",userInfo);
//        CCTabBarController *rootVC = (CCTabBarController *)self.window.rootViewController;
//        NSDictionary *userDic = userInfo;
//        NSString *stype = [NSString stringWithFormat:@"%@",userDic[@"push_type"]];
//        NSLog(@"运行状态下push_type的值为:%@",stype);
//        if ([stype isEqualToString:@"1"]) {//直播课程页
//
//            NSLog(@"用户已经进入到直播课程页中");
//            rootVC.selectedIndex = 0;
//            NSString *roomidStr = [NSString stringWithFormat:@"%@",userDic[@"roomid"]];
//            NSString *cid = [NSString stringWithFormat:@"%@",userDic[@"cid"]];
//            NSString *title = [NSString stringWithFormat:@"%@",userDic[@"title"]];
//            PlayParameter *parameter = [[PlayParameter alloc] init];
//            parameter.userId = DWACCOUNT_USERID;
//            parameter.roomId = roomidStr;
//            self.liveIdStr = roomidStr;
//            NSLog(@"此时获取到的数据为:%@ --- %@ --- %@",parameter.userId,parameter.roomId,self.liveIdStr);
//            parameter.viewerName = GetFromUserDefaults(@"iNickName");
//            parameter.token = @"";
//            parameter.security = NO;
//            parameter.viewerCustomua = @"viewercustomua";
//            RequestData *requestData = [[RequestData alloc] initLoginWithParameter:parameter];
//            requestData.delegate = self;
//
//            NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//            [dic setValue:roomidStr forKey:@"roomid"];
//            [dic setValue:cid forKey:@"ID"];
//            [dic setValue:title forKey:@"TITLETwo"];
//            nowDict = dic;
//
//            NSLog(@"此时获取到的字典为:%@",nowDict);
//        }
//        else if ([stype isEqualToString:@"2"]) {//视频课程页
//            NSLog(@"用户已经进入到视频课程页中");
//
//            rootVC.selectedIndex = 0;
//            CCNavigationController *homeNav = [rootVC.childViewControllers firstObject];
//            NSInteger csIdStr = [userDic[@" "] integerValue];
//            NSString *roomidStr = [NSString stringWithFormat:@"%@",userDic[@"roomid"]];
//            BFWatchCourseVC *player = [[BFWatchCourseVC alloc] init];
//            player.playMode = NO;
//            player.videoId = roomidStr;
//            player.videos = @[roomidStr];
//            player.isInstroduce = NO;
//            player.cid = csIdStr;
//            player.canClick = YES;
//            player.indexpath = 0;
//            [homeNav pushViewController:player animated:YES];
//
//        }
//        else if ([stype isEqualToString:@"3"]) {//跳转到帖子详情页
//            NSLog(@"用户已经进入到帖子详情页判断中");
//            rootVC.selectedIndex = 1;
//            CCNavigationController *homeNav = rootVC.childViewControllers[1];
//            BFCommunityDetailsVC *vc = [BFCommunityDetailsVC new];
//            BFCommunityModel *model = [BFCommunityModel new];
//            NSString *tipsId = [NSString stringWithFormat:@"%@",userDic[@"pId"]];
//            model.pId = [tipsId integerValue];
//            vc.model = model;
//            vc.isFromOtherApp = YES;
//            NSLog(@"帖子详情页id为:%@",tipsId);
//            [homeNav pushViewController:vc animated:YES];
//        }
//        else if ([stype isEqualToString:@"4"]) {//车人才详情页
//            NSLog(@"用户已经进入到车人才详情页中");
//            rootVC.selectedIndex = 3;
//        }
//        else if ([stype isEqualToString:@"5"]) {//原厂资料详情页
//            NSLog(@"用户已经进入到原厂资料详情页中");
//            rootVC.selectedIndex = 0;
//            CCNavigationController *homeNav = [rootVC.childViewControllers firstObject];
//            BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
//            watchVC.url = [NSString stringWithFormat:@"%@",userDic[@"dataUrl"]];
//            [homeNav pushViewController:watchVC animated:YES];
//
//        }
//        else if ([stype isEqualToString:@"6"]) {//中国汽车技术研究中心详情页
//            NSLog(@"用户已经进入到中国汽车技术研究中心详情页中");
//            rootVC.selectedIndex = 0;
//            CCNavigationController *homeNav = [rootVC.childViewControllers firstObject];
//            NSInteger csIdStr = [userDic[@"cId"] integerValue];
//            NSString *roomidStr = [NSString stringWithFormat:@"%@",userDic[@"roomid"]];
//            BFWatchCourseVC *player = [[BFWatchCourseVC alloc] init];
//            player.playMode = NO;
//            player.videoId = roomidStr;
//            player.videos = @[roomidStr];
//            player.isInstroduce = NO;
//            player.cid = csIdStr;
//            player.canClick = YES;
//            player.indexpath = 0;
//            [homeNav pushViewController:player animated:YES];
//
//        }
//        else if ([stype isEqualToString:@"7"]) {//资讯详情页
//            NSLog(@"用户已经进入到资讯详情页中");
//
//            rootVC.selectedIndex = 0;
//            CCNavigationController *homeNav = [rootVC.childViewControllers firstObject];
//            BFCarConsultDetailsVC *VC = [BFCarConsultDetailsVC new];
//            VC.carNewModel = [BFCarNewsModel new];
//            NSString *newsId = [NSString stringWithFormat:@"%@",userDic[@"nId"]];
//            VC.carNewModel.nId = [newsId integerValue];
//            VC.nId = [newsId integerValue];;
//            VC.isFromOtherApp = YES;
//            [homeNav pushViewController:VC animated:YES];
//
//        }
//        else if ([stype isEqualToString:@"8"]) {//系统及时推送 车人才企业端
//            NSLog(@"用户已经进入到车人才企业端页中");
//            rootVC.selectedIndex = 3;
//            NSDictionary *dic = @{@"uId":GetFromUserDefaults(@"uId"),
//                                  @"jpType":@"1",
//                                  @"jpToken":GetFromUserDefaults(@"DeviceToken")
//                                  };
//            [NetworkRequest sendDataWithUrl:phoneToken parameters:dic successResponse:^(id data) {
//                NSDictionary *dic = data;
//                if ([dic[@"status"] intValue] == 1) {
//                    NSLog(@"添加设备标识成功");
//                }
//                else {
//                    NSLog(@"添加设备标识失败");
//                }
//            } failure:^(NSError *error) {
//                NSLog(@"添加设备标识失败");
//            }];
//        }
//        else if ([stype isEqualToString:@"11"]) {//直接跳进主页
//            NSLog(@"用户已经进入到主页中");
//            rootVC.selectedIndex = 0;
//        }
//    }else{
//        //应用处于后台时的本地推送接受
//        NSLog(@"应用处于后台时的本地推送接受的个人信息为:%@",userInfo);
//    }
//}


//初始化U-Share及第三方平台
-(void)configUSharePlatforms {
    NSLog(@"当前版本号:%@",[UMSocialGlobal umSocialSDKVersion]);

    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx34b73821c8cce8b3" appSecret:@"c686a9f22f2707fa6ab910058bd01b8c" redirectURL:nil];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106619867"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3295439168"  appSecret:@"732f7466e82a6ef0905c018bb8cea83e" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

#pragma mark - 校验是否已经登录

-(void)networkForCheckIfHasBeenLogin {
    
    UIView *updateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    self.updateView = updateView;
    updateView.backgroundColor = [UIColor whiteColor];
    UIImageView *updateImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 200)/2, 200, 200, 200)];
    updateImg.image = [UIImage imageNamed:@"update"];
    [updateView addSubview:updateImg];
    UIButton *reBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reBtn.frame = CGRectMake((KScreenW - 80)/2, updateImg.bottom + 20, 80, 30);
    reBtn.layer.cornerRadius = 3.0f;
    reBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    reBtn.layer.borderColor = RGBColor(0, 148, 213).CGColor;
    reBtn.layer.borderWidth = 0.50f;
    [reBtn setTitle:@"重新加载" forState:UIControlStateNormal];
    [reBtn setTitleColor:RGBColor(0, 148, 213) forState:UIControlStateNormal];
    reBtn.backgroundColor = [UIColor whiteColor];
    [reBtn addTarget:self action:@selector(clickReloadData) forControlEvents:UIControlEventTouchUpInside];
    [updateView addSubview:reBtn];
    
    [NetworkRequest sendDataWithUrl:CHECKLOGIN parameters:nil successResponse:^(id data) {
        if ([data isKindOfClass:[NSString class]]) {
            NSLog(@"字符串");
        }
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:data];
        if (1 == [dic[@"status"] intValue]) {
            NSLog(@"用户已登录");
            SaveToUserDefaults(@"loginStatus", @"1");
        }
        else if (-2 == [dic[@"status"] intValue]) {
            SaveToUserDefaults(@"loginStatus", @"0");
//            [ZAlertView showSVProgressForInfoStatus:@"您的身份信息已失效,请您重新登录"];
        }
        else if (-10 == [dic[@"status"] intValue]) {
            SaveToUserDefaults(@"loginStatus", @"0");
        }
        else {
            SaveToUserDefaults(@"loginStatus", @"0");
//            [ZAlertView showSVProgressForInfoStatus:@"请您重新登录"];
        }
        
        [updateView removeFromSuperview];
      //  self.window.rootViewController = [[CCTabBarController alloc] init];
    } failure:^(NSError *error) {
//        [self.window.rootViewController.view addSubview:updateView];
    }] ;
}

-(void)clickReloadData {
    [self networkForCheckIfHasBeenLogin];
}

#pragma mark - 升级版本控制

-(void)networkForAppStoreCheckAndUpdateControl {
    [NetworkRequest requestWithUrl:AppCheck parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSDictionary *dicVersion = dic[@"data"];
        NSLog(@"返回的数据为:%@",dicVersion);
        //服务端返回的强制升级版本号
        NSString *forceVersion = [NSString stringWithFormat:@"%@",dicVersion[@"enforce"]];
        //服务端返回的版本号
        NSString *serverCheckVersion = dicVersion[@"versionnum"];
        //服务端返回的更新内容文案
        NSString *updateStr = dicVersion[@"vcontent"];
        
        //客户端本地的版本号
        NSString *clientCheckVersion = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
        //
        if ([serverCheckVersion isEqualToString:clientCheckVersion]) {
            SaveToUserDefaults(@"checkVersion",@"1");
        }
        else {
            SaveToUserDefaults(@"checkVersion",@"0");
        }
        //强制升级版本号判断
        int serverForceVersion = 0;
        //serverForceVersion是服务器端返回的"强制升级版本号"经过处理之后不带小数点的整型

        if (![forceVersion isEqualToString:@"0"]) {
            serverForceVersion = [[[forceVersion substringWithRange:NSMakeRange(0, 5)] stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
        }
        
        //clientForceVersion是客户端获取当前版本号并且经过处理之后不带小数点的整型
        int clientForceVersion = [[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
        //服务器返回的数据大于客户端数据的话进行强制升级
        if (serverForceVersion > clientForceVersion) {
            NSString *messageVersion = updateStr;
            NSString *mainTiele = [NSString stringWithFormat:@"北方职教邀您体验新版本"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:mainTiele message:messageVersion delegate:self cancelButtonTitle:@"暂不升级" otherButtonTitles:@"马上升级", nil];
            alertView.delegate = self;
            [alertView show];
        }
    } failureResponse:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

#pragma mark - UIAlertView代理事件

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
    }
    else {
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%8C%97%E6%96%B9%E8%81%8C%E6%95%99/id1329341454?mt=8"]];
    }
}

//#pragma mark - 友盟统计
//
//-(void)uMeng {
//    [UMCommonLogManager setUpUMCommonLogManager];
//    [UMConfigure setLogEnabled:YES];
//    [UMConfigure initWithAppkey:@"5afa98a3f43e48694b000301" channel:@"App Store"];
//    [MobClick setScenarioType:E_UM_GAME|E_UM_DPLUS];
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // 停止 drmServer
    [self.drmServer stop];
    
    // 上传
    [self.uploadItems writeToPlistFile:DWUploadItemPlistFilename];
    for (DWUploadItem *item in self.uploadItems.items) {
        if (item.uploader) {
            [item.uploader pause];
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //校验用户是否登录
    [self networkForCheckIfHasBeenLogin];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 启动 drmServer
    self.drmServer = [[DWDrmServer alloc] initWithListenPort:20140];
    BOOL success = [self.drmServer start];
    if (!success) {
        logerror(@"drmServer 启动失败");
    }
    
    
    // 上传
    self.uploadItems = [[DWUploadItems alloc] initWithPath:DWUploadItemPlistFilename];
    for (DWUploadItem *item in self.uploadItems.items) {
        switch (item.videoUploadStatus) {
            case DWUploadStatusStart:
                item.videoUploadStatus = DWUploadStatusWait;
                break;
                
            case DWUploadStatusUploading:
                item.videoUploadStatus = DWUploadStatusWait;
                break;
                
            default:
                break;
        }
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    // 1.将URL转成字符串
    NSString *urlString = url.absoluteString;
    NSLog(@"%@",urlString);
    
    NSArray *arr = [url.host componentsSeparatedByString:@"="];
    NSInteger Id = [[arr lastObject] integerValue];
    
    // 获取到主页控制器
    CCTabBarController *rootVC = (CCTabBarController *)self.window.rootViewController;
    // 2.跳转过来
    if ([urlString containsString:@"course"]) {
        rootVC.selectedIndex = 2;
        CCNavigationController *homeNav = rootVC.childViewControllers[2];
        BFCourseDetailsVC *VC = [BFCourseDetailsVC new];
        VC.model = [BFCourseModel new];
        VC.model.cid = Id;
        VC.isFromOtherApp = YES;
        [homeNav pushViewController:VC animated:YES];
    } else if ([urlString containsString:@"community"]){
        rootVC.selectedIndex = 1;
        CCNavigationController *homeNav = rootVC.childViewControllers[1];
        BFCommunityDetailsVC *VC = [BFCommunityDetailsVC new];
        VC.model = [BFCommunityModel new];
        VC.model.pId = Id;
        VC.isFromOtherApp = YES;
        [homeNav pushViewController:VC animated:YES];
    } else if ([urlString containsString:@"consult"]){
        rootVC.selectedIndex = 0;
        CCNavigationController *homeNav = [rootVC.childViewControllers firstObject];
        BFCarConsultDetailsVC *VC = [BFCarConsultDetailsVC new];
        VC.carNewModel = [BFCarNewsModel new];
        VC.carNewModel.nId = Id;
        VC.nId = Id;
        VC.isFromOtherApp = YES;
        [homeNav pushViewController:VC animated:YES];
    } else if ([urlString containsString:@"liveCourse"]){
        rootVC.selectedIndex = 0;
    } else if ([urlString containsString:@"carTalent"]){
        rootVC.selectedIndex = 3;
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    NSLog(@"url = %@,options = %@",url,options);
    NSString *urlString = url.absoluteString;
    if ([urlString containsString:@"course"] || [urlString containsString:@"community"] || [urlString containsString:@"consult"] || [urlString containsString:@"liveCourse"] || [urlString containsString:@"carTalent"]){
        NSArray *arr = [url.host componentsSeparatedByString:@"="];
        NSInteger Id = [[arr lastObject] integerValue];
        
        // 获取到主页控制器
        CCTabBarController *rootVC = (CCTabBarController *)self.window.rootViewController;
        if ([urlString containsString:@"course"]) {
            rootVC.selectedIndex = 2;
            CCNavigationController *homeNav = rootVC.childViewControllers[2];
            BFCourseDetailsVC *VC = [BFCourseDetailsVC new];
            VC.model = [BFCourseModel new];
            VC.model.cid = Id;
            VC.isFromOtherApp = YES;
            [homeNav pushViewController:VC animated:YES];
        } else if ([urlString containsString:@"community"]){
            rootVC.selectedIndex = 1;
            CCNavigationController *homeNav = rootVC.childViewControllers[1];
            BFCommunityDetailsVC *VC = [BFCommunityDetailsVC new];
            VC.model = [BFCommunityModel new];
            VC.model.pId = Id;
            VC.isFromOtherApp = YES;
            [homeNav pushViewController:VC animated:YES];
        } else if ([urlString containsString:@"consult"]){
            rootVC.selectedIndex = 0;
            CCNavigationController *homeNav = [rootVC.childViewControllers firstObject];
            BFCarConsultDetailsVC *VC = [BFCarConsultDetailsVC new];
            VC.carNewModel = [BFCarNewsModel new];
            VC.carNewModel.nId = Id;
            VC.nId = Id;
            VC.isFromOtherApp = YES;
            [homeNav pushViewController:VC animated:YES];
        } else if ([urlString containsString:@"liveCourse"]){
            rootVC.selectedIndex = 0;
            CCNavigationController *homeNav = [rootVC.childViewControllers firstObject];
            NSString *str = GetFromUserDefaults(@"loginStatus");
            if ([str isEqualToString:@"1"]) {
//                NSArray *arr = [url.host componentsSeparatedByString:@"&"];
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                for (NSString *str in arr) {
//                    if ([str containsString:@"="]) {
//                        NSArray *subArr = [str componentsSeparatedByString:@"="];
//                        [dic setValue:subArr[1] forKey:subArr[0]];
//                    }
//                }
//                NSLog(@"%@",dic);
//                if (![[dic allKeys] containsObject:@"passWord"]) {
//                    [dic setValue:@"" forKey:@"passWord"];
//                }
//                _msgOpenDic = dic;
//                NSMutableDictionary *mDIc = _msgOpenDic.mutableCopy;
                _Id = @(Id);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WatchLiveCourse" object:_Id];
                
            }
            else {
                BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
                [homeNav pushViewController:loginVC animated:YES];
            }
        } else if ([urlString containsString:@"carTalent"]){
            rootVC.selectedIndex = 3;
        }
        return YES;
    }
    
    // 判断传过来的url是否为文件类型
    if ([url.scheme isEqualToString:@"file"]) {
        NSLog(@"当前获得的文件路径为:%@",url);
        NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobResumeJRreUrlInsert.do",ServerURL];
        NSData *data = [NSData dataWithContentsOfURL:url options:NSDataReadingMappedIfSafe error:nil];
        NSString *str = [NSString stringWithFormat:@"%@",url];
        NSDictionary *dic = @{@"uId":GetFromUserDefaults(@"uId")};
        
        //1.创建管理者对象
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/plain",@"video/cc",nil];
        //http请求头上添加cookie和token
        NSString* cookie = GetFromUserDefaults(@"session") ? : @""; //先给个默认值防止crash
        NSString *token = GetFromUserDefaults(@"token") ? : @"";
        NSString *uId = [NSString stringWithFormat:@"%@",GetFromUserDefaults(@"uId") ? : @""];
        NSString *session = [NSString stringWithFormat:@"sessionId=%@;JSESSIONID=%@",cookie,cookie];
        [manager.requestSerializer setValue:session forHTTPHeaderField:@"sessionId"];
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        [manager.requestSerializer setValue:uId forHTTPHeaderField:@"uId"];
        
        [manager POST:urlStr parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            
            [formData appendPartWithFileData:data name:@"jrreFile" fileName:[NSString stringWithFormat:@"个人简历.%@",str.pathExtension] mimeType:@"application/octet-stream"];
            
        } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [ZAlertView showSVProgressForSuccess:@"附件简历上传成功"];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            [ZAlertView showSVProgressForErrorStatus:@"附件简历上传失败"];
            
        }];
        return YES;
    }
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    NSLog(@"url:%@",url.absoluteString);
    NSLog(@"host:%@",url.host);
    if ([url.host isEqualToString:@"test"])
    {
        NSLog(@"进入测试界面");
    }
    else {
        BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
        if (!result) {
            // 其他如支付等SDK的回调
        }
        return result;
    }
    return YES;
}

// 检测是否有短信启动，如果有，跳转
- (void)checkIsHaveLiveCourse{
    if (_msgOpenDic) {
        NSInteger ID = [_Id integerValue];
        NSNumber *Id = @(ID);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"WatchLiveCourse" object:Id];
        _Id = nil;
    }
}

#pragma mark -CCPushUtilDelegate-
//@optional
/**
 *    @brief    请求成功
 */
-(void)requestLoginSucceedWithViewerId:(NSString *)viewerId {
    NSLog(@"登录成功 viewerId = %@",viewerId);
    [self OnStartLive];
}

-(void)OnStartLive{
    _LiveShowViewController = nil;
    _LiveShowViewController = [[LiveShowViewController alloc] init];
    _LiveShowViewController.roomId = [NSString stringWithFormat:@"%@",nowDict[@"roomid"]];
    _LiveShowViewController.IsHorizontal = _IsHorizontal;
    float width = _size.width;
    float height = _size.height;
    if (_IsHorizontal) {
        _size.width = MAX(width, height);
        _size.height = MIN(width, height);
    } else {
        _size.width = MIN(width, height);
        _size.height = MAX(width, height);
    }
    [[CCPushUtil sharedInstanceWithDelegate:self] setVideoSize:_size BitRate:(int)_bitRate FrameRate:(int)_frameRate];
    CCTabBarController *rootVC = (CCTabBarController *)self.window.rootViewController;
    rootVC.selectedIndex = 0;
    CCNavigationController *homeNav = rootVC.childViewControllers[1];
    _LiveShowViewController.modalPresentationStyle = 0;
    [homeNav presentViewController:_LiveShowViewController animated:YES completion:nil];
}

/**
 *    @brief    登录请求失败
 */
-(void)requestLoginFailed:(NSError *)error reason:(NSString *)reason {
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    //    _innerView.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[@"原因：" stringByAppendingString:message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
#pragma mark - CCPushDelegate
//@optional
/**
 *    @brief    请求成功
 */
-(void)loginSucceedPlay {
    SaveToUserDefaults(WATCH_USERID,DWACCOUNT_USERID);
    SaveToUserDefaults(WATCH_ROOMID,self.liveIdStr);
    SaveToUserDefaults(WATCH_USERNAME,GetFromUserDefaults(@"iNickName"));
    SaveToUserDefaults(WATCH_PASSWORD,@"");
    [_loadingView removeFromSuperview];
    _loadingView = nil;
    [UIApplication sharedApplication].idleTimerDisabled=YES;
    
    NSLog(@"获取到的数据为:%@",nowDict);
    
    
    BFWatchLiveCourseVC *vc = [[BFWatchLiveCourseVC alloc] initWithLeftLabelText:[NSString stringWithFormat:@"%@",nowDict[@"TITLETwo"]]];
    vc.cid = [[NSString stringWithFormat:@"%@",nowDict[@"ID"]] integerValue];
    vc.dict = nowDict;
    CCTabBarController *rootVC = (CCTabBarController *)self.window.rootViewController;
    rootVC.selectedIndex = 0;
    CCNavigationController *homeNav = rootVC.childViewControllers[1];
    vc.modalPresentationStyle = 0;
    [homeNav presentViewController:vc animated:YES completion:nil];
}

/**
 *    @brief    登录请求失败
 */
-(void)loginFailed:(NSError *)error reason:(NSString *)reason {
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    [_loadingView removeFromSuperview];
    _loadingView = nil;
    [self showInformationViewWithMessage:message];
}

- (void)showInformationViewWithMessage:(NSString *)message{
    [_informationView removeFromSuperview];
    _informationView = [[InformationShowView alloc] initWithLabel:message];
//    [self. addSubview:_informationView];
    [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeInformationView) userInfo:nil repeats:NO];
}

-(void)removeInformationView {
    [_informationView removeFromSuperview];
    _informationView = nil;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

