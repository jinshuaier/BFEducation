//
//  BFTimeTransition.m
//  Bf
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFTimeTransition.h"

@implementation BFTimeTransition
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString dateFormat:(NSString *)dateFormat
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSTimeInterval)getCurrentTime{
    NSDate *senddate = [NSDate date];
    return [senddate timeIntervalSince1970] * 1000;
}

+ (NSInteger)compareCurrentTimeWithTime:(NSTimeInterval)time{
    NSTimeInterval currentTime = [self getCurrentTime];
    if (currentTime > time) {
        return 1;
    }else if (currentTime == time){
        return 0;
    }else{
        return -1;
    }
}

+ (NSTimeInterval)differenceValueWithTime:(NSTimeInterval)time{
    NSTimeInterval currentTime = [self getCurrentTime];
    return currentTime - time;
}

+ (NSString *)diffTimeTransformWithTime:(NSTimeInterval)time{
    NSInteger day = 0;
    NSInteger hour = 0;
    NSInteger min = 0;
    NSInteger second = 0;
    NSString *str;
    if (time / 1000 / 60 / 60 / 24 > 0) {
        day = time / 1000 / 60 / 60 / 24;
        hour = (time - (day * 1000 * 60 * 60 * 24)) / 1000 / 60 / 60;
        str = [NSString stringWithFormat:@"%ld天%ld小时",day,hour];
    }else if (time / 1000 / 60 / 60 > 0){
        hour = time / 1000 / 60 / 60;
        min = (time - (hour * 1000 * 60 * 60)) / 1000 / 60;
        str = [NSString stringWithFormat:@"%ld小时%ld分",hour,min];
    }else if (time / 1000 / 60 > 0){
        min = time / 1000 / 60;
        second = (time - (min * 1000 * 60)) / 1000;
        str = [NSString stringWithFormat:@"%ld分%ld秒",min,second];
    }else if (time / 1000 > 0){
        str = [NSString stringWithFormat:@"%ld秒",second];
    }else{
        str = @"刚刚";
    }
    
    return str;
}

+ (NSString *)diffTimeTransformEvaluateWithTime:(NSTimeInterval)time{
    NSInteger day = 0;
    NSInteger hour = 0;
    NSInteger min = 0;
    NSInteger second = 0;
    NSString *str;
    NSInteger tempTime = [self differenceValueWithTime:time];
    if (tempTime / 1000 / 60 / 60 / 24 > 0) {
        day = tempTime / 1000 / 60 / 60 / 24;
        str = [NSString stringWithFormat:@"%ld天前",day];
    }else if (tempTime / 1000 / 60 / 60 > 0){
        hour = tempTime / 1000 / 60 / 60;
        str = [NSString stringWithFormat:@"%ld小时前",hour];
    }else if (tempTime / 1000 / 60 > 0){
        min = tempTime / 1000 / 60;
        str = [NSString stringWithFormat:@"%ld分前",min];
    }else if (tempTime / 1000 > 0){
        second = tempTime / 1000;
        if (second <= 10) {
            str = @"刚刚";
        }else{
            str = [NSString stringWithFormat:@"%ld秒",second];
        }
    }else{
        str = @"刚刚";
    }
    return str;
}

@end
