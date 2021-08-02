//
//  BFLittleChapterModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/19.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFLittleChapterModel : NSObject
// 标题
@property (nonatomic , strong) NSString *ctitle;
// 子数组
@property (nonatomic , strong) NSArray *child;
// 小节id
@property (nonatomic , assign) NSInteger cid;
// 是否展示
@property (nonatomic , assign) BOOL isShow;

+ (instancetype)initWithDict:(NSDictionary *)dict;
@end
