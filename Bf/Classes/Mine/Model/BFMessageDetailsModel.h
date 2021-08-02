//
//  BFMessageDetailsModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFMessageDetailsModel : NSObject
// 头像
@property (nonatomic , strong) NSString *headerImageName;
// 时间
@property (nonatomic , strong) NSString *timeStr;
// 描述
@property (nonatomic , strong) NSString *describeStr;
// 帖子
@property (nonatomic , strong) NSString *contentStr;
@end
