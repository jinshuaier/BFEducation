//
//  AppDelegate.h
//  Bf
//
//  Created by 陈大鹰 on 2017/11/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWUploadItem.h"
#import "DWSDK.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL isDownloaded;
}
@property (assign, nonatomic)BOOL isDownloaded;
@property (strong, nonatomic)UIWindow *window;


@property (strong, nonatomic)DWUploadItems *uploadItems;

@property (strong, nonatomic)DWDrmServer *drmServer;

@property (nonatomic, assign) CGFloat scaleH;
@property (nonatomic, assign) CGFloat scaleW;
@end

