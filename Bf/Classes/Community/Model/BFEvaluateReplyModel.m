//
//  BFEvaluateReplyModel.m
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFEvaluateReplyModel.h"

@implementation BFEvaluateReplyModel
+ (instancetype)initWithDict:(NSDictionary *)dict{
    BFEvaluateReplyModel *model = [BFEvaluateReplyModel mj_objectWithKeyValues:dict];
    return model;
}
@end
