//
//  BFTipModel.m
//  Bf
//
//  Created by 陈大鹰 on 2018/2/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFTipModel.h"

@implementation BFTipModel
-(instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    //1. 去掉首尾空格和换行符
    self.iNickName = [self.iNickName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去掉所有空格和换行符
    self.iNickName = [self.iNickName stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    self.iNickName = [self.iNickName stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return self;
}

// 放错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
