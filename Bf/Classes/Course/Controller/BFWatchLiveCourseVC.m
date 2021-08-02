//
//  BFWatchLiveCourseVC.m
//  Bf
//
//  Created by 春晓 on 2017/12/21.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFWatchLiveCourseVC.h"
#import "CustomTextField.h"
#import "CCPublicTableViewCell.h"
#import "CCPrivateChatView.h"
#import "ModelView.h"
#import "CCSDK/RequestData.h"
#import "LoadingView.h"
#import "InformationShowView.h"
#import "Utility.h"
#import "GongGaoView.h"
#import "ChatView.h"
#import "QuestionView.h"
#import "Dialogue.h"
#import "LianmaiView.h"
#import <AVFoundation/AVFoundation.h>
#import "LotteryView.h"
#import "RollcallView.h"
#import "VoteView.h"
#import "VoteViewResult.h"
#import "QuestionnaireSurvey.h"
#import "QuestionnaireSurveyPopUp.h"
#import "BFCustomerCell.h"
#import "UIView+Frame.h"

@interface BFWatchLiveCourseVC ()<UITextFieldDelegate,RequestDataDelegate,UIScrollViewDelegate,LianMaiDelegate,UIAlertViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

/*
 * 是否横屏模式
 */
@property(nonatomic,assign)Boolean                  isScreenLandScape;
@property(nonatomic,strong)UIImageView              *daohangView;
@property(nonatomic,strong)UIButton                 *leftButton;
@property(nonatomic,strong)UILabel                  *leftLabel;
@property(nonatomic,copy) NSString                  *leftLabelText;

@property(nonatomic,strong)UIImageView              *userCountLogo;
@property(nonatomic,copy)  NSString                 *userCount;
@property(nonatomic,strong)UILabel                  *userCountLabel;
@property(nonatomic,strong)UIButton                 *gongGaoBtn;
@property(nonatomic,strong)UIImageView              *gongGaoDot;

@property(nonatomic,strong)UIImageView              *soundBg;
@property(nonatomic,strong)UILabel                  *soundLabel;

@property(nonatomic,strong)CustomTextField          *chatTextField;
@property(nonatomic,strong)UIButton                 *danMuButton;
@property(nonatomic,strong)UIButton                 *sendButton;
@property(nonatomic,strong)UIView                   *contentView;
@property(nonatomic,strong)UIButton                 *rightView;

@property(nonatomic,strong)UIView                   *emojiView;
@property(nonatomic,strong)UIImageView              *contentBtnView;
@property(nonatomic,strong)NSMutableDictionary      *dataPrivateDic;
@property(nonatomic,strong)UIButton                 *soundVideoBtn;
@property(nonatomic,strong)UIButton                 *selectRoadBtn;
@property(nonatomic,strong)UIButton                 *hideDanMuBtn;
@property(nonatomic,assign)CGRect                   videoRect;

@property(nonatomic,strong)UIButton                 *yuanHuaBtn;
@property(nonatomic,strong)UIButton                 *qingXiBtn;
@property(nonatomic,strong)UIButton                 *liuChangBtn;
@property(nonatomic,strong)UIButton                 *qingXiDuBtn;

@property(nonatomic,strong)ModelView                *modelView;
@property(nonatomic,strong)UIView                   *modeoCenterView;
@property(nonatomic,strong)UILabel                  *modeoCenterLabel;
@property(nonatomic,strong)UIButton                 *cancelBtn;
@property(nonatomic,strong)UIButton                 *sureBtn;
@property(nonatomic,strong)NSTimer                  *timer;
@property(nonatomic,strong)NSTimer                  *danMuTimer;
@property(nonatomic,strong)NSTimer                  *hiddenTimer;
@property(nonatomic,assign)NSTimeInterval           hiddenTime;

@property(nonatomic,strong)RequestData              *requestData;
@property(nonatomic,strong)LoadingView              *loadingView;
@property(nonatomic,strong)UIView                   *informationView;

@property(nonatomic,assign)NSInteger                currentRoadNum;
@property(nonatomic,assign)NSInteger                currentSecRoadNum;
@property(nonatomic,strong)NSMutableArray           *secRoadKeyArray;

@property(nonatomic,strong)UIButton                 *mainRoad;
@property(nonatomic,strong)UIButton                 *secondRoad;

@property(nonatomic,copy)  NSString                 *viewerId;
@property(nonatomic,strong)NSMutableDictionary      *userDic;

@property(nonatomic,strong)NSMutableArray           *array;
@property(assign,nonatomic)NSInteger                secondToEnd;
@property(assign,nonatomic)NSInteger                lineLimit;
@property(assign,nonatomic)BOOL                     isKeyBoardShow;

@property(nonatomic,strong)GongGaoView              *gongGaoView;
@property(nonatomic,copy)  NSString                 *gongGaoStr;
@property(nonatomic,strong)UIView                   *videoView;
@property(nonatomic,strong)UIImageView              *barImageView;
@property(nonatomic,strong)UIButton                 *lianmaiBtn;
@property(nonatomic,strong)UIButton                 *quanPingBtn;
@property(nonatomic,strong)UIScrollView             *scrollView;
@property(nonatomic,strong)UISegmentedControl       *segment;
@property(nonatomic,strong)UIView                   *shadowView;
@property(nonatomic,strong)UIView                   *pptView;
@property(nonatomic,strong)ChatView                 *chatView;
@property(nonatomic,strong)QuestionView             *questionChatView;
@property(nonatomic,strong)UIView                   *introductionView;
@property(nonatomic,strong)UIImageView              *zhibozhongImage;
@property(nonatomic,strong)UILabel                  *zhibozhongLabel;

@property(nonatomic,copy)  NSString                 *roomDesc;
@property(nonatomic,copy)  NSString                 *roomName;

@property(nonatomic,strong)NSMutableDictionary      *QADic;
@property(nonatomic,strong)NSMutableArray           *publicChatArray;
@property(nonatomic,assign)BOOL                     newGongGao;
@property(nonatomic,assign)CGRect                   keyboardRect;

@property(nonatomic,strong)LianmaiView              *lianMaiView;

@property(copy,nonatomic)  NSString                 *videosizeStr;
@property(assign,nonatomic)BOOL                     isAllow;
@property(assign,nonatomic)BOOL                     needReloadLianMainView;
@property(nonatomic,strong)LotteryView              *lotteryView;
@property(nonatomic,strong)NSMutableArray           *lotteryViewTags;
@property(nonatomic,strong)RollcallView             *rollcallView;

@property(nonatomic,assign)NSInteger                duration;

@property(nonatomic,strong)VoteView                 *voteView;
@property(nonatomic,strong)VoteViewResult           *voteViewResult;
@property(nonatomic,assign)NSInteger                mySelectIndex;
@property(nonatomic,strong)NSMutableArray           *mySelectIndexArray;
@property(nonatomic,assign)NSInteger                templateType;

@property(nonatomic,assign)BOOL                     autoRotate;
@property(nonatomic,strong)UITapGestureRecognizer   *hideTextBoardTap1;
@property (strong, nonatomic) NSMutableArray        *keysArrAll;
@property(nonatomic,assign)BOOL                     lianMaiHidden;
@property(nonatomic,strong)QuestionnaireSurvey      *questionnaireSurvey;
@property(nonatomic,strong)QuestionnaireSurveyPopUp *questionnaireSurveyPopUp;
@property(nonatomic,copy  )NSString                 *roomUserCount;
@property(nonatomic,strong)InformationShowView      *informationViewPop;
@property(nonatomic,strong)UIView                   *smallVideoView;
//#ifdef LIANMAI_WEBRTC
@property(nonatomic,assign)BOOL                     isAudioVideo;//YES表示音视频连麦，NO表示音频连麦
@property(strong,nonatomic)UIView                   *remoteView;

@property(strong,nonatomic)UIView                   *teachetView;
@property(strong,nonatomic)UICollectionView         *customersView;
@property(strong,nonatomic)UITapGestureRecognizer   *singleTap;
// 聊天按钮
@property (nonatomic , strong) UIButton *chatBtn;
//#endif
// 观看者头像数组
@property (nonatomic , strong) NSMutableArray *headerArray;
// 时候正在直播
@property (nonatomic , assign) BOOL isLive;

@property (nonatomic,strong)UIView * danmuBgView;//承托弹幕

@property (nonatomic, strong)UIView * bottomBgView;//视频底部蒙版

@end

static NSString *customerCell = @"customerCell";

static int livingTimes = 0;

@implementation BFWatchLiveCourseVC{
    UIView *lineView;
    NSTimer *zhibozhongTimer;
    NSMutableArray *zhibozhongArray;
    BOOL isDanmu;
    int  qingxidu;// 0:标清，1:清晰，2:原画
    UIView *lineViewLift;
    UIView *lineViewRight;
    UIView *shadowView;
}

-(instancetype)initWithLeftLabelText:(NSString *)leftLabelText {
    self = [super init];
    if(self) {
        self.leftLabelText = leftLabelText;
        self.isScreenLandScape = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"课程直播页"];
  
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"课程直播页"];

}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 返回你所需要的状态栏样式
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    _currentRoadNum = 0;
    _currentSecRoadNum = 0;
    _isKeyBoardShow = NO;
    _isAllow = NO;
    _autoRotate = NO;
    _roomUserCount = @"1";
    isDanmu = YES;
    qingxidu = 0;
    zhibozhongArray = [NSMutableArray array];
    for (int i = 1; i < 9; i++) {
        NSString *str = [NSString stringWithFormat:@"living%d",i];
        UIImage *img = [UIImage imageNamed:str];
        [zhibozhongArray addObject:img];
    }
    
    [self initUI];
    [self addObserver];
    [self startDanMuTimer];
    [self startHiddenTimer];
    
    _secondToEnd = 8.0f;
    
    if(!self.isScreenLandScape) {
        _lineLimit = (CCGetRealFromPt(462) - 64) / (IMGWIDTH * 1.5);
    }
    
    PlayParameter *parameter = [[PlayParameter alloc] init];
    parameter.userId = GetFromUserDefaults(WATCH_USERID);
    parameter.roomId = GetFromUserDefaults(WATCH_ROOMID);
    parameter.viewerName = GetFromUserDefaults(WATCH_USERNAME);
    parameter.token = GetFromUserDefaults(WATCH_PASSWORD);
    parameter.docParent = self.pptView;
    parameter.docFrame = self.pptView.frame;
    parameter.playerParent = self.videoView;
    parameter.playerFrame = _videoRect;
    parameter.security = NO;
    parameter.PPTScalingMode = 2;
    parameter.defaultColor = [UIColor whiteColor];
    parameter.scalingMode = 1;
    parameter.pauseInBackGround = NO;
    parameter.viewerCustomua = @"viewercustomua";
    _requestData = [[RequestData alloc] initWithParameter:parameter];
    _requestData.delegate = self;
}

- (void)getWatchLiveHeadView{
    NSString *url = [NSString stringWithFormat:@"%@?cId=%ld",WatchLiveHeadView,_cid];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            NSArray *arr = dic[@"data"];
            if (_headerArray) {
                self.headerArray = nil;
            }
            self.headerArray = arr.mutableCopy;
            dispatch_async(dispatch_get_main_queue(), ^{
                [_customersView reloadData];
            });
        }
    } failureResponse:^(NSError *error) {
        
    }];
}
-(UIView *)bottomBgView{
    
    if (!_bottomBgView) {
        _bottomBgView = [[UIView alloc]init];
        _bottomBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
      
        
    }
    
    return _bottomBgView;
}
-(void)initUI {
    //#ifdef LIANMAI_WEBRTC
    _isAudioVideo = NO;
    //#endif
    if(!self.isScreenLandScape) {
        //        WS(ws)
        [self.view addSubview:self.videoView];
        if (KIsiPhoneX) {
            UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 44)];
            topView.backgroundColor = [UIColor blackColor];
            [self.view addSubview:topView];
            
            _videoRect = CGRectMake(0, 44, self.view.frame.size.width, CCGetRealFromPt(462));
        }else {
            UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 20)];
            topView.backgroundColor = [UIColor blackColor];
            [self.view addSubview:topView];
            _videoRect = CGRectMake(0, 20, self.view.frame.size.width, CCGetRealFromPt(462));
            
            
        }

        self.videoView.frame = _videoRect;
//        [self.videoView setFrame:_videoRect];
   
        [self.videoView addSubview:self.daohangView];
        
         self.daohangView.frame = CGRectMake(0, 0, KScreenW, 44);

        
        self.leftButton.frame = CGRectMake(16, 0, 30, self.daohangView.height);
//        self.leftButton.frame = CGRectMake(16, CCGetRealFromPt(108) - 30, 30, 30);
        [self.leftButton setImage:[UIImage imageNamed:@"返回-白"] forState:(UIControlStateNormal)];

//        self.leftLabel.frame = CGRectMake(46 + 5, CCGetRealFromPt(108) - 30, KScreenW / 2, 30);
        self.leftLabel.frame = CGRectMake(46 + 5, 0, KScreenW / 2, self.daohangView.height);
        [self.daohangView addSubview:self.leftButton];
        [self.daohangView addSubview:self.leftLabel];
        [self.videoView addSubview:self.zhibozhongImage];
        self.zhibozhongImage.frame = CGRectMake(16, CCGetRealFromPt(462) - 30, 30, 30);
        self.zhibozhongImage.hidden = YES;
        [self.videoView addSubview:self.zhibozhongLabel];
        self.zhibozhongLabel.frame = CGRectMake(16 + 30, CCGetRealFromPt(462) - 30, 100, 30);
        self.zhibozhongLabel.hidden = YES;
        
        
        [self.videoView addSubview:self.userCountLabel];
        self.userCountLabel.frame = CGRectMake(KScreenW - 55, 7, 45, 30);
        self.userCountLabel.textAlignment = NSTextAlignmentCenter;
        self.userCountLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.userCountLabel.layer.masksToBounds = YES;
        self.userCountLabel.layer.cornerRadius = 5.0;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置collectionView滚动方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //该方法也可以设置itemSize
        layout.itemSize =CGSizeMake(30, 30);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 5;
        if (KIsiPhoneX) {
            _customersView = [[UICollectionView alloc] initWithFrame:CGRectMake(KScreenW / 2 + 50,44, KScreenW / 2 - 100, 30) collectionViewLayout:layout];
        }
        else {
            _customersView = [[UICollectionView alloc] initWithFrame:CGRectMake(KScreenW / 2 + 50, 44, KScreenW / 2 - 100, 30) collectionViewLayout:layout];
        }
        _customersView.backgroundColor = [UIColor clearColor];
        _customersView.delegate = self;
        _customersView.dataSource = self;
        [self.videoView addSubview:_customersView];
        [_customersView registerClass:[BFCustomerCell class] forCellWithReuseIdentifier:customerCell];
        
        /*
        shadowView = [[UIView alloc] initWithFrame:_customersView.frame];
        [self.videoView addSubview:shadowView];
        UIColor *colorOneLift = [UIColor colorWithWhite:0 alpha:0.8];
        UIColor *colorTwoLift = [UIColor colorWithWhite:0 alpha:0.0];
        NSArray *colorsLift = [NSArray arrayWithObjects:(id)colorOneLift.CGColor, colorTwoLift.CGColor, nil];
        CAGradientLayer *gradientLift = [CAGradientLayer layer];
        //设置开始和结束位置(设置渐变的方向)
        gradientLift.startPoint = CGPointMake(0, 0);
        gradientLift.endPoint = CGPointMake(0.3, 0);
        gradientLift.colors = colorsLift;
        gradientLift.frame = CGRectMake(0, 0, 15, 30);
        [shadowView.layer insertSublayer:gradientLift atIndex:0];
        
        CAGradientLayer *gradientRight = [CAGradientLayer layer];
        //设置开始和结束位置(设置渐变的方向)
        gradientRight.startPoint = CGPointMake(0.3, 0);
        gradientRight.endPoint = CGPointMake(0, 0);
        gradientRight.colors = colorsLift;
        gradientRight.frame = CGRectMake(0, 0, 15, 30);
        [shadowView.layer insertSublayer:gradientRight atIndex:0];
         */
        
        self.bottomBgView.frame = CGRectMake(0, self.videoView.height-40, self.videoView.width, 40);
        [self.videoView addSubview:self.bottomBgView];
       [self.videoView bringSubviewToFront:self.zhibozhongImage];
       [self.videoView bringSubviewToFront:self.zhibozhongLabel];
        [self.videoView addSubview:self.qingXiDuBtn];
        self.qingXiDuBtn.frame = CGRectMake(KScreenW - 100, self.videoView.height - 40, 50, 30);
        self.qingXiDuBtn.hidden = YES;
        [self.videoView addSubview:self.chatBtn];
        self.chatBtn.frame = CGRectMake(16, self.videoView.height - 40, 30, 30);
        self.chatBtn.hidden = YES;
        
        [self.videoView addSubview:self.danMuButton];
        self.danMuButton.frame = CGRectMake(KScreenW - 190, self.videoView.height - 40, 30, 30);
        self.danMuButton.hidden = YES;
        
        [self.videoView addSubview:self.quanPingBtn];
        [self.quanPingBtn setImage:[UIImage imageNamed:@"最大化"] forState:(UIControlStateNormal)];
        self.quanPingBtn.frame = CGRectMake(KScreenW - 16 - 30, self.zhibozhongImage.frame.origin.y, 30, 30);
        
        _singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealSingleTap:)];
        [self.videoView addGestureRecognizer:_singleTap];
        
        lineView = [[UIView alloc] init];
        _teachetView = [[UIView alloc] init];
        if (KIsiPhoneX) {
            lineView.frame = CGRectMake(0, CCGetRealFromPt(462) +44, KScreenW, 5);
            _teachetView.frame = CGRectMake(0, CCGetRealFromPt(462) + 5+ 44, KScreenW, CCGetRealFromPt(110));
        }else {
            lineView.frame = CGRectMake(0, CCGetRealFromPt(462) +20, KScreenW, 5);
            _teachetView.frame = CGRectMake(0, CCGetRealFromPt(462) + 25, KScreenW, CCGetRealFromPt(110));
        }
        lineView.backgroundColor = RGBColor(240, 240, 240);
        [self.view addSubview:lineView];
        [self.view addSubview:_teachetView];
        
        UILabel *teacherNameLabel = [[UILabel alloc] init];
        if (_dict[@"rname"]) {
            teacherNameLabel.text = _dict[@"rname"];
        }else{
            teacherNameLabel.text = @"暂无";
        }
        
        [_teachetView addSubview:teacherNameLabel];
        teacherNameLabel.textColor = RGBColor(51, 51, 51);
        teacherNameLabel.font = [UIFont systemFontOfSize:PXTOPT(28)];
        
        
        UILabel *shareLabel = [[UILabel alloc] init];
        shareLabel.backgroundColor = [UIColor whiteColor];
        UIImage *shareImg = [UIImage imageNamed:@"分享"];
        NSTextAttachment *textAttach = [[NSTextAttachment alloc] init];
        textAttach.image = shareImg;
        NSAttributedString *str = [NSAttributedString attributedStringWithAttachment:textAttach];
        shareLabel.attributedText = str;
        shareLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *Ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShareLiveCourse)];
        [shareLabel addGestureRecognizer:Ges];
        [_teachetView addSubview:shareLabel];
        
        UILabel *teacherIntroduceLabel = [[UILabel alloc] init];
        [_teachetView addSubview:teacherIntroduceLabel];
        if (_dict[@"iintr"]) {
            teacherIntroduceLabel.text = _dict[@"iintr"];
        }else{
            teacherIntroduceLabel.text = @"暂无";
        }

        teacherIntroduceLabel.textColor = RGBColor(153, 153, 153);
        teacherIntroduceLabel.font = [UIFont systemFontOfSize:PXTOPT(24)];
        UIImageView *headerImageView = [[UIImageView alloc] init];
        headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        [headerImageView sd_setImageWithURL:[NSURL URLWithString:_dict[@"iphoto"]] placeholderImage:[UIImage imageNamed:@"123"]];
        headerImageView.layer.masksToBounds = YES;
        headerImageView.layer.cornerRadius = PXTOPT(100) / 2;
        [_teachetView addSubview:headerImageView];
        
        headerImageView.sd_layout
        .leftSpaceToView(self.teachetView, PXTOPT(30))
        .centerYIs(CCGetRealFromPt(110) / 2)
        .widthIs(PXTOPT(100))
        .heightIs(PXTOPT(100));
        
        teacherNameLabel.sd_layout
        .leftSpaceToView(headerImageView, 10)
        .topEqualToView(headerImageView)
        .rightSpaceToView(self.teachetView, 15)
        .heightIs(20);
        
        teacherIntroduceLabel.sd_layout
        .leftSpaceToView(headerImageView, 10)
        .topSpaceToView(teacherNameLabel, 5)
        .rightSpaceToView(self.teachetView, 35)
        .heightIs(20);
        
        shareLabel.sd_layout
        .leftSpaceToView(teacherIntroduceLabel,0)
        .centerYIs(CCGetRealFromPt(110) / 2)
        .widthIs(PXTOPT(70))
        .heightIs(PXTOPT(70));
        
        [self.view addSubview:self.chatView];
        [self.view addSubview:self.contentView];
        
        if (KIsiPhoneX) {
            self.chatView.frame = CGRectMake(0, CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5+44, self.view.frame.size.width , self.view.frame.size.height - (CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5 + CCGetRealFromPt(110)+20+44+5));
            self.contentView.frame = CGRectMake(0, KScreenH - CCGetRealFromPt(110)-20, self.view.frame.size.width , CCGetRealFromPt(110));
        }
        else {
            self.chatView.frame = CGRectMake(0, CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5 +44, self.view.frame.size.width , self.view.frame.size.height - (CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5 + CCGetRealFromPt(110)+44+5));
            self.contentView.frame = CGRectMake(0, KScreenH - CCGetRealFromPt(110), self.view.frame.size.width , CCGetRealFromPt(110));
        }
        
        //        WS(ws);
        
        [self.contentView addSubview:self.sendButton];
        [self.contentView addSubview:self.chatTextField];
        self.chatTextField.frame = CGRectMake(CCGetRealFromPt(24), 0, CCGetRealFromPt(556), CCGetRealFromPt(84));
        self.chatTextField.centerY = self.contentView.height / 2.0;
        //        self.sendButton.frame = CGRectMake(CCGetRealFromPt(24), 0, CCGetRealFromPt(556), CCGetRealFromPt(84));
        self.sendButton.x = KScreenW - CCGetRealFromPt(24) - CCGetRealFromPt(120);
        self.sendButton.width = CCGetRealFromPt(120);
        self.sendButton.height = CCGetRealFromPt(84);
        self.sendButton.centerY = self.contentView.height / 2.0;
        
        [self.view bringSubviewToFront:self.videoView];
        
    }
    [self.view layoutIfNeeded];
}

#pragma mark - 直播课分享

-(void)clickShareLiveCourse {
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        if (UMSocialPlatformType_QQ == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到QQ好友
        }
        else if (UMSocialPlatformType_Qzone == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到QQ空间
        }
        else if (UMSocialPlatformType_Sina == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到新浪微博
        }
        else if (UMSocialPlatformType_WechatSession == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到微信好友
        }
        else if (UMSocialPlatformType_WechatTimeLine == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到微信朋友圈
        }
        else if (UMSocialPlatformType_WechatFavorite == platformType) {
            [self detailShareWithPlatformType:platformType];//分享到微信收藏
        }
    }];
}

-(void)detailShareWithPlatformType:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UIImage *shareImg = [[UIImage alloc] init];
    shareImg = [UIImage imageNamed:@"logo-2"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"[北方职教]直播课堂"] descr:_leftLabelText thumImage:shareImg];
    //设置网页地址
//    shareObject.webpageUrl = [NSString stringWithFormat:@"http://www.beifangzj.com/live-h5.html?cid=%ld",_cid];
    shareObject.webpageUrl = [NSString stringWithFormat:@"http://www.beifangzj.com/bfweb/live-h5.html?cid=%ld",_cid];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            [ZAlertView showSVProgressForSuccess:@"分享成功"];
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}

- (void)setIsLive:(BOOL)isLive{
    _isLive = isLive;
    self.zhibozhongImage.hidden = !_isLive;
    self.zhibozhongLabel.hidden = !_isLive;
}

/**         
 *    @brief  收到播放直播状态 0直播 1未直播
 */
- (void)getPlayStatue:(NSInteger)status {
    if(status == 1) {
        [self loadInformationView:@"直播未开始"];
        [_videoView removeGestureRecognizer:_singleTap];
        _contentView.userInteractionEnabled = NO;
    }
    self.isLive = !status;
}

/**
 *    @brief  主讲开始推流
 */
- (void)onLiveStatusChangeStart {
    [_loadingView removeFromSuperview];
    _loadingView = nil;
    [_informationView removeFromSuperview];
    _informationView = nil;
    _loadingView = [[LoadingView alloc] initWithLabel:@"视频加载中" centerY:YES];
    [self.videoView addSubview:_loadingView];
    UITapGestureRecognizer *hideTextBoardTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealSingleInformationTap)];
    [_loadingView addGestureRecognizer:hideTextBoardTap];
    [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (KIsiPhoneX) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(50+24, 0, 0, 0));
        }
        else {
            make.edges.mas_equalTo(UIEdgeInsetsMake(50, 0, 0, 0));
        }
        
    }];
    [_loadingView layoutIfNeeded];
    if (_singleTap) {
        [_videoView addGestureRecognizer:_singleTap];
    }else{
        _singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealSingleTap:)];
        [self.videoView addGestureRecognizer:_singleTap];
    }
    _contentView.userInteractionEnabled = YES;
}

-(void)loadInformationView:(NSString *)informationStr {
    [_loadingView removeFromSuperview];
    _loadingView = nil;
    [_informationView removeFromSuperview];
    _informationView = nil;
    
    [self showAll];
    
    _informationView = [[UIView alloc] init];
    _informationView.backgroundColor = CCClearColor;
    UITapGestureRecognizer *hideTextBoardTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealSingleInformationTap)];
    [self.videoView addSubview:_informationView];
    if([informationStr isEqualToString:@"视频加载失败"]) {
        [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (KIsiPhoneX) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(50+24, 100, 0, 100));
            }
            else {
                make.edges.mas_equalTo(UIEdgeInsetsMake(50, 100, 0, 100));
            }
        }];
    } else {
        [_informationView addGestureRecognizer:hideTextBoardTap];
        [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (KIsiPhoneX) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(50+24, 0, 0, 0));
            }
            else {
                make.edges.mas_equalTo(UIEdgeInsetsMake(50, 0, 0, 0));
            }
        }];
    }
    UILabel *label = [UILabel new];
    label.backgroundColor = CCClearColor;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:FontSize_32];
    label.text = informationStr;
    [_informationView addSubview:label];
    WS(ws)
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.informationView);
    }];
}
/**
 *    @brief  停止直播，endNormal表示是否异常停止推流，这个参数对观看端影响不大
 */
- (void)onLiveStatusChangeEnd:(BOOL)endNormal {
    [self loadInformationView:@"直播已停止"];
}

/**
 *    @brief    收到在线人数
 */
- (void)onUserCount:(NSString *)count {
    WS(ws)
    _roomUserCount = count;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([count integerValue] > 10000) {
            ws.userCountLabel.text = [NSString stringWithFormat:@"%.1f万",[count integerValue] / 10000.0];
        }else{
            ws.userCountLabel.text = [NSString stringWithFormat:@"%@",count];
        }
    });
    [self getWatchLiveHeadView];
}

// 全屏切换
-(void)quanPingBtnClicked {
    self.hiddenTime = 5.0f;
    //    if([self hasViewOnTheScreen:YES]) return;
    WS(ws)
    [self.view endEditing:YES];
    if (!self.isScreenLandScape) {
        self.isScreenLandScape = YES;
        self.autoRotate = YES;
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationLandscapeLeft] forKey:@"orientation"];
        [UIApplication sharedApplication].statusBarHidden = YES;
        [_requestData changePlayerFrame:self.view.frame];
        [self.videoView setFrame:self.view.frame];
        self.daohangView.frame = CGRectMake(0, 0, KScreenW, 44);
        [_quanPingBtn setImage:[UIImage imageNamed:@"最小化"] forState:(UIControlStateNormal)];
        self.quanPingBtn.frame = CGRectMake(KScreenW - 16 - 30, KScreenH - 40, 30, 30);
        self.leftLabel.frame = CGRectMake(46 + 5, 0, KScreenW / 2, self.daohangView.height);
        self.zhibozhongImage.frame = CGRectMake(KScreenW - 16 - 130, 4, 30, 30);
        self.zhibozhongLabel.frame = CGRectMake(KScreenW - 16 - 100, 4, 100, 30);
        self.userCountLabel.hidden = YES;
        _customersView.hidden = YES;
        lineViewLift.hidden = YES;
        lineViewRight.hidden = YES;
        _contentView.frame = CGRectMake(0, KScreenH - CCGetRealFromPt(110), KScreenW, CCGetRealFromPt(110));
        self.bottomBgView.frame = CGRectMake(0, self.videoView.height-40, self.videoView.width, 40);
        self.qingXiDuBtn.frame = CGRectMake(KScreenW - 100, self.videoView.height - 40, 50, 30);
        self.qingXiDuBtn.hidden = NO;
        self.chatBtn.frame = CGRectMake(16, self.videoView.height - 40, 30, 30);
        self.chatBtn.hidden = NO;
        self.danMuButton.hidden = NO;
        self.danMuButton.frame = CGRectMake(KScreenW - 190, self.videoView.height - 40, 30, 30);
        
        
        self.chatTextField.frame = CGRectMake(CCGetRealFromPt(24), 0, KScreenW - CCGetRealFromPt(24) - CCGetRealFromPt(24) - CCGetRealFromPt(120) - CCGetRealFromPt(24), CCGetRealFromPt(84));
        self.chatTextField.centerY = self.contentView.height / 2.0;
        //        self.sendButton.frame = CGRectMake(CCGetRealFromPt(24), 0, CCGetRealFromPt(556), CCGetRealFromPt(84));
        self.sendButton.x = KScreenW - CCGetRealFromPt(24) - CCGetRealFromPt(120);
        self.sendButton.width = CCGetRealFromPt(120);
        self.sendButton.height = CCGetRealFromPt(84);
        self.sendButton.centerY = self.contentView.height / 2.0;
        self.contentView.hidden = YES;
        //        WS(ws);
        //        [_sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.centerY.mas_equalTo(ws.contentView.mas_centerY);
        //            make.right.mas_equalTo(ws.contentView).offset(-CCGetRealFromPt(24));
        //            make.size.mas_equalTo(CGSizeMake(CCGetRealFromPt(120), CCGetRealFromPt(84)));
        //        }];
        //        [_chatTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.centerY.mas_equalTo(ws.contentView.mas_centerY);
        //            make.left.mas_equalTo(ws.contentView).offset(CCGetRealFromPt(24));
        //            make.size.mas_equalTo(CGSizeMake(KScreenW - CCGetRealFromPt(120) - 10 - CCGetRealFromPt(24), CCGetRealFromPt(84)));
        //        }];
        //        self.contentView.hidden = NO;
        //        self.hideDanMuBtn.hidden = YES;
        //        self.quanPingBtn.hidden = YES;
        
        [UIView animateWithDuration:0.25f animations:^{
            [ws.view layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    } else {
        self.isScreenLandScape = NO;
        self.autoRotate = YES;
        [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
        [UIApplication sharedApplication].statusBarHidden = NO;
        
        [_videoView setFrame:_videoRect];
        [_requestData changePlayerFrame:CGRectMake(0, 0, _videoView.width, _videoView.height)];
        [_quanPingBtn setImage:[UIImage imageNamed:@"最大化"] forState:(UIControlStateNormal)];
        
//        self.videoView.frame = CGRectMake(0, 0, self.view.frame.size.width, CCGetRealFromPt(462));
//        self.daohangView.frame = CGRectMake(0, 0, KScreenW, CCGetRealFromPt(108));
    
//        if (KIsiPhoneX) {
//            self.videoView.frame = CGRectMake(0, 44, self.view.frame.size.width, CCGetRealFromPt(462));
//
//        }else {
//            self.videoView.frame = CGRectMake(0, 20, self.view.frame.size.width, CCGetRealFromPt(462));
//
//        }
        self.daohangView.frame = CGRectMake(0, 0, KScreenW, 44);
//        [_requestData changePlayerFrame:self.videoView.frame];
        self.leftButton.frame = CGRectMake(16, 0, 30, self.daohangView.height);
        self.leftLabel.frame = CGRectMake(46 + 5,0, KScreenW / 2, self.daohangView.height);
        
        self.zhibozhongImage.frame = CGRectMake(16, CCGetRealFromPt(462) - 30, 30, 30);
        self.zhibozhongLabel.frame = CGRectMake(16 + 30, CCGetRealFromPt(462) - 30, 100, 30);
        self.userCountLabel.hidden = NO;
        self.userCountLabel.frame = CGRectMake(KScreenW - 55, 7, 45, 30);
        _customersView.hidden = NO;
        lineViewLift.hidden = NO;
        lineViewRight.hidden = NO;
        self.quanPingBtn.frame = CGRectMake(KScreenW - 16 - 30, self.zhibozhongImage.frame.origin.y, 30, 30);
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.videoView.bottom, KScreenW, 5)];
        _teachetView = [[UIView alloc] initWithFrame:CGRectMake(0, self.videoView.bottom + 5, KScreenW, CCGetRealFromPt(110))];
//        self.chatView.frame = CGRectMake(0, CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5, self.view.frame.size.width , self.view.frame.size.height - (CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5 + CCGetRealFromPt(110)));
//        self.contentView.frame = CGRectMake(0, KScreenH - CCGetRealFromPt(110), self.view.frame.size.width , CCGetRealFromPt(110));
        if (KIsiPhoneX) {
                   self.chatView.frame = CGRectMake(0, CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5+44, self.view.frame.size.width , self.view.frame.size.height - (CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5 + CCGetRealFromPt(110)-20));
                   self.contentView.frame = CGRectMake(0, KScreenH - CCGetRealFromPt(110)-20, self.view.frame.size.width , CCGetRealFromPt(110));
               }
               else {
                   self.chatView.frame = CGRectMake(0, CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5 +44, self.view.frame.size.width , self.view.frame.size.height - (CCGetRealFromPt(462) + CCGetRealFromPt(110) + 5 + CCGetRealFromPt(110)));
                   self.contentView.frame = CGRectMake(0, KScreenH - CCGetRealFromPt(110), self.view.frame.size.width , CCGetRealFromPt(110));
               }
        self.bottomBgView.frame = CGRectMake(0, self.videoView.height-40, self.videoView.width, 40);
        self.qingXiDuBtn.frame = CGRectMake(KScreenW - 100, self.videoView.height - 40, 50, 30);
        self.qingXiDuBtn.hidden = YES;
        self.chatBtn.frame = CGRectMake(16, self.videoView.height - 40, 30, 30);
        self.chatBtn.hidden = YES;
        self.danMuButton.frame = CGRectMake(KScreenW - 190, self.videoView.height - 40, 30, 30);
        self.danMuButton.hidden = YES;
        
        self.chatTextField.frame = CGRectMake(CCGetRealFromPt(24), 0, CCGetRealFromPt(556), CCGetRealFromPt(84));
        self.chatTextField.centerY = self.contentView.height / 2.0;
        //        self.sendButton.frame = CGRectMake(CCGetRealFromPt(24), 0, CCGetRealFromPt(556), CCGetRealFromPt(84));
        self.sendButton.x = KScreenW - CCGetRealFromPt(24) - CCGetRealFromPt(120);
        self.sendButton.width = CCGetRealFromPt(120);
        self.sendButton.height = CCGetRealFromPt(84);
        self.sendButton.centerY = self.contentView.height / 2.0;
        self.contentView.hidden = NO;
        [self.view bringSubviewToFront:self.videoView];
        //        self.yuanHuaBtn.hidden = YES;
        //        self.qingXiBtn.hidden = YES;
        //        self.liuChangBtn.hidden = YES;
        //        self.qingXiDuBtn.hidden = YES;
        ////        self.contentView.hidden = YES;
        //        self.hideDanMuBtn.hidden = NO;
        //        self.quanPingBtn.hidden = NO;
        //        self.mainRoad.hidden = YES;
        //        self.secondRoad.hidden = YES;
        
        
        [UIView animateWithDuration:0.25f animations:^{
            [ws.view layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    }
    //#ifdef LIANMAI_WEBRTC
    if(_remoteView) {
        self.remoteView.frame = [self calculateRemoteVIdeoRect:self.videoView.frame];
        [_requestData setRemoteVideoFrameA:self.remoteView.frame];
    }
    //#endif
    self.autoRotate = NO;
}

#pragma mark keyboard notification
- (void)keyboardWillShow:(NSNotification *)notif {
    if (self.isScreenLandScape) {
        _contentView.hidden = NO;
        [self.view bringSubviewToFront:self.contentView];
        //        _contentView.frame = CGRectMake(0, KScreenH - y - CCGetRealFromPt(110), KScreenW, CCGetRealFromPt(110));
    }
    NSDictionary *userInfo = [notif userInfo];
    _isKeyBoardShow = YES;
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    _keyboardRect = [aValue CGRectValue];
    CGFloat y = _keyboardRect.size.height;
    //    CGFloat x = _keyboardRect.size.width;
    NSLog(@"键盘高度是  %d",(int)y);
    _videoView.frame = CGRectMake(0, y, KScreenW, CCGetRealFromPt(462));
    
    _isKeyBoardShow = YES;
}

- (void)keyboardWillHide:(NSNotification *)notif {
    
    //
    if (self.isScreenLandScape) {
        [self.videoView setFrame:self.view.frame];
        [self.view bringSubviewToFront:self.videoView];
        _contentView.hidden = YES;
    }else{
        if (KIsiPhoneX) {
            self.videoView.frame = CGRectMake(0, 44, self.view.frame.size.width, CCGetRealFromPt(462));
        }else{
           self.videoView.frame = CGRectMake(0, 20, self.view.frame.size.width, CCGetRealFromPt(462));
        }
        
        [self.view bringSubviewToFront:self.videoView];
    }
    _isKeyBoardShow = NO;
}

#pragma mark -lazy-
-(UIView *)videoView {
    if(!_videoView) {
        _videoView = [UIView new];
        _videoView.backgroundColor = [UIColor blackColor];
    }
    return _videoView;
}

-(UIImageView *)daohangView {
    if(!_daohangView) {
        _daohangView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"daohang"]];
        _daohangView.userInteractionEnabled = YES;
        _daohangView.contentMode = UIViewContentModeScaleToFill;
    }
    return _daohangView;
}

-(UILabel *)leftLabel {
    if(!_leftLabel) {
        _leftLabel = [UILabel new];
        _leftLabel.text = _leftLabelText;
        _leftLabel.textColor = [UIColor whiteColor];
        _leftLabel.font = [UIFont systemFontOfSize:FontSize_30];
        _leftLabel.shadowOffset = CGSizeMake(0, 1);
        _leftLabel.shadowColor = CCRGBAColor(102, 102, 102, 0.5);
        _leftLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _leftLabel;
}

-(UIButton *)leftButton {
    if(!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.backgroundColor = CCClearColor;
        [_leftButton addTarget:self action:@selector(onSelectVC) forControlEvents:UIControlEventTouchUpInside];
        UIImage *aimage = [UIImage imageNamed:@"nav_ic_back_nor"];
        UIImage *image = [aimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [_leftButton setImage:image forState:UIControlStateNormal];
        _leftButton.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _leftButton;
}

-(UIImageView *)zhibozhongImage {
    if(!_zhibozhongImage) {
        _zhibozhongImage = [UIImageView new];
        _zhibozhongImage.image = zhibozhongArray[0];
        _zhibozhongImage.backgroundColor = CCClearColor;
        _zhibozhongImage.contentMode = UIViewContentModeScaleAspectFill;
        if (!zhibozhongTimer) {
            zhibozhongTimer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(changePic) userInfo:nil repeats:YES];
        }
    }
    return _zhibozhongImage;
}

- (UILabel *)zhibozhongLabel{
    if(!_zhibozhongLabel) {
        _zhibozhongLabel = [UILabel new];
        _zhibozhongLabel.text = @"直播中";
        _zhibozhongLabel.textColor = [UIColor whiteColor];
        _zhibozhongLabel.textAlignment = NSTextAlignmentLeft;
        _zhibozhongLabel.font = [UIFont systemFontOfSize:FontSize_24];
    }
    return _zhibozhongLabel;
}

-(UILabel *)userCountLabel {
    if(!_userCountLabel) {
        _userCountLabel = [UILabel new];
        _userCountLabel.text = _roomUserCount;
        _userCountLabel.textColor = [UIColor whiteColor];
        _userCountLabel.textAlignment = NSTextAlignmentLeft;
        _userCountLabel.font = [UIFont systemFontOfSize:FontSize_24];
        _userCountLabel.shadowOffset = CGSizeMake(0, 1);
        _userCountLabel.shadowColor = CCRGBAColor(102, 102, 102, 0.5);
    }
    return _userCountLabel;
}

-(UIButton *)quanPingBtn {
    if(!_quanPingBtn) {
        _quanPingBtn = [UIButton new];
        _quanPingBtn.backgroundColor = CCClearColor;
        [_quanPingBtn setImage:[UIImage imageNamed:@"video_ic_full_nor"] forState:UIControlStateNormal];
        _quanPingBtn.contentMode = UIViewContentModeScaleAspectFit;
        [_quanPingBtn addTarget:self action:@selector(quanPingBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quanPingBtn;
}

-(UIButton *)danMuButton {
    if(!_danMuButton) {
        _danMuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_danMuButton setImage:[UIImage imageNamed:@"关弹幕"] forState:UIControlStateNormal];
        [_danMuButton addTarget:self action:@selector(danMuBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _danMuButton;
}

-(UIButton *)qingXiDuBtn {
    if(!_qingXiDuBtn) {
        _qingXiDuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qingXiDuBtn setTitle:@"标清" forState:UIControlStateNormal];
        [_qingXiDuBtn.titleLabel setFont:[UIFont systemFontOfSize:FontSize_28]];
        [_qingXiDuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_qingXiDuBtn addTarget:self action:@selector(qingXiDuAction) forControlEvents:UIControlEventTouchUpInside];
        [_qingXiDuBtn setBackgroundColor:CCClearColor];
    }
    return _qingXiDuBtn;
}

- (void)qingXiDuAction{
    ++qingxidu;
    if (qingxidu > 2) {
        qingxidu = 0;
    }
    if (qingxidu == 0) {
        [_qingXiDuBtn setTitle:@"标清" forState:UIControlStateNormal];
        [self liuChangBtnClicked];
    }else if (qingxidu == 1){
        [_qingXiDuBtn setTitle:@"清晰" forState:UIControlStateNormal];
        [self qingXiBtnClicked];
    }else if (qingxidu == 2){
        [_qingXiDuBtn setTitle:@"原画" forState:UIControlStateNormal];
        [self yuanHuaBtnClicked];
    }
}

-(void)yuanHuaBtnClicked {
    //    self.hiddenTime = 5;
    //    _yuanHuaBtn.selected = YES;
    //    _qingXiBtn.selected = NO;
    //    _liuChangBtn.selected = NO;
    //
    //    _yuanHuaBtn.hidden = YES;
    //    _qingXiBtn.hidden = YES;
    //    _liuChangBtn.hidden = YES;
    
    if(_currentSecRoadNum == 0) {
        return;
    }
    _currentSecRoadNum = 0;
    [_requestData switchToPlayUrlWithFirIndex:_currentRoadNum key:[_secRoadKeyArray objectAtIndex:_currentSecRoadNum]];
}

-(void)qingXiBtnClicked {
    //    self.hiddenTime = 5;
    //    _yuanHuaBtn.selected = NO;
    //    _qingXiBtn.selected = YES;
    //    _liuChangBtn.selected = NO;
    //
    //    _yuanHuaBtn.hidden = YES;
    //    _qingXiBtn.hidden = YES;
    //    _liuChangBtn.hidden = YES;
    
    if(_currentSecRoadNum == 1) {
        return;
    }
    _currentSecRoadNum = 1;
    [_requestData switchToPlayUrlWithFirIndex:_currentRoadNum key:[_secRoadKeyArray objectAtIndex:_currentSecRoadNum]];
}

-(void)liuChangBtnClicked {
    //    self.hiddenTime = 5;
    //    _yuanHuaBtn.selected = NO;
    //    _qingXiBtn.selected = NO;
    //    _liuChangBtn.selected = YES;
    //
    //    _yuanHuaBtn.hidden = YES;
    //    _qingXiBtn.hidden = YES;
    //    _liuChangBtn.hidden = YES;
    
    if(_currentSecRoadNum == 2) {
        return;
    }
    _currentSecRoadNum = 2;
    [_requestData switchToPlayUrlWithFirIndex:_currentRoadNum key:[_secRoadKeyArray objectAtIndex:_currentSecRoadNum]];
}

-(void)danMuBtnClicked {
    
    //    if([self hasViewOnTheScreen:NO]) return;
    //
    //    _hiddenTime = 5.0f;
    //    BOOL selected = _hideDanMuBtn.selected;
    //    _danMuButton.selected = !selected;
    //    _hideDanMuBtn.selected = !selected;
    //    NSLog(@"selected = %d",selected);
    _hiddenTime = 5.0f;
    if (isDanmu) {
        [_danMuButton setImage:[UIImage imageNamed:@"弹弹幕"] forState:UIControlStateNormal];
        isDanmu = NO;
        [self stopDanMuTimer];
        _danmuBgView.hidden = YES;
    }else{
        [_danMuButton setImage:[UIImage imageNamed:@"关弹幕"] forState:UIControlStateNormal];
        isDanmu = YES;
        [self startDanMuTimer];
        _danmuBgView.hidden = NO;
    }
}

- (UIButton *)chatBtn{
    if(!_chatBtn) {
        _chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatBtn.imageView setContentMode:UIViewContentModeScaleAspectFit];
        [_chatBtn setImage:[UIImage imageNamed:@"聊天"] forState:(UIControlStateNormal)];
        [_chatBtn addTarget:self action:@selector(chatBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatBtn;
}

- (void)chatBtnClick{
    
    [_chatTextField becomeFirstResponder];
}

-(ChatView *)chatView {
    WS(ws)
    if(!_chatView) {
        _chatView = [[ChatView alloc] initWithPublicChatBlock:^(NSString *msg) {
            [ws.requestData chatMessage:msg];
        } PrivateChatBlock:^(NSString *anteid, NSString *msg) {
            [ws.requestData privateChatWithTouserid:anteid msg:msg];
        } input:YES];
        _chatView.backgroundColor = CCRGBColor(250,250,250);
        
    }
    return _chatView;
}

-(UIView *)contentView {
    if(!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = CCRGBColor(240,240,240);
       
    }
    return _contentView;
}

-(CustomTextField *)chatTextField {
    if(!_chatTextField) {
        _chatTextField = [CustomTextField new];
        _chatTextField.delegate = self;
        [_chatTextField addTarget:self action:@selector(chatTextFieldChange) forControlEvents:UIControlEventEditingChanged];
        //        _chatTextField.text = @"输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制在输入限制";
        _chatTextField.rightView = self.rightView;
    }
    return _chatTextField;
}

-(void)chatTextFieldChange {
    if(_chatTextField.text.length > 300) {
        //        [self endEditing:YES];
        _chatTextField.text = [_chatTextField.text substringToIndex:300];
        [_informationView removeFromSuperview];
        _informationView = [[InformationShowView alloc] initWithLabel:@"输入限制在300个字符以内"];
        [APPDelegate.window addSubview:_informationView];
        [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 200, 0));
        }];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(informationViewRemove) userInfo:nil repeats:NO];
    }
}

-(UIButton *)rightView {
    if(!_rightView) {
        _rightView = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightView.frame = CGRectMake(0, 0, CCGetRealFromPt(48), CCGetRealFromPt(48));
        _rightView.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _rightView.backgroundColor = CCClearColor;
//        [_rightView setImage:[UIImage imageNamed:@"chat_ic_face_nor"] forState:UIControlStateNormal];
//        [_rightView setImage:[UIImage imageNamed:@"chat_ic_face_hov"] forState:UIControlStateSelected];
//        [_rightView addTarget:self action:@selector(faceBoardClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightView;
}

- (void)faceBoardClick {
    BOOL selected = !_rightView.selected;
    _rightView.selected = selected;
    
    if(selected) {
        [_chatTextField setInputView:self.emojiView];
    } else {
        [_chatTextField setInputView:nil];
    }
    
    [_chatTextField becomeFirstResponder];
    [_chatTextField reloadInputViews];
}

-(UIButton *)sendButton {
    if(!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.backgroundColor = CCRGBColor(0,129,244);
        _sendButton.layer.cornerRadius = CCGetRealFromPt(4);
        _sendButton.layer.masksToBounds = YES;
        _sendButton.layer.borderColor = [CCRGBColor(0,129,244) CGColor];
        _sendButton.layer.borderWidth = 1;
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:CCRGBColor(255,255,255) forState:UIControlStateNormal];
        [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:FontSize_30]];
        [_sendButton addTarget:self action:@selector(sendBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

-(void)sendBtnClicked {
    if(!StrNotEmpty([_chatTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]])) {
        [_informationView removeFromSuperview];
        _informationView = [[InformationShowView alloc] initWithLabel:@"发送内容为空"];
        [APPDelegate.window addSubview:_informationView];
        [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 200, 0));
        }];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(informationViewRemove) userInfo:nil repeats:NO];
        return;
    }
    WS(ws);
    [ws.requestData chatMessage:_chatTextField.text];
    _chatTextField.text = nil;
    [_chatTextField resignFirstResponder];
}

-(void)informationViewRemove {
    [_informationView removeFromSuperview];
    _informationView = nil;
}

-(ModelView *)modelView {
    if(!_modelView) {
        _modelView = [ModelView new];
        _modelView.backgroundColor = CCClearColor;
    }
    return _modelView;
}

- (NSMutableArray *)headerArray{
    if (!_headerArray) {
        _headerArray = [NSMutableArray array];
    }
    return _headerArray;
}

-(UIView *)modeoCenterView {
    if(!_modeoCenterView) {
        _modeoCenterView = [UIView new];
        _modeoCenterView.backgroundColor = [UIColor whiteColor];
        _modeoCenterView.layer.borderWidth = 1;
        _modeoCenterView.layer.borderColor = [CCRGBColor(187, 187, 187) CGColor];
        _modeoCenterView.layer.cornerRadius = CCGetRealFromPt(10);
        _modeoCenterView.layer.masksToBounds = YES;
    }
    return _modeoCenterView;
}

-(UIButton *)cancelBtn {
    if(!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        _cancelBtn.layer.cornerRadius = CCGetRealFromPt(10);
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:CCRGBColor(51,51,51) forState:UIControlStateNormal];
        [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:FontSize_30]];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)sureBtn {
    if(!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = [UIColor whiteColor];
        _sureBtn.layer.cornerRadius = CCGetRealFromPt(10);
        _sureBtn.layer.masksToBounds = YES;
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:CCRGBColor(51,51,51) forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:[UIFont systemFontOfSize:FontSize_30]];
        [_sureBtn addTarget:self action:@selector(sureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

-(void)sureBtnClicked {
    //    dispatch_async(dispatch_get_main_queue(), ^{
    [self hiddenAllBtns];
    [self removeObserver];
    [self stopTimer];
    [self stopHiddenTimer];
    [self stopDanMuTimer];
    [_requestData requestCancel];
    _requestData = nil;
    [_modelView removeFromSuperview];
    _modelView = nil;
    [_voteViewResult removeFromSuperview];
    _voteViewResult = nil;
    [_voteView removeFromSuperview];
    _voteView = nil;
    [_lotteryView removeFromSuperview];
    _lotteryView = nil;
    [_questionnaireSurvey removeFromSuperview];
    _questionnaireSurvey = nil;
    [_questionnaireSurveyPopUp removeFromSuperview];
    _questionnaireSurveyPopUp = nil;
    [_rollcallView removeFromSuperview];
    _rollcallView = nil;
    [zhibozhongTimer invalidate];
    zhibozhongTimer = nil;
    [self dismissViewControllerAnimated:YES completion:^ {
    }];
    //    });
}

-(UILabel *)modeoCenterLabel {
    if(!_modeoCenterLabel) {
        _modeoCenterLabel = [UILabel new];
        _modeoCenterLabel.font = [UIFont systemFontOfSize:FontSize_30];
        _modeoCenterLabel.textAlignment = NSTextAlignmentCenter;
        _modeoCenterLabel.textColor = CCRGBColor(51,51,51);
        _modeoCenterLabel.text = @"您确认结束观看直播吗？";
    }
    return _modeoCenterLabel;
}

-(void) stopTimer {
    if([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

-(void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerPlaybackStateDidChangeNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMovieNaturalSizeAvailableNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"remove_lotteryView"
                                                  object:nil];
}

-(void)cancelBtnClicked {
    [self.modelView removeFromSuperview];
}

-(void)onSelectVC {
    //    dispatch_async(dispatch_get_main_queue(), ^{
    if(self.isScreenLandScape) {
        [self quanPingBtnClicked];
    } else {
        [self closeBtnClicked];
    }
    //    });
}

-(void)closeBtnClicked {
    [self.view addSubview:self.modelView];
    WS(ws)
    [_modelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view);
    }];
    [_modelView addSubview:self.modeoCenterView];
    [_modeoCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        if(!ws.isScreenLandScape) {
            make.top.mas_equalTo(ws.modelView).offset(CCGetRealFromPt(390));
        } else {
            make.centerY.mas_equalTo(ws.modelView.mas_centerY);
        }
        make.centerX.mas_equalTo(ws.modelView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(CCGetRealFromPt(500), CCGetRealFromPt(250)));
    }];
    [_modeoCenterView addSubview:self.cancelBtn];
    [_modeoCenterView addSubview:self.sureBtn];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.mas_equalTo(ws.modeoCenterView);
        make.height.mas_equalTo(CCGetRealFromPt(100));
        make.right.mas_equalTo(ws.sureBtn.mas_left);
        make.width.mas_equalTo(ws.sureBtn.mas_width);
    }];
    
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.and.bottom.mas_equalTo(ws.modeoCenterView);
        make.height.mas_equalTo(ws.cancelBtn);
        make.left.mas_equalTo(ws.cancelBtn.mas_right);
        make.width.mas_equalTo(ws.cancelBtn.mas_width);
    }];
    
    [_modelView addSubview:self.modeoCenterLabel];
    [_modeoCenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.mas_equalTo(ws.modeoCenterView);
        make.bottom.mas_equalTo(ws.sureBtn.mas_top);
    }];
    
    UIView *lineCross = [UIView new];
    lineCross.backgroundColor = CCRGBColor(221,221,221);
    [_modeoCenterView addSubview:lineCross];
    [lineCross mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(ws.modeoCenterView);
        make.bottom.mas_equalTo(ws.cancelBtn.mas_top);
        make.height.mas_equalTo(1);
    }];
    
    UIView *lineVertical = [UIView new];
    lineVertical.backgroundColor = CCRGBColor(221,221,221);
    [_modeoCenterView addSubview:lineVertical];
    [lineVertical mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ws.cancelBtn.mas_right);
        make.top.mas_equalTo(lineCross.mas_bottom);
        make.bottom.mas_equalTo(ws.cancelBtn.mas_bottom);
        make.width.mas_equalTo(1);
    }];
}

-(void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackStateDidChange:)
                                                 name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieLoadStateDidChange:)
                                                 name:IJKMPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(movieNaturalSizeAvailableNotification:) name:IJKMPMovieNaturalSizeAvailableNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(removeLotteryView:)
                                                 name:@"remove_lotteryView"
                                               object:nil];
}

- (void)removeLotteryView:(NSNotification*) notification
{
    NSDictionary *dic = [notification object];
    NSInteger tag = [dic[@"tag"] integerValue];
    LotteryView *lotteryView = [APPDelegate.window viewWithTag:tag];
    [lotteryView removeFromSuperview];
    lotteryView = nil;
}

-(void)movieNaturalSizeAvailableNotification:(NSNotification *)notification {
    //    NSLog(@"player.naturalSize = %@",NSStringFromCGSize(_requestData.ijkPlayer.naturalSize));
}

-(void)play_loadVideoFail {
    [self loadInformationView:@"视频加载失败"];
}

-(void)dealSingleInformationTap {
    [self.view endEditing:YES];
}

- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
    //    IJKMPMoviePlaybackStateStopped,
    //    IJKMPMoviePlaybackStatePlaying,
    //    IJKMPMoviePlaybackStatePaused,
    //    IJKMPMoviePlaybackStateInterrupted,
    //    IJKMPMoviePlaybackStateSeekingForward,
    //    IJKMPMoviePlaybackStateSeekingBackward
    //    NSLog(@"_requestData.ijkPlayer.playbackState = %ld",_requestData.ijkPlayer.playbackState);
    
    switch (_requestData.ijkPlayer.playbackState)
    {
        case IJKMPMoviePlaybackStateStopped: {
            break;
        }
        case IJKMPMoviePlaybackStatePlaying:{
            [_loadingView removeFromSuperview];
            _loadingView = nil;
            [_informationView removeFromSuperview];
            _informationView = nil;
            break;
        }
        case IJKMPMoviePlaybackStatePaused:{
            //            [_loadingView removeFromSuperview];
            //            _loadingView = nil;
            //            [_informationView removeFromSuperview];
            //            _informationView = nil;
            break;
        }
        case IJKMPMoviePlaybackStateInterrupted: {
            break;
        }
        case IJKMPMoviePlaybackStateSeekingForward:
        case IJKMPMoviePlaybackStateSeekingBackward: {
            break;
        }
        default: {
            break;
        }
    }
}

-(void)movieLoadStateDidChange:(NSNotification*)notification
{
    switch (_requestData.ijkPlayer.loadState)
    {
        case IJKMPMovieLoadStateStalled:
            break;
        case IJKMPMovieLoadStatePlayable:
            break;
        case IJKMPMovieLoadStatePlaythroughOK:
            break;
        default:
            break;
    }
}

- (void)appWillEnterBackgroundNotification {
    _needReloadLianMainView = NO;
    self.lianMaiHidden = NO;
    if(_lianMaiView) {
        _needReloadLianMainView = YES;
        self.lianMaiHidden = _lianMaiView.hidden;
        [_lianMaiView removeFromSuperview];
        _lianMaiView = nil;
    }
}

- (void)appWillEnterForegroundNotification {
    if(_needReloadLianMainView == YES) {
        
        if(_lianMaiView) {
            self.lianMaiHidden = _lianMaiView.hidden;
            [_lianMaiView removeFromSuperview];
            _lianMaiView = nil;
        }
        [self showAll];
        [self.videoView addSubview:self.lianMaiView];
        _lianMaiView.hidden = self.lianMaiHidden;
        
        AVAuthorizationStatus statusVideo = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        AVAuthorizationStatus statusAudio = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
        
        [self judgeLianMaiLocationWithVideoPermission:statusVideo AudioPermission:statusAudio];
        
        [_lianMaiView initUIWithVideoPermission:statusVideo AudioPermission:statusAudio];
    }
}

-(void)judgeLianMaiLocationWithVideoPermission:(AVAuthorizationStatus)statusVideo AudioPermission:(AVAuthorizationStatus)statusAudio {
    
    if(_isScreenLandScape) {
        if (statusVideo == AVAuthorizationStatusAuthorized && statusAudio == AVAuthorizationStatusAuthorized) {
            _lianMaiView.frame = CGRectMake(CCGetRealFromPt(114), CCGetRealFromPt(270), CCGetRealFromPt(330), CCGetRealFromPt(210));
        } else {
            _lianMaiView.frame = CGRectMake(CCGetRealFromPt(114), CCGetRealFromPt(270), CCGetRealFromPt(390), CCGetRealFromPt(280));
        }
    } else {
        if (statusVideo == AVAuthorizationStatusAuthorized && statusAudio == AVAuthorizationStatusAuthorized) {
            //        if(1) {
            _lianMaiView.frame = CGRectMake(CCGetRealFromPt(114), CCGetRealFromPt(176), CCGetRealFromPt(330), CCGetRealFromPt(210));
        } else {
            _lianMaiView.frame = CGRectMake(CCGetRealFromPt(114), CCGetRealFromPt(176), CCGetRealFromPt(390), CCGetRealFromPt(280));
        }
    }
}

- (void)startDanMuTimer {
    [self stopDanMuTimer];
    _danMuTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(makeTheRightAction) userInfo:nil repeats:YES];
}

- (void)makeTheRightAction {
    if([_requestData isPlaying] && _loadingView) {
        [_loadingView removeFromSuperview];
        _loadingView = nil;
    }
    
    for(int i = 0;i < _lineLimit;i++){
        if ([self.array count] >= 1) {
            [self makeLabel:[_array objectAtIndex:0] currentLine:i];
            [_array removeObjectAtIndex:0];
        } else {
            break;
        }
    }
}

- (void)makeLabel:(NSString *)str currentLine:(int)currentLine{
    NSMutableAttributedString *attrStr = [Utility emotionStrWithString:str y:-8];
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:20.0f]
                    range:NSMakeRange(0, attrStr.length)];
    CGSize textSize = [attrStr boundingRectWithSize:CGSizeMake(100000, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                            context:nil].size;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width, 0 + IMGWIDTH * 0.5 * (currentLine + 1) + IMGWIDTH * currentLine, textSize.width, textSize.height + 2)];
    contentLabel.font = [UIFont systemFontOfSize:20.0f];
    contentLabel.numberOfLines = 1;
    contentLabel.attributedText = attrStr;
    contentLabel.shadowOffset = CGSizeMake(0, 1);
    contentLabel.shadowColor = CCRGBAColor(0, 0, 0, 0.5);
    contentLabel.backgroundColor = [UIColor clearColor];
    //设置字体颜色为green
    contentLabel.textColor = [UIColor whiteColor];
    //文字居中显示
    contentLabel.textAlignment = NSTextAlignmentCenter;
    //自动折行设置
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    if(!_danmuBgView){
        self.danmuBgView.frame = CGRectMake(0,64, self.videoView.width, 12);
    }
    
    [self.danmuBgView addSubview:contentLabel];
    [self.videoView insertSubview:self.danmuBgView belowSubview:self.zhibozhongImage];
    
    [self moveAction:contentLabel size:textSize];
}
-(UIView *)danmuBgView{
    
    if (!_danmuBgView) {
        _danmuBgView = [[UIView alloc]init];
        _danmuBgView.backgroundColor = [UIColor clearColor];
    }
    return _danmuBgView;
}
- (void)moveAction:(UIView *)view size:(CGSize) size {
    [UIView animateWithDuration:_secondToEnd delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
        view.frame = CGRectMake(-size.width,view.frame.origin.y,size.width,size.height);
    } completion:^(BOOL finished) {
        [view removeFromSuperview];
    }];
}

- (void)stopDanMuTimer {
    if ([_danMuTimer isValid]){
        [_danMuTimer invalidate];
        _danMuTimer=nil;
        [self.array removeAllObjects];
    }
}

-(void)startHiddenTimer {
    [self stopHiddenTimer];
    self.hiddenTime = 5.0f;
    self.hiddenTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(hiddenAll) userInfo:nil repeats:YES];
}

-(void)hiddenAll {
    if((_isScreenLandScape == YES && _isKeyBoardShow == YES) || _yuanHuaBtn.hidden == NO || self.mainRoad.hidden == NO || (_lianMaiView && _lianMaiView.hidden == NO) || _loadingView || _informationView) {
        _hiddenTime = 5.0f;
        return;
    }
    if(_hiddenTime > 0.0f) {
        _hiddenTime -= 1.0f;
    }
    if(_hiddenTime == 0) {
        _daohangView.hidden = YES;
        
        _barImageView.hidden = YES;
        //        _contentView.hidden = YES;
        
        _lianmaiBtn.hidden = YES;
        _selectRoadBtn.hidden = YES;
        
        _soundVideoBtn.hidden = YES;
        _hideDanMuBtn.hidden = YES;
        _quanPingBtn.hidden = YES;
        
        _qingXiDuBtn.hidden = YES;
        _yuanHuaBtn.hidden = YES;
        _bottomBgView.hidden = YES;
        _qingXiBtn.hidden = YES;
        _liuChangBtn.hidden = YES;
        _mainRoad.hidden = YES;
        _secondRoad.hidden = YES;
        if (_isLive) {
            _zhibozhongImage.hidden = NO;
            _zhibozhongLabel.hidden = NO;
        }
        if(_lianMaiView.needToRemoveLianMaiView) {
            [_lianMaiView removeFromSuperview];
            _lianMaiView = nil;
        } else {
            _lianMaiView.hidden = YES;
        }
    }
}

-(void)stopHiddenTimer {
    if([self.hiddenTimer isValid]) {
        [self.hiddenTimer invalidate];
        self.hiddenTimer = nil;
    }
}

-(CGRect) calculateRemoteVIdeoRect:(CGRect)rect {
    //字符串是否包含有某字符串
    NSRange range = [_videosizeStr rangeOfString:@"x"];
    float remoteSizeWHPercent = [[_videosizeStr substringToIndex:range.location] floatValue] / [[_videosizeStr substringFromIndex:(range.location + 1)] floatValue];
    
    float videoParentWHPercent = rect.size.width / rect.size.height;
    
    CGSize remoteVideoSize = CGSizeZero;
    
    if(remoteSizeWHPercent > videoParentWHPercent) {
        remoteVideoSize = CGSizeMake(rect.size.width, rect.size.width / remoteSizeWHPercent);
    } else {
        remoteVideoSize = CGSizeMake(rect.size.height * remoteSizeWHPercent, rect.size.height);
    }
    
    CGRect remoteVideoRect = CGRectMake((rect.size.width - remoteVideoSize.width) / 2, (rect.size.height - remoteVideoSize.height) / 2, remoteVideoSize.width, remoteVideoSize.height);
    return remoteVideoRect;
}

- (void)dealSingleTap:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
    CGPoint point = [tap locationInView:self.view];
    if(!_isScreenLandScape) {
        //        if(_daohangView.hidden == NO && CGRectContainsPoint(_daohangView.frame, point)) {
        //            return;
        //        } else
        //        if (_barImageView.hidden == NO && CGRectContainsPoint(_barImageView.frame, point)) {
        //            return;
        //        } else if (_lianMaiView && _lianMaiView.hidden == NO && CGRectContainsPoint(_lianMaiView.frame, point)) {
        //            return;
        //        } else if(_gongGaoView) {
        //            return;
        //        } else if([self hasViewOnTheScreen:YES]) {
        //            return;
        //        }
        
        if(self.daohangView.hidden == YES) {
            self.hiddenTime = 5.0f;
            [self showAll];
        } else {
            self.hiddenTime = 0.0f;
            [self hiddenAllBtns];
        }
    } else {
        //        if(_daohangView.hidden == NO && CGRectContainsPoint(_daohangView.frame, point)) {
        //            return;
        //        } else
        //        if (_lianMaiView && _lianMaiView.hidden == NO && CGRectContainsPoint(_lianMaiView.frame, point)) {
        //            return;
        //        } else if(_gongGaoView) {
        //            return;
        //        } else if([self hasViewOnTheScreen:YES]) {
        //            return;
        //        }
        
        if([_chatTextField isFirstResponder] || self.daohangView.hidden) {
            [_chatTextField resignFirstResponder];
            
            self.hiddenTime = 5.0f;
            [self showAll];
        } else {
            self.hiddenTime = 0.0f;
            [self hiddenAllBtns];
        }
    }
}

-(BOOL)hasViewOnTheScreen:(BOOL)allowConnectingClick {
    if([_lianMaiView isConnecting] && !allowConnectingClick) {
        return YES;
    } else if(_lianMaiView && _lianMaiView.hidden == NO) {
        if(_lianMaiView.needToRemoveLianMaiView) {
            [_lianMaiView removeFromSuperview];
            _lianMaiView = nil;
        } else {
            _lianMaiView.hidden = YES;
        }
        if([_lianMaiView isConnecting]) {
            _lianmaiBtn.selected = YES;
        }
        return YES;
    } else if(_yuanHuaBtn.hidden == NO) {
        _yuanHuaBtn.hidden = YES;
        _qingXiBtn.hidden = YES;
        _liuChangBtn.hidden = YES;
        return YES;
    } else if(_mainRoad.hidden == NO) {
        _mainRoad.hidden = YES;
        _secondRoad.hidden = YES;
        return YES;
    }
    return NO;
}

-(void)hiddenAllBtns {
    if(_isScreenLandScape == YES && _isKeyBoardShow == YES) {
        _hiddenTime = 5.0f;
        return;
    }
    _gongGaoDot.hidden = !_newGongGao;

    _daohangView.hidden = YES;
    _barImageView.hidden = YES;
    _lianmaiBtn.hidden = YES;
    _selectRoadBtn.hidden = YES;
    _soundVideoBtn.hidden = YES;
    _mainRoad.hidden = YES;
    _secondRoad.hidden = YES;
    _qingXiDuBtn.hidden = YES;
    //    _contentView.hidden = YES;
    _hideDanMuBtn.hidden = YES;
    _quanPingBtn.hidden = YES;
    _yuanHuaBtn.hidden = YES;
    _bottomBgView.hidden = YES;
    _qingXiBtn.hidden = YES;
    _liuChangBtn.hidden = YES;
    if (_isLive) {
        _zhibozhongImage.hidden = YES;
        _zhibozhongLabel.hidden = YES;
    }
    _chatBtn.hidden = YES;
    _danMuButton.hidden = YES;
    if(_lianMaiView.needToRemoveLianMaiView) {
        [_lianMaiView removeFromSuperview];
        _lianMaiView = nil;
    } else {
        _lianMaiView.hidden = YES;
    }
}

-(void)showAll {
    _hiddenTime = 5.0f;
    _daohangView.hidden = NO;
    _barImageView.hidden = NO;
    _lianmaiBtn.hidden = NO;
    _selectRoadBtn.hidden = NO;
    _soundVideoBtn.hidden = NO;
    _bottomBgView.hidden = NO;
    _mainRoad.hidden = YES;
    _secondRoad.hidden = YES;
    if (_isLive) {
        _zhibozhongImage.hidden = NO;
        _zhibozhongLabel.hidden = NO;
    }

    if(_isScreenLandScape) {
        _qingXiDuBtn.hidden = NO;
        //        _contentView.hidden = NO;
        //        _hideDanMuBtn.hidden = YES;
        _quanPingBtn.hidden = NO;
        _danMuButton.hidden = NO;
        _chatBtn.hidden = NO;
    } else {
        _qingXiDuBtn.hidden = YES;
        //        _contentView.hidden = YES;
        //        _hideDanMuBtn.hidden = NO;
        _quanPingBtn.hidden = NO;
        _danMuButton.hidden = YES;
        _chatBtn.hidden = YES;
    }
}

#pragma mark -collectionView-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _headerArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFCustomerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:customerCell forIndexPath:indexPath];
    //    [cell.headerImageView sd_setImageWithURL:[NSURL ] placeholderImage:[UIImage imageNamed:@"123"]];
    [cell.headerImageView sd_setImageWithURL:[NSURL URLWithString:_headerArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"123"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(NSMutableArray *)array {
    if(!_array) {
        _array = [NSMutableArray new];
    }
    return _array;
}

-(NSMutableArray *)publicChatArray {
    if(!_publicChatArray) {
        _publicChatArray = [[NSMutableArray alloc] init];
    }
    return _publicChatArray;
}

- (void)insertStr:(NSString *)str{
    if ([_danMuTimer isValid]) {
        [self.array addObject:str];
    }
}

/**
 *    @brief  历史聊天数据
 */
- (void)onChatLog:(NSArray *)chatLogArr {
    NSLog(@"onChatLog = %@",chatLogArr);
    
    for(NSDictionary *dic in chatLogArr) {
        Dialogue *dialogue = [[Dialogue alloc] init];
        dialogue.userid = dic[@"userId"];
        dialogue.fromuserid = dic[@"userId"];
        dialogue.username = dic[@"userName"];
        dialogue.fromusername = dic[@"userName"];
        dialogue.userrole = dic[@"userRole"];
        dialogue.fromuserrole = dic[@"userRole"];
        dialogue.msg = dic[@"content"];
        dialogue.useravatar = dic[@"userAvatar"];
        dialogue.time = dic[@"time"];
        dialogue.myViwerId = _viewerId;
        
        if([self.userDic objectForKey:dialogue.userid] == nil) {
            [self.userDic setObject:dic[@"userName"] forKey:dialogue.userid];
        }
        
        [self.publicChatArray addObject:dialogue];
    }
    [self.chatView reloadPublicChatArray:self.publicChatArray];
}

- (void)onPublicChatMessage:(NSDictionary *)dic {
    //    NSLog(@"onPublicChatMessage = %@",dic);
    if(isDanmu) {
        [self insertStr:dic[@"msg"]];
    }
    
    Dialogue *dialogue = [[Dialogue alloc] init];
    dialogue.userid = dic[@"userid"];
    dialogue.fromuserid = dic[@"userid"];
    dialogue.username = dic[@"username"];
    dialogue.fromusername = dic[@"username"];
    dialogue.userrole = dic[@"userrole"];
    dialogue.fromuserrole = dic[@"userrole"];
    dialogue.msg = dic[@"msg"];
    dialogue.useravatar = dic[@"useravatar"];
    dialogue.time = dic[@"time"];
    dialogue.myViwerId = _viewerId;
    
    if([self.userDic objectForKey:dialogue.userid] == nil) {
        [self.userDic setObject:dic[@"username"] forKey:dialogue.userid];
    }
    
    [self.publicChatArray addObject:dialogue];
    
    [self.chatView reloadPublicChatArray:self.publicChatArray];
}

/*
 *  @brief  收到自己的禁言消息，如果你被禁言了，你发出的消息只有你自己能看到，其他人看不到
 */
- (void)onSilenceUserChatMessage:(NSDictionary *)message {
    [self onPublicChatMessage:message];
}

/**
 *    @brief    当主讲全体禁言时，你再发消息，会出发此代理方法，information是禁言提示信息
 */
- (void)information:(NSString *)information {
    NSString *str = @"讲师暂停了问答，请专心看直播吧";
    if(_segment.selectedSegmentIndex == 1) {
        str = @"讲师暂停了文字聊天，请专心看直播吧";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:str preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [_voteViewResult removeFromSuperview];
    _voteViewResult = nil;
    [_voteView removeFromSuperview];
    _voteView = nil;
    [_lotteryView removeFromSuperview];
    _lotteryView = nil;
    [_questionnaireSurvey removeFromSuperview];
    _questionnaireSurvey = nil;
    [_questionnaireSurveyPopUp removeFromSuperview];
    _questionnaireSurveyPopUp = nil;
    [_rollcallView removeFromSuperview];
    _rollcallView = nil;
    
    [self hiddenAllBtns];
    [self removeObserver];
    [self stopTimer];
    [self stopHiddenTimer];
    [self stopDanMuTimer];
    [_requestData requestCancel];
    _requestData = nil;
    
    [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    [self dismissViewControllerAnimated:YES completion:^ {
    }];
}

/**
 *    @brief  收到踢出消息，停止推流并退出播放（被主播踢出）
 */
- (void)onKickOut {
    [_requestData stopPlayer];
    [self.view endEditing:YES];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"您已被管理员踢出！" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

-(UIView *)emojiView {
    if(!_emojiView) {
        if(_keyboardRect.size.width == 0 || _keyboardRect.size.height ==0) {
            _keyboardRect = CGRectMake(0, 0, 736, 194);
        }
        //        NSLog(@"_keyboardRect = %@",NSStringFromCGRect(_keyboardRect));
        
        _emojiView = [[UIView alloc] initWithFrame:_keyboardRect];
        _emojiView.backgroundColor = CCRGBColor(242,239,237);
        
        CGFloat faceIconSize = CCGetRealFromPt(60);
        CGFloat xspace = (_keyboardRect.size.width - FACE_COUNT_CLU * faceIconSize) / (FACE_COUNT_CLU + 1);
        CGFloat yspace = (_keyboardRect.size.height - 26 - FACE_COUNT_ROW * faceIconSize) / (FACE_COUNT_ROW + 1);
        
        for (int i = 0; i < FACE_COUNT_ALL; i++) {
            UIButton *faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
            faceButton.tag = i + 1;
            
            [faceButton addTarget:self action:@selector(faceButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            //            计算每一个表情按钮的坐标和在哪一屏
            CGFloat x = (i % FACE_COUNT_CLU + 1) * xspace + (i % FACE_COUNT_CLU) * faceIconSize;
            CGFloat y = (i / FACE_COUNT_CLU + 1) * yspace + (i / FACE_COUNT_CLU) * faceIconSize;
            
            faceButton.frame = CGRectMake(x, y, faceIconSize, faceIconSize);
            faceButton.backgroundColor = CCClearColor;
            [faceButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%02d", i+1]]
                        forState:UIControlStateNormal];
            faceButton.contentMode = UIViewContentModeScaleAspectFit;
            [_emojiView addSubview:faceButton];
        }
        //删除键
        UIButton *button14 = (UIButton *)[_emojiView viewWithTag:14];
        UIButton *button20 = (UIButton *)[_emojiView viewWithTag:20];
        
        UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
        back.contentMode = UIViewContentModeScaleAspectFit;
        [back setImage:[UIImage imageNamed:@"chat_btn_facedel"] forState:UIControlStateNormal];
        [back addTarget:self action:@selector(backFace) forControlEvents:UIControlEventTouchUpInside];
        [_emojiView addSubview:back];
        
        [back mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(button14);
            make.centerY.mas_equalTo(button20);
        }];
    }
    return _emojiView;
}

- (BOOL)shouldAutorotate{
    return self.autoRotate;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)broadcast_msg:(NSDictionary *)dic {
    //    NSLog(@"broadcast_msg dic:%@",dic);
    Dialogue *dialogue = [[Dialogue alloc] init];
    dialogue.msg = [NSString stringWithFormat:@"系统消息：%@",dic[@"value"][@"content"]];
    
    [self.publicChatArray addObject:dialogue];
    
    [self.chatView reloadPublicChatArray:self.publicChatArray];
}

// 直播中图片切换
- (void)changePic{
    ++livingTimes;
    if (livingTimes == 8) {
        livingTimes = 0;
    }
    _zhibozhongImage.image = zhibozhongArray[livingTimes];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
