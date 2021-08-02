//
//  BFCarEvaluateModel.m
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCarEvaluateModel.h"

@implementation BFCarEvaluateModel
+ (instancetype)initWithDict:(NSDictionary *)dict{
    BFCarEvaluateModel *model = [BFCarEvaluateModel mj_objectWithKeyValues:dict];
    
    if ([[dict allKeys] containsObject:@"replys"]) {
        NSArray *replys = dict[@"replys"];
        if (replys.count == 0) {
            model.haveReply = NO;
        }else{
            model.haveReply = YES;
        }
    }else{
        model.haveReply = NO;
    }
    model.comFlag = [dict[@"comFlag"] integerValue];
    return model;
}

/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"replys" : @"BFCarEvaluateReplyModel"
              };
}
@end
