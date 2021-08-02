//
//  BFWatchCourseVC.h
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFBaseViewController.h"
@class BFCourseModel;
@interface BFWatchCourseVC : BFBaseViewController
// 看视频
@property (copy, nonatomic)NSString *videoId;
@property (copy, nonatomic)NSString *videoLocalPath;
@property (assign, nonatomic)BOOL playMode;
@property (strong, nonatomic)NSArray *videos;
@property (assign, nonatomic)NSInteger indexpath;

// 目录
@property (nonatomic , copy) NSMutableArray *dataSource;
@property (nonatomic , copy) NSMutableDictionary *catalogueDic;
// model
@property (nonatomic , strong) BFCourseModel *model;

// 是否可以点击目录
@property (nonatomic , assign) BOOL canClick;

// 是否是简介
@property (nonatomic , assign) BOOL isInstroduce;
// 课程系列id
@property (assign, nonatomic)NSInteger cid;
@end
