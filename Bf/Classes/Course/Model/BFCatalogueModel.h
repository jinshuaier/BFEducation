//
//  BFCatalogueModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCourseModel.h"

typedef NS_ENUM(NSInteger, ChapterType) {
    ChapterType_Chapter = 0,        // 章节
    ChapterType_LittleChapter,  // 小节
    ChapterType_Course          // 课程
};

@interface BFCatalogueModel : BFCourseModel

// 课程类型
@property (nonatomic , assign) ChapterType chapterType;

// 章 节
// 章节表主键
@property (nonatomic , assign) NSInteger cTId;
// 排序
@property (nonatomic , assign) NSInteger cTSort;
// 标题
@property (nonatomic , strong) NSString *cTTitle;
// 0=章节/小节ID
@property (nonatomic , assign) NSInteger cTType;
// 时间字符
@property (nonatomic , strong) NSString *dateTime;
// 时间戳
@property (nonatomic , assign) NSInteger rTime;

// 课
// 禁用标识
@property (nonatomic , assign) NSInteger aBlocked;
// 结束时间字符串
@property (nonatomic , strong) NSString *cEndDateTime;
// 课程主表主键
@property (nonatomic , assign) NSInteger cEndTime;
// 课程主表主键
@property (nonatomic , assign) NSInteger cId;
// 0=直播1=回放2=视频
@property (nonatomic , assign) NSInteger cKey;
// 章节ID
@property (nonatomic , assign) NSInteger cMaxId;
// 小节ID
@property (nonatomic , assign) NSInteger cMinId;
// 人数/限100
@property (nonatomic , assign) NSInteger cNum;
// 开始时间字符串
@property (nonatomic , strong) NSString *cStartDateTime;
// <#描述#>
@property (nonatomic , assign) NSInteger cStartTime;
// 0=单课/0>系列外键ID
@property (nonatomic , assign) NSInteger cState;
// 标题
@property (nonatomic , strong) NSString *cTitle;
// 课程分类表外键
@property (nonatomic , assign) NSInteger classId;
// 学分
@property (nonatomic , assign) NSInteger rCRedit;
// roomId
@property (nonatomic , strong) NSString *roomId;


// 是否显示
@property (nonatomic , assign) BOOL isShow;
// 是否展开
@property (nonatomic , assign) BOOL isExpand;
// 是否选择
@property (nonatomic , assign) BOOL isSelect;
// 父节点id
@property (nonatomic , assign) NSInteger parentId;

// id
@property (nonatomic , assign) NSInteger commonId;

+ (instancetype)initWithDict:(NSDictionary *)dic;



@end
