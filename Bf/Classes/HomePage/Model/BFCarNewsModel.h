//
//  BFCarNewsModel.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFCarConsultContentModel.h"
#import "BFCarEvaluateModel.h"

@interface BFCarNewsModel : NSObject
/*管理员外键*/
@property (nonatomic,copy) NSString *aId;
/*时间类型*/
@property (nonatomic,copy) NSString *dateTime;
/*资讯内容表主键*/
@property (nonatomic,copy) NSString *nCId;
/*缩略图路径*/
@property (nonatomic,copy) NSString *nCImg;
/*判断终端*/
@property (nonatomic,copy) NSString *nCState;
/*资讯主键*/
@property (nonatomic,assign) NSInteger nId;
/*资讯类型*/
@property (nonatomic,copy) NSString *nState;
/*资讯类别表主键*/
@property (nonatomic,copy) NSString *nTId;
/*资讯简介*/
@property (nonatomic,copy) NSString *pDesc;
/*时间戳*/
@property (nonatomic,assign) NSInteger pTime;
/*资讯标题*/
@property (nonatomic,copy) NSString *pTitle;
/*资讯内容*/
@property (nonatomic,copy) NSString *nCCont;
/*收藏数量*/
@property (nonatomic,assign) NSInteger collCount;
/*是否收藏*/
@property (nonatomic,assign) NSInteger collFlag;
/*评论数量*/
@property (nonatomic,assign) NSInteger commCount;
/*点赞数量*/
@property (nonatomic,assign) NSInteger likeCount;
/*是否点赞*/
@property (nonatomic,assign) NSInteger likeFlag;
/*用户名*/
@property (nonatomic,copy) NSString *iNickName;
/*用户头像*/
@property (nonatomic,copy) NSString *iPhoto;
/*浏览量*/
@property (nonatomic,assign) NSInteger nNum;

// 内容数组
@property (nonatomic , strong) NSMutableArray<BFCarConsultContentModel *> *contentArray;
// 精彩评论
@property (nonatomic , strong) NSMutableArray <BFCarEvaluateModel *> *wonderfulEvaluateArray;
// 最新评论
@property (nonatomic , strong) NSMutableArray <BFCarEvaluateModel *> *newestEvaluateArray;
// 是否有视频
@property (nonatomic , assign) BOOL haveVideo;
// 是否有图片
@property (nonatomic , assign) BOOL haveImg;
// 是否有精彩评论
@property (nonatomic , assign) BOOL haveWonderfulEvaluate;
// 是否有最新评论
@property (nonatomic , assign) BOOL haveNewestEvaluate;

// 总页数
@property (nonatomic , assign) NSInteger lastPage;
// 当前页
@property (nonatomic , assign) NSInteger curPage;

- (instancetype)initWithDict:(NSDictionary *)dict;

- (void)fillWithDict:(NSDictionary *)dict;
@end
