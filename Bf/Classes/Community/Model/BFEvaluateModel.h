//
//  BFEvaluateModel.h
//  NewTest
//
//  Created by 春晓 on 2017/12/1.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFEvaluateReplyModel.h"

@interface BFEvaluateModel : NSObject
// 是否有回复
@property (nonatomic , assign) BOOL haveReply;
// 评论状态 0 正常 1 禁用
@property (nonatomic , assign) NSInteger aBlocked;
// 是否点赞
@property (nonatomic , assign) NSInteger comFlag;
// 时间
@property (nonatomic , strong) NSString *dateTime;
// 用户信息表主键
@property (nonatomic , assign) NSInteger iId;
// 用户昵称
@property (nonatomic , strong) NSString *iNickName;
// 用户头像
@property (nonatomic , strong) NSString *iPhoto;
// 用户职业
@property (nonatomic , assign) NSInteger iState;
// 内容
@property (nonatomic , strong) NSString *pCComment;
// 评论ID
@property (nonatomic , assign) NSInteger pCId;
// 回复id
@property (nonatomic , assign) NSInteger pCState;
// 时间戳
@property (nonatomic , assign) NSInteger pCTime;
// 帖子id
@property (nonatomic , assign) NSInteger pId;
// 点赞个数
@property (nonatomic , assign) NSInteger postComCount;
// 回复集合
@property (nonatomic , strong) NSMutableArray<BFEvaluateReplyModel *> *replys;
//
@property (nonatomic , assign) NSInteger uCredit;
//
@property (nonatomic , assign) NSInteger uId;
//
@property (nonatomic , assign) NSInteger uIds;
//
@property (nonatomic , assign) NSInteger uState;
//
@property (nonatomic , assign) NSInteger uStateBf;
//
@property (nonatomic , assign) NSInteger uStateSenior;
//
@property (nonatomic , assign) NSInteger uStateVip;


+ (instancetype)initWithDict:(NSDictionary *)dict;
@end
