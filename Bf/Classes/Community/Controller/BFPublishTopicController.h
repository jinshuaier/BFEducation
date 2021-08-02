//
//  BFPublishTopicController.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/2.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFCommunityModel.h"

typedef NS_ENUM(NSInteger, BFCommunityType) {
    BFCommunityType_Send, // 发布
    BFCommunityType_Edit  // 修改
};

@interface BFPublishTopicController : BFBaseViewController
// 数据
@property (nonatomic , strong) BFCommunityModel *model;
// 帖子发布的类型
@property (nonatomic , assign) BFCommunityType communityType;
@end
