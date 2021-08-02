//
//  BFCarNewsModel.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCarNewsModel.h"
#import "BFCarConsultContentModel.h"

@implementation BFCarNewsModel
-(instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    if (!self.contentArray) {
        self.contentArray = [NSMutableArray array];
    }
    //1. 去掉首尾空格和换行符
    self.iNickName = [self.iNickName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //2. 去掉所有空格和换行符
    self.iNickName = [self.iNickName stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    self.iNickName = [self.iNickName stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    self.curPage = 0;
    self.lastPage = 1;
    return self;
}

- (void)fillWithDict:(NSDictionary *)dict{
    [self setValuesForKeysWithDictionary:dict];
}

// 放错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}



@end
