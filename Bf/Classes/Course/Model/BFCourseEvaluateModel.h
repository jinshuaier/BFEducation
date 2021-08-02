//
//  BFCourseEvaluateModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFCourseEvaluateModel : NSObject
// 评论内容
@property (nonatomic , strong) NSString *ceeval;
// 头像
@property (nonatomic , strong) NSString *iphoto;
//
@property (nonatomic , assign) NSInteger uid;
//
@property (nonatomic , assign) NSInteger ceid;
//
@property (nonatomic , assign) NSInteger uaid;
//
@property (nonatomic , assign) NSInteger rid;
//
@property (nonatomic , assign) NSInteger iid;
//
@property (nonatomic , assign) NSInteger cetime;
//
@property (nonatomic , assign) NSInteger uuid;
//
@property (nonatomic , assign) NSInteger aid;
//
@property (nonatomic , assign) NSInteger cestate;
//
@property (nonatomic , assign) NSInteger cistate;
//
@property (nonatomic , assign) NSInteger ciid;
//
@property (nonatomic , assign) NSInteger ablocked;
//
@property (nonatomic , assign) NSInteger uIds;
// 名字
@property (nonatomic , strong) NSString *inickname;
// 回复评论数组
@property (nonatomic , strong) NSArray *replys;

+ (instancetype)initWithDict:(NSDictionary *)dict;
@end
