//
//  BFCourseEvaluateReplyModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFCourseEvaluateReplyModel : NSObject

//
@property (nonatomic , assign) NSInteger ceid;
//
@property (nonatomic , assign) NSInteger uid;
//
@property (nonatomic , assign) BOOL cistate;
//
@property (nonatomic , assign) NSInteger ciid;
//
@property (nonatomic , assign) NSInteger cestate;
//
@property (nonatomic , assign) NSInteger aid;
//
@property (nonatomic , assign) NSInteger cetime;
//
@property (nonatomic , assign) BOOL ablocked;
//
@property (nonatomic , assign) NSInteger uIds;
// 内容
@property (nonatomic , strong) NSString *ceeval;
// 名字
@property (nonatomic , strong) NSString *inickname;

@end
