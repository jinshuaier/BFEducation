//
//  BFEvaluateModel.m
//  NewTest
//
//  Created by 春晓 on 2017/12/1.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFEvaluateModel.h"

@implementation BFEvaluateModel
+ (instancetype)initWithDict:(NSDictionary *)dict{
    BFEvaluateModel *model = [BFEvaluateModel mj_objectWithKeyValues:dict];
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
    return model;
}

/* 实现该方法，说明数组中存储的模型数据类型 */
+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"replys" : @"BFEvaluateReplyModel"
              };
}

//- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    if ([key isEqualToString:@"nCComment"]) {
//        _pCComment = value;
//    }else if ([key isEqualToString:@"nCId"]) {
//        _pCId = [value integerValue];
//    }else if ([key isEqualToString:@"nCState"]) {
//        _pCComment = value;
//    }else if ([key isEqualToString:@"nCTime"]) {
//        _pCComment = value;
//    }else if ([key isEqualToString:@"nComCount"]) {
//        _pCComment = value;
//    }else if ([key isEqualToString:@"nId"]) {
//        _pCComment = value;
//    }
//}

@end
