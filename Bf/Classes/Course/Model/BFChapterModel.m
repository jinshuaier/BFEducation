//
//  BFChapterModel.m
//  Bf
//
//  Created by 春晓 on 2017/12/19.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFChapterModel.h"

@implementation BFChapterModel
+ (instancetype)initWithDict:(NSDictionary *)dict{
    BFChapterModel *model = [BFChapterModel mj_objectWithKeyValues:dict];
    return model;
}

/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"child" : @"BFLittleChapterModel"
              };
}
@end
