//
//  BFJobStyleModel.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/29.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFJobStyleModel.h"

@implementation BFJobStyleModel
-(instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

// 放错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
