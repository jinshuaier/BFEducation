//
//  BFPlayBack.h
//  Bf
//
//  Created by 春晓 on 2017/11/22.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFPlayBack : NSObject
// 回放Id
@property (nonatomic , strong) NSString *back_id;
// 直播Id
@property (nonatomic , strong) NSString *live_id;
// 开始时间
@property (nonatomic , strong) NSString *start;
// 结束时间
@property (nonatomic , strong) NSString *end;
@end
