//
//  BFSetCourseModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFSetCourseModel : NSObject
// 是否失效
@property (nonatomic , assign) BOOL isLoseEfficacy;

// 图片路径
@property (nonatomic , strong) NSString *cscover;
// 课程名字
@property (nonatomic , strong) NSString *cstitle;
// 课程开始时间
@property (nonatomic , assign) NSInteger cstarttime;
// 课程结束时间
@property (nonatomic , assign) NSInteger cendtime;
// 课程学分
@property (nonatomic , assign) NSInteger csprice;
// 课程剩余人数
@property (nonatomic , assign) NSInteger residueCount;
// 课程ID
@property (nonatomic , assign) NSInteger csid;
// 0=直播/1=视频(录播)
@property (nonatomic , assign) NSInteger ckey;
// 0=单课/1=系列
@property (nonatomic , assign) NSInteger cstate;

@property (nonatomic , assign) NSInteger buyState;
// 收藏 -1未登陆 0没收藏 1收藏
@property (nonatomic , assign) NSInteger sc;

@property (nonatomic , assign) NSInteger gouke;
// 描述
@property (nonatomic , strong) NSString *descriptionStr;
// 剩余人数
@property (nonatomic , assign) NSInteger cnum;
@end
