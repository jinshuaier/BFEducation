//
//  BFMyCourseModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFMyCourseModel : NSObject
// 是否过期
@property (nonatomic , assign) BOOL isLoseEfficacy;
// 结束时间
@property (nonatomic , strong) NSString *cEndDateTime;
// 
@property (nonatomic , assign) NSInteger cEndTime;
// 课程系列封面图
@property (nonatomic , strong) NSString *cCover;
// 系列主键
@property (nonatomic , assign) NSInteger cId;
// 人数
@property (nonatomic , assign) NSInteger cNum;
// 标题
@property (nonatomic , strong) NSString *cTitle;
// 开始时间
@property (nonatomic , strong) NSString *cStartDateTime;
//
@property (nonatomic , assign) NSInteger cStartTime;
// 类别ID
@property (nonatomic , assign) NSInteger classId;
// 0=直播 1=视频
@property (nonatomic , assign) NSInteger csKey;

@property (nonatomic , assign) NSInteger rCId;
// 学分
@property (nonatomic , assign) NSInteger rCRedit;

@property (nonatomic , assign) NSInteger rState;

@property (nonatomic , assign) NSInteger rTime;
// 距离开课时间
@property (nonatomic , strong) NSString *startingTime;

// 直播房间号
@property (nonatomic , strong) NSString *roomId;

+ (instancetype)initWithDict:(NSDictionary *)dic;

@end
