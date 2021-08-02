//
//  BFCourseDetailsTopModel.h
//  基本框架
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BFCourseDetailsTopModel : NSObject

// 课程状态
@property (nonatomic , strong) NSString *courseState;
// 课程名字
@property (nonatomic , strong) NSString *courseName;
// 课程时间
@property (nonatomic , strong) NSString *courseTime;
// 剩余名额
@property (nonatomic , assign) NSInteger restNumber;
// 学分
@property (nonatomic , assign) NSInteger credit;


@end
