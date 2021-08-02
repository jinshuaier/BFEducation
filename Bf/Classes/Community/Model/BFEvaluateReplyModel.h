//
//  BFEvaluateReplyModel.h
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFEvaluateReplyModel : NSObject

// 评论状态 0 正常 1 禁用
@property (nonatomic , assign) NSInteger aBlocked;
//
@property (nonatomic , assign) NSInteger comFlag;
//
@property (nonatomic , assign) NSInteger iId;
// 回复的用户
@property (nonatomic , strong) NSString *iNickName;
// 被回复的用户
@property (nonatomic , strong) NSString *iNickNames;
//
@property (nonatomic , assign) NSInteger iState;
// 内容
@property (nonatomic , strong) NSString *pCComment;
//
@property (nonatomic , assign) NSInteger pCId;
//
@property (nonatomic , assign) NSInteger pCState;
//
@property (nonatomic , assign) NSInteger pCTime;
//
@property (nonatomic , assign) NSInteger pId;
//
@property (nonatomic , assign) NSInteger postComCount;
//
@property (nonatomic , assign) NSInteger uCredit;
// 用户ID
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
