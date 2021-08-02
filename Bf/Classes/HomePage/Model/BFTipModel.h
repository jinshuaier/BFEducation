//
//  BFTipModel.h
//  Bf
//
//  Created by 陈大鹰 on 2018/2/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFTipModel : NSObject
/*用户昵称*/
@property (nonatomic,strong) NSString *iNickName;
/*用户头像*/
@property (nonatomic,strong) NSString *iPhoto;
/*用户主键ID*/
@property (nonatomic,strong) NSString *pId;
/*0 纯文字/1=图册/2=视频贴/3=并*/
@property (nonatomic,assign) NSInteger pState;
/*1=加精/2=置顶*/
@property (nonatomic,assign) NSInteger pKey;
/*帖子点赞数*/
@property (nonatomic,strong) NSString *pNum;
/*帖子标题*/
@property (nonatomic,strong) NSString *pTitle;
/*帖子标题*/
@property (nonatomic,strong) NSString *pCover;
/*帖子简介*/
@property (nonatomic,strong) NSString *pDesc;
/*点赞数量*/
@property (nonatomic,strong) NSString *likeCount;
/*评论数量*/
@property (nonatomic,strong) NSString *commentCount;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
