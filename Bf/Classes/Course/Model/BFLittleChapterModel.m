//
//  BFLittleChapterModel.m
//  Bf
//
//  Created by 春晓 on 2017/12/19.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFLittleChapterModel.h"

@implementation BFLittleChapterModel
+ (instancetype)initWithDict:(NSDictionary *)dict{
    BFLittleChapterModel *model = [BFLittleChapterModel mj_objectWithKeyValues:dict];
    return model;
}

/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"child" : @"BFCourseModel"
              };
}
@end
