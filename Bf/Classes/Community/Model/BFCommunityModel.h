//
//  BFCommunityImgModel.h
//  Bf
//
//  Created by 春晓 on 2017/11/27.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFEvaluateModel.h"

typedef NS_ENUM(NSInteger, BFCommunityModelType) {
    BFCommunityModelType_Text,
    BFCommunityModelType_Image,
    BFCommunityModelType_Video,
    BFCommunityModelType_VideoAndImage
};

@interface BFCommunityModel : NSObject
// 种类
@property (nonatomic , assign) BFCommunityModelType communityModelType;

// =========================================================
// 禁封标识0=正常1=禁封
@property (nonatomic , assign) NSInteger aBlocked;
// 用户评论数量
@property (nonatomic , assign) NSInteger commentCount;
// 用户信息表主键
@property (nonatomic , assign) NSInteger iId;
// 用户昵称
@property (nonatomic , strong) NSString *iNickName;
// 用户头像
@property (nonatomic , strong) NSString *iPhoto;
// 用户状态
@property (nonatomic , assign) NSInteger iState;
// 点赞数量
@property (nonatomic , assign) NSInteger likeCount;
// 帖子内容
@property (nonatomic , strong) NSString *pCcont;
// 帖子内容
@property (nonatomic , strong) NSString *disStr;
// 帖子内容富文本
@property (nonatomic , strong) NSMutableAttributedString *pCcontAttributed;
// 帖子内容表主键
@property (nonatomic , assign) NSInteger pCid;
// 该用户是否收藏1收藏
@property (nonatomic , assign) NSInteger pColFlag;
// 该用户是否点赞
@property (nonatomic , assign) NSInteger pComFlag;
// 帖子简介
@property (nonatomic , strong) NSString *pDesc;
// 帖子主键
@property (nonatomic , assign) NSInteger pId;
// 帖子加精顶置默认0   1=加精/2=置顶
@property (nonatomic , assign) NSInteger pKey;
// 帖子浏览量
@property (nonatomic , assign) NSInteger pNum;
// 帖子类型1=图册/2=视频贴/3=合
@property (nonatomic , assign) NSInteger pState;
// 发布时间
@property (nonatomic , assign) NSInteger pTime;
// 帖子标题
@property (nonatomic , strong) NSString *pTitle;
// 视频ID
@property (nonatomic , strong) NSString *pVId;
// 视频VID
@property (nonatomic , strong) NSString *pVUrl;
// 视频封面图
@property (nonatomic , strong) NSString *pCover;
// 帖子图片列表
@property (nonatomic , strong) NSArray *postPhotoList;
// 用户总学分
@property (nonatomic , assign) NSInteger uCredit;
// 用户主表主键
@property (nonatomic , assign) NSInteger uId;
// 用户收费会员级别
@property (nonatomic , assign) NSInteger uState;
// 1=北方讲师[扩展]
@property (nonatomic , assign) NSInteger uStateBf;
// 1=大牛[扩展]
@property (nonatomic , assign) NSInteger uStateSenior;
// 1=vip[扩展]
@property (nonatomic , assign) NSInteger uStateVip;

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

// 总页数
@property (nonatomic , assign) NSInteger lastPage;
// 当前页
@property (nonatomic , assign) NSInteger curPage;

+ (instancetype)initWithDict:(NSDictionary *)dict;

- (void)fillWithDict:(NSDictionary *)dict;
@end
