//
//  BFCommunityDetailsModel.h
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFEvaluateModel.h"

@interface BFCommunityDetailsModel : NSObject
// 头像
@property (nonatomic , strong) NSString *headImageName;
// 名字
@property (nonatomic , strong) NSString *nameStr;
// 时间
@property (nonatomic , strong) NSString *timeStr;
// 标题
@property (nonatomic , strong) NSString *titleStr;
// 正文
@property (nonatomic , strong) NSString *contentStr;
// 标签
@property (nonatomic , strong) NSString *tagStr;
// 视频
@property (nonatomic , strong) NSString *videoStr;
// 图片
@property (nonatomic , strong) NSMutableArray *imgArray;
// 图片描述文字
@property (nonatomic , strong) NSMutableArray *imgTextArray;
// 精彩评论
@property (nonatomic , strong) NSMutableArray <BFEvaluateModel *> *wonderfulEvaluateArray;
// 最新评论
@property (nonatomic , strong) NSMutableArray <BFEvaluateModel *> *newestEvaluateArray;
// 是否有视频
@property (nonatomic , assign) BOOL haveVideo;
// 是否有图片
@property (nonatomic , assign) BOOL haveImg;
// 是否有精彩评论
@property (nonatomic , assign) BOOL haveWonderfulEvaluate;
// 是否有最新评论
@property (nonatomic , assign) BOOL haveNewestEvaluate;
@end
