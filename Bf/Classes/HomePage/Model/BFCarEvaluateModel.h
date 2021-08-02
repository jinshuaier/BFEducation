//
//  BFCarEvaluateModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFCarEvaluateModel : NSObject
// 是否有回复
@property (nonatomic , assign) BOOL haveReply;
// <#描述#>
@property (nonatomic , strong) NSString *dateTime;
// <#描述#>
@property (nonatomic , strong) NSString *iNickName;
// <#描述#>
@property (nonatomic , strong) NSString *iPhoto;
// <#描述#>
@property (nonatomic , assign) NSInteger aBlocked;
// <#描述#>
@property (nonatomic , assign) NSInteger comFlag;
// <#描述#>
@property (nonatomic , assign) BOOL likedFlag;
// <#描述#>
@property (nonatomic , strong) NSString *nCComment;

// <#描述#>
@property (nonatomic , assign) NSInteger nCId;
// <#描述#>
@property (nonatomic , assign) NSInteger nCState;
// <#描述#>
@property (nonatomic , assign) NSInteger nCTime;
// <#描述#>
@property (nonatomic , assign) NSInteger nComCount;
// <#描述#>
@property (nonatomic , assign) NSInteger nId;
// <#描述#>
@property (nonatomic , strong) NSMutableArray *replys;
// <#描述#>
@property (nonatomic , assign) NSInteger uId;

+ (instancetype)initWithDict:(NSDictionary *)dict;

@end
