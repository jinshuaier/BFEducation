//
//  BFPlayLive.h
//  Bf
//
//  Created by 春晓 on 2017/11/22.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFPlayLive : NSObject
// 直播间ID
@property (nonatomic , strong) NSString *room_id;
// 直播间模版
@property (nonatomic , strong) NSString *room_mb;
// 直播间名字
@property (nonatomic , strong) NSString *room_name;
// 直播间状态
@property (nonatomic , strong) NSString *room_zt;
// 学生在这个直播间的权限（老师观看的时候则没有这一项）  目前暂定 0 是没有权限   1 是有权限
@property (nonatomic , strong) NSString *order;
@end
