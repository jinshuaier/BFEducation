//
//  BFMyCourseModel.m
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMyCourseModel.h"
#import "BFTimeTransition.h"

@implementation BFMyCourseModel
+ (instancetype)initWithDict:(NSDictionary *)dic{
    BFMyCourseModel *model = [BFMyCourseModel mj_objectWithKeyValues:dic];
    model.isLoseEfficacy = [BFTimeTransition compareCurrentTimeWithTime:model.cEndTime];
    return model;
}
@end
