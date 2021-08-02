//
//  BFCarEvaluateReplyModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFCarEvaluateReplyModel : NSObject
// <#描述#>
@property (nonatomic , assign) NSInteger aBlocked;

// <#描述#>
@property (nonatomic , strong) NSString *dateTime;
// <#描述#>
@property (nonatomic , strong) NSString *iNickName;
// <#描述#>
@property (nonatomic , strong) NSString *iNickNames;
// <#描述#>
@property (nonatomic , assign) NSInteger likeFlag;
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
@property (nonatomic , assign) NSInteger uId;
// <#描述#>
@property (nonatomic , assign) NSInteger uIds;
@end
