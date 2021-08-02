//
//  BFLatestHomePageViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/16.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFLatestHomePageViewController.h"
//顶部轮播图
#import "NewPagedFlowView.h"
//技术总监视频诊断collectionCell
#import "BFMiddleCollectionCell.h"
//直播课堂自定义View
#import "BFFourClassView.h"
//车人才自定义View
#import "BFCarTalentView.h"
//热门帖子自定义cell
#import "BFTipsCell.h"
#import "BFTipTopCell.h"
//汽车研究中心自定义View
#import "BFCarCenterView.h"
//资讯自定义View
#import "BFNewsOneView.h"
#import "BFNewsTwoView.h"
//系列课自定义View
#import "BFSerCourseView.h"
//资讯详情页
#import "BFCarConsultDetailsVC.h"
//车资讯model
#import "BFCarNewsModel.h"
//原厂资料自定义View
#import "BFDataView.h"
//预览简历页面
#import "BFWatchResumeController.h"
#import "BFCommunityDetailsVC.h"
#import "BFCommunityModel.h"
#import "LiveShowViewController.h"
#import "LoadingView.h"
#import "InformationShowView.h"
#import "BFWatchLiveCourseVC.h"
#import "BFCarTalentsViewController.h"
#import "BFWatchCourseVC.h"
#import "BFCompanyDetailViewController.h"
#import "CCTabBarController.h"
#import "CCNavigationController.h"
#import "CXSearchController.h"
#import "BFNewHomePageViewController.h"
#import "BFPlayBackOneViewController.h"
#import "BFMoreCourseListVC.h"
#import "BFChatViewController.h"
#import "BFDownloadController.h"
#import "BFCourseListVC.h"
#import "BFCooperationController.h"
@interface BFLatestHomePageViewController ()<UIScrollViewDelegate,NewPagedFlowViewDelegate,NewPagedFlowViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,RequestDataDelegate,CCPushUtilDelegate,UIWebViewDelegate>
{
    NewPagedFlowView *pageFlowView;
    NewPagedFlowView *pageFlowView1;
    UICollectionView *collectionView0;
    NSDictionary     *nowDict;
    NSString         *liveId;
    NSInteger        cId;
    UIImageView      *liveNowImg;
    NSString * xilieCid;
}
@property (nonatomic, strong) AppDelegate *appDelegate;
//顶部导航栏视图
@property (nonatomic,strong) UIView *navView;
/*pageControl*/
@property (nonatomic,strong) UIPageControl *pageControl;
//顶部图片
@property (nonatomic,strong) UIImageView *topImage;
//顶部搜索按钮
@property (nonatomic,strong) UIImageView *searchImg;
//顶部客服按钮
@property (nonatomic,strong) UIImageView *serviceImg;
//首页整体ScrollView
@property (nonatomic,strong) UIScrollView *scrollView;
//系列课程按钮ScrollView
@property (nonatomic,strong) UIScrollView *scrollViewBtn;
//系列课程视频列表ScrollView
@property (nonatomic,strong) UIScrollView *scrollViewSer;
//原厂资料ScrollView
@property (nonatomic,strong) UIScrollView *scrollViewData;
//根据差值 判断ScrollView是上滑还是下拉
@property (nonatomic,assign) NSInteger lastcontentOffset;
@property (nonatomic,strong) PGIndexBannerSubiew *bannerView0;
@property (nonatomic,strong) PGIndexBannerSubiew *bannerView1;
/*tableView*/
@property (nonatomic,strong) UITableView *tableView;
//热门资讯数组
@property (nonatomic , strong) NSMutableArray *newsArr;
@property (nonatomic,strong) UIImageView *zixunImg;
@property (nonatomic,strong) UILabel *newsTitle;
@property (nonatomic,strong) BFNewsOneView *newsView0;
@property (nonatomic,strong) BFNewsOneView *newsView1;
@property (nonatomic,strong) BFNewsTwoView *newsView2;
@property (nonatomic,strong) BFNewsTwoView *newsView3;
//热门帖子数组
@property (nonatomic , strong) NSMutableArray *tipArr;
//首页banner数组
@property (nonatomic , strong) NSMutableArray *bannerArr;
//首页六个视频数组
@property (nonatomic , strong) NSMutableArray *sixVideoArr;
/*系列课程数组*/
@property (nonatomic,strong) NSMutableArray *kcArr;

@property (nonatomic , strong) UIImageView *xnyMainImg;
@property (nonatomic , strong) UILabel *xnyLeftLbl;
@property (nonatomic , strong) UILabel *xnyRightLbl;
@property (nonatomic , strong) UIImageView *liveMainImg;
@property (nonatomic , strong) UILabel *LeftLbl1;
@property (nonatomic , strong) UILabel *RightLbl1;
@property (nonatomic , strong) UIImageView *videoMainImg;
@property (nonatomic , strong) UIImageView *carMainImg;
@property (nonatomic , strong) UIImageView *noMainImg;
@property (nonatomic , strong) UILabel *noLeftLbl;
@property (nonatomic , strong) UILabel *noRightLbl;
@property (nonatomic , strong) UIImageView *goodsMainImg;

@property(nonatomic,strong) LoadingView *loadingView;
@property(nonatomic,strong) InformationShowView *informationView;
@property(nonatomic,strong) UILabel *informationLabel;
@property(nonatomic,strong) LiveShowViewController  *LiveShowViewController;
@property(nonatomic,copy) NSString *liveIdStr;
// 直播
@property (nonatomic, assign) Boolean IsHorizontal;
// 分辨率
@property (nonatomic, assign) CGSize size;
// 码率
@property (nonatomic, assign) NSInteger bitRate;
// 帧率
@property (nonatomic, assign) NSInteger frameRate;
//技术论坛相关数据
@property (nonatomic,strong) NSMutableArray *techArr;
@property (nonatomic,strong) UIImageView *leftImg;
@property (nonatomic,strong) UILabel *LeftText;
@property (nonatomic,strong) UILabel *topiclbl0;
@property (nonatomic,strong) UILabel *topiclbl1;
@property (nonatomic,strong) UILabel *topiclbl2;
//车系数据
@property (nonatomic,strong) NSMutableArray *carStyleArr;
//直播课堂数据
@property (nonatomic,strong) NSMutableArray *liveClassArr;
//直播回放数据
@property (nonatomic,strong) NSMutableArray *backClassArr;
//直播回放数据
@property (nonatomic,strong) BFFourClassView *view0;
@property (nonatomic,strong) BFFourClassView *view1;
@property (nonatomic,strong) BFFourClassView *view2;
@property (nonatomic,strong) BFFourClassView *view3;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic,strong) BFSerCourseView *courseView0;
@property (nonatomic,strong) BFSerCourseView *courseView1;
@property (nonatomic,strong) BFSerCourseView *courseView2;
@property (nonatomic,strong) BFSerCourseView *courseView3;
@property (nonatomic,strong) BFSerCourseView *courseView4;
@property (nonatomic,strong) BFSerCourseView *courseView5;
@property (nonatomic,strong) BFSerCourseView *courseView6;
@property (nonatomic,strong) BFSerCourseView *courseView7;
@property (nonatomic,strong) UIImageView *serMainImg;
/*车人才数组*/
@property (nonatomic,strong) NSMutableArray *carTalentArr;
@property (nonatomic,strong) BFCarTalentView *carView0;
@property (nonatomic,strong) BFCarTalentView *carView1;
@property (strong, nonatomic)UIWindow *window;

/*汽车技术研究中心八组视频数据*/
@property (nonatomic,strong) BFCarCenterView *carView00;
@property (nonatomic,strong) BFCarCenterView *carView11;
@property (nonatomic,strong) BFCarCenterView *carView22;
@property (nonatomic,strong) BFCarCenterView *carView33;
@property (nonatomic,strong) BFCarCenterView *carView44;
@property (nonatomic,strong) BFCarCenterView *carView55;
@property (nonatomic,strong) BFCarCenterView *carView66;
@property (nonatomic,strong) BFCarCenterView *carView77;
/*汽车技术研究中心数组*/
@property (nonatomic,strong) NSMutableArray *carCenterArr;
@property (nonatomic,strong) NSMutableArray *btnMutableArray;


@property (nonatomic,strong) UILabel *xnyLbl;
@property (nonatomic,strong) UILabel *liveLbl;
@property (nonatomic,strong) UILabel *videoLbl;
@property (nonatomic,strong) UILabel *carLbl;
@property (nonatomic,strong) UILabel *noLbl;
@property (nonatomic,strong) UILabel *goodsLbl;
@end

@implementation BFLatestHomePageViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    //友盟统计 ---- 进入该页面
//    [MobClick beginLogPageView:@"首页"];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //友盟统计 ---- 离开该页面
//    [MobClick endLogPageView:@"首页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appDelegate = appDelegate;
    
    //创建ScrollView
    [self setUpScrollView];
    //创建顶部导航栏视图
    [self createNavgationView];
    //创建视图
    [self createInterface];
    
    // 直播相关数据初始化
    _IsHorizontal = YES;
    _size = CGSizeMake(540, 960);
    _frameRate = 20;
    _bitRate = 500.0;
    _isFirstLoad = true;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WatchLiveAction:) name:@"WatchLiveCourse" object:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CheckIsHaveLiveCourse" object:nil];
    });
    xilieCid = @"26";
    //首页banner的网络请求
    [self bannerNetwork];
    //推荐资讯的网络请求
    [self newsNetwork];
    //热门帖子的网络请求
    [self hotTipsNetwork];
    //首页六个视频的网络请求
    [self sixVideoNetwork];
    //技术论坛的网络请求
    [self TechTipNetwork];
    //车系网络请求
    [self carStyleNetwork];
    //直播课堂的网络请求
    [self liveClassNetwork];
    //系列课程网络请求
    [self xiliekechengNet:xilieCid];
    //中国汽车技术研究中心网络请求
    [self carCenterNetwork];
    //车人才网络请求
    [self CarTalentNetwork];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 创建首页整体ScrollView

-(void)setUpScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,100 , KScreenW, KScreenH - 100 )];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(KScreenW,2 * KScreenH);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = YES;
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
}

#pragma mark - 自定义顶部导航视图

-(void)createNavgationView {
    //背景View
    self.navView = [UIView new];
    self.navView.frame = CGRectMake(0, 0, KScreenW, 100 );
    self.navView.backgroundColor = RGBColor(0, 148, 231);
    [self.view addSubview:self.navView];
    //图片
    UIImageView *topImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 35, KScreenW - 200, 50)];
    self.topImage = topImage;
    topImage.contentMode = UIViewContentModeScaleToFill;
    topImage.image = [UIImage imageNamed:@"logo_默认状态"];
    [self.navView addSubview:topImage];
    //搜索按钮
    UIImageView *searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW - 20 - 14.5, 50, 20, 20)];
    self.searchImg = searchImg;
    searchImg.image = [UIImage imageNamed:@"搜索-默认状态"];
    searchImg.clipsToBounds = YES;
    searchImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *searchGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSearch)];
    [searchImg addGestureRecognizer:searchGes];
    [self.navView addSubview:searchImg];
    
    //客服按钮
    UIImageView *serviceImg = [[UIImageView alloc] initWithFrame:CGRectMake(14.5, 50, 20, 20)];
    self.serviceImg = serviceImg;
    serviceImg.image = [UIImage imageNamed:@"首页-客服-默认"];
    serviceImg.clipsToBounds = YES;
    serviceImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *serviceGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickService)];
    [serviceImg addGestureRecognizer:serviceGes];
    [self.navView addSubview:serviceImg];
}

-(void)clickSearch {
    CXSearchController *searchVC = [[CXSearchController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

-(void)clickService {
    
    NSString *qqNumber=@"2990233680";
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNumber]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        webView.delegate = self;
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"nil" message:@"对不起，您还没安装QQ" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
//    NSString *str = GetFromUserDefaults(@"loginStatus");
//    if ([str isEqualToString:@"1"]) { //用户已登录
////        BFChatViewController *chatVC = [BFChatViewController new];
////        [self.navigationController pushViewController:chatVC animated:YES];
//
//        //qqNumber就是你要打开的QQ号码， 也就是你的客服号码。
//
//
//
//    }
//    else {
//        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
//        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        [self presentViewController:navigation animated:YES completion:nil];
//    }
}

#pragma mark - 滑动视图让顶部导航栏进行缩放

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat hight = scrollView.frame.size.height;
    CGFloat contentOffset = scrollView.contentOffset.y;
    CGFloat distanceFromBottom = scrollView.contentSize.height - contentOffset;
    CGFloat offset = contentOffset - self.lastcontentOffset;
    self.lastcontentOffset = contentOffset;
    if (offset > 0 && contentOffset > 0) {
        NSLog(@"上拉行为");
        [UIView animateWithDuration:0.3 animations:^{
            self.navView.frame = CGRectMake(0, 0, KScreenW, 74 );
            self.topImage.frame = CGRectMake(100, 35, KScreenW - 200, 30 );
            self.topImage.image = [UIImage imageNamed:@"logo-滑动时状态"];
            self.searchImg.frame = CGRectMake(KScreenW - 20   - 14.5, 37 , 20  , 20 );
            self.searchImg.image = [UIImage imageNamed:@"搜索-滑动时样式"];
            self.serviceImg.frame = CGRectMake(14.5, 37 , 20  , 20 );
            self.serviceImg.image = [UIImage imageNamed:@"首页-客服-滑动时"];
            self.scrollView.frame = CGRectMake(0,74 , KScreenW, KScreenH - 74 );
            
        }];
    }
    if (offset < 0 && distanceFromBottom > hight) {
        
        NSLog(@"当前offset的值为:%f",offset);
        NSLog(@"下拉行为");
        
        
    }
    if (contentOffset == 0) {
        NSLog(@"滑动到顶部");
        [UIView animateWithDuration:0.3 animations:^{
            
            self.navView.frame = CGRectMake(0, 0, KScreenW, 100 );
            self.topImage.frame = CGRectMake(100, 35, KScreenW - 200, 50);
            self.topImage.image = [UIImage imageNamed:@"logo_默认状态"];
            
            self.searchImg.frame = CGRectMake(KScreenW - 20 - 14.5, 50, 20, 20);
            self.searchImg.image = [UIImage imageNamed:@"搜索-默认状态"];
            
            self.serviceImg.frame = CGRectMake(14.5, 50, 20, 20);
            self.serviceImg.image = [UIImage imageNamed:@"首页-客服-默认"];
            
            self.scrollView.frame = CGRectMake(0,100 , KScreenW, KScreenH - 100 );
        }];
        
        __weak typeof(self) weakSelf = self;
        self.scrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadNewData];
        }];
    }
    if (distanceFromBottom < hight) {
        NSLog(@"滑动到底部");
    }
}

-(void)loadNewData {
    //首页banner的网络请求
    [self bannerNetwork];
    //推荐资讯的网络请求
    [self newsNetwork];
    //热门帖子的网络请求
    [self hotTipsNetwork];
    //首页六个视频的网络请求
    [self sixVideoNetwork];
    //技术论坛的网络请求
    [self TechTipNetwork];
    //车系网络请求
    [self carStyleNetwork];
    //直播课堂的网络请求
    [self liveClassNetwork];
    //系列课程网络请求
    [self xiliekechengNet:xilieCid];
    //中国汽车技术研究中心网络请求
    [self carCenterNetwork];
    //车人才网络请求
    [self CarTalentNetwork];
    
    [self.scrollView.mj_header endRefreshing];
}

#pragma mark - 创建视图页面

-(void)createInterface {
    
#pragma mark - 顶部轮播图
    
    UIView *bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 180 )];
    bannerView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:bannerView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 180 )];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.isCarousel = YES;
    pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView.isOpenAutoScroll = YES;
    pageFlowView.leftRightMargin = 20;
    pageFlowView.userInteractionEnabled = NO;
    [pageFlowView reloadData];
    [bannerView addSubview:pageFlowView];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake((KScreenW-20)/2, 140 , 20, 20);
    _pageControl.numberOfPages = 4;
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];// 设置非选中页的圆点颜色
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor]; // 设置选中页的圆点颜色
    [self.scrollView addSubview:_pageControl];

    
#pragma mark - 合作平台内容
    
#pragma mark - 西安电大项目
    UIImageView *cooperationImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, bannerView.bottom, 17, 17)];
    cooperationImg.image = [UIImage imageNamed:@"合作icon"];
    [self.scrollView addSubview:cooperationImg];
    
    UILabel *cooLbl = [[UILabel alloc] initWithFrame:CGRectMake(cooperationImg.right + 6.5, bannerView.bottom - 1.5, 250, 20)];
    cooLbl.text = @"合作平台";
    cooLbl.textColor = RGBColor(51, 51, 51);
    cooLbl.font = [UIFont fontWithName:BFfont size:14];
    [self.scrollView addSubview:cooLbl];
    
    UIImageView *cooMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, cooperationImg.bottom + 8, KScreenW - 30, 108)];
    cooMainImg.image = [UIImage imageNamed:@"丝路学院"];
    cooMainImg.userInteractionEnabled = YES;
    cooMainImg.clipsToBounds = YES;
    UITapGestureRecognizer *cooGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCooAction)];
    [cooMainImg addGestureRecognizer:cooGes];
    [self.scrollView addSubview:cooMainImg];
    
#pragma mark - 长城网项目
    UIImageView *greatWallImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, cooMainImg.bottom, cooMainImg.width/2, 75)];
    greatWallImg.image = [UIImage imageNamed:@"八一通"];
    greatWallImg.userInteractionEnabled = YES;
    greatWallImg.clipsToBounds = YES;
    UITapGestureRecognizer *cooGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCooAction1)];
    [greatWallImg addGestureRecognizer:cooGes1];
    [self.scrollView addSubview:greatWallImg];
    
#pragma mark - 北方钓鱼台项目
    UIImageView *flyImg = [[UIImageView alloc] initWithFrame:CGRectMake(greatWallImg.right, cooMainImg.bottom, cooMainImg.width/2, 75)];
    flyImg.image = [UIImage imageNamed:@"北方钓鱼台"];
    flyImg.userInteractionEnabled = YES;
    flyImg.clipsToBounds = YES;
    UITapGestureRecognizer *cooGes2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCooAction2)];
    [flyImg addGestureRecognizer:cooGes2];
    [self.scrollView addSubview:flyImg];
    
#pragma mark - 大牛在线标题
    
    UIImageView *dnImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, greatWallImg.bottom + 10.5, 17  , 17 )];
    dnImg.image = [UIImage imageNamed:@"1大牛在线"];
    [self.scrollView addSubview:dnImg];
    
    UILabel *dnLbl = [[UILabel alloc] initWithFrame:CGRectMake(dnImg.right + 6.5, greatWallImg.bottom + 8.5, 250, 20 )];
    dnLbl.text = @"百位总监全程视频诊断修车";
    dnLbl.textColor = RGBColor(51, 51, 51);
    dnLbl.font = [UIFont fontWithName:BFfont size:14];
    [self.scrollView addSubview:dnLbl];

#pragma mark - 大牛在线图片
    
    UIImageView *dnMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, dnImg.bottom + 8, KScreenW, 168 )];
    dnMainImg.image = [UIImage imageNamed:@"1大牛在线banner"];
    dnMainImg.userInteractionEnabled = YES;
    dnMainImg.clipsToBounds = YES;
    dnMainImg.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDNAction)];
    [dnMainImg addGestureRecognizer:ges];
    [self.scrollView addSubview:dnMainImg];
    
#pragma mark - 新能源课堂
    
    UIImageView *xnyImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, dnMainImg.bottom + 10.5, 18  , 14  )];
    xnyImg.image = [UIImage imageNamed:@"新能源课堂"];
    [self.scrollView addSubview:xnyImg];
    
    UILabel *xnyLbl = [[UILabel alloc] initWithFrame:CGRectMake(xnyImg.right + 6.5, dnMainImg.bottom + 7.5, 150, 20 )];
    self.xnyLbl = xnyLbl;
    xnyLbl.text = @"汽车时讯";
    xnyLbl.textColor = RGBColor(51, 51, 51);
    xnyLbl.font = [UIFont fontWithName:BFfont size:14];
    [self.scrollView addSubview:xnyLbl];
    
    UIImageView *xnyMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, xnyImg.bottom + 15, (KScreenW - 45)/2, 97 )];
    self.xnyMainImg = xnyMainImg;
    xnyMainImg.image = PLACEHOLDER;
    xnyMainImg.userInteractionEnabled = YES;
    xnyMainImg.layer.cornerRadius = 5;
    xnyMainImg.clipsToBounds = YES;
    UITapGestureRecognizer *ges0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickXNYAction)];
    [xnyMainImg addGestureRecognizer:ges0];
    [self.scrollView addSubview:xnyMainImg];
    
    UIImageView *xnyShadowImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, xnyMainImg.bottom - 60, xnyMainImg.width, 60)];
    xnyShadowImg.image = [UIImage imageNamed:@"shadow"];
    xnyShadowImg.layer.cornerRadius = 5;
    xnyShadowImg.clipsToBounds = YES;
    [self.scrollView addSubview:xnyShadowImg];
    
//    UILabel *xnyLeftLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, xnyMainImg.bottom - 25, xnyMainImg.width/2 - 5, 25)];
     UILabel *xnyLeftLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, xnyMainImg.bottom - 25, xnyMainImg.width - 10, 25)];
    self.xnyLeftLbl = xnyLeftLbl;
    xnyLeftLbl.text = @"特斯拉视频";
    xnyLeftLbl.textColor = RGBColor(255, 255, 255);
    xnyLeftLbl.font = [UIFont fontWithName:BFfont size:10.0f];
    [self.scrollView addSubview:xnyLeftLbl];
    
    UILabel *xnyRightLbl = [[UILabel alloc] initWithFrame:CGRectMake(xnyLeftLbl.right, xnyMainImg.bottom - 25, xnyMainImg.width/2 - 5, 25)];
    self.xnyRightLbl = xnyRightLbl;
    xnyRightLbl.text = @"新能源系列";
    xnyRightLbl.textColor = RGBColor(255, 255, 255);
    xnyRightLbl.textAlignment = NSTextAlignmentRight;
    xnyRightLbl.font = [UIFont fontWithName:BFfont size:10.0f];
//    2018.6.25-xzj 新能源课堂修改
//    [self.scrollView addSubview:xnyRightLbl];

#pragma mark - 直播课堂
    
    UIImageView *liveImg = [[UIImageView alloc] initWithFrame:CGRectMake(xnyMainImg.right + 15, dnMainImg.bottom + 10.5, 18  , 14  )];
    liveImg.image = [UIImage imageNamed:@"直播课堂"];
    [self.scrollView addSubview:liveImg];
    
    UILabel *liveLbl = [[UILabel alloc] initWithFrame:CGRectMake(liveImg.right + 6.5, dnMainImg.bottom + 7.5, 150, 20 )];
    self.liveLbl = liveLbl;
    liveLbl.text = @"直播课堂";
    liveLbl.textColor = RGBColor(51, 51, 51);
    liveLbl.font = [UIFont fontWithName:BFfont size:14];
    [self.scrollView addSubview:liveLbl];
    
    UIImageView *liveMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(xnyMainImg.right + 15, liveImg.bottom + 15, (KScreenW - 45)/2, 97 )];
    self.liveMainImg = liveMainImg;
    liveMainImg.image = PLACEHOLDER;
    liveMainImg.userInteractionEnabled = YES;
    liveMainImg.clipsToBounds = YES;
    liveMainImg.layer.cornerRadius = 5;
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLiveAction)];
    [liveMainImg addGestureRecognizer:ges1];
    [self.scrollView addSubview:liveMainImg];
    
    liveNowImg = [[UIImageView alloc] initWithFrame:CGRectMake(liveMainImg.right - 5 - 60, liveImg.bottom + 25, 60, 18)];
    liveNowImg.image = [UIImage imageNamed:@"直播中"];
    [self.scrollView addSubview:liveNowImg];
    
    UIImageView *ShadowImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(xnyMainImg.right + 15, liveMainImg.bottom - 60, liveMainImg.width, 60)];
    ShadowImg1.image = [UIImage imageNamed:@"shadow"];
    ShadowImg1.layer.cornerRadius = 5;
    ShadowImg1.clipsToBounds = YES;
    [self.scrollView addSubview:ShadowImg1];
    
    UILabel *LeftLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(xnyMainImg.right + 20, liveMainImg.bottom - 25, liveMainImg.width/2 - 5, 25)];
    self.LeftLbl1 = LeftLbl1;
    LeftLbl1.text = @"看孙立伟老师如何进行汽车的拆解";
    LeftLbl1.textColor = RGBColor(255, 255, 255);
    LeftLbl1.font = [UIFont fontWithName:BFfont size:10.0f];
    [self.scrollView addSubview:LeftLbl1];
    
    UILabel *RightLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(LeftLbl1.right, liveMainImg.bottom - 25, liveMainImg.width/2 - 5, 25)];
    self.RightLbl1 = RightLbl1;
    RightLbl1.text = @"8月16日 14:30";
    RightLbl1.textColor = RGBColor(255, 255, 255);
    RightLbl1.textAlignment = NSTextAlignmentRight;
    RightLbl1.font = [UIFont fontWithName:BFfont size:10.0f];
    [self.scrollView addSubview:RightLbl1];
    
#pragma mark - 视频课堂
    
    UIImageView *videoImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, xnyMainImg.bottom + 14, 18  , 15  )];
    videoImg.image = [UIImage imageNamed:@"视频课堂"];
    [self.scrollView addSubview:videoImg];
    
    UILabel *videoLbl = [[UILabel alloc] initWithFrame:CGRectMake(videoImg.right + 6.5, xnyMainImg.bottom + 12, 150, 20 )];
    self.videoLbl = videoLbl;
    videoLbl.text = @"视频课堂";
    videoLbl.textColor = RGBColor(51, 51, 51);
    videoLbl.font = [UIFont fontWithName:BFfont size:14];
    [self.scrollView addSubview:videoLbl];
    
    UIImageView *videoMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, videoLbl.bottom + 15, (KScreenW - 45)/2, 97 )];
    self.videoMainImg = videoMainImg;
    videoMainImg.image = PLACEHOLDER;
    videoMainImg.userInteractionEnabled = YES;
    videoMainImg.layer.cornerRadius = 5;
    UITapGestureRecognizer *ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickVideoAction)];
    [videoMainImg addGestureRecognizer:ges2];
    [self.scrollView addSubview:videoMainImg];
    
#pragma mark - 车人才
    
    UIImageView *carImg = [[UIImageView alloc] initWithFrame:CGRectMake(videoMainImg.right + 15, liveMainImg.bottom + 15, 17.5  , 16 )];
    carImg.image = [UIImage imageNamed:@"车人才-2"];
    [self.scrollView addSubview:carImg];
    
    UILabel *carLbl = [[UILabel alloc] initWithFrame:CGRectMake(carImg.right + 6.5, liveMainImg.bottom + 12, 150, 20 )];
    self.carLbl = carLbl;
    carLbl.text = @"车人才";
    carLbl.textColor = RGBColor(51, 51, 51);
    carLbl.font = [UIFont fontWithName:BFfont size:14];
    [self.scrollView addSubview:carLbl];
    
    UIImageView *carMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(videoMainImg.right + 15, carLbl.bottom + 15, (KScreenW - 45)/2, 97 )];
    self.carMainImg = carMainImg;
    carMainImg.image = PLACEHOLDER;
    carMainImg.userInteractionEnabled = YES;
    carMainImg.layer.cornerRadius = 5;
    UITapGestureRecognizer *ges3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCarAction)];
    [carMainImg addGestureRecognizer:ges3];
    [self.scrollView addSubview:carMainImg];
    
#pragma mark - 无人驾驶课程
    
    UIImageView *noImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, videoMainImg.bottom + 15, 18  , 16 )];
    noImg.image = [UIImage imageNamed:@"无人驾驶课程"];
    [self.scrollView addSubview:noImg];
    
    UILabel *noLbl = [[UILabel alloc] initWithFrame:CGRectMake(noImg.right + 6.5, videoMainImg.bottom + 12, 150, 20 )];
    self.noLbl = noLbl;
    noLbl.text = @"无人驾驶课程";
    noLbl.textColor = RGBColor(51, 51, 51);
    noLbl.font = [UIFont fontWithName:BFfont size:14];
    [self.scrollView addSubview:noLbl];
    
    UIImageView *noMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, noLbl.bottom + 15, (KScreenW - 45)/2, 97 )];
    self.noMainImg = noMainImg;
    noMainImg.image = PLACEHOLDER;
    noMainImg.userInteractionEnabled = YES;
    noMainImg.layer.cornerRadius = 5;
    UITapGestureRecognizer *ges4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNoAction)];
    [noMainImg addGestureRecognizer:ges4];
    [self.scrollView addSubview:noMainImg];
    
    UIImageView *noShadowImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, noMainImg.bottom - 60, noMainImg.width, 60)];
    noShadowImg.image = [UIImage imageNamed:@"shadow"];
    noShadowImg.layer.cornerRadius = 5;
    noShadowImg.clipsToBounds = YES;
    [self.scrollView addSubview:noShadowImg];
    
    UILabel *noLeftLbl = [[UILabel alloc] initWithFrame:CGRectMake(20, noMainImg.bottom - 25, noMainImg.width/2 - 5, 25)];
    self.noLeftLbl = noLeftLbl;
    noLeftLbl.text = @"无人驾驶视频";
    noLeftLbl.textColor = RGBColor(255, 255, 255);
    noLeftLbl.font = [UIFont fontWithName:BFfont size:10.0f];
    [self.scrollView addSubview:noLeftLbl];
    
    UILabel *noRightLbl = [[UILabel alloc] initWithFrame:CGRectMake(noLeftLbl.right, noMainImg.bottom - 25, noMainImg.width/2 - 5, 25)];
    self.noRightLbl = noRightLbl;
    noRightLbl.text = @"无人驾驶系列";
    noRightLbl.textColor = RGBColor(255, 255, 255);
    noRightLbl.textAlignment = NSTextAlignmentRight;
    noRightLbl.font = [UIFont fontWithName:BFfont size:10.0f];
    [self.scrollView addSubview:noRightLbl];
    
    
#pragma mark - 汽配商务
    
    UIImageView *goodsImg = [[UIImageView alloc] initWithFrame:CGRectMake(noMainImg.right + 15, carMainImg.bottom + 15, 17.5  , 16 )];
    goodsImg.image = [UIImage imageNamed:@"汽配商务"];
    [self.scrollView addSubview:goodsImg];
    
    UILabel *goodsLbl = [[UILabel alloc] initWithFrame:CGRectMake(goodsImg.right + 6.5, carMainImg.bottom + 12, 150, 20 )];
    self.goodsLbl = goodsLbl;
    goodsLbl.text = @"汽配商务";
    goodsLbl.textColor = RGBColor(51, 51, 51);
    goodsLbl.font = [UIFont fontWithName:BFfont size:14];
    [self.scrollView addSubview:goodsLbl];
    
    UIImageView *goodsMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(noMainImg.right + 15, goodsLbl.bottom + 15, (KScreenW - 45)/2, 97 )];
    self.goodsMainImg = goodsMainImg;
    goodsMainImg.image = PLACEHOLDER;
    goodsMainImg.userInteractionEnabled = YES;
    goodsMainImg.layer.cornerRadius = 5;
    UITapGestureRecognizer *ges5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickGoodsAction)];
    [goodsMainImg addGestureRecognizer:ges5];
    [self.scrollView addSubview:goodsMainImg];
    
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, goodsMainImg.bottom + 15, KScreenW, 10.0f)];
    line0.backgroundColor = GroundGraryColor;
    [self.scrollView addSubview:line0];
    
#pragma mark - 技术论坛标题
    
    UIImageView *topicImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, line0.bottom + 15, 18   , 17 )];
    topicImg.image = [UIImage imageNamed:@"技术论坛"];
    [self.scrollView addSubview:topicImg];
    
    UILabel *topicLbl = [[UILabel alloc] initWithFrame:CGRectMake(topicImg.right + 6.5, line0.bottom + 13.5, 200, 20 )];
    topicLbl.text = @"技术论坛";
    topicLbl.textColor = RGBColor(51, 51, 51);
    topicLbl.font = [UIFont fontWithName:BFfont size:14];
    [self.scrollView addSubview:topicLbl];
    
    UILabel *moreLbl0 = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW - 40 - 15, line0.bottom + 13.5, 40, 20 )];
    moreLbl0.text = @"更多 >";
    moreLbl0.userInteractionEnabled = YES;
    moreLbl0.clipsToBounds = YES;
    UITapGestureRecognizer *ges6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMore0Action)];
    [moreLbl0 addGestureRecognizer:ges6];
    moreLbl0.textColor = RGBColor(153, 153, 153);
    moreLbl0.font = [UIFont fontWithName:BFfont size:13.0f];
    [self.scrollView addSubview:moreLbl0];
    
#pragma mark - 技术论坛内容
    
    UIImageView *leftImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, topicLbl.bottom + 15, 135   , 85 )];
    self.leftImg = leftImg;
    leftImg.image = [UIImage imageNamed:@"1banner"];
    leftImg.userInteractionEnabled = YES;
    leftImg.clipsToBounds = YES;
    UITapGestureRecognizer *ges7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTechTopic0Action)];
    [leftImg addGestureRecognizer:ges7];
    leftImg.layer.cornerRadius = 6.0f;
    [self.scrollView addSubview:leftImg];
    
    UIImageView *leftShadowImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, leftImg.bottom - 60, leftImg.width, 60)];
    leftShadowImg.image = [UIImage imageNamed:@"shadow"];
    leftShadowImg.layer.cornerRadius = 5;
    leftShadowImg.clipsToBounds = YES;
    [self.scrollView addSubview:leftShadowImg];
    
    UILabel *LeftText = [[UILabel alloc] initWithFrame:CGRectMake(20, leftImg.bottom - 25, leftImg.width - 10, 25)];
    self.LeftText = LeftText;
    LeftText.text = @"无人驾驶视频";
    LeftText.textColor = RGBColor(255, 255, 255);
    LeftText.font = [UIFont fontWithName:BFfont size:10.0f];
    [self.scrollView addSubview:LeftText];
    
    
    UILabel *topiclbl0 = [[UILabel alloc] initWithFrame:CGRectMake(leftImg.right + 10, topicImg.bottom + 20, KScreenW - leftImg.right - 10 - 15, 12.5 )];
    self.topiclbl0 = topiclbl0;
    topiclbl0.text = @"教育部部长视察北方学校，并给出高度评价.他们指出";
    topiclbl0.textColor = RGBColor(0, 0, 0);
    topiclbl0.font = [UIFont fontWithName:BFfont size:12.0f];
    topiclbl0.clipsToBounds = YES;
    topiclbl0.userInteractionEnabled = YES;
    UITapGestureRecognizer *topic0ActionGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTechTopic0Action)];
    [topiclbl0 addGestureRecognizer:topic0ActionGes];
    [self.scrollView addSubview:topiclbl0];
    
    UILabel *topiclbl1 = [[UILabel alloc] initWithFrame:CGRectMake(leftImg.right + 10, topiclbl0.bottom + 18.5 , KScreenW - leftImg.right - 10 - 15, 12.5 )];
    self.topiclbl1 = topiclbl1;
    topiclbl1.text = @"5年后,800万汽修工将骤减到100万!";
    topiclbl1.textColor = RGBColor(0, 0, 0);
    topiclbl1.font = [UIFont fontWithName:BFfont size:12.0f];
    topiclbl1.clipsToBounds = YES;
    topiclbl1.userInteractionEnabled = YES;
    UITapGestureRecognizer *topic1ActionGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTechTopic1Action)];
    [topiclbl1 addGestureRecognizer:topic1ActionGes];
    [self.scrollView addSubview:topiclbl1];
    
    UILabel *topiclbl2 = [[UILabel alloc] initWithFrame:CGRectMake(leftImg.right + 10, topiclbl1.bottom + 18.5 , KScreenW - leftImg.right - 10 - 15, 12.5 )];
    self.topiclbl2 = topiclbl2;
    topiclbl2.text = @"震惊!你所不知道的汽修行业大起底!";
    topiclbl2.textColor = RGBColor(0, 0, 0);
    topiclbl2.font = [UIFont fontWithName:BFfont size:12.0f];
    topiclbl2.clipsToBounds = YES;
    topiclbl2.userInteractionEnabled = YES;
    UITapGestureRecognizer *topic2ActionGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTechTopic2Action)];
    [topiclbl2 addGestureRecognizer:topic2ActionGes];
    [self.scrollView addSubview:topiclbl2];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, leftImg.bottom + 15, KScreenW, 10.0f)];
    line1.backgroundColor = GroundGraryColor;
    [self.scrollView addSubview:line1];
    
#pragma mark - 原厂资料标题
    
    UIImageView *dataImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, line1.bottom + 15, 14  , 16 )];
    dataImg.image = [UIImage imageNamed:@"原厂资料"];
    [self.scrollView addSubview:dataImg];
    
    UILabel *dataLbl = [[UILabel alloc] initWithFrame:CGRectMake(dataImg.right + 6.5, line1.bottom + 13, 200, 20 )];
    dataLbl.text = @"原厂资料";
    dataLbl.textColor = RGBColor(51, 51, 51);
    dataLbl.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.scrollView addSubview:dataLbl];

#pragma mark - 原厂资料标题
    
    UIImageView *dataMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(2, dataLbl.bottom, KScreenW - 4, 130 )];
    dataMainImg.image = [UIImage imageNamed:@"原厂资料banner"];
    dataMainImg.contentMode = UIViewContentModeScaleAspectFit;
    dataMainImg.clipsToBounds = YES;
    [self.scrollView addSubview:dataMainImg];
    
#pragma mark - 百位总监全程视频诊断修车标题
    
    UIImageView *repairImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, dataMainImg.bottom + 15, 14  , 16 )];
    repairImg.image = [UIImage imageNamed:@"1大牛在线"];
    [self.scrollView addSubview:repairImg];
    
    UILabel *repairLbl = [[UILabel alloc] initWithFrame:CGRectMake(repairImg.right + 6.5, dataMainImg.bottom + 13, KScreenW - 30 - 40, 20 )];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"百位总监全程视频诊断修车 | Online"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(51, 51, 51)
                          range:NSMakeRange(0,12)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(204, 204, 204)
                          range:NSMakeRange(12,9)];
    [AttributedStr addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:15.0]
                          range:NSMakeRange(0,12)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:13.0]
                          range:NSMakeRange(12,9)];
    repairLbl.attributedText = AttributedStr;
    [self.scrollView addSubview:repairLbl];
    
//    UILabel *moreLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW - 40 - 15, dataMainImg.bottom + 15, 40, 17 )];
//    moreLbl1.text = @"更多 >";
//    UITapGestureRecognizer *ges8 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMore1Action)];
//    [moreLbl1 addGestureRecognizer:ges8];
//    moreLbl1.textColor = RGBColor(153, 153, 153);
//    moreLbl1.font = [UIFont fontWithName:BFfont size:13.0f];
//    [self.scrollView addSubview:moreLbl1];
    
#pragma mark - 百位总监全程视频诊断修车内容
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //2.初始化collectionView
    collectionView0 = [[UICollectionView alloc] initWithFrame:CGRectMake(0, repairLbl.bottom + 15, KScreenW, 320 ) collectionViewLayout:layout];
    [self.scrollView addSubview:collectionView0];
    collectionView0.backgroundColor = GroundGraryColor;
    //3.注册collectionViewCell
    [collectionView0 registerClass:[BFMiddleCollectionCell class] forCellWithReuseIdentifier:@"cellId"];
    //4.设置代理
    collectionView0.delegate = self;
    collectionView0.dataSource = self;
    
#pragma mark - 直播课堂标题
    
    UIImageView *newLiveImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, collectionView0.bottom + 15, 18  , 16 )];
    newLiveImg.image = [UIImage imageNamed:@"直播课堂"];
    [self.scrollView addSubview:newLiveImg];
    
    UILabel *newLiveLbl = [[UILabel alloc] initWithFrame:CGRectMake(repairImg.right + 6.5, collectionView0.bottom + 13, KScreenW - 30 - 40, 20 )];
    NSMutableAttributedString *AttributedStr1 = [[NSMutableAttributedString alloc]initWithString:@"直播课堂 | Live Broadcast"];
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(51, 51, 51)
                          range:NSMakeRange(0,4)];
    [AttributedStr1 addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(204, 204, 204)
                          range:NSMakeRange(4,17)];
    [AttributedStr1 addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:15.0]
                          range:NSMakeRange(0,4)];
    [AttributedStr1 addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:13.0]
                          range:NSMakeRange(4,17)];
    newLiveLbl.attributedText = AttributedStr1;
    [self.scrollView addSubview:newLiveLbl];
    
    UILabel *backLbl = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW - 80 - 15, collectionView0.bottom + 15, 80, 17 )];
    backLbl.text = @"回放 >";
    backLbl.userInteractionEnabled = YES;
    backLbl.textAlignment = NSTextAlignmentRight;
    UITapGestureRecognizer *ges9 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBackAction)];
    [backLbl addGestureRecognizer:ges9];
    backLbl.textColor = RGBColor(153, 153, 153);
    backLbl.font = [UIFont fontWithName:BFfont size:13.0f];
    [self.scrollView addSubview:backLbl];
    
#pragma mark - 直播课堂内容
    
    UIView *liveView = [[UIView alloc] initWithFrame:CGRectMake(0, newLiveLbl.bottom + 15, KScreenW, 161.5 )];
    liveView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:liveView];
    pageFlowView1 = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 161.5 )];
    pageFlowView1.delegate = self;
    pageFlowView1.dataSource = self;
    pageFlowView1.isCarousel = YES;
    pageFlowView1.orientation = NewPagedFlowViewOrientationHorizontal;
    pageFlowView1.isOpenAutoScroll = YES;
    pageFlowView1.leftRightMargin = 20;
    pageFlowView1.pageControl.numberOfPages = 4;
    [pageFlowView1 reloadData];
    [liveView addSubview:pageFlowView1];
    
    #define imgWidth (KScreenW - 15 * 3)/2
    
    BFFourClassView *view0 = [[BFFourClassView alloc] initWithFrame:CGRectMake(15, liveView.bottom + 15, imgWidth, 163)];
    self.view0 = view0;
    view0.userInteractionEnabled = YES;
    view0.clipsToBounds = YES;
    UITapGestureRecognizer *gesClass0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClass1Action)];
    [view0 addGestureRecognizer:gesClass0];
    [self.scrollView addSubview:view0];
    
    BFFourClassView *view1 = [[BFFourClassView alloc] initWithFrame:CGRectMake(15 * 2 + imgWidth, liveView.bottom + 15, imgWidth, 163)];
    self.view1 = view1;
    view1.userInteractionEnabled = YES;
    view1.clipsToBounds = YES;
    UITapGestureRecognizer *gesClass1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClass2Action)];
    [view1 addGestureRecognizer:gesClass1];
    [self.scrollView addSubview:view1];

    BFFourClassView *view2 = [[BFFourClassView alloc] initWithFrame:CGRectMake(15, view0.bottom + 15, imgWidth, 163)];
    self.view2 = view2;
    view2.userInteractionEnabled = YES;
    view2.clipsToBounds = YES;
    UITapGestureRecognizer *gesClass2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClass3Action)];
    [view2 addGestureRecognizer:gesClass2];
    [self.scrollView addSubview:view2];

    BFFourClassView *view3 = [[BFFourClassView alloc] initWithFrame:CGRectMake(15 * 2 + imgWidth, view1.bottom + 15, imgWidth, 163)];
    self.view3 = view3;
    view3.userInteractionEnabled = YES;
    view3.clipsToBounds = YES;
    UITapGestureRecognizer *gesClass3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickClass4Action)];
    [view3 addGestureRecognizer:gesClass3];
    [self.scrollView addSubview:view3];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, view3.bottom + 15, KScreenW, 10.0f)];
    line2.backgroundColor = GroundGraryColor;
    [self.scrollView addSubview:line2];
    
#pragma mark - 系列课程标题

    UIImageView *serImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, line2.bottom + 14, 16  , 17 )];
    serImg.image = [UIImage imageNamed:@"1无人驾驶课程"];
    [self.scrollView addSubview:serImg];
    
    UILabel *serLbl = [[UILabel alloc] initWithFrame:CGRectMake(serImg.right + 6.5, line2.bottom + 13, KScreenW - 30 - 40, 20 )];
    NSMutableAttributedString *AttributedS = [[NSMutableAttributedString alloc]initWithString:@"系列课程 | Series Courses"];
    [AttributedS addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(51, 51, 51)
                           range:NSMakeRange(0,4)];
    [AttributedS addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(204, 204, 204)
                           range:NSMakeRange(4,17)];
    [AttributedS addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:15.0]
                           range:NSMakeRange(0,4)];
    [AttributedS addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:13.0]
                           range:NSMakeRange(4,17)];
    serLbl.attributedText = AttributedS;
    [self.scrollView addSubview:serLbl];
    
#pragma mark - 系列课程内容
    
    //创建横向滑动scrollView
    self.scrollViewBtn = [[UIScrollView alloc] initWithFrame:CGRectMake(0,serLbl.bottom + 15, KScreenW, 30 )];
    self.scrollViewBtn.backgroundColor = [UIColor whiteColor];
    self.scrollViewBtn.contentSize = CGSizeMake(2 * KScreenW,30);
    self.scrollViewBtn.backgroundColor = [UIColor whiteColor];
    self.scrollViewBtn.showsHorizontalScrollIndicator = NO;
    self.scrollViewBtn.bounces = YES;
    self.scrollViewBtn.delegate = self;
    self.scrollViewBtn.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.scrollViewBtn];
    NSArray *titleArr = @[@"故障案例类",@"电动汽车",@"混动汽车",@"奔宝奥系列",@"精品车型",@"高端车型",@"汽修基础",@"特色经典"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn = btn;
        btn.frame = CGRectMake(80*i + 15*(i+1), 0, 80, 30);
        NSString *str = [NSString stringWithFormat:@"%@",titleArr[i]];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:BFfont size:13.0f];
        if (i == 0) {
            [btn setTitleColor:RGBColor(51, 150, 252) forState:UIControlStateNormal];
            [btn setBackgroundColor:RGBColor(239,247,255)];
        }
        else {
            [btn setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
            [btn setBackgroundColor:RGBColor(247,249,251)];
        }
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 15.0f;
        if (i == 0) {
            btn.tag = 26;
        }
        else if (i == 1) {
            btn.tag = 18;
        }
        else if (i == 2) {
            btn.tag = 19;
        }
        else if (i == 3) {
            btn.tag = 29;
        }
        else if (i == 4) {
            btn.tag = 17;
        }
        else if (i == 5) {
            btn.tag = 30;
        }
        else if (i == 6) {
            btn.tag = 28;
        }
        else if (i == 7) {
            btn.tag = 25;
        }
        [self.btnMutableArray addObject:btn];
        [btn addTarget:self action:@selector(clickChooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollViewBtn addSubview:btn];
        self.scrollViewBtn.contentSize = CGSizeMake(80*(i+1) + 15*(i+2),30);
    }
    
    UIImageView *serMainImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, self.scrollViewBtn.bottom + 15, KScreenW - 30, 150 )];
    self.serMainImg = serMainImg;
    serMainImg.layer.cornerRadius = 3.0f;
    serMainImg.clipsToBounds = YES;
    [self.scrollView addSubview:serMainImg];
    
    self.scrollViewSer = [[UIScrollView alloc] initWithFrame:CGRectMake(0,serMainImg.bottom + 15, KScreenW, 325 )];
    self.scrollViewSer.backgroundColor = [UIColor whiteColor];
    self.scrollViewSer.contentSize = CGSizeMake(575  ,325 );
    self.scrollViewSer.backgroundColor = [UIColor whiteColor];
    self.scrollViewSer.showsHorizontalScrollIndicator = NO;
    self.scrollViewSer.bounces = YES;
    self.scrollViewSer.delegate = self;
    self.scrollViewSer.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.scrollViewSer];
    
    BFSerCourseView *courseView0 = [[BFSerCourseView alloc] initWithFrame:CGRectMake(0, 0, 125  , 155 )];
    self.courseView0 = courseView0;
    courseView0.userInteractionEnabled = YES;
    UITapGestureRecognizer *courseGes0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCourse0Action)];
    [courseView0 addGestureRecognizer:courseGes0];
    [self.scrollViewSer addSubview:courseView0];
    
    BFSerCourseView *courseView1 = [[BFSerCourseView alloc] initWithFrame:CGRectMake(courseView0.right + 15, 0, 125  , 155 )];
    self.courseView1 = courseView1;
    courseView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *courseGes1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCourse1Action)];
    [courseView1 addGestureRecognizer:courseGes1];
    [self.scrollViewSer addSubview:courseView1];
    
    BFSerCourseView *courseView2 = [[BFSerCourseView alloc] initWithFrame:CGRectMake(courseView1.right + 15, 0, 125  , 155 )];
    self.courseView2 = courseView2;
    courseView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *courseGes2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCourse2Action)];
    [courseView2 addGestureRecognizer:courseGes2];
    [self.scrollViewSer addSubview:courseView2];
    
    BFSerCourseView *courseView3 = [[BFSerCourseView alloc] initWithFrame:CGRectMake(courseView2.right + 15, 0, 125  , 155 )];
    self.courseView3 = courseView3;
    courseView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *courseGes3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCourse3Action)];
    [courseView3 addGestureRecognizer:courseGes3];
    [self.scrollViewSer addSubview:courseView3];
    
    BFSerCourseView *courseView4 = [[BFSerCourseView alloc] initWithFrame:CGRectMake(0, courseView0.bottom + 15, 125  , 155 )];
    self.courseView4 = courseView4;
    courseView4.userInteractionEnabled = YES;
    UITapGestureRecognizer *courseGes4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCourse4Action)];
    [courseView4 addGestureRecognizer:courseGes4];
    [self.scrollViewSer addSubview:courseView4];
    
    BFSerCourseView *courseView5 = [[BFSerCourseView alloc] initWithFrame:CGRectMake(courseView4.right + 15, courseView1.bottom + 15, 125  , 155 )];
    self.courseView5 = courseView5;
    courseView5.userInteractionEnabled = YES;
    UITapGestureRecognizer *courseGes5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCourse5Action)];
    [courseView5 addGestureRecognizer:courseGes5];
    [self.scrollViewSer addSubview:courseView5];
    
    BFSerCourseView *courseView6 = [[BFSerCourseView alloc] initWithFrame:CGRectMake(courseView5.right + 15, courseView2.bottom + 15, 125  , 155 )];
    self.courseView6 = courseView6;
    courseView6.userInteractionEnabled = YES;
    UITapGestureRecognizer *courseGes6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCourse6Action)];
    [courseView6 addGestureRecognizer:courseGes6];
    [self.scrollViewSer addSubview:courseView6];
    
    BFSerCourseView *courseView7 = [[BFSerCourseView alloc] initWithFrame:CGRectMake(courseView6.right + 15, courseView3.bottom + 15, 125  , 155 )];
    self.courseView7 = courseView7;
    courseView7.userInteractionEnabled = YES;
    UITapGestureRecognizer *courseGes7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCourse7Action)];
    [courseView7 addGestureRecognizer:courseGes7];
    [self.scrollViewSer addSubview:courseView7];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollViewSer.bottom + 15, KScreenW, 10.0f)];
    line3.backgroundColor = GroundGraryColor;
    [self.scrollView addSubview:line3];
    
#pragma mark - 车人才
    
    UIImageView *carTalImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, line3.bottom + 15, 20  , 16 )];
    carTalImg.image = [UIImage imageNamed:@"车人才-2"];
    [self.scrollView addSubview:carTalImg];
    
    UILabel *carTalLbl = [[UILabel alloc] initWithFrame:CGRectMake(carTalImg.right + 6.5, line3.bottom + 13, KScreenW - 30 - 40, 20 )];
    NSMutableAttributedString *AttributedStr2 = [[NSMutableAttributedString alloc]initWithString:@"车人才 | Recruits"];
    [AttributedStr2 addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(51, 51, 51)
                           range:NSMakeRange(0,3)];
    [AttributedStr2 addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(204, 204, 204)
                           range:NSMakeRange(4,10)];
    [AttributedStr2 addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:15.0]
                           range:NSMakeRange(0,3)];
    [AttributedStr2 addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:13.0]
                           range:NSMakeRange(4,10)];
    carTalLbl.attributedText = AttributedStr2;
    [self.scrollView addSubview:carTalLbl];
    
    UILabel *moreLbl2 = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW - 40 - 15, line3.bottom + 13.5, 40, 20 )];
    moreLbl2.text = @"更多 >";
    moreLbl2.userInteractionEnabled = YES;
    moreLbl2.clipsToBounds = YES;
    UITapGestureRecognizer *ges10 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMore2Action)];
    [moreLbl2 addGestureRecognizer:ges10];
    moreLbl2.textColor = RGBColor(153, 153, 153);
    moreLbl2.font = [UIFont fontWithName:BFfont size:13.0f];
    [self.scrollView addSubview:moreLbl2];
    
    BFCarTalentView *carView0 = [[BFCarTalentView alloc] initWithFrame:CGRectMake(0, carTalLbl.bottom + 15, KScreenW, 125 )];
    self.carView0 = carView0;
    carView0.userInteractionEnabled = YES;
    UITapGestureRecognizer *carG0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCarTalent0Action)];
    [carView0 addGestureRecognizer:carG0];
    [self.scrollView addSubview:carView0];
    
    BFCarTalentView *carView1 = [[BFCarTalentView alloc] initWithFrame:CGRectMake(0, carView0.bottom, KScreenW, 125 )];
    self.carView1 = carView1;
    carView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *carG1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCarTalent1Action)];
    [carView1 addGestureRecognizer:carG1];
    [self.scrollView addSubview:carView1];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, carView1.bottom, KScreenW, 10.0f)];
    line4.backgroundColor = GroundGraryColor;
    [self.scrollView addSubview:line4];
    
    
#pragma mark - 技术论坛标题

    UIImageView *techImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, line4.bottom + 15, 18  , 16 )];
    techImg.image = [UIImage imageNamed:@"技术论坛"];
    [self.scrollView addSubview:techImg];
    
    UILabel *techLbl = [[UILabel alloc] initWithFrame:CGRectMake(techImg.right + 6.5, line4.bottom + 13, KScreenW - 30 - 40, 20 )];
    NSMutableAttributedString *AttributedStr3 = [[NSMutableAttributedString alloc]initWithString:@"技术论坛 | Hot Post"];
    [AttributedStr3 addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(51, 51, 51)
                           range:NSMakeRange(0,4)];
    [AttributedStr3 addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(204, 204, 204)
                           range:NSMakeRange(4,11)];
    [AttributedStr3 addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:15.0]
                           range:NSMakeRange(0,4)];
    [AttributedStr3 addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:13.0]
                           range:NSMakeRange(4,11)];
    techLbl.attributedText = AttributedStr3;
    [self.scrollView addSubview:techLbl];
    
    UILabel *moreLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW - 40 - 15, line4.bottom + 13.5, 40, 20 )];
    moreLbl3.text = @"更多 >";
    moreLbl3.userInteractionEnabled = YES;
    moreLbl3.clipsToBounds = YES;
    UITapGestureRecognizer *ges11 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMore3Action)];
    [moreLbl3 addGestureRecognizer:ges11];
    moreLbl3.textColor = RGBColor(153, 153, 153);
    moreLbl3.font = [UIFont fontWithName:BFfont size:13.0f];
    [self.scrollView addSubview:moreLbl3];
    
#pragma mark - 技术论坛内容
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, techLbl.bottom, KScreenW, 133 * 3  + 306.5 ) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[BFTipsCell class] forCellReuseIdentifier:@"tipCell"];
    [self.tableView registerClass:[BFTipTopCell class] forCellReuseIdentifier:@"tipTopCell"];
    [self.scrollView addSubview:self.tableView];
    
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, KScreenW, 10.0f)];
    line5.backgroundColor = GroundGraryColor;
    [self.scrollView addSubview:line5];
    
#pragma mark - 原厂资料
    
    UIImageView *dataImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, line5.bottom + 15, 15  , 17 )];
    dataImg1.image = [UIImage imageNamed:@"原厂资料"];
    [self.scrollView addSubview:dataImg1];
    
    UILabel *dataLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(dataImg1.right + 6.5, line5.bottom + 13.5, KScreenW - 30 - 40, 20 )];
    NSMutableAttributedString *AttributedStrData = [[NSMutableAttributedString alloc]initWithString:@"原厂资料 | Data Download"];
    [AttributedStrData addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(51, 51, 51)
                           range:NSMakeRange(0,4)];
    [AttributedStrData addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(204, 204, 204)
                           range:NSMakeRange(4,16)];
    [AttributedStrData addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:15.0]
                           range:NSMakeRange(0,4)];
    [AttributedStrData addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:13.0]
                           range:NSMakeRange(4,16)];
    dataLbl1.attributedText = AttributedStrData;
    [self.scrollView addSubview:dataLbl1];
    
#pragma mark - 原厂资料内容
    
    self.scrollViewData = [[UIScrollView alloc] initWithFrame:CGRectMake(0,dataLbl1.bottom + 15, KScreenW, 248.5 )];
    self.scrollViewData.backgroundColor = [UIColor whiteColor];
    self.scrollViewData.contentSize = CGSizeMake(1031  ,248.5 );
    self.scrollViewData.backgroundColor = [UIColor whiteColor];
    self.scrollViewData.showsHorizontalScrollIndicator = NO;
    self.scrollViewData.bounces = YES;
    self.scrollViewData.delegate = self;
    self.scrollViewData.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.scrollViewData];
    //
    BFDataView *dataView0 = [[BFDataView alloc] initWithFrame:CGRectMake(15, 15, 112  , 248.5 )];
    dataView0.dataImage.image = [UIImage imageNamed:@"奥迪网络结构"];
    dataView0.dataTitle.text = @"奥迪网络结构";
    UITapGestureRecognizer *dataG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDownload0Action)];
    [dataView0.download addGestureRecognizer:dataG];
    [self.scrollViewData addSubview:dataView0];
    //
    BFDataView *dataView1 = [[BFDataView alloc] initWithFrame:CGRectMake(dataView0.right + 15, 15, 112  , 248.5 )];
    dataView1.dataImage.image = [UIImage imageNamed:@"宝马后座区娱乐系统"];
    dataView1.dataTitle.text = @"宝马后座区娱乐系统";
    UITapGestureRecognizer *dataG1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDownload1Action)];
    [dataView1.download addGestureRecognizer:dataG1];
    [self.scrollViewData addSubview:dataView1];
    //
    BFDataView *dataView2 = [[BFDataView alloc] initWithFrame:CGRectMake(dataView1.right + 15, 15, 112  , 248.5 )];
    dataView2.dataImage.image = [UIImage imageNamed:@"奔驰E系原厂维修手册"];
    dataView2.dataTitle.text = @"奔驰E系原厂维修手册";
    UITapGestureRecognizer *dataG2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDownload2Action)];
    [dataView2.download addGestureRecognizer:dataG2];
    [self.scrollViewData addSubview:dataView2];
    //
    BFDataView *dataView3 = [[BFDataView alloc] initWithFrame:CGRectMake(dataView2.right + 15, 15, 112  , 248.5 )];
    dataView3.dataImage.image = [UIImage imageNamed:@"本田雅阁电路图"];
    dataView3.dataTitle.text = @"本田雅阁电路图";
    UITapGestureRecognizer *dataG3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDownload3Action)];
    [dataView3.download addGestureRecognizer:dataG3];
    [self.scrollViewData addSubview:dataView3];
    //
    BFDataView *dataView4 = [[BFDataView alloc] initWithFrame:CGRectMake(dataView3.right + 15, 15, 112  , 248.5 )];
    dataView4.dataImage.image = [UIImage imageNamed:@"比亚迪·秦HA-高压部分"];
    dataView4.dataTitle.text = @"比亚迪·秦HA-高压部分";
    UITapGestureRecognizer *dataG4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDownload4Action)];
    [dataView4.download addGestureRecognizer:dataG4];
    [self.scrollViewData addSubview:dataView4];
    //
    BFDataView *dataView5 = [[BFDataView alloc] initWithFrame:CGRectMake(dataView4.right + 15, 15, 112  , 248.5 )];
    dataView5.dataImage.image = [UIImage imageNamed:@"广汽传祺GS8原厂电路图"];
    dataView5.dataTitle.text = @"广汽传祺GS8原厂电路图";
    UITapGestureRecognizer *dataG5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDownload5Action)];
    [dataView5.download addGestureRecognizer:dataG5];
    [self.scrollViewData addSubview:dataView5];
    
    BFDataView *dataView6 = [[BFDataView alloc] initWithFrame:CGRectMake(dataView5.right + 15, 15, 112  , 248.5 )];
    dataView6.dataImage.image = [UIImage imageNamed:@"哈弗H6原厂电路图"];
    dataView6.dataTitle.text = @"哈弗H6原厂电路图";
    UITapGestureRecognizer *dataG6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDownload6Action)];
    [dataView6.download addGestureRecognizer:dataG6];
    [self.scrollViewData addSubview:dataView6];
    
    BFDataView *dataView7 = [[BFDataView alloc] initWithFrame:CGRectMake(dataView6.right + 15, 15, 112  , 248.5 )];
    dataView7.dataImage.image = [UIImage imageNamed:@"上海大众途昂电器位置图"];
    dataView7.dataTitle.text = @"上海大众途昂电器位置图";
    UITapGestureRecognizer *dataG7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDownload7Action)];
    [dataView7.download addGestureRecognizer:dataG7];
    [self.scrollViewData addSubview:dataView7];
    
    UIView *line6 = [[UIView alloc] initWithFrame:CGRectMake(0, self.scrollViewData.bottom + 15, KScreenW, 10.0f)];
    line6.backgroundColor = GroundGraryColor;
    [self.scrollView addSubview:line6];
    
#pragma mark - 中国汽车技术研究中心标题
    
    UIImageView *zbImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, line6.bottom + 17.5, 24  , 11 )];
    zbImg.image = [UIImage imageNamed:@"中国汽车技术研究中心"];
    [self.scrollView addSubview:zbImg];
    
    UILabel *zbLbl = [[UILabel alloc] initWithFrame:CGRectMake(zbImg.right + 6.5, line6.bottom + 13, KScreenW - 30 - 40, 20 )];
    NSMutableAttributedString *AttributedStr4 = [[NSMutableAttributedString alloc]initWithString:@"中国汽车技术研究中心 | Research Center"];
    [AttributedStr4 addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(51, 51, 51)
                           range:NSMakeRange(0,10)];
    [AttributedStr4 addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(204, 204, 204)
                           range:NSMakeRange(10,18)];
    [AttributedStr4 addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:15.0]
                           range:NSMakeRange(0,10)];
    [AttributedStr4 addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:13.0]
                           range:NSMakeRange(10,18)];
    zbLbl.attributedText = AttributedStr4;
    [self.scrollView addSubview:zbLbl];
    
#pragma mark - 中国汽车技术研究中心四组视频
    
    BFCarCenterView *carView00 = [[BFCarCenterView alloc] initWithFrame:CGRectMake(15, zbLbl.bottom + 15, imgWidth, 146 )];
    self.carView00 = carView00;
    carView00.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesCar0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCar0Action)];
    [carView00 addGestureRecognizer:gesCar0];
    [self.scrollView addSubview:carView00];
    
    BFCarCenterView *carView11 = [[BFCarCenterView alloc] initWithFrame:CGRectMake(15 * 2 + imgWidth, zbLbl.bottom + 15, imgWidth, 146 )];
    self.carView11 = carView11;
    carView11.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesCar1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCar1Action)];
    [carView11 addGestureRecognizer:gesCar1];
    [self.scrollView addSubview:carView11];
    
    BFCarCenterView *carView22 = [[BFCarCenterView alloc] initWithFrame:CGRectMake(15, carView00.bottom + 15, imgWidth, 146 )];
    self.carView22 = carView22;
    carView22.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesCar2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCar2Action)];
    [carView22 addGestureRecognizer:gesCar2];
    [self.scrollView addSubview:carView22];
    
    BFCarCenterView *carView33 = [[BFCarCenterView alloc] initWithFrame:CGRectMake(15 * 2 + imgWidth, carView11.bottom + 15, imgWidth, 146 )];
    self.carView33 = carView33;
    carView33.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesCar3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCar3Action)];
    [carView33 addGestureRecognizer:gesCar3];
    [self.scrollView addSubview:carView33];

    BFCarCenterView *carView44 = [[BFCarCenterView alloc] initWithFrame:CGRectMake(15, carView22.bottom + 15, imgWidth, 146 )];
    self.carView44 = carView44;
    carView44.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesCar4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCar4Action)];
    [carView44 addGestureRecognizer:gesCar4];
    [self.scrollView addSubview:carView44];
    
    BFCarCenterView *carView55 = [[BFCarCenterView alloc] initWithFrame:CGRectMake(15 * 2 + imgWidth, carView33.bottom + 15, imgWidth, 146 )];
    self.carView55 = carView55;
    carView55.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesCar5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCar5Action)];
    [carView55 addGestureRecognizer:gesCar5];
    [self.scrollView addSubview:carView55];
    
    BFCarCenterView *carView66 = [[BFCarCenterView alloc] initWithFrame:CGRectMake(15, carView44.bottom + 15, imgWidth, 146 )];
    self.carView66 = carView66;
    carView66.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesCar6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCar6Action)];
    [carView66 addGestureRecognizer:gesCar6];
    [self.scrollView addSubview:carView66];
    
    BFCarCenterView *carView77 = [[BFCarCenterView alloc] initWithFrame:CGRectMake(15 * 2 + imgWidth, carView55.bottom + 15, imgWidth, 146 )];
    self.carView77 = carView77;
    carView77.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesCar7 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCar7Action)];
    [carView77 addGestureRecognizer:gesCar7];
    [self.scrollView addSubview:carView77];
    
    UIView *line7 = [[UIView alloc] initWithFrame:CGRectMake(0, carView77.bottom + 15, KScreenW, 10.0f)];
    line7.backgroundColor = GroundGraryColor;
    [self.scrollView addSubview:line7];

#pragma mark - 行业资讯标题
    
    UIImageView *newsImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, line7.bottom + 15, 15  , 16 )];
    newsImg.image = [UIImage imageNamed:@"行业资讯"];
    [self.scrollView addSubview:newsImg];
    
    UILabel *newsLbl = [[UILabel alloc] initWithFrame:CGRectMake(newsImg.right + 6.5, line7.bottom + 13, KScreenW - 30 - 40, 20 )];
    NSMutableAttributedString *AttributedStr5 = [[NSMutableAttributedString alloc]initWithString:@"行业资讯 | Latest Information"];
    [AttributedStr5 addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(51, 51, 51)
                           range:NSMakeRange(0,4)];
    [AttributedStr5 addAttribute:NSForegroundColorAttributeName
                           value:RGBColor(204, 204, 204)
                           range:NSMakeRange(4,21)];
    [AttributedStr5 addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:15.0]
                           range:NSMakeRange(0,4)];
    [AttributedStr5 addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:13.0]
                           range:NSMakeRange(4,21)];
    newsLbl.attributedText = AttributedStr5;
    [self.scrollView addSubview:newsLbl];
    
    UILabel *moreLbl5 = [[UILabel alloc] initWithFrame:CGRectMake(KScreenW - 40 - 15, line7.bottom + 13.5, 40, 20 )];
    moreLbl5.text = @"更多 >";
    moreLbl5.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges13 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMore5Action)];
    [moreLbl5 addGestureRecognizer:ges13];
    moreLbl5.textColor = RGBColor(153, 153, 153);
    moreLbl5.font = [UIFont fontWithName:BFfont size:13.0f];
    [self.scrollView addSubview:moreLbl5];
    
#pragma mark - 行业资讯内容
    //资讯大图带视频
    UIImageView *zixunImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, newsLbl.bottom + 15, KScreenW - 30, 170 )];
    self.zixunImg = zixunImg;
    UITapGestureRecognizer *newsImgGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicknewsImgAction)];
    [zixunImg addGestureRecognizer:newsImgGes];
    zixunImg.userInteractionEnabled = YES;
    zixunImg.layer.cornerRadius = 5.0f;
    [zixunImg setContentMode:UIViewContentModeScaleAspectFill];
    zixunImg.clipsToBounds = YES;
    zixunImg.image = [UIImage imageNamed:@"1大牛在线banner"];
    [self.scrollView addSubview:zixunImg];
    //资讯大图阴影
    UIImageView *shadowImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, zixunImg.bottom - 60, KScreenW - 30, 60 )];
    shadowImg.image = [UIImage imageNamed:@"shadow"];
    shadowImg.layer.cornerRadius = 5.0f;
    shadowImg.clipsToBounds = YES;
    [self.scrollView addSubview:shadowImg];
    //资讯大图标题
    UILabel *newsTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, zixunImg.bottom - 40, KScreenW - 30, 40)];
    self.newsTitle = newsTitle;
    newsTitle.textAlignment = NSTextAlignmentLeft;
    newsTitle.text = @"节能与综合利用司开展新能源汽车蓄节能与综合利用司开展新能源汽车蓄";
    newsTitle.textColor = [UIColor whiteColor];
    newsTitle.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.scrollView addSubview:newsTitle];
    //资讯大图下划线
    UIView *newsLine = [[UIView alloc] initWithFrame:CGRectMake(15, zixunImg.bottom + 10, KScreenW - 30, 0.50f)];
    newsLine.backgroundColor = RGBColor(237, 237, 237);
    [self.scrollView addSubview:newsLine];
    //两个资讯
    BFNewsOneView *newsView0 = [[BFNewsOneView alloc] initWithFrame:CGRectMake(15, newsLine.bottom, KScreenW - 30, 91 )];
    self.newsView0 = newsView0;
    newsView0.userInteractionEnabled = YES;
    UITapGestureRecognizer *view0Ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicknewsView0Action)];
    [newsView0 addGestureRecognizer:view0Ges];
    [self.scrollView addSubview:newsView0];
    self.scrollView.contentSize = CGSizeMake(KScreenW,newsView0.bottom + 60);
    
    BFNewsOneView *newsView1 = [[BFNewsOneView alloc] initWithFrame:CGRectMake(15, newsView0.bottom, KScreenW - 30, 91 )];
    self.newsView1 = newsView1;
    newsView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *view1Ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicknewsView1Action)];
    [newsView1 addGestureRecognizer:view1Ges];
    [self.scrollView addSubview:newsView1];
    //两个资讯
    BFNewsTwoView *newsView2 = [[BFNewsTwoView alloc] initWithFrame:CGRectMake(15, newsView1.bottom, KScreenW - 30, 91 )];
    self.newsView2 = newsView2;
    newsView2.userInteractionEnabled = YES;
    UITapGestureRecognizer *view2Ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicknewsView2Action)];
    [newsView2 addGestureRecognizer:view2Ges];
    [self.scrollView addSubview:newsView2];

    BFNewsTwoView *newsView3 = [[BFNewsTwoView alloc] initWithFrame:CGRectMake(15, newsView2.bottom, KScreenW - 30, 91 )];
    self.newsView3 = newsView3;
    newsView3.userInteractionEnabled = YES;
    UITapGestureRecognizer *view3Ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicknewsView3Action)];
    [newsView3 addGestureRecognizer:view3Ges];
    [self.scrollView addSubview:newsView3];

#pragma mark - 底部地图
    //地图
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, newsView3.bottom + 15, KScreenW, 296.5 )];
    imgView.image = [UIImage imageNamed:@"底部地图"];
    [self.scrollView addSubview:imgView];
    //底部文字标题
    UILabel *tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom + 15, KScreenW, 15)];
    tipLbl.text = @"- 百 位 总 监 全 程 视 频 诊 断 修 车 -";
    tipLbl.textColor = RGBColor(153, 153, 153);
    tipLbl.font = [UIFont fontWithName:BFfont size:12.0f];
    tipLbl.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:tipLbl];
    
    self.scrollView.contentSize = CGSizeMake(KScreenW,tipLbl.bottom + 15);
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tipArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *voidCell;
    if (indexPath.row == 0) {
        NSDictionary *dic = self.tipArr[0];
        BFTipTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipTopCell" forIndexPath:indexPath];
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:dic[@"iPhoto"]] placeholderImage:PLACEHOLDER];
        cell.headNickname.text = dic[@"iNickName"];
        [cell.tipImg sd_setImageWithURL:[NSURL URLWithString:dic[@"photoUrl"]] placeholderImage:PLACEHOLDER];
        cell.tipTitle.text = dic[@"pTitle"];
        cell.watchLbl.text = [NSString stringWithFormat:@"%@",dic[@"pNum"]];
        cell.zanLbl.text = [NSString stringWithFormat:@"%@",dic[@"likeCount"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        voidCell = cell;
    }
    else {
        BFTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tipCell" forIndexPath:indexPath];
        NSDictionary *dic = self.tipArr[indexPath.row];
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:dic[@"iPhoto"]] placeholderImage:PLACEHOLDER];
        cell.headNickname.text = dic[@"iNickName"];
        NSString *photoUrl = [NSString stringWithFormat:@"%@",dic[@"photoUrl"]];
        [cell.tipImg sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:PLACEHOLDER];
        cell.tipTitle.text = dic[@"pTitle"];
        cell.watchLbl.text = [NSString stringWithFormat:@"%@",dic[@"pNum"]];
        cell.zanLbl.text = [NSString stringWithFormat:@"%@",dic[@"likeCount"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        voidCell = cell;
    }
    return voidCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = self.tipArr[indexPath.row];
    NSString *url = [NSString stringWithFormat:@"%@?pId=%ld",CommunityShowNumURL,[dic[@"pId"] integerValue]];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
    } failureResponse:^(NSError *error) {
    }];
    BFCommunityDetailsVC *vc = [BFCommunityDetailsVC new];
    BFCommunityModel *model = [BFCommunityModel new];
    model.pId = [dic[@"pId"] integerValue];
    model.pCcont = [NSString stringWithFormat:@"%@",dic[@"pCcont"]];
    model.pTitle = [NSString stringWithFormat:@"%@",dic[@"pTitle"]];
    model.pDesc = [NSString stringWithFormat:@"%@",dic[@"pDesc"]];
    vc.model = model;
    vc.isFromOtherApp = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 306.5f ;
    }
    else {
        return 133.0f ;
    }
    return 133.0f ;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
}


#pragma mark - 顶部轮播图Delegate

- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    if (flowView == pageFlowView) {
        return CGSizeMake(310  ,150 );
    }
    else
        return CGSizeMake(302.5  ,161.5 );
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    if (flowView == pageFlowView) {
//        NSLog(@"顶部滚动到了第%ld页",pageNumber);
        _pageControl.currentPage = pageNumber;
    }
    else {
//        NSLog(@"中间直播课堂滚动到了第%ld页",pageNumber);
    }
}

#pragma mark - 顶部轮播图Datasource

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    if (flowView == pageFlowView) {
        return self.bannerArr.count;
    }
    else
        return self.liveClassArr.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    PGIndexBannerSubiew *bannerView = [PGIndexBannerSubiew new];
    if (flowView == pageFlowView) {
        PGIndexBannerSubiew *bannerView0 = [flowView dequeueReusableCell];
        if (!bannerView0) {
            bannerView0 = [[PGIndexBannerSubiew alloc] init];
            bannerView0.tag = index;
            bannerView0.layer.cornerRadius = 4;
            bannerView0.layer.masksToBounds = YES;
            bannerView0.userInteractionEnabled = NO;
            
        }
        if (self.bannerArr.count == 0) {
            
        }
        else {
            NSDictionary *dic = self.bannerArr[index];
            NSString *urlStr = dic[@"abcover"];
            [bannerView0.mainImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"组3"]];
            bannerView0.mainImageView.layer.cornerRadius = 4.0f;
            self.bannerView0 = bannerView0;
            bannerView = bannerView0;
            return bannerView0;
        }
    }
    else if (flowView == pageFlowView1){
        PGIndexBannerSubiew *bannerView1 = [flowView dequeueReusableCell];
        if (!bannerView1) {
            bannerView1 = [[PGIndexBannerSubiew alloc] init];
            bannerView1.tag = index;
            bannerView1.layer.cornerRadius = 4;
            bannerView1.layer.masksToBounds = YES;
        }
        
        if (self.liveClassArr.count == 0) {
            
        }
        else {
            NSDictionary *dic = self.liveClassArr[index];
            NSString *urlStr = dic[@"ccover"];
            [bannerView1.mainImageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"组3"]];
            bannerView1.mainImageView.layer.cornerRadius = 4.0f;
            NSString *liveS = [NSString stringWithFormat:@"%@",dic[@"liveState"]];
            if ([liveS isEqualToString:@"1"]) {
                //直播
                bannerView1.mainTip.image = [UIImage imageNamed:@"直播中"];
            }
            else {
                //预告
                bannerView1.mainTip.image = [UIImage imageNamed:@"预告"];
            }
            bannerView1.classDescription.text = [NSString stringWithFormat:@"%@  %@",dic[@"ctitle"], dic[@"cstarttime"]];
            self.bannerView1 = bannerView1;
            bannerView = bannerView1;
            return bannerView1;
        }
    }
    return bannerView;
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    NSLog(@"直播课程的轮播图点击了第%ld张图",(long)subIndex);
    [self pushOrWatch1:(NSInteger)subIndex];
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.carStyleArr.count;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200  , 305 );
}

#pragma mark - 精品课程横向滑动cell

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BFMiddleCollectionCell *cell = (BFMiddleCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = 5.0f;
//    cell.layer.shadowColor = [UIColor blackColor].CGColor;
//    cell.layer.shadowOpacity = 0.8f;
//    cell.layer.shadowRadius = 5.0f;
//    cell.layer.shadowOffset = CGSizeMake(0,0);
    cell.topImage.clipsToBounds = YES;
    cell.topImage.contentMode = UIViewContentModeScaleAspectFill;
    NSDictionary *dic = self.carStyleArr[indexPath.row];
    [cell.topImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"sUrl"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
    cell.topLbl.text = [NSString stringWithFormat:@"%@",dic[@"sName"]];
    NSString *str = [NSString stringWithFormat:@"%@",dic[@"seriesNum"]];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@位专家在线",str]];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:19.0]
                          range:NSMakeRange(0,str.length)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:11.0]
                          range:NSMakeRange(str.length,5)];
    [AttributedStr addAttribute:NSForegroundColorAttributeName
                          value:RGBColor(0, 157, 255)
                          range:NSMakeRange(0,str.length + 5)];
    
    cell.specialistLbl.attributedText = AttributedStr;
    NSArray *arr = dic[@"seriesList"];
    NSDictionary *list0 = arr[0];
    [cell.middleImg0 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[list0[@"mUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] placeholderImage:[UIImage imageNamed:@"组3"]];
    cell.middleLbl0.text = [NSString stringWithFormat:@"%@",list0[@"mName"]];
    
    
    NSDictionary *list1 = arr[1];
    [cell.middleImg1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[list1[@"mUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] placeholderImage:[UIImage imageNamed:@"组3"]];
    cell.middleLbl1.text = [NSString stringWithFormat:@"%@",list1[@"mName"]];
    
    NSDictionary *list2 = arr[2];
    [cell.middleImg2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[list2[@"mUrl"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]] placeholderImage:[UIImage imageNamed:@"组3"]];
    cell.middleLbl2.text = [NSString stringWithFormat:@"%@",list2[@"mName"]];
    
    return cell;
}

#pragma mark - collectionView的点击事件

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.获取应用程序App-B的URL Scheme
    NSURL *appBUrl = [NSURL URLWithString:@"sxc://BFLiveAnswerVC"];
    
    // 2.判断手机中是否安装了对应程序
    if ([[UIApplication sharedApplication] canOpenURL:appBUrl]) {
        // 3. 打开应用程序App-B
        [[UIApplication sharedApplication] openURL:appBUrl];
    } else {
        //跳转到搜修车下载页
        BFDownloadController *downLoadVC = [[BFDownloadController alloc] init];
        [self.navigationController pushViewController:downLoadVC animated:YES];
    }
}

#pragma mark - 首页Banner的网络请求

-(void)bannerNetwork {
    NSString *urlStr = [NSString stringWithFormat:@"%@BfHomePage/bfHomePageBannerTwo.do",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            self.bannerArr = dic[@"data"];
            _pageControl.numberOfPages = self.bannerArr.count;
            [pageFlowView reloadData];
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 合作平台的点击事件
-(void)clickCooAction {
    BFCooperationController *VC = [[BFCooperationController alloc] init];
    VC.urlStr = [NSString stringWithFormat:@"http://www.beifangzj.com/bfweb/h5-enter-ad2.html"];
    VC.titleStr = @"丝路学院学员专区";
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)clickCooAction1 {
    BFCooperationController *VC = [[BFCooperationController alloc] init];
    VC.urlStr = [NSString stringWithFormat:@"http://www.beifangzj.com/bfweb/h5-enter-ad1.html"];
    VC.titleStr = @"长城网学员专区";
    [self.navigationController pushViewController:VC animated:YES];
}

-(void)clickCooAction2 {
    BFCooperationController *VC = [[BFCooperationController alloc] init];
    VC.urlStr = [NSString stringWithFormat:@"http://chushi.beifangzj.com"];
    VC.titleStr = @"北方钓鱼台学员专区";
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 六个模块的网络请求

-(void)sixVideoNetwork {
    NSString *urlStr = [NSString stringWithFormat:@"%@BfHomePage/bfHomePageSixBannerTwo.do",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            self.sixVideoArr = dic[@"data"];
            
            //新能源课堂数据
            NSDictionary *dic0 = self.sixVideoArr[0];
            self.xnyLbl.text = [NSString stringWithFormat:@"%@",dic0[@"TITLEOne"]];
            [self.xnyMainImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic0[@"COVER"]]]];
            self.xnyLeftLbl.text = [NSString stringWithFormat:@"%@",dic0[@"TITLETwo"]];
            self.xnyRightLbl.text = [NSString stringWithFormat:@"%@",dic0[@"TITLEThree"]];
            
            //直播课堂数据
            NSDictionary *dic1 = self.sixVideoArr[1];
            NSLog(@"%@",dic1);
            nowDict = dic1;
            self.liveLbl.text = [NSString stringWithFormat:@"%@",dic1[@"TITLEOne"]];
            [self.liveMainImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic1[@"COVER"]]]];
            self.LeftLbl1.text = [NSString stringWithFormat:@"%@",dic1[@"TITLETwo"]];
            self.RightLbl1.text = [NSString stringWithFormat:@"%@",dic1[@"TITLEThere"]];
            if([dic1[@"roomState"] isEqualToString:@"0"]) {
                liveNowImg.image = [UIImage imageNamed:@"1即将开始"];
            }else{
                liveNowImg.image = [UIImage imageNamed:@"直播中"];
            }
            
            //视频课堂数据
            NSDictionary *dic2 = self.sixVideoArr[2];
            self.videoLbl.text = [NSString stringWithFormat:@"%@",dic2[@"TITLEOne"]];
            [self.videoMainImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic2[@"COVER"]]]];
            
            //车人才数据
            NSDictionary *dic3 = self.sixVideoArr[3];
            self.carLbl.text = [NSString stringWithFormat:@"%@",dic3[@"TITLEOne"]];
            [self.carMainImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic3[@"COVER"]]]];
            
            //无人驾驶课堂数据
            NSDictionary *dic4 = self.sixVideoArr[4];
            self.noLbl.text = [NSString stringWithFormat:@"%@",dic4[@"TITLEOne"]];
            [self.noMainImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic4[@"COVER"]]]];
            self.noLeftLbl.text = [NSString stringWithFormat:@"%@",dic4[@"TITLETwo"]];
            self.noRightLbl.text = [NSString stringWithFormat:@"%@",dic4[@"TITLEThree"]];
            
            //汽配商务数据
            NSDictionary *dic5 = self.sixVideoArr[5];
            self.goodsLbl.text = [NSString stringWithFormat:@"%@",dic5[@"TITLEOne"]];
            [self.goodsMainImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic5[@"COVER"]]]];
            
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 车人才网络请求

-(void)CarTalentNetwork {
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do?startPage=1&bRId=-1&jWDiploma=-1&jWYear=-1&jWMoney=-1&jCSize=-1&jMState=-1",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            self.carTalentArr = dic[@"data"];
            
            NSDictionary *dic0 = self.carTalentArr[0];
            
            NSString *str0 = [NSString stringWithFormat:@"%@",dic0[@"jWYear"]];
            NSString *str00 = @"0";
            if ([str0 isEqualToString:@"0"]) {
                str00 = @"应届生";
            }
            else if ([str0 isEqualToString:@"1"]) {
                str00 = @"1-3年";
            }
            else if ([str0 isEqualToString:@"2"]) {
                str00 = @"3-5年";
            }
            else if ([str0 isEqualToString:@"3"]) {
                str00 = @"5-10年";
            }
            else if ([str0 isEqualToString:@"4"]) {
                str00 = @"10年以上";
            }
            
            NSString *str1 = [NSString stringWithFormat:@"%@",dic0[@"jWDiploma"]];
            NSString *str11 = @"0";
            if ([str1 isEqualToString:@"0"]) {
                str11 = @"不限";
            }
            else if ([str1 isEqualToString:@"1"]) {
                str11 = @"中专以下";
            }
            else if ([str1 isEqualToString:@"2"]) {
                str11 = @"高中";
            }
            else if ([str1 isEqualToString:@"3"]) {
                str11 = @"大专";
            }
            else if ([str1 isEqualToString:@"4"]) {
                str11 = @"本科";
            }
            
            NSString *str2 = [NSString stringWithFormat:@"%@",dic0[@"jWMoney"]];
            NSString *str22 = @"0";
            if ([str2 isEqualToString:@"0"]) {
                str22 = @"面议";
            }
            else if ([str2 isEqualToString:@"1"]) {
                str22 = @"3000元以下";
            }
            else if ([str2 isEqualToString:@"2"]) {
                str22 = @"3000-5000";
            }
            else if ([str2 isEqualToString:@"3"]) {
                str22 = @"5000-7000";
            }
            else if ([str2 isEqualToString:@"4"]) {
                str22 = @"7000-10000";
            }
            else if ([str2 isEqualToString:@"5"]) {
                str22 = @"10000-15000";
            }
            else if ([str2 isEqualToString:@"6"]) {
                str22 = @"15000以上";
            }
            
            self.carView0.companyJob.text = [NSString stringWithFormat:@"%@",dic0[@"jWName"]];
            self.carView0.companyLocation.text = [NSString stringWithFormat:@"%@",dic0[@"bRName"]];
            self.carView0.companyYear.text = [NSString stringWithFormat:@"%@",str00];
            self.carView0.companyDegree.text = [NSString stringWithFormat:@"%@",str11];
            self.carView0.companyMoney.text = [NSString stringWithFormat:@"%@",str22];
            self.carView0.companyTime.text = [NSString stringWithFormat:@"%@",dic0[@"jWTimeStr"]];
            [self.carView0.companyLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic0[@"jCLogo"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView0.companyName.text = [NSString stringWithFormat:@"%@",dic0[@"jCName"]];
            
            
            
            
            
            
            
            
            NSDictionary *dic1 = self.carTalentArr[1];
            
            NSString *str3 = [NSString stringWithFormat:@"%@",dic1[@"jWYear"]];
            NSString *str33 = @"0";
            if ([str3 isEqualToString:@"0"]) {
                str33 = @"应届生";
            }
            else if ([str3 isEqualToString:@"1"]) {
                str33 = @"1-3年";
            }
            else if ([str3 isEqualToString:@"2"]) {
                str33 = @"3-5年";
            }
            else if ([str3 isEqualToString:@"3"]) {
                str33 = @"5-10年";
            }
            else if ([str3 isEqualToString:@"4"]) {
                str33 = @"10年以上";
            }
            
            NSString *str4 = [NSString stringWithFormat:@"%@",dic1[@"jWDiploma"]];
            NSString *str44 = @"0";
            if ([str4 isEqualToString:@"0"]) {
                str44 = @"不限";
            }
            else if ([str4 isEqualToString:@"1"]) {
                str44 = @"中专以下";
            }
            else if ([str4 isEqualToString:@"2"]) {
                str44 = @"高中";
            }
            else if ([str4 isEqualToString:@"3"]) {
                str44 = @"大专";
            }
            else if ([str4 isEqualToString:@"4"]) {
                str44 = @"本科";
            }
            
            NSString *str5 = [NSString stringWithFormat:@"%@",dic1[@"jWMoney"]];
            NSString *str55 = @"0";
            if ([str5 isEqualToString:@"0"]) {
                str55 = @"面议";
            }
            else if ([str5 isEqualToString:@"1"]) {
                str55 = @"3000元以下";
            }
            else if ([str5 isEqualToString:@"2"]) {
                str55 = @"3000-5000";
            }
            else if ([str5 isEqualToString:@"3"]) {
                str55 = @"5000-7000";
            }
            else if ([str5 isEqualToString:@"4"]) {
                str55 = @"7000-10000";
            }
            else if ([str5 isEqualToString:@"5"]) {
                str55 = @"10000-15000";
            }
            else if ([str5 isEqualToString:@"6"]) {
                str55 = @"15000以上";
            }
            
            self.carView1.companyJob.text = [NSString stringWithFormat:@"%@",dic1[@"jWName"]];
            self.carView1.companyLocation.text = [NSString stringWithFormat:@"%@",dic1[@"bRName"]];
            self.carView1.companyYear.text = [NSString stringWithFormat:@"%@",str33];
            self.carView1.companyDegree.text = [NSString stringWithFormat:@"%@",str44];
            self.carView1.companyMoney.text = [NSString stringWithFormat:@"%@",str55];
            self.carView1.companyTime.text = [NSString stringWithFormat:@"%@",dic1[@"jWTimeStr"]];
            [self.carView1.companyLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic1[@"jCLogo"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView1.companyName.text = [NSString stringWithFormat:@"%@",dic1[@"jCName"]];
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 技术论坛的网络请求

-(void)TechTipNetwork {
    NSString *urlStr = [NSString stringWithFormat:@"%@BfHomePage/bfHomePageBannerPostTwo.do",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            if (dic[@"data"] == nil) {
                
            }
            else {
                self.techArr = dic[@"data"];
                NSDictionary *techDic0 = self.techArr[0];
                
                [self.leftImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",techDic0[@"ppurl"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
                self.LeftText.text = [NSString stringWithFormat:@"%@",techDic0[@"ptitle"]];
                self.topiclbl0.text = [NSString stringWithFormat:@"%@",techDic0[@"ptitle"]];
                NSDictionary *techDic1 = self.techArr[1];
                self.topiclbl1.text = [NSString stringWithFormat:@"%@",techDic1[@"ptitle"]];
                NSDictionary *techDic2 = self.techArr[2];
                self.topiclbl2.text = [NSString stringWithFormat:@"%@",techDic2[@"ptitle"]];
            }
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 车系网络请求

-(void)carStyleNetwork {
    NSString *urlStr = [NSString stringWithFormat:@"%@BfHomePage/bfHomePageBannerExpert.do",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            self.carStyleArr = dic[@"data"];
            [collectionView0 reloadData];
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 直播课堂的网络请求

-(void)liveClassNetwork {
    NSString *urlStr = [NSString stringWithFormat:@"%@BfHomePage/bfHomePageBannerLive.do",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            
            if (dic[@"liveData"] == nil || dic[@"videoData"] == nil) {
                
            }
            else {
                self.liveClassArr = dic[@"liveData"];
                self.backClassArr = dic[@"videoData"];
                NSDictionary *dic0 = self.backClassArr[0];
                [self.view0.classImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic0[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
                self.view0.classTitle.text = [NSString stringWithFormat:@"%@",dic0[@"ctitle"]];
                [self.view0.classTeacher sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic0[@"iphoto"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
                self.view0.teacherName.text = [NSString stringWithFormat:@"%@",dic0[@"rname"]];
                self.view0.playNumber.text = [NSString stringWithFormat:@"%@次播放",dic0[@"livenum"]];
                
                NSDictionary *dic1 = self.backClassArr[1];
                [self.view1.classImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic1[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
                self.view1.classTitle.text = [NSString stringWithFormat:@"%@",dic1[@"ctitle"]];
                [self.view1.classTeacher sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic1[@"iphoto"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
                self.view1.teacherName.text = [NSString stringWithFormat:@"%@",dic1[@"rname"]];
                self.view1.playNumber.text = [NSString stringWithFormat:@"%@次播放",dic1[@"livenum"]];
                
                NSDictionary *dic2 = self.backClassArr[2];
                [self.view2.classImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic2[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
                self.view2.classTitle.text = [NSString stringWithFormat:@"%@",dic2[@"ctitle"]];
                [self.view2.classTeacher sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic2[@"iphoto"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
                self.view2.teacherName.text = [NSString stringWithFormat:@"%@",dic2[@"rname"]];
                self.view2.playNumber.text = [NSString stringWithFormat:@"%@次播放",dic2[@"livenum"]];
                
                NSDictionary *dic3 = self.backClassArr[3];
                [self.view3.classImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic3[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
                self.view3.classTitle.text = [NSString stringWithFormat:@"%@",dic3[@"ctitle"]];
                [self.view3.classTeacher sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic3[@"iphoto"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
                self.view3.teacherName.text = [NSString stringWithFormat:@"%@",dic3[@"rname"]];
                self.view3.playNumber.text = [NSString stringWithFormat:@"%@次播放",dic3[@"livenum"]];
                
                [pageFlowView1 reloadData];
            }
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 推荐资讯网络请求

-(void)newsNetwork {
    [NetworkRequest requestWithUrl:FindHomeNews parameters:nil successResponse:^(id data) {
        self.newsArr = data;
        if (self.newsArr.count == 0) {
            
        }
        else {
            //资讯大图
            NSDictionary *newsDic1 = self.newsArr[0];
            [self.zixunImg sd_setImageWithURL:[NSURL URLWithString:newsDic1[@"nCImg"]] placeholderImage:PLACEHOLDER];
            self.newsTitle.text = newsDic1[@"pTitle"];
            //第一个资讯
            NSDictionary *newsDic2 = self.newsArr[1];
            [self.newsView0.newsImgOne sd_setImageWithURL:[NSURL URLWithString:newsDic2[@"nCImg"]] placeholderImage:PLACEHOLDER];
            self.newsView0.newsTitleOne.text = newsDic2[@"pTitle"];
            self.newsView0.newsContentOne.text = newsDic2[@"pDesc"];
            //第二个资讯
            NSDictionary *newsDic3 = self.newsArr[2];
            [self.newsView1.newsImgOne sd_setImageWithURL:[NSURL URLWithString:newsDic3[@"nCImg"]] placeholderImage:PLACEHOLDER];
            self.newsView1.newsTitleOne.text = newsDic3[@"pTitle"];
            self.newsView1.newsContentOne.text = newsDic3[@"pDesc"];
            //第三个资讯
            NSDictionary *newsDic4 = self.newsArr[3];
            [self.newsView2.newsImgOne sd_setImageWithURL:[NSURL URLWithString:newsDic4[@"nCImg"]] placeholderImage:PLACEHOLDER];
            self.newsView2.newsTitleOne.text = newsDic4[@"pTitle"];
            self.newsView2.newsContentOne.text = newsDic4[@"pDesc"];
            //第四个资讯
            NSDictionary *newsDic5 = self.newsArr[4];
            [self.newsView3.newsImgOne sd_setImageWithURL:[NSURL URLWithString:newsDic5[@"nCImg"]] placeholderImage:PLACEHOLDER];
            self.newsView3.newsTitleOne.text = newsDic5[@"pTitle"];
            self.newsView3.newsContentOne.text = newsDic5[@"pDesc"];
        }
        
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 热门帖子网络请求

-(void)hotTipsNetwork {
    [NetworkRequest requestWithUrl:FindHomeTips parameters:nil successResponse:^(id data) {
        self.tipArr = data;
        [self.tableView reloadData];
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 汽车技术研究中心网络请求

-(void)carCenterNetwork {
    NSString *urlStr = [NSString stringWithFormat:@"%@BfHomePage/bfHomePageFourClass.do",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        self.carCenterArr = data;
        NSLog(@"显示的数据为:%@",data);
        
        if (self.carCenterArr.count == 0) {
            
        }
        else {
            NSDictionary *carDic0 = self.carCenterArr[0];
            [self.carView00.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",carDic0[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView00.postLbl.text = [NSString stringWithFormat:@"%@",carDic0[@"ctitile"]];
            self.carView00.num.text = [NSString stringWithFormat:@"%@次播放",carDic0[@"cnum"]];
            
            NSDictionary *carDic1 = self.carCenterArr[1];
            [self.carView11.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",carDic1[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView11.postLbl.text = [NSString stringWithFormat:@"%@",carDic1[@"ctitile"]];
            self.carView11.num.text = [NSString stringWithFormat:@"%@次播放",carDic1[@"cnum"]];
            
            NSDictionary *carDic2 = self.carCenterArr[2];
            [self.carView22.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",carDic2[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView22.postLbl.text = [NSString stringWithFormat:@"%@",carDic2[@"ctitile"]];
            self.carView22.num.text = [NSString stringWithFormat:@"%@次播放",carDic2[@"cnum"]];
            
            NSDictionary *carDic3 = self.carCenterArr[3];
            [self.carView33.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",carDic3[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView33.postLbl.text = [NSString stringWithFormat:@"%@",carDic3[@"ctitile"]];
            self.carView33.num.text = [NSString stringWithFormat:@"%@次播放",carDic3[@"cnum"]];
            
            NSDictionary *carDic4 = self.carCenterArr[4];
            [self.carView44.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",carDic4[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView44.postLbl.text = [NSString stringWithFormat:@"%@",carDic4[@"ctitile"]];
            self.carView44.num.text = [NSString stringWithFormat:@"%@次播放",carDic4[@"cnum"]];
            
            NSDictionary *carDic5 = self.carCenterArr[5];
            [self.carView55.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",carDic5[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView55.postLbl.text = [NSString stringWithFormat:@"%@",carDic5[@"ctitile"]];
            self.carView55.num.text = [NSString stringWithFormat:@"%@次播放",carDic5[@"cnum"]];
            
            NSDictionary *carDic6 = self.carCenterArr[6];
            [self.carView66.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",carDic6[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView66.postLbl.text = [NSString stringWithFormat:@"%@",carDic6[@"ctitile"]];
            self.carView66.num.text = [NSString stringWithFormat:@"%@次播放",carDic6[@"cnum"]];
            
            NSDictionary *carDic7 = self.carCenterArr[7];
            [self.carView77.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",carDic7[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.carView77.postLbl.text = [NSString stringWithFormat:@"%@",carDic7[@"ctitile"]];
            self.carView77.num.text = [NSString stringWithFormat:@"%@次播放",carDic7[@"cnum"]];
        }

    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 大牛视图的点击事件

-(void)clickDNAction {
    
    // 1.获取应用程序App-B的URL Scheme
    NSURL *appBUrl = [NSURL URLWithString:@"sxc://BFLiveAnswerVC"];
    
    // 2.判断手机中是否安装了对应程序
    if ([[UIApplication sharedApplication] canOpenURL:appBUrl]) {
        // 3. 打开应用程序App-B
        [[UIApplication sharedApplication] openURL:appBUrl];
    } else {
        //跳转到搜修车下载页
        BFDownloadController *downLoadVC = [[BFDownloadController alloc] init];
        [self.navigationController pushViewController:downLoadVC animated:YES];
    }
}

#pragma mark - 新能源课堂的点击事件

-(void)clickXNYAction {
//    NSDictionary *dic0 = self.sixVideoArr[0];
//    BFMoreCourseListVC *vc = [[BFMoreCourseListVC alloc] init];
//    vc.cid = [dic0[@"ID"] integerValue];
//    vc.titleStr = @"新能源";
//    [self.navigationController pushViewController:vc animated:YES];
    
    NSDictionary *dic0 = self.sixVideoArr[0];
    NSString *cidStr =dic0[@"ID"];
    
    for (CCNavigationController *vc in self.tabBarController.childViewControllers) {
        NSLog(@"%@",vc.childViewControllers.firstObject);
        if ([vc.childViewControllers.firstObject isKindOfClass:[BFCourseListVC class]]) {
            BFCourseListVC *corseVC = vc.childViewControllers.firstObject;
            corseVC.cid = [cidStr intValue];
            corseVC.selectedIndex = 6;
            self.tabBarController.selectedIndex = 2;
            if (!_isFirstLoad) {
                [corseVC scrollToXNY];
            }
            _isFirstLoad = false;
        }
    }
}

#pragma mark - 直播课堂的点击事件

-(void)clickLiveAction {
    [self pushOrWatch:1];
}

#pragma mark - 视频课堂的点击事件

-(void)clickVideoAction {
    for (CCNavigationController *vc in self.tabBarController.childViewControllers) {
        NSLog(@"%@",vc.childViewControllers.firstObject);
        if ([vc.childViewControllers.firstObject isKindOfClass:[BFCourseListVC class]]) {
            BFCourseListVC *corseVC = vc.childViewControllers.firstObject;
            corseVC.selectedIndex = 0;
            self.tabBarController.selectedIndex = 2;
            if (!_isFirstLoad) {
                [corseVC scrollToXNY];
            }
            _isFirstLoad = false;
        }
    }
//    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
}

#pragma mark - 车人才的点击事件

-(void)clickCarAction {
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
}

#pragma mark - 无人驾驶课程的点击事件

-(void)clickNoAction {
    NSDictionary *dic0 = self.sixVideoArr[4];
    BFMoreCourseListVC *vc = [[BFMoreCourseListVC alloc] init];
    vc.cid = [dic0[@"ID"] integerValue];
    vc.titleStr = @"无人驾驶";
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 汽配商务的点击事件

-(void)clickGoodsAction {
    //汽配商务
    NSDictionary *dic0 = self.sixVideoArr[5];
    NSString *cidStr =dic0[@"ID"];
    for (CCNavigationController *vc in self.tabBarController.childViewControllers) {
        NSLog(@"%@",vc.childViewControllers.firstObject);
        if ([vc.childViewControllers.firstObject isKindOfClass:[BFCourseListVC class]]) {
            BFCourseListVC *corseVC = vc.childViewControllers.firstObject;
            corseVC.cid = [cidStr intValue];
            corseVC.selectedIndex = 7;
            self.tabBarController.selectedIndex = 2;
            if (!_isFirstLoad) {
                [corseVC scrollToXNY];
            }
            _isFirstLoad = false;
        }
    }
    
}

#pragma mark - 技术论坛左侧图片的点击事件

-(void)clickTechTopic0Action {
    NSDictionary *dic = self.techArr[0];
    BFCommunityDetailsVC *vc = [BFCommunityDetailsVC new];
    BFCommunityModel *model = [BFCommunityModel new];
    model.pId = [dic[@"pid"] integerValue];
    vc.model = model;
    vc.isFromOtherApp = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickTechTopic1Action {
    NSDictionary *dic = self.techArr[1];
    BFCommunityDetailsVC *vc = [BFCommunityDetailsVC new];
    BFCommunityModel *model = [BFCommunityModel new];
    model.pId = [dic[@"pid"] integerValue];
    vc.model = model;
    vc.isFromOtherApp = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickTechTopic2Action {
    NSDictionary *dic = self.techArr[2];
    BFCommunityDetailsVC *vc = [BFCommunityDetailsVC new];
    BFCommunityModel *model = [BFCommunityModel new];
    model.pId = [dic[@"pid"] integerValue];
    vc.model = model;
    vc.isFromOtherApp = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 技术论坛更多按钮的点击事件

-(void)clickMore0Action {
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

//#pragma mark - 百位总监全程视频诊断修车的点击事件
//
//-(void)clickMore1Action {
//    [ZAlertView showSVProgressForInfoStatus:@"点击跳转到百位总监全程视频诊断修车"];
//}
//

#pragma mark - 直播课程回放的点击事件

-(void)clickBackAction {
    BFPlayBackOneViewController *playBackVC = [[BFPlayBackOneViewController alloc] init];
    [self.navigationController pushViewController:playBackVC animated:YES];
}

#pragma mark - 回放课程1的点击事件

-(void)clickClass1Action {
    
    NSDictionary *dic = self.backClassArr[0];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = dic[@"roomid"];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 回放课程2的点击事件

-(void)clickClass2Action {
    
    NSDictionary *dic = self.backClassArr[1];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = dic[@"roomid"];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 回放课程3的点击事件

-(void)clickClass3Action {
    
    NSDictionary *dic = self.backClassArr[2];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = dic[@"roomid"];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 回放课程4的点击事件

-(void)clickClass4Action {
    
    NSDictionary *dic = self.backClassArr[3];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = dic[@"roomid"];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

- (void)watchVideoAction:(NSString *)roomId withCid:(NSInteger)cid{
    BFWatchCourseVC *player = [[BFWatchCourseVC alloc] init];
    player.playMode = NO;
    player.videoId = roomId;
    player.videos = @[roomId];
    player.isInstroduce = NO;
    player.cid = cid;
    player.canClick = YES;
    player.indexpath = 0;
    [self.navigationController pushViewController:player animated:YES];
}

#pragma mark - 车人才更多的点击事件

-(void)clickMore2Action {
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];
}

#pragma mark - 技术论坛更多的点击事件

-(void)clickMore3Action {
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:1];
}

#pragma mark - 资讯大图点击事件

-(void)clicknewsImgAction {
    BFCarConsultDetailsVC *vc = [BFCarConsultDetailsVC new];
    NSDictionary *dic = self.newsArr[0];
    BFCarNewsModel *carNewModel = [BFCarNewsModel new];
    carNewModel.nId = [dic[@"nId"] integerValue];
    vc.carNewModel = carNewModel;
    vc.isFromOtherApp = YES;
    //统计观看资讯详情点击事件的个数
//    [MobClick event:@"watchNews"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 资讯1点击事件

-(void)clicknewsView0Action {
    BFCarConsultDetailsVC *vc = [BFCarConsultDetailsVC new];
    NSDictionary *dic = self.newsArr[1];
    BFCarNewsModel *carNewModel = [BFCarNewsModel new];
    carNewModel.nId = [dic[@"nId"] integerValue];
    vc.carNewModel = carNewModel;
    vc.isFromOtherApp = YES;
    //统计观看资讯详情点击事件的个数
//    [MobClick event:@"watchNews"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 资讯2点击事件

-(void)clicknewsView1Action {
    BFCarConsultDetailsVC *vc = [BFCarConsultDetailsVC new];
    NSDictionary *dic = self.newsArr[2];
    BFCarNewsModel *carNewModel = [BFCarNewsModel new];
    carNewModel.nId = [dic[@"nId"] integerValue];
    vc.carNewModel = carNewModel;
    vc.isFromOtherApp = YES;
    //统计观看资讯详情点击事件的个数
//    [MobClick event:@"watchNews"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 资讯3点击事件

-(void)clicknewsView2Action {
    BFCarConsultDetailsVC *vc = [BFCarConsultDetailsVC new];
    NSDictionary *dic = self.newsArr[3];
    BFCarNewsModel *carNewModel = [BFCarNewsModel new];
    carNewModel.nId = [dic[@"nId"] integerValue];
    vc.carNewModel = carNewModel;
    vc.isFromOtherApp = YES;
    //统计观看资讯详情点击事件的个数
//    [MobClick event:@"watchNews"];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 资讯4点击事件

-(void)clicknewsView3Action {
    BFCarConsultDetailsVC *vc = [BFCarConsultDetailsVC new];
    NSDictionary *dic = self.newsArr[4];
    BFCarNewsModel *carNewModel = [BFCarNewsModel new];
    carNewModel.nId = [dic[@"nId"] integerValue];
    vc.carNewModel = carNewModel;
    vc.isFromOtherApp = YES;
    //统计观看资讯详情点击事件的个数
//    [MobClick event:@"watchNews"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)xiliekechengNet:(NSString*)cid {
    NSString *urlStr = [NSString stringWithFormat:@"%@BfHomePage/bfHomePageSeriesCourses.do?cId=%@",ServerURL,cid];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            
            [self.serMainImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"courseClassCover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            NSArray *arr = dic[@"data"];
            self.kcArr = arr;
            NSDictionary *dic0 = arr[0];
            [self.courseView0.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic0[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView0.postLbl.text = [NSString stringWithFormat:@"%@",dic0[@"ctitle"]];
            self.courseView0.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic0[@"livenum"]];
            
            NSDictionary *dic1 = arr[1];
            [self.courseView1.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic1[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView1.postLbl.text = [NSString stringWithFormat:@"%@",dic1[@"ctitle"]];
            self.courseView1.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic1[@"livenum"]];
            
            NSDictionary *dic2 = arr[2];
            [self.courseView2.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic2[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView2.postLbl.text = [NSString stringWithFormat:@"%@",dic2[@"ctitle"]];
            self.courseView2.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic2[@"livenum"]];
            
            NSDictionary *dic3 = arr[3];
            [self.courseView3.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic3[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView3.postLbl.text = [NSString stringWithFormat:@"%@",dic3[@"ctitle"]];
            self.courseView3.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic3[@"livenum"]];
            
            NSDictionary *dic4 = arr[4];
            [self.courseView4.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic4[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView4.postLbl.text = [NSString stringWithFormat:@"%@",dic4[@"ctitle"]];
            self.courseView4.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic4[@"livenum"]];
            
            NSDictionary *dic5 = arr[5];
            [self.courseView5.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic5[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView5.postLbl.text = [NSString stringWithFormat:@"%@",dic5[@"ctitle"]];
            self.courseView5.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic5[@"livenum"]];
            
            NSDictionary *dic6 = arr[6];
            [self.courseView6.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic6[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView6.postLbl.text = [NSString stringWithFormat:@"%@",dic6[@"ctitle"]];
            self.courseView6.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic6[@"livenum"]];
            
            NSDictionary *dic7 = arr[7];
            [self.courseView7.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic7[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView7.postLbl.text = [NSString stringWithFormat:@"%@",dic7[@"ctitle"]];
            self.courseView7.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic7[@"livenum"]];
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 系列课程横向滑动按钮的点击事件

-(void)clickChooseAction:(UIButton *)sender {
    
    xilieCid = [NSString stringWithFormat:@"%ld",sender.tag];
    for (UIButton *btn in self.btnMutableArray){
        NSLog(@"按钮%ld ---- 当前按钮的%ld",btn.tag,sender.tag);
        if (btn.tag == sender.tag) {
            [btn setTitleColor:RGBColor(51, 150, 252) forState:UIControlStateNormal];
            [btn setBackgroundColor:RGBColor(239,247,255)];
        } else {
            [btn setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
            [btn setBackgroundColor:RGBColor(247,249,251)];
        }
    }
    
    NSString *urlStr = [NSString stringWithFormat:@"%@BfHomePage/bfHomePageSeriesCourses.do?cId=%ld",ServerURL,sender.tag];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {

            [self.serMainImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"courseClassCover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            NSMutableArray *arr = dic[@"data"];
            self.kcArr = arr;
            NSDictionary *dic0 = arr[0];
            [self.courseView0.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic0[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView0.postLbl.text = [NSString stringWithFormat:@"%@",dic0[@"ctitle"]];
            self.courseView0.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic0[@"livenum"]];
            
            NSDictionary *dic1 = arr[1];
            [self.courseView1.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic1[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView1.postLbl.text = [NSString stringWithFormat:@"%@",dic1[@"ctitle"]];
            self.courseView1.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic1[@"livenum"]];
            
            NSDictionary *dic2 = arr[2];
            [self.courseView2.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic2[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView2.postLbl.text = [NSString stringWithFormat:@"%@",dic2[@"ctitle"]];
            self.courseView2.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic2[@"livenum"]];
            
            NSDictionary *dic3 = arr[3];
            [self.courseView3.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic3[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView3.postLbl.text = [NSString stringWithFormat:@"%@",dic3[@"ctitle"]];
            self.courseView3.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic3[@"livenum"]];
            
            NSDictionary *dic4 = arr[4];
            [self.courseView4.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic4[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView4.postLbl.text = [NSString stringWithFormat:@"%@",dic4[@"ctitle"]];
            self.courseView4.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic4[@"livenum"]];
            
            NSDictionary *dic5 = arr[5];
            [self.courseView5.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic5[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView5.postLbl.text = [NSString stringWithFormat:@"%@",dic5[@"ctitle"]];
            self.courseView5.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic5[@"livenum"]];
            
            NSDictionary *dic6 = arr[6];
            [self.courseView6.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic6[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView6.postLbl.text = [NSString stringWithFormat:@"%@",dic6[@"ctitle"]];
            self.courseView6.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic6[@"livenum"]];
            
            NSDictionary *dic7 = arr[7];
            [self.courseView7.postImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic7[@"ccover"]]] placeholderImage:[UIImage imageNamed:@"组3"]];
            self.courseView7.postLbl.text = [NSString stringWithFormat:@"%@",dic7[@"ctitle"]];
            self.courseView7.logoNumber.text = [NSString stringWithFormat:@"%@播放量",dic7[@"livenum"]];
            
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - 八个视频系列课程点击事件1

-(void)clickCourse0Action {
    NSDictionary *dic = self.kcArr[0];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
    
}

#pragma mark - 八个视频系列课程点击事件2

-(void)clickCourse1Action {
    NSDictionary *dic = self.kcArr[1];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 八个视频系列课程点击事件3

-(void)clickCourse2Action {
    NSDictionary *dic = self.kcArr[2];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 八个视频系列课程点击事件4

-(void)clickCourse3Action {
    NSDictionary *dic = self.kcArr[3];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 八个视频系列课程点击事件5

-(void)clickCourse4Action {
    NSDictionary *dic = self.kcArr[4];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 八个视频系列课程点击事件6

-(void)clickCourse5Action {
    NSDictionary *dic = self.kcArr[5];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 八个视频系列课程点击事件7

-(void)clickCourse6Action {
    NSDictionary *dic = self.kcArr[6];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 八个视频系列课程点击事件8

-(void)clickCourse7Action {
    NSDictionary *dic = self.kcArr[7];
    NSInteger csIdStr = [dic[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 汽车技术研究中心四个视频中的第一个

-(void)clickCar0Action {
    NSDictionary *dic0 = self.carCenterArr[0];
    NSInteger csIdStr = [dic0[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic0[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic0[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 汽车技术研究中心四个视频中的第二个

-(void)clickCar1Action {
    NSDictionary *dic1 = self.carCenterArr[1];
    NSInteger csIdStr = [dic1[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic1[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic1[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 汽车技术研究中心四个视频中的第三个

-(void)clickCar2Action {
    NSDictionary *dic2 = self.carCenterArr[2];
    NSInteger csIdStr = [dic2[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic2[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic2[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 汽车技术研究中心四个视频中的第四个

-(void)clickCar3Action {
    NSDictionary *dic3 = self.carCenterArr[3];
    NSInteger csIdStr = [dic3[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic3[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic3[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 汽车技术研究中心四个视频中的第五个

-(void)clickCar4Action {
    NSDictionary *dic4 = self.carCenterArr[4];
    NSInteger csIdStr = [dic4[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic4[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic4[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 汽车技术研究中心四个视频中的第六个

-(void)clickCar5Action {
    NSDictionary *dic5 = self.carCenterArr[5];
    NSInteger csIdStr = [dic5[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic5[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic5[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 汽车技术研究中心四个视频中的第七个

-(void)clickCar6Action {
    NSDictionary *dic6 = self.carCenterArr[6];
    NSInteger csIdStr = [dic6[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic6[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic6[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 汽车技术研究中心四个视频中的第八个

-(void)clickCar7Action {
    NSDictionary *dic7 = self.carCenterArr[7];
    NSInteger csIdStr = [dic7[@"cid"] integerValue];
    NSString *roomidStr = [NSString stringWithFormat:@"%@",dic7[@"roomid"]];
    
    NSString *cidStr = [NSString stringWithFormat:@"%@",dic7[@"cid"]];
    NSString *urlStr = [NSString stringWithFormat:@"%@?cId=%@",VideoPlayNumbers,cidStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSLog(@"点赞成功");
        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    [self watchVideoAction:roomidStr withCid:csIdStr];
}

#pragma mark - 行业资讯更多的点击事件

-(void)clickMore5Action {
    BFNewHomePageViewController *vc = [[BFNewHomePageViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 原厂资料在线预览

-(void)clickDownload0Action {
    BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
    watchVC.url = [NSString stringWithFormat:@"http://www.beifangzj.com/image/datacode/file/ad.pdf"];
    [self.navigationController pushViewController:watchVC animated:YES];
}

#pragma mark - 原厂资料在线预览

-(void)clickDownload1Action {
    BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
    watchVC.url = [NSString stringWithFormat:@"http://www.beifangzj.com/image/datacode/file/bmhz.pdf"];
    [self.navigationController pushViewController:watchVC animated:YES];
}

#pragma mark - 原厂资料在线预览

-(void)clickDownload2Action {
    BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
    watchVC.url = [NSString stringWithFormat:@"http://www.beifangzj.com/image/datacode/file/bc.pdf"];
    [self.navigationController pushViewController:watchVC animated:YES];
}

#pragma mark - 原厂资料在线预览

-(void)clickDownload3Action {
    BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
    watchVC.url = [NSString stringWithFormat:@"http://www.beifangzj.com/image/datacode/file/bt.pdf"];
    [self.navigationController pushViewController:watchVC animated:YES];
}

#pragma mark - 原厂资料在线预览

-(void)clickDownload4Action {
    BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
    watchVC.url = [NSString stringWithFormat:@"http://www.beifangzj.com/image/datacode/file/byd.pdf"];
    [self.navigationController pushViewController:watchVC animated:YES];
}

#pragma mark - 原厂资料在线预览

-(void)clickDownload5Action {
    BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
    watchVC.url = [NSString stringWithFormat:@"http://www.beifangzj.com/image/datacode/file/gq.pdf"];
    [self.navigationController pushViewController:watchVC animated:YES];
}

#pragma mark - 原厂资料在线预览

-(void)clickDownload6Action {
    BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
    watchVC.url = [NSString stringWithFormat:@"http://www.beifangzj.com/image/datacode/file/hf.pdf"];
    [self.navigationController pushViewController:watchVC animated:YES];
}

#pragma mark - 原厂资料在线预览

-(void)clickDownload7Action {
    BFWatchResumeController *watchVC = [[BFWatchResumeController alloc] init];
    watchVC.url = [NSString stringWithFormat:@"http://www.beifangzj.com/image/datacode/file/dz.pdf"];
    [self.navigationController pushViewController:watchVC animated:YES];
}

-(void)clickCarTalent0Action {
    NSDictionary *dic = self.carTalentArr[0];
    NSString *idStr = dic[@"jWId"];
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkInfoSelect.do?jWId=%@",ServerURL,idStr];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dict = data;
        NSLog(@"获取到的数据为:%@",dict);
        BFCompanyDetailViewController *detailVC = [[BFCompanyDetailViewController alloc] init];
        detailVC.dic = dict[@"data"];
        [self.navigationController pushViewController:detailVC animated:YES];
    } failureResponse:^(NSError *error) {
        NSLog(@"error - %@",error);
    }];
}

-(void)clickCarTalent1Action {
    NSDictionary *dic = self.carTalentArr[1];
    NSString *idStr = dic[@"jWId"];
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkInfoSelect.do?jWId=%@",ServerURL,idStr];
    NSLog(@"%@",urlStr);
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dict = data;
        NSLog(@"获取到的数据为:%@",dict);
        BFCompanyDetailViewController *detailVC = [[BFCompanyDetailViewController alloc] init];
        detailVC.dic = dict[@"data"];
        [self.navigationController pushViewController:detailVC animated:YES];
    } failureResponse:^(NSError *error) {
        NSLog(@"error - %@",error);
    }];
}

- (void)pushOrWatch:(NSInteger) num{
    NSString *str = GetFromUserDefaults(@"loginStatus");

    NSString *checkStr = GetFromUserDefaults(@"checkVersion");
    if ([checkStr isEqualToString:@"1"]) {
        NSDictionary *dicLive = self.sixVideoArr[num];
        NSString *roomidStr = dicLive[@"roomid"];
        self.liveIdStr = roomidStr;
        PlayParameter *parameter = [[PlayParameter alloc] init];
        parameter.userId = DWACCOUNT_USERID;
        parameter.roomId = roomidStr;
        parameter.viewerName = GetFromUserDefaults(@"iNickName");
        parameter.token = @"";
        parameter.security = NO;
        parameter.viewerCustomua = @"viewercustomua";
        RequestData *requestData = [[RequestData alloc] initLoginWithParameter:parameter];
        requestData.delegate = self;
        nowDict = dicLive;
    }
    else {
        NSDictionary *dicLive = self.sixVideoArr[num];
        NSString *roomidStr = dicLive[@"roomid"];
        self.liveIdStr = roomidStr;
        PlayParameter *parameter = [[PlayParameter alloc] init];
        parameter.userId = DWACCOUNT_USERID;
        parameter.roomId = roomidStr;
        parameter.viewerName = GetFromUserDefaults(@"iNickName");
        parameter.token = @"";
        parameter.security = NO;
        parameter.viewerCustomua = @"viewercustomua";
        RequestData *requestData = [[RequestData alloc] initLoginWithParameter:parameter];
        requestData.delegate = self;
        nowDict = dicLive;
        
//        if ([str isEqualToString:@"1"]) { //用户已登录
//
//        }
//        else {
//            BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
//            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
//            [self presentViewController:navigation animated:YES completion:nil];
//        }
    }
}

- (void)pushOrWatch1:(NSInteger) num{
    NSString *str = GetFromUserDefaults(@"loginStatus");
    
    NSString *checkStr = GetFromUserDefaults(@"checkVersion");
    if ([checkStr isEqualToString:@"1"]) {
        NSDictionary *dicLive = self.liveClassArr[num];
        NSString *liveStr = [NSString stringWithFormat:@"%@",dicLive[@"liveState"]];
        if ([liveStr isEqualToString:@"1"]) {
            //进入直播页面
            NSString *roomidStr = dicLive[@"roomid"];
            self.liveIdStr = roomidStr;
            PlayParameter *parameter = [[PlayParameter alloc] init];
            parameter.userId = DWACCOUNT_USERID;
            parameter.roomId = roomidStr;
            parameter.viewerName = GetFromUserDefaults(@"iNickName");
            parameter.token = @"";
            parameter.security = NO;
            parameter.viewerCustomua = @"viewercustomua";
            RequestData *requestData = [[RequestData alloc] initLoginWithParameter:parameter];
            requestData.delegate = self;
            nowDict = dicLive;
        }
        else {
            
        }
    }
    else {
        NSDictionary *dicLive = self.liveClassArr[num];
        NSString *liveStr = [NSString stringWithFormat:@"%@",dicLive[@"liveState"]];
        if ([liveStr isEqualToString:@"1"]) {
            //进入直播页面
            NSString *roomidStr = dicLive[@"roomid"];
            self.liveIdStr = roomidStr;
            PlayParameter *parameter = [[PlayParameter alloc] init];
            parameter.userId = DWACCOUNT_USERID;
            parameter.roomId = roomidStr;
            parameter.viewerName = GetFromUserDefaults(@"iNickName");
            parameter.token = @"";
            parameter.security = NO;
            parameter.viewerCustomua = @"viewercustomua";
            RequestData *requestData = [[RequestData alloc] initLoginWithParameter:parameter];
            requestData.delegate = self;
            nowDict = dicLive;
        }
        else {
            
        }

//        if ([str isEqualToString:@"1"]) { //用户已登录
//        }
//        else {
//            BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
//            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
//            [self presentViewController:navigation animated:YES completion:nil];
//        }
    }
}


#pragma mark -CCPushUtilDelegate-
//@optional
/**
 *    @brief    请求成功
 */
-(void)requestLoginSucceedWithViewerId:(NSString *)viewerId {
    NSLog(@"登录成功 viewerId = %@",viewerId);
    [self OnStartLive];
}

-(void)OnStartLive{
    _LiveShowViewController = nil;
    _LiveShowViewController = [[LiveShowViewController alloc] init];
    _LiveShowViewController.roomId = liveId;
    _LiveShowViewController.IsHorizontal = _IsHorizontal;
    float width = _size.width;
    float height = _size.height;
    if (_IsHorizontal) {
        _size.width = MAX(width, height);
        _size.height = MIN(width, height);
    } else {
        _size.width = MIN(width, height);
        _size.height = MAX(width, height);
    }
    [[CCPushUtil sharedInstanceWithDelegate:self] setVideoSize:_size BitRate:(int)_bitRate FrameRate:(int)_frameRate];
    _LiveShowViewController.modalPresentationStyle = 0;
    [self presentViewController:_LiveShowViewController animated:YES completion:nil];
}

/**
 *    @brief    登录请求失败
 */
-(void)requestLoginFailed:(NSError *)error reason:(NSString *)reason {
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    NSLog(@"%@",message);
    //    _innerView.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:[@"原因：" stringByAppendingString:message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)WatchLiveAction:(NSNotification *)noti {
    if ([[self class] isCurrentViewControllerVisible:self]) {
        NSNumber *cid = noti.object;
//        PlayParameter *parameter = [[PlayParameter alloc] init];
//        parameter.userId = DWACCOUNT_USERID;
//        parameter.roomId = dic[@"roomId"];
//        parameter.viewerName = GetFromUserDefaults(@"iNickName");
//        parameter.token = dic[@"passWord"];
//        parameter.security = NO;
//        parameter.viewerCustomua = @"viewercustomua";
//        RequestData *requestData = [[RequestData alloc] initLoginWithParameter:parameter];
//        requestData.delegate = self;
//        nowDict = dic;
//        self.liveIdStr = dic[@"roomId"];
        [self getTeacherMsgWithCid:[cid integerValue]];
    }
}

// 判断当前控制器是否正在显示
+(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController
{
    return (viewController.isViewLoaded && viewController.view.window);
}

#pragma mark - CCPushDelegate
//@optional
/**
 *    @brief    请求成功
 */
-(void)loginSucceedPlay {
    SaveToUserDefaults(WATCH_USERID,DWACCOUNT_USERID);
    SaveToUserDefaults(WATCH_ROOMID,self.liveIdStr);
    SaveToUserDefaults(WATCH_USERNAME,GetFromUserDefaults(@"iNickName"));
    SaveToUserDefaults(WATCH_PASSWORD,nowDict[@"passWord"]);
    [_loadingView removeFromSuperview];
    _loadingView = nil;
    [UIApplication sharedApplication].idleTimerDisabled=YES;
    BFWatchLiveCourseVC *vc = [[BFWatchLiveCourseVC alloc] initWithLeftLabelText:nowDict[@"TITLETwo"]];
    vc.cid = [nowDict[@"ID"] integerValue];
    vc.dict = nowDict;
    vc.modalPresentationStyle = 0;
    [self presentViewController:vc animated:YES completion:nil];
    
}

/**
 *    @brief    登录请求失败
 */
-(void)loginFailed:(NSError *)error reason:(NSString *)reason {
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    [_loadingView removeFromSuperview];
    _loadingView = nil;
    [self showInformationViewWithMessage:message];
}

- (void)showInformationViewWithMessage:(NSString *)message{
    [_informationView removeFromSuperview];
    _informationView = [[InformationShowView alloc] initWithLabel:message];
    [self.view addSubview:_informationView];
    [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeInformationView) userInfo:nil repeats:NO];
}

-(void)removeInformationView {
    [_informationView removeFromSuperview];
    _informationView = nil;
}

#pragma mark -获取直播间详情-
- (void)getTeacherMsgWithCid:(NSInteger)cid  {
    NSString *url = [NSString stringWithFormat:@"%@?cid=%ld",LiveCourseContentURL,cid];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        PlayParameter *parameter = [[PlayParameter alloc] init];
        parameter.userId = DWACCOUNT_USERID;
        parameter.roomId = data[@"roomid"];
        parameter.viewerName = GetFromUserDefaults(@"iNickName");
        parameter.token = @"";
        parameter.security = NO;
        parameter.viewerCustomua = @"viewercustomua";
        RequestData *requestData = [[RequestData alloc] initLoginWithParameter:parameter];
        requestData.delegate = self;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:data[@"ctitle"] forKey:@"TITLETwo"];
        [dic setValue:@(cid) forKey:@"ID"];
        [dic setValue:data[@"rname"] forKey:@"rname"];
        [dic setValue:data[@"iphoto"] forKey:@"iphoto"];
        [dic setValue:data[@"iintr"] forKey:@"iintr"];
        [dic setValue:data[@"roomid"] forKey:@"roomid"];
        nowDict = dic;
        self.liveIdStr = dic[@"roomid"];
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark - lazyLoading

-(NSMutableArray *)bannerArr {
    if (_bannerArr == nil) {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

-(NSMutableArray *)sixVideoArr {
    if (_sixVideoArr == nil) {
        _sixVideoArr = [NSMutableArray array];
    }
    return _sixVideoArr;
}

-(NSMutableArray *)newsArr {
    if (_newsArr == nil) {
        _newsArr = [NSMutableArray array];
    }
    return _newsArr;
}

-(NSMutableArray *)tipArr {
    if (_tipArr == nil) {
        _tipArr = [NSMutableArray arrayWithCapacity:5];
    }
    return _tipArr;
}

-(NSMutableArray *)techArr {
    if (_techArr == nil) {
        _techArr = [NSMutableArray array];
    }
    return _techArr;
}

-(NSMutableArray *)carStyleArr {
    if (_carStyleArr == nil) {
        _carStyleArr = [NSMutableArray array];
    }
    return _carStyleArr;
}

-(NSMutableArray *)liveClassArr {
    if (_liveClassArr == nil) {
        _liveClassArr = [NSMutableArray array];
    }
    return _liveClassArr;
}

-(NSMutableArray *)backClassArr {
    if (_backClassArr == nil) {
        _backClassArr = [NSMutableArray array];
    }
    return _backClassArr;
}

-(NSMutableArray *)carTalentArr {
    if (_carTalentArr == nil) {
        _carTalentArr = [NSMutableArray arrayWithCapacity:2];
    }
    return _carTalentArr;
}

-(NSMutableArray *)kcArr {
    if (_kcArr == nil) {
        _kcArr = [NSMutableArray array];
    }
    return _kcArr;
}

-(NSMutableArray *)carCenterArr {
    if (_carCenterArr == nil) {
        _carCenterArr = [NSMutableArray array];
    }
    return _carCenterArr;
}

- (NSMutableArray *)btnMutableArray {
    if (_btnMutableArray == nil) {
        _btnMutableArray = [NSMutableArray array];
    }
    return _btnMutableArray;
}

@end
