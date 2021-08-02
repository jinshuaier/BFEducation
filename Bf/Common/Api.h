//
//  Api.h
//  GeneralProject
//
//  Created by 陈大鹰 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#ifndef Api_h
#define Api_h

#if DEBUG

//本地服务器

#define ServerURL       @"http://www.beifangzj.com/app-api/" // 线上
//#define ServerURL       @"http://192.168.0.183:8080/BFapp/" // 康康测试


#else
//线上服务器
#define ServerURL       @"http://www.beifangzj.com/app-api/"// 线上

#endif

#pragma mark - 以"/"结尾
#pragma mark    -----------------------------------关键字Key------------------------------------
// 旧的
// 学生登陆URL
#define LoginURL_STU          [NSString stringWithFormat:@"%@stuLogin",ServerURL]
// 老师登陆URL
#define LoginURL_TEAC         [NSString stringWithFormat:@"%@teacLogin",ServerURL]
// 查询所有直播间列表
#define FindRoomURL           [NSString stringWithFormat:@"%@findRoom",ServerURL]
// 获取单个直播间信息
#define PlayRoomURL           [NSString stringWithFormat:@"%@playRoom",ServerURL]
// 退出直播间
#define EndLiveURL            [NSString stringWithFormat:@"%@endLive",ServerURL]
// 老师查询正在直播的直播间列表
#define FindRoomLookURL_Teac  [NSString stringWithFormat:@"%@findRoomLook",ServerURL]
// 学生查询正在直播的直播间列表
#define FindRoomLookURL_Stu   [NSString stringWithFormat:@"%@findRoomLookStu",ServerURL]
// 选择单个直播间，进入直播间时，获取观看直播间信息
#define LookRoomURL           [NSString stringWithFormat:@"%@lookRoom",ServerURL]
// 老师查找所有回放直播间
#define FindBackRoomURL_TEAC  [NSString stringWithFormat:@"%@findBackRoom",ServerURL]
// 学生查找所有回放直播间
#define FindBackRoomURL_STU   [NSString stringWithFormat:@"%@findBackRoomStu",ServerURL]
// 单个直播间的回放列表
#define FindBackURL           [NSString stringWithFormat:@"%@findBack",ServerURL]
// 选择单个回放，获取回放信息
#define PlayBackURL           [NSString stringWithFormat:@"%@playBack",ServerURL]
// 查询所有点播视频
#define FindVideoURL          [NSString stringWithFormat:@"%@findVideo",ServerURL]
// 上传视频
#define AddVideoURL           [NSString stringWithFormat:@"%@addVideo",ServerURL]

// ===================================================================================
// 新的
#pragma mark -首页-
// 首页课程列表
#define FirstPageCourseListURL         [NSString stringWithFormat:@"%@bfCourse/courseFirst.do",ServerURL]

#pragma mark -课程-
// 课程列表
#define CourseListURL                  [NSString stringWithFormat:@"%@bfCourse/course.do",ServerURL]
// 课程详情页
#define CourseCatalogueURL             [NSString stringWithFormat:@"%@bfSeries/seriesData.do",ServerURL]
// 课程评价
#define CourseEvaluateURL              [NSString stringWithFormat:@"%@bfSeries/isCommentOrReply.do",ServerURL]
// 课程收藏
#define CourseCollectionURL            [NSString stringWithFormat:@"%@bfLogCoursecollectController/coursecollect.do",ServerURL]
// 课程目录
#define CourseDirectoryURL             [NSString stringWithFormat:@"%@BFUserController/bfCourseDirectorySelect.do",ServerURL]
// 课程（直播报名/视频上课）
#define CourseBuyURL                   [NSString stringWithFormat:@"%@userBuy/courseName.do",ServerURL]
// 我的课程
#define MyCoursesURL                   [NSString stringWithFormat:@"%@BFUserController/bfCourseRecgSelectByUId.do",ServerURL]
// 课程搜索
#define CoursesSearchURL               [NSString stringWithFormat:@"%@class/like.do",ServerURL]
// 课程详情获取评价
#define CoursesGetEvaluateURL          [NSString stringWithFormat:@"%@bfSeries/bfCourseCollectSelectList.do",ServerURL]


//登录
#define LOGINURL                       [NSString stringWithFormat:@"%@BFUserController/bfUserLogin.do",ServerURL]
//发送验证码
#define SENDVCODE                      [NSString stringWithFormat:@"%@BFUserController/sendPwd.do",ServerURL]
//注册
#define REGISTER                       [NSString stringWithFormat:@"%@BFUserController/bfUserRegistered.do",ServerURL]
//找回密码
#define FindPWD                        [NSString stringWithFormat:@"%@BFUserController/bfUserRetrievePwd.do",ServerURL]
//验证是否登录
#define CHECKLOGIN                     [NSString stringWithFormat:@"%@/BFUserController/bfUserInfoIf.do",ServerURL]
//车资讯首页
#define CARNEWS                        [NSString stringWithFormat:@"%@BfNewsController/bfNewsSelect.do",ServerURL]
//咨询点赞
#define CARNEWSLikeURL                 [NSString stringWithFormat:@"%@BfNewsController/bfNewsLikedState.do",ServerURL]
//咨询评论点赞
#define NewsCommentLikedURL            [NSString stringWithFormat:@"%@BfNewsController/bfNewsCommentLikedState.do",ServerURL]
//咨询收藏
#define NewsCollectURL                 [NSString stringWithFormat:@"%@BfNewsController/bfNewsCollectState.do",ServerURL]
//咨询评论
#define NewsEvaluateURL                [NSString stringWithFormat:@"%@BfNewsController/bfNewsCommentOrReply.do",ServerURL]
//获取咨询评论
#define NewsGetEvaluateURL             [NSString stringWithFormat:@"%@BfNewsController/bfNewsCommentSelect.do",ServerURL]
//咨询浏览量
#define NewsShowNumURL                 [NSString stringWithFormat:@"%@BfNewsController/bfNewsViewsInsert.do",ServerURL]


//校友认证
#define SchoolVip                      [NSString stringWithFormat:@"%@class/addSchoolVip.do",ServerURL]


//发布帖子
#define PublishTips                    [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostReleaseInsert.do",ServerURL]
//修改用户信息
#define UpdatePersonalCenter           [NSString stringWithFormat:@"%@BFUserController/bfUserPersonalCenterUpdate.do",ServerURL]
//更改用户头像
#define UpdateUserImg                  [NSString stringWithFormat:@"%@BFUserController/bfUserPhotoUpdateIOS.do",ServerURL]
//退出登录
#define LOGOUT                         [NSString stringWithFormat:@"%@BFUserController/bfUserLogOut.do",ServerURL]
#pragma mark -帖子-
// 帖子列表
#define CommunityListURL               [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostSelectListThree.do",ServerURL]
#define CommunityDetailURL             [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostSelectByPIdThree.do",ServerURL]

// 帖子评论
#define CommunityEvaluateURL           [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostCommentSelectByPId.do",ServerURL]
// 帖子浏览量
#define CommunityShowNumURL            [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostPNumInsert.do",ServerURL]
// 帖子收藏
#define CommunityCollectURL            [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostCollectUpdate.do",ServerURL]
// 帖子点赞
#define CommunityLikeURL               [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostLikeUpdate.do",ServerURL]
// 帖子评论点赞
#define CommunityEvaluateLikeURL       [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostCommentLike.do",ServerURL]
// 帖子发表评论
#define CommunityPostEvaluateURL       [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostContCommentOrReply.do",ServerURL]
// 获取收藏的帖子
#define CommunityGetCollectionURL      [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostCollectSelectByUIdThree.do",ServerURL]
// 获取我发布的帖子
#define CommunityGetSendURL            [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostSelectByUIdThree.do",ServerURL]
// 删除我发布的帖子
#define CommunityDeleteURL             [NSString stringWithFormat:@"%@BfBbsController/bfUserPostDeleteByPId.do",ServerURL]
// 发布帖子（富文本）
#define CommunityPublishURL            [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostInsertThree.do",ServerURL]
// 发布搜索
#define CommunitySearchURL            [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostSelectByTitle.do",ServerURL]



// 查询用户个人收藏课程
#define CollectCourse                  [NSString stringWithFormat:@"%@BFUserController/bfCourseCollectSelectByUId.do",ServerURL]
// 查询用户个人收藏资讯
#define CollectConsult                 [NSString stringWithFormat:@"%@BfNewsController/bfNewsCollectSelectByUId.do",ServerURL]
//首页精品推荐
#define GetBoutiqueCourse              [NSString stringWithFormat:@"%@BfHomePage/getBoutiqueCourse.do",ServerURL]
//首页底部系列课
#define FindHomeBottom                 [NSString stringWithFormat:@"%@BfHomePage/findHomeBottom.do",ServerURL]
//首页中间直播系列
#define FindHomeMiddle                 [NSString stringWithFormat:@"%@BfHomePage/findHomeMiddle.do",ServerURL]
// 直播获取观看者头像
#define WatchLiveHeadView              [NSString stringWithFormat:@"%@live/selectLiveUserPhoto.do",ServerURL]
//首页顶部banner
#define FindHomeBanner                 [NSString stringWithFormat:@"%@BfHomePage/findHomeBanner.do",ServerURL]
//App版本检查
#define AppVersonCheck                 [NSString stringWithFormat:@"%@BFUserController/bfAppVersionCheck.do",ServerURL]
//审核接口 BFUserController/bfAppVersionObtain.do
#define AppCheck                       [NSString stringWithFormat:@"%@BFUserController/bfAppVersionObtain.do",ServerURL]
//推荐资讯
#define FindHomeNews                   [NSString stringWithFormat:@"%@BfHomePage/findHomeNews.do",ServerURL]
//热门帖子
#define FindHomeTips                   [NSString stringWithFormat:@"%@BfHomePage/findHomePost.do",ServerURL]
//引导页
#define Guide                          [NSString stringWithFormat:@"%@BfHomePage/getfindHomeguide.do",ServerURL]
//三方登录
#define ThirdLogin                     [NSString stringWithFormat:@"%@BFUserController/bfUserForeignLogin.do",ServerURL]
//短信登录
#define BFSMSLogin                     [NSString stringWithFormat:@"%@login/bfSMSLogin.do",ServerURL]

//三方登录绑定手机号
#define ThirdLoginBindingPhone         [NSString stringWithFormat:@"%@BFUserController/bfUserBindPhoneNumber.do",ServerURL]

//查询三方绑定状态
#define ThirdPartBindSelectByUid       [NSString stringWithFormat:@"%@login/bfThirdPartBindSelectByUId.do",ServerURL]

//接触第三方绑定
#define ThirdPartBindDelectByState     [NSString stringWithFormat:@"%@login/bfThirdPartBindDeleteByBState",ServerURL]

#pragma mark -搜修车配套接口-
// 资讯
#define SXCConsult                       [NSString stringWithFormat:@"%@BfNewsController/bfNewsSelectByNId.do",ServerURL]
// 帖子
#define SXCCommunity                     [NSString stringWithFormat:@"%@BfBbsController/bfBbsPostSelectByPIds.do",ServerURL]
// 课程
#define SXCCourse                        [NSString stringWithFormat:@"%@bfSeries/bfCourseSeriesSelectByCSId.do",ServerURL]


#pragma mark - 车人才
//企业认证提交
#define CompanyCertification             [NSString stringWithFormat:@"%@bfJobController/bfCompanyCertification.do",ServerURL]
//企业重新认证提交
#define CompanyCertificationNew          [NSString stringWithFormat:@"%@bfJobController/bfJobCompanyCertifiedUpdate.do",ServerURL]
//查询企业认证/信息
#define QueryCompanyCertification        [NSString stringWithFormat:@"%@bfJobController/bfJobCompanySelectState.do",ServerURL]
//企业认证资料
#define QueryCompanyCertificationInformation        [NSString stringWithFormat:@"%@bfJobController/bfJobCompanyCertificationSelect.do",ServerURL]
//企业信息查询资料
#define QueryCompanyInformation          [NSString stringWithFormat:@"%@bfJobController/bfCompanyInfoSelect.do",ServerURL]
//企业信息编辑资料
#define CompanyInformationUpdate         [NSString stringWithFormat:@"%@bfJobController/bfJobCompanyInfoUpdate.do",ServerURL]
//发布职位
#define PostJob                          [NSString stringWithFormat:@"%@bfJobController/bfJobWorkInsert.do",ServerURL]
//车人才首页
#define companyList                      [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do",ServerURL]
//职位详情
#define workDetail                       [NSString stringWithFormat:@"%@bfJobController/bfJobWorkInfoSelect.do",ServerURL]
//发布基础简历
#define SendJobResumeFirst               [NSString stringWithFormat:@"%@bfJobController/bfJobResumeInsert.do",ServerURL]
//添加工作经历
#define AddWorkEx                        [NSString stringWithFormat:@"%@bfJobController/bfJobExperienceInsert.do",ServerURL]
//添加教育经历
#define AddEducationEx                   [NSString stringWithFormat:@"%@bfJobController/bfJobLearnInsert.do",ServerURL]
//修改简历基本信息
#define ChangeInfomation                 [NSString stringWithFormat:@"%@bfJobController/bfJobResumeInfoUpdate.do",ServerURL]
//修改工作经历
#define ChangeWorkEx                     [NSString stringWithFormat:@"%@bfJobController/bfJobExperienceUpdate.do",ServerURL]
//修改教育经历
#define ChangeEducationEx                [NSString stringWithFormat:@"%@bfJobController/bfJobLearnUpdate.do",ServerURL]


// 课程改版
// 课程列表banner
#define CourseListBannerURL              [NSString stringWithFormat:@"%@bfCourseClass/findCourseBanner.do",ServerURL]
// 课程列表侧滑
#define CourseCategoryURL                [NSString stringWithFormat:@"%@bfCourseClass/findCourseCategory.do",ServerURL]
// 全部课程
#define CourseListALLURL                 [NSString stringWithFormat:@"%@bfCourseClass/findAllCourse.do",ServerURL]
// 课程分条件查询
#define CourseListByIdURL                [NSString stringWithFormat:@"%@bfCourseClass/findAllCourseByCsid.do",ServerURL]
//添加app设备标识
#define phoneToken                       [NSString stringWithFormat:@"%@login/bfJobPhoneTokenInsert.do",ServerURL]

// 开课
// 创建直播课
#define CreateLiveCourseURL              [NSString stringWithFormat:@"%@bfCourse/bfCourseSelectTeacherInsert.do",ServerURL]
// 修改直播课
#define EditLiveCourseURL                [NSString stringWithFormat:@"%@bfCourse/bfCourseByTeacherIdUpdate.do",ServerURL]
// 直播课列表
#define LiveCourseListURL                [NSString stringWithFormat:@"%@bfCourse/bfCourseByTeacherIdList.do",ServerURL]
// 关闭直播课
#define StopLiveCourseURL                [NSString stringWithFormat:@"%@bfCourse/bfCourseByTeacherIdPlayBackUpdate.do",ServerURL]
// 删除直播课
#define DeleteLiveCourseURL              [NSString stringWithFormat:@"%@bfCourse/bfCourseDeleteByTeacher.do",ServerURL]

// 根据cId查询直播课程详情
#define LiveCourseContentURL             [NSString stringWithFormat:@"%@BfHomePage/isLivebroadcast.do",ServerURL]


//首页回放列表
#define HomepagePlayBackList             [NSString stringWithFormat:@"%@bfCourse/bfCoursePlayBackList.do",ServerURL]
//视频播放记录
#define VideoPlayNumbers                 [NSString stringWithFormat:@"%@bfCourse/bfCourseUpdateCNumAdd.do",ServerURL]

#endif /* Api_h */
