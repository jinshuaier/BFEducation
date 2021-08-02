//
//  BFCourseEvaluateModel.m
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCourseEvaluateModel.h"

@implementation BFCourseEvaluateModel
+ (instancetype)initWithDict:(NSDictionary *)dict{
    BFCourseEvaluateModel *model = [BFCourseEvaluateModel mj_objectWithKeyValues:dict];
    return model;
}

// 实现该方法，说明数组中存储的模型数据类型
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"replys" : @"BFCourseEvaluateReplyModel"
              };
}

//- (NSString *)description{
//    return [NSString stringWithFormat:@"ceeval = %@",_ceeval];
//}

@end
