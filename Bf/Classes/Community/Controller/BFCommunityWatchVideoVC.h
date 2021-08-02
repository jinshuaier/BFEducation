//
//  BFCommunityWatchVideoVC.h
//  Bf
//
//  Created by 春晓 on 2017/12/16.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFCommunityWatchVideoVC : UIViewController
// 看视频
@property (copy, nonatomic)NSString *videoId;
@property (copy, nonatomic)NSString *videoLocalPath;
@property (assign, nonatomic)BOOL playMode;
@property (strong, nonatomic)NSArray *videos;
@property (assign, nonatomic)NSInteger indexpath;
@end
