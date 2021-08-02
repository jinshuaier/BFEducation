//
//  BFTimeTransition.h
//  Bf
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFTimeTransition : NSObject
// 时间格式转化
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString dateFormat:(NSString *)dateFormat;

// 获取当前时间戳
+ (NSTimeInterval)getCurrentTime;

// 当前时间与传进来的时间比较
+ (NSInteger)compareCurrentTimeWithTime:(NSTimeInterval)time;

// 时间差计算函数
+ (NSString *)diffTimeTransformWithTime:(NSTimeInterval)time;

+ (NSTimeInterval)differenceValueWithTime:(NSTimeInterval)time;

+ (NSString *)diffTimeTransformEvaluateWithTime:(NSTimeInterval)time;

@end
