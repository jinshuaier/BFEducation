//
//  BFCourseModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BFCollectClassModel;


@interface BFCourseModel : NSObject
// 是否失效
@property (nonatomic , assign) BOOL isLoseEfficacy;

// 图片路径
@property (nonatomic , strong) NSString *cscover;
// 课程名字
@property (nonatomic , strong) NSString *ctitle;
// 课程开始时间
@property (nonatomic , assign) NSInteger cstarttime;
// 课程结束时间
@property (nonatomic , assign) NSInteger cendtime;
// 课程学分
@property (nonatomic , assign) NSInteger cprice;
// 课程剩余人数
@property (nonatomic , assign) NSInteger residueCount;
// 课程ID
@property (nonatomic , assign) NSInteger cid;
// 0=直播/1=视频(录播)
@property (nonatomic , assign) NSInteger ckey;
// 0=单课/1=系列
@property (nonatomic , assign) NSInteger cstate;
// 剩余人数
@property (nonatomic , assign) NSInteger cnum;
//
@property (nonatomic , assign) NSInteger ctype;
//
@property (nonatomic , assign) NSInteger csort;
//
@property (nonatomic , assign) NSInteger ccid;
// 试听课videoId
@property (nonatomic , strong) NSString *cvideo;
// 播放id
@property (nonatomic , strong) NSString *roomid;
// 收藏 -1未登陆 0没收藏 1收藏
@property (nonatomic , assign) NSInteger sc;

@property (nonatomic , assign) NSInteger gouke;
// 描述
@property (nonatomic , strong) NSString *descriptionStr;

// 封面图
@property (nonatomic , strong) UIImage *coverImg;

- (instancetype)initWithBFCollectClassModel:(BFCollectClassModel *)model;

- (void)fillWithDict:(NSDictionary *)dict;


@end
