//
//  BFWatchCourseVideoVC.h
//  Bf
//
//  Created by 春晓 on 2017/12/29.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFWatchCourseVideoVC : BFBaseViewController
// 看视频
@property (copy, nonatomic)NSString *videoId;
@property (copy, nonatomic)NSString *videoLocalPath;
@property (assign, nonatomic)BOOL playMode;
@property (strong, nonatomic)NSArray *videos;
@property (assign, nonatomic)NSInteger indexpath;
// 是否可以点击目录
@property (nonatomic , assign) BOOL canClick;
@end
