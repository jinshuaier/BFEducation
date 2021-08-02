//
//  BFCourseDetailsTeachers.m
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCourseDetailsTeachers.h"

@implementation BFCourseDetailsTeachers
+ (instancetype)initWithDict:(NSDictionary *)dict{
    BFCourseDetailsTeachers *model = [BFCourseDetailsTeachers mj_objectWithKeyValues:dict];
    model.teacherRole = TeacherRole_Give;
    return model;
}

/* 实现该方法，说明数组中存储的模型数据类型 */
//+ (NSDictionary *)mj_objectClassInArray{
//    return @{ @"replys" : @"BFEvaluateReplyModel"
//              };
//}
@end
