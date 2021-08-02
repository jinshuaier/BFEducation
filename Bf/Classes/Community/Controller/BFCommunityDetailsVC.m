//
//  BFCommunityDetailsVC.m
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCommunityDetailsVC.h"
#import "BFEditEvaluateVC.h"
#import "BFCommunityWatchVideoVC.h"
#import "ZZBrowserPickerViewController.h"

#import "BFCommunityDetailsTopCell.h"
#import "BFCommunityContentCell.h"
#import "BFCommunityDetailsImgVideoCell.h"
#import "BFCommunityDetailsMoreCell.h"

// 评价
#import "BFEvaluateCell.h"
#import "BFEvaluateSecTypeCell.h"
#import "BFEvaluateReplyModel.h"
#import "BFEvaluateReplyCell.h"
#import "BFEvaluateModel.h"

#import "BFTitleCell.h"
#import "BFTempCell.h"

#import "UILabel+MBCategory.h"
#import "NSString+Extension.h"
#import "NSMutableAttributedString+BFHeight.h"
#import <MBProgressHUD.h>
#import <WebKit/WebKit.h>
#import "BFPublishTopicController.h"
#import "MIPhotoBrowser.h"


#define ImgCount 10000

@interface BFCommunityDetailsVC ()<UITableViewDelegate,UITableViewDataSource,BFEvaluateSecTypeCellDelegate,ZZBrowserPickerDelegate,BFCommunityModelDelegate,WKNavigationDelegate,WKUIDelegate,UIWebViewDelegate,MIPhotoBrowserDelegate>
// tabel
@property (nonatomic , strong) UITableView *tableView;
// 评论
@property (nonatomic , strong) UIButton *commentBtn;
// 收藏
@property (nonatomic , strong) UIButton *collectBtn;
// 点赞
@property (nonatomic , strong) UIButton *likeBtn;
// 评论高度缓存字典
@property (nonatomic , strong) NSMutableDictionary *cacheDict;
// 回复高度缓存字典
@property (nonatomic , strong) NSMutableDictionary *replyscacheDict;
// 图片
@property (nonatomic , strong) NSMutableArray *photoArray;
/*
 图片浏览器
 */
@property (nonatomic, strong) ZZBrowserPickerViewController *browserController;
// webview
@property (nonatomic , strong) UIWebView *webView;
// html高度
@property (nonatomic , assign) CGFloat htmlHeight;
// 数据
@property (nonatomic , strong) BFCommunityModel *detailModel;
// 图片展示背景
@property (nonatomic , strong) UIView *bgView;
// 图片展示背景
@property (nonatomic , strong) UIImageView *imgView;
// image
@property (nonatomic , strong) UIImage *webImage;
// imageURL
@property (nonatomic , strong) NSString *imgUrl;
// imageData
@property (nonatomic , strong) NSData *webImgdata;
@end

static NSString *topCellId           = @"topCellId";
static NSString *imgVideoCellId      = @"imgVideoCellId";
static NSString *moreCellId          = @"moreCellId";
// 评价重用ID
static NSString *evaluateCellId      = @"evaluateCellId";
static NSString *evaluateReplyCellId = @"evaluateReplyCellId";

static NSString *tempCellId          = @"tempCellId";
static NSString *titleCellId         = @"titleCellId";
static NSString *contentCellId       = @"ContentCellId";
static NSString *webContentCellId    = @"WebContentCellId";


@implementation BFCommunityDetailsVC{
    UIView *bottomView;
    BOOL isExtend;// 如果图片超过展示最大张数是否已经展开
    BOOL canReplyRevaluate;// 是否可以回复别人的回复 YES:能。NO:不能
    
    NSInteger evaluateType;// 评论的类型，0为评论，大于0是所回复的评论或者回复的id
    NSIndexPath *evaluateIndexPath;// 评论的位置
    BOOL isEvaluate;// 是否是评论 YES:是评论 NO:是回复
    NSInteger lastPage;// 总页数
    NSInteger curPage;// 当前页
    
    UIView *lineView;
    UIView *lineView1;
    UIView *lineView2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"帖子详情页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"帖子详情页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"帖子详情";
    canReplyRevaluate = NO;
    lastPage = 1;
    curPage = 0;
    _cacheDict = [NSMutableDictionary dictionary];
    _replyscacheDict = [NSMutableDictionary dictionary];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupUI];
    [self layout];
    
    [self prepareDetailData];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(0, 0, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(shareBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    self.navigationItem.rightBarButtonItem = item1;
    
}

//分享
-(void)shareBtnAction {
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
    
    if (self.photoArray.count == 0 && !_model.pCover) {
        shareImg = [UIImage imageNamed:@"logo-2"];
    }
    else {
        if (_model.haveVideo) {
//                NSDictionary *dic = _model.pCover;
            NSString* strUrl = _model.pCover;
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:strUrl]];
            SDImageCache* cache = [SDImageCache sharedImageCache];
            //此方法会先从memory中取。
            shareImg = [cache imageFromDiskCacheForKey:key];
        }
        else {
            NSDictionary *dic = _model.postPhotoList[0];
            NSString* strUrl = dic[@"pPUrl"];
            SDWebImageManager *manager = [SDWebImageManager sharedManager];
            NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:strUrl]];
            SDImageCache* cache = [SDImageCache sharedImageCache];
            //此方法会先从memory中取。
            shareImg = [cache imageFromDiskCacheForKey:key];
        }
    }
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"[北方职教]%@",_model.pTitle] descr:_model.pDesc thumImage:shareImg];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"https://www.beifangzj.com/bfweb/detailsPost-h5.html?pId=%ld",_model.pId];
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

- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RefrashCommunityDetails" object:nil];
}

- (void)setupUI{
    _webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webView.delegate = self;
    _webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:_webView];
    [_webView sizeToFit];
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"findImg" withExtension:@"js"] encoding:NSUTF8StringEncoding error:nil]];
    
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
    CGFloat tableViewY = rectOfNavigationbar.size.height + rectOfStatusbar.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewY, KScreenW, self.view.height - 55 - tableViewY) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[BFEvaluateSecTypeCell class] forCellReuseIdentifier:evaluateCellId];
    [_tableView registerClass:[BFEvaluateReplyCell class] forCellReuseIdentifier:evaluateReplyCellId];
    [_tableView registerClass:[BFCommunityDetailsTopCell class] forCellReuseIdentifier:topCellId];
    [_tableView registerClass:[BFCommunityDetailsImgVideoCell class] forCellReuseIdentifier:imgVideoCellId];
    [_tableView registerClass:[BFCommunityDetailsMoreCell class] forCellReuseIdentifier:moreCellId];
    [_tableView registerClass:[BFTitleCell class] forCellReuseIdentifier:titleCellId];
    [_tableView registerClass:[BFTempCell class] forCellReuseIdentifier:tempCellId];
    [_tableView registerClass:[BFCommunityContentCell class] forCellReuseIdentifier:contentCellId];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:webContentCellId];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.estimatedRowHeight=150.0f;
    
    [self.tableView.mj_footer beginRefreshing];
    bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBColor(231, 229, 229);
    [bottomView addSubview:lineView];
    lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = RGBColor(231, 229, 229);
    [bottomView addSubview:lineView1];
    lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = RGBColor(231, 229, 229);
    [bottomView addSubview:lineView2];
    
    UIFont *font = [UIFont fontWithName:BFfont size:PXTOPT(28.0)];
    _commentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_commentBtn setTitle:@"评论" forState:(UIControlStateNormal)];
    _commentBtn.titleLabel.font = font;
    _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4.5);
    _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4.5);
    [_commentBtn setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    [_commentBtn setImage:[UIImage imageNamed:@"评论"] forState:(UIControlStateNormal)];
    [_commentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_commentBtn];
    
    _collectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _collectBtn.titleLabel.font = font;
    _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4.5);
    _collectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4.5);
    if (_detailModel.pColFlag > 0) {//已收藏
        [_collectBtn setTitle:@"已收藏" forState:(UIControlStateNormal)];
        [_collectBtn setImage:[UIImage imageNamed:@"收藏成功"] forState:(UIControlStateNormal)];
    }
    else {//未收藏
        [_collectBtn setTitle:@"收藏" forState:(UIControlStateNormal)];
        [_collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:(UIControlStateNormal)];
    }
    [_collectBtn setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    [_collectBtn addTarget:self action:@selector(collectBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_collectBtn];
    
    _likeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _likeBtn.titleLabel.font = font;
    _likeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4.5);
    _likeBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4.5);
    [_likeBtn setTitle:@"赞" forState:(UIControlStateNormal)];
    [_likeBtn setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    [_likeBtn setImage:[UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
    [_likeBtn addTarget:self action:@selector(likeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_likeBtn];
}

- (void)layout{
    bottomView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(55);
    
//    _tableView.sd_layout
//    .topEqualToView(self.view)
//    .leftEqualToView(self.view)
//    .rightEqualToView(self.view)
//    .bottomSpaceToView(bottomView, 0);
    
    _commentBtn.sd_layout
    .leftEqualToView(bottomView)
    .topEqualToView(bottomView)
    .bottomEqualToView(bottomView)
    .widthIs(KScreenW / 3);
    
    _likeBtn.sd_layout
    .rightEqualToView(bottomView)
    .topEqualToView(bottomView)
    .bottomEqualToView(bottomView)
    .widthIs(KScreenW / 3);
    
    _collectBtn.sd_layout
    .leftSpaceToView(_commentBtn, 0)
    .topEqualToView(bottomView)
    .bottomEqualToView(bottomView)
    .rightSpaceToView(_likeBtn, 0);
    
    lineView.sd_layout
    .rightEqualToView(bottomView)
    .topEqualToView(bottomView)
    .leftEqualToView(bottomView)
    .heightIs(1);
    
    lineView1.sd_layout
    .bottomSpaceToView(bottomView, 14)
    .topSpaceToView(bottomView, 14)
    .leftSpaceToView(bottomView, KScreenW / 3)
    .widthIs(1);
    
    lineView2.sd_layout
    .bottomSpaceToView(bottomView, 14)
    .topSpaceToView(bottomView, 14)
    .rightSpaceToView(bottomView, KScreenW / 3)
    .widthIs(1);
}

- (void)loadNewData{
    NSString *url;
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@&startPage=%d",CommunityEvaluateURL,_detailModel.pId,GetFromUserDefaults(@"uId"),1];
    }else{
        url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@&startPage=%d",CommunityEvaluateURL,_detailModel.pId,@"0",1];
    }
    [self prepareDataWithURL:url];
}

- (void)loadMoreData{
    if (_detailModel.curPage < _detailModel.lastPage) {
        NSString *url;
        NSString *str = GetFromUserDefaults(@"loginStatus");
        if ([str isEqualToString:@"1"]) { //用户已登录
            url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@&startPage=%ld",CommunityEvaluateURL,_detailModel.pId,GetFromUserDefaults(@"uId"),_detailModel.curPage + 1];
        }else{
            url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@&startPage=%ld",CommunityEvaluateURL,_detailModel.pId,@"0",_detailModel.curPage + 1];
        }
        [self prepareDataWithURL:url];
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        self.tableView.mj_footer.hidden = YES;
    }
    
}

- (void)setModel:(BFCommunityModel *)model{
    if (!_photoArray) {
        _photoArray = [NSMutableArray array];
    }
    _model = model;
    if (_model.postPhotoList.count > 0) {
        for (NSDictionary *dic in _model.postPhotoList) {
            [_photoArray addObject:dic[@"pPUrl"]];
        }
    }
}

#pragma mark -请求详情-
- (void)prepareDetailData{
    NSString *url;
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@",CommunityDetailURL,_model.pId,GetFromUserDefaults(@"uId")];
    }else{
        url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@",CommunityDetailURL,_model.pId,@"0"];
    }
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            NSDictionary *dict = dic[@"data"];
            _detailModel = [BFCommunityModel initWithDict:dict];
            _detailModel.pCcont = [self fontSetWithHTML:_detailModel.pCcont];
            [_webView loadHTMLString:_detailModel.pCcont baseURL:nil];
            [self loadNewData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
                [_likeBtn setImage:_detailModel.pComFlag ? [UIImage imageNamed:@"点赞成功"] : [UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
                if (_detailModel.pColFlag > 0) {//已收藏
                    [_collectBtn setTitle:@"已收藏" forState:(UIControlStateNormal)];
                    [_collectBtn setImage:[UIImage imageNamed:@"收藏成功"] forState:(UIControlStateNormal)];
                }
                else {//未收藏
                    [_collectBtn setTitle:@"收藏" forState:(UIControlStateNormal)];
                    [_collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:(UIControlStateNormal)];
                }
            });
        }else{
            
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark -html图片文字适应屏幕大小-
- (NSString *)reSizeImageWithHTML:(NSString *)html {
    return [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%fpx}</style>%@", KScreenW - 2 * PXTOPT(28), html];
}

#pragma mark -html设置文字大小-
- (NSString *)fontSetWithHTML:(NSString *)html {
    NSString *newHtmlString = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<meta name=\"viewport\" content=\"initial-scale=1.0, maximum-scale=1.0, user-scalable=no\" /> \n"
                       "<style type=\"text/css\"> \n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>"
                       "<span>%@"
                       "</span>"
                       "</body>"
                       "</html>",html];
    return newHtmlString;
}


#pragma mark -获取评论网络请求-
- (void)prepareDataWithURL:(NSString *)url{
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *arr2 = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [arr addObject:@"组2"];
        [arr2 addObject:@"图片对应的文字"];
    }
    
    if (arr.count > ImgCount) {
        isExtend = NO;
    }
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            NSArray *arr = dic[@"data"];
            _detailModel.curPage = [dic[@"curPage"] integerValue];
            _detailModel.lastPage = [dic[@"lastPage"] integerValue];
            if (_detailModel.curPage == 1) {
                if (arr && arr.count > 0) {
                    _detailModel.haveNewestEvaluate = YES;
                    if (!_detailModel.newestEvaluateArray) {
                        _detailModel.newestEvaluateArray = [NSMutableArray array];
                    }
                }else{
                    _tableView.mj_footer.hidden = YES;
                    [_tableView.mj_footer endRefreshing];
                    _detailModel.haveNewestEvaluate = NO;
                }
                [_detailModel.newestEvaluateArray removeAllObjects];
            }else{
                
            }
            for (NSDictionary *dict in arr) {
                BFEvaluateModel *evaluateModel = [BFEvaluateModel initWithDict:dict];
                [_detailModel.newestEvaluateArray addObject:evaluateModel];
            }
            
            NSArray *wCommentArr = dic[@"wComment"];
            if (wCommentArr && wCommentArr.count > 0) {
                _detailModel.haveWonderfulEvaluate = YES;
                if (!_detailModel.wonderfulEvaluateArray) {
                    _detailModel.wonderfulEvaluateArray = [NSMutableArray array];
                }
            }else{
                _detailModel.haveWonderfulEvaluate = NO;
            }
            [_detailModel.wonderfulEvaluateArray removeAllObjects];
            for (NSDictionary *dict in wCommentArr) {
                BFEvaluateModel *evaluateModel = [BFEvaluateModel initWithDict:dict];
                [_detailModel.wonderfulEvaluateArray addObject:evaluateModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            [self.tableView.mj_footer endRefreshing];
            
        }else{
            [self.tableView.mj_footer endRefreshing];
//            self.tableView.mj_footer.hidden = YES;
        }
    } failureResponse:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
//        self.tableView.mj_footer.hidden = YES;
    }];
}

- (void)sendEditEvaluateWithContent:(NSString *)content{
    NSMutableDictionary *paramet = [NSMutableDictionary dictionary];
    [paramet setValue:@([GetFromUserDefaults(@"uId") integerValue]) forKey:@"uId"];
    [paramet setValue:@(_detailModel.pId) forKey:@"pId"];
    [paramet setValue:@(evaluateType) forKey:@"pCState"];
    [paramet setValue:content forKey:@"pCComment"];
    [NetworkRequest sendDataWithUrl:CommunityPostEvaluateURL parameters:paramet successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            _detailModel.curPage = [dic[@"curPage"] integerValue];
            _detailModel.lastPage = [dic[@"lastPage"] integerValue];
            NSArray *arr = dic[@"data"];
            if (arr && arr.count > 0) {
                _detailModel.haveNewestEvaluate = YES;
                if (!_detailModel.newestEvaluateArray) {
                    _detailModel.newestEvaluateArray = [NSMutableArray array];
                }
                [_detailModel.newestEvaluateArray removeAllObjects];
                
            }else{
                _detailModel.haveNewestEvaluate = NO;
            }
            for (NSDictionary *dict in arr) {
                BFEvaluateModel *evaluateModel = [BFEvaluateModel initWithDict:dict];
                [_detailModel.newestEvaluateArray addObject:evaluateModel];
            }
            NSArray *wCommentArr = dic[@"wComment"];
            if (wCommentArr && wCommentArr.count > 0) {
                _detailModel.haveWonderfulEvaluate = YES;
                if (!_detailModel.wonderfulEvaluateArray) {
                    _detailModel.wonderfulEvaluateArray = [NSMutableArray array];
                }
                [_detailModel.wonderfulEvaluateArray removeAllObjects];
            }else{
                _detailModel.haveWonderfulEvaluate = NO;
            }
            for (NSDictionary *dict in wCommentArr) {
                BFEvaluateModel *evaluateModel = [BFEvaluateModel initWithDict:dict];
                [_detailModel.wonderfulEvaluateArray addObject:evaluateModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            [self showHUD:@"评论成功"];
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = NO;
        }else{
//            [self showHUD:[NSString stringWithFormat:@"评论失败，%@",dic[@"msg"]]];
            [self showHUD:@"评论失败"];
        }
        
    } failure:^(NSError *error) {
        [self showHUD:@"评论失败"];
    }];
}

#pragma mark -设置-
- (void)setHtmlHeight:(CGFloat)htmlHeight{
    _htmlHeight = htmlHeight;
    [_tableView reloadData];
}

#pragma mark -UItableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger tempCount = 1;
    if (_detailModel.haveWonderfulEvaluate) {
        tempCount += (_detailModel.wonderfulEvaluateArray.count + 1);
    }
    if (_detailModel.haveNewestEvaluate) {
        tempCount += (_detailModel.newestEvaluateArray.count + 1);
    }
    return tempCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        if (_detailModel.haveVideo) {
            return 4;
        }else{
            return 3;
        }
    }else if(_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (section == 1){
            return 1;
        }else if (section - 2 < _detailModel.wonderfulEvaluateArray.count){
            BFEvaluateModel *evaluateModel = _detailModel.wonderfulEvaluateArray[section - 2];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }else if (section - 2 == _detailModel.wonderfulEvaluateArray.count){
            return 1;
        }else{
            NSInteger tempCount = 3 + _detailModel.wonderfulEvaluateArray.count;
            BFEvaluateModel *evaluateModel = _detailModel.newestEvaluateArray[section - tempCount];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }
    }else if(_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        if (section == 1){
            return 1;
        }else if (section - 2 < _detailModel.wonderfulEvaluateArray.count){
            BFEvaluateModel *evaluateModel = _detailModel.wonderfulEvaluateArray[section - 2];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }else if (section - 2 == _detailModel.wonderfulEvaluateArray.count){
            return 1;
        }else{
            NSInteger tempCount = 3 + _detailModel.wonderfulEvaluateArray.count;
            BFEvaluateModel *evaluateModel = _detailModel.newestEvaluateArray[section - tempCount];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }
    }else if(!_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论没有 最新评论有
        if (section == 1){
            return 1;
        }else if (section - 2 < _detailModel.newestEvaluateArray.count){
            BFEvaluateModel *evaluateModel = _detailModel.newestEvaluateArray[section - 2];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }
        return 0;
    }else if(!_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论和 最新评论都没有
        return 0;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BFCommunityDetailsTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFCommunityDetailsTopCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:topCellId];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.model = _detailModel;
            cell.delegate = self;
            NSString *str = GetFromUserDefaults(@"loginStatus");
            if ([str isEqualToString:@"1"]) { //用户已登录
                NSNumber *loginUid = GetFromUserDefaults(@"uId");
                if ([loginUid integerValue] == _detailModel.uId) { // 当前直播老师就是登陆老师
                    cell.isSelfSend = YES;
                }else{
                    cell.isSelfSend = NO;
                }
            }else{
                cell.isSelfSend = NO;
            }
            return cell;
        }else if (indexPath.row == 1) {
            BFCommunityContentCell *cell = [tableView dequeueReusableCellWithIdentifier:contentCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFCommunityContentCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:contentCellId];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.contentLabel.text = _detailModel.pTitle;
            cell.contentLabel.textColor = RGBColor(51, 51, 51);
            cell.contentLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(40.0f)];
            return cell;
        }else if(indexPath.row == 2){
            if (_detailModel.haveVideo) {
                BFCommunityDetailsImgVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:imgVideoCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFCommunityDetailsImgVideoCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:imgVideoCellId];
                }
                cell.isVideo = YES;
                NSString *videoUrlStr = _detailModel.pCover;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell.imgVideoImageView sd_setImageWithURL:[NSURL URLWithString:videoUrlStr] placeholderImage:[UIImage imageNamed:@"组2"]];
                return cell;
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:webContentCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:webContentCellId];
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                [cell.contentView addSubview:_webView];
                _webView.sd_layout
                .leftSpaceToView(cell.contentView, PXTOPT(20))
                .topSpaceToView(cell.contentView, PXTOPT(10))
                .rightSpaceToView(cell.contentView, PXTOPT(20))
                .bottomSpaceToView(cell.contentView, PXTOPT(10));
                return cell;
            }
            
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:webContentCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:webContentCellId];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            [cell.contentView addSubview:_webView];
            _webView.sd_layout
            .leftSpaceToView(cell.contentView, PXTOPT(20))
            .topSpaceToView(cell.contentView, PXTOPT(10))
            .rightSpaceToView(cell.contentView, PXTOPT(20))
            .bottomSpaceToView(cell.contentView, PXTOPT(10));
            return cell;
        }
    }
    else if(_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (indexPath.section == 1){
            BFTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:titleCellId];
            }
            cell.nameLabel.text = @"精彩评论";
            cell.nameLabel.textColor = RGBColor(51, 51, 51);
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else if (indexPath.section - 2 < _detailModel.wonderfulEvaluateArray.count){
            BFEvaluateModel *evaluateModel = _detailModel.wonderfulEvaluateArray[indexPath.section - 2];
            if (indexPath.row == 0) {
                BFEvaluateSecTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFEvaluateSecTypeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateCellId];
                }
                cell.delegate = self;
                cell.model = evaluateModel;
                if (indexPath.section == 2){
                    cell.lineView.frame = CGRectMake(0, 0, KScreenW, 0.5f);
                }else{
                    cell.lineView.frame = CGRectMake(0, 4, KScreenW, 0.5f);
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }else{
                BFEvaluateReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateReplyCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFEvaluateReplyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateReplyCellId];
                }
                cell.evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }
        }else if (indexPath.section - 2 == _detailModel.wonderfulEvaluateArray.count){
            BFTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:titleCellId];
            }
            cell.nameLabel.text = @"最新评论";
            cell.nameLabel.textColor = RGBColor(51, 51, 51);
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else{
            NSInteger tempCount = 3 + _detailModel.wonderfulEvaluateArray.count;
            BFEvaluateModel *evaluateModel = _detailModel.newestEvaluateArray[indexPath.section - tempCount];
            if (indexPath.row == 0) {
                BFEvaluateSecTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFEvaluateSecTypeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateCellId];
                }
                cell.delegate = self;
                cell.model = evaluateModel;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                if (indexPath.section - 2 == _detailModel.wonderfulEvaluateArray.count + 1){
                    cell.lineView.frame = CGRectMake(0, 0, KScreenW, 0.5f);
                }else{
                    cell.lineView.frame = CGRectMake(0, 4, KScreenW, 0.5f);
                }
                return cell;
            }else{
                BFEvaluateReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateReplyCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFEvaluateReplyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateReplyCellId];
                }
                cell.evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }
        }
    }else if(_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        return nil;
    }else if(!_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论没有最新评论有
        if (indexPath.section == 1){
            BFTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:titleCellId];
            }
            cell.nameLabel.text = @"最新评论";
            cell.nameLabel.textColor = RGBColor(51, 51, 51);
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else if (indexPath.section - 2 < _detailModel.newestEvaluateArray.count){
            BFEvaluateModel *evaluateModel = _detailModel.newestEvaluateArray[indexPath.section - 2];
            if (indexPath.row == 0) {
                BFEvaluateSecTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFEvaluateSecTypeCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateCellId];
                }
                cell.delegate = self;
                cell.model = evaluateModel;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                if (indexPath.section == 2){
                    cell.lineView.frame = CGRectMake(0, 0, KScreenW, 0.5f);
                }else{
                    cell.lineView.frame = CGRectMake(0, 4, KScreenW, 0.5f);
                }
                return cell;
            }else{
                BFEvaluateReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateReplyCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFEvaluateReplyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateReplyCellId];
                }
                cell.evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }
        }
    }else if(!_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        return nil;
    }else{
        return nil;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (_detailModel.pKey == 0) {
                return 50;
            }else{
                return 80;
            }
        }else if (indexPath.row == 1) {
            CGFloat h = [_detailModel.pTitle boundingRectWithSize:CGSizeMake(KScreenW - 28, 60) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:BFfont size:PXTOPT(40.0f)]} context:nil].size.height + 20;
            return h;
        }else if (indexPath.row == 2){
            if (_detailModel.haveVideo) {
                return 200;
            }else{
                return self.htmlHeight;
            }
        }else{
//            CGSize si = [_model.pCcontAttributed boundingRectWithSize:CGSizeMake(KScreenW - 28, MAXFLOAT) font:[UIFont fontWithName:BFfont size:PXTOPT(32.0f)] lineSpacing:3];
//            NSLog(@"%@,%lf",_model.pCcontAttributed,si.height);
//            return si.height;
            return self.htmlHeight;
        }
    }else if(_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (indexPath.section == 1){
            return 50;
        }else if (indexPath.section - 2 < _detailModel.wonderfulEvaluateArray.count){
            BFEvaluateModel *evaluateModel = _detailModel.wonderfulEvaluateArray[indexPath.section - 2];
            if (indexPath.row == 0) {
                return [self cacheCellHeightWithContent:evaluateModel.pCComment withFont:[UIFont fontWithName:BFfont size:PXTOPT(28)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateModel.pCId isReply:NO];
            }else{
                BFEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                return [self cacheCellHeightWithContent:evaluateReplyModel.pCComment withFont:[UIFont fontWithName:BFfont size:13] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateReplyModel.pCId isReply:YES];
            }
        }else if (indexPath.section - 2 == _detailModel.wonderfulEvaluateArray.count){
            return 50;
        }else{
            BFEvaluateModel *evaluateModel = _detailModel.newestEvaluateArray[indexPath.section - 3 - _detailModel.wonderfulEvaluateArray.count];
            if (indexPath.row == 0) {
                return [self cacheCellHeightWithContent:evaluateModel.pCComment withFont:[UIFont fontWithName:BFfont size:PXTOPT(28)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateModel.pCId isReply:NO];
            }else{
                BFEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                return [self cacheCellHeightWithContent:evaluateReplyModel.pCComment withFont:[UIFont fontWithName:BFfont size:13] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateReplyModel.pCId isReply:YES];
            }
        }
    }else if(_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        return 0;
    }else if(!_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论没有 最新评论有
        if (indexPath.section == 1){
            return 50;
        }else if (indexPath.section - 2 < _detailModel.newestEvaluateArray.count){
            BFEvaluateModel *evaluateModel = _detailModel.newestEvaluateArray[indexPath.section - 2];
            if (indexPath.row == 0) {
                return [self cacheCellHeightWithContent:evaluateModel.pCComment withFont:[UIFont fontWithName:BFfont size:PXTOPT(28)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateModel.pCId isReply:NO];
            }else{
                BFEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                return [self cacheCellHeightWithContent:evaluateReplyModel.pCComment withFont:[UIFont fontWithName:BFfont size:13] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateReplyModel.pCId isReply:YES];
            }
        }
        return 0;
    }else if(!_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        return 0;
    }else{
        return 0;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 2){
            if (_detailModel.haveVideo) {
                [self watchVideoAction:_detailModel.pVUrl];
            }else{
                
            }
        }
    }else if(_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (indexPath.section == 1){
            
        }else if (indexPath.section - 2 < _detailModel.wonderfulEvaluateArray.count){
            BFEvaluateModel *evaluateModel = _detailModel.wonderfulEvaluateArray[indexPath.section - 2];
            if (indexPath.row == 0) {
                evaluateType = evaluateModel.pCId;
                evaluateIndexPath = indexPath;
                isEvaluate = YES;
            }else{
                BFEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                evaluateType = evaluateReplyModel.pCId;
                evaluateIndexPath = indexPath;
                isEvaluate = NO;
            }
        }else if (indexPath.section - 2 == _detailModel.wonderfulEvaluateArray.count){
            
        }else{
            NSInteger tempCount = 3 + _detailModel.wonderfulEvaluateArray.count;
            BFEvaluateModel *evaluateModel = _detailModel.newestEvaluateArray[indexPath.section - tempCount];
            if (indexPath.row == 0) {
                evaluateType = evaluateModel.pCId;
                evaluateIndexPath = indexPath;
                isEvaluate = YES;
            }else{
                BFEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                evaluateType = evaluateReplyModel.pCId;
                evaluateIndexPath = indexPath;
                isEvaluate = NO;
            }
        }
        [self evaluateAction];
    }else if(_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        
    }else if(!_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论没有最新评论有
        if (indexPath.section == 1){
            
        }else if (indexPath.section - 2 < _detailModel.newestEvaluateArray.count){
            BFEvaluateModel *evaluateModel = _detailModel.newestEvaluateArray[indexPath.section - 2];
            if (indexPath.row == 0) {
                evaluateType = evaluateModel.pCId;
                evaluateIndexPath = indexPath;
                isEvaluate = YES;
            }else{
                BFEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                evaluateType = evaluateReplyModel.pCId;
                evaluateIndexPath = indexPath;
                isEvaluate = NO;
            }
        }
        [self evaluateAction];
    }else if(!_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        
    }else{
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGBColor(240, 240, 240);
        return lineView;
//    }else if (section == 1){
//        return nil;
    }else if(_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (section == 1){
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, PXTOPT(30))];
            backView.backgroundColor = [UIColor whiteColor];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, PXTOPT(14), KScreenW, PXTOPT(16))];
            lineView.backgroundColor = RGBColor(240, 240, 240);
            [backView addSubview:lineView];
            return backView;
        }else if (section - 2 < _detailModel.wonderfulEvaluateArray.count){
            return nil;
        }else if (section - 2 == _detailModel.wonderfulEvaluateArray.count){
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = RGBColor(240, 240, 240);
            return lineView;
        }else{
            return nil;
        }
    }else if(_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        return nil;;
    }else if(!_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论没有 最新评论有
        if (section == 1){
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, PXTOPT(30))];
            backView.backgroundColor = [UIColor whiteColor];
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, PXTOPT(14), KScreenW, PXTOPT(16))];
            lineView.backgroundColor = RGBColor(240, 240, 240);
            [backView addSubview:lineView];
            return backView;
        }else if (section - 2 < _detailModel.wonderfulEvaluateArray.count){
            return nil;
        }
        return nil;
    }else if(!_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        return nil;;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if(_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (section == 1){
            return PXTOPT(30);
        }else if (section - 2 < _detailModel.wonderfulEvaluateArray.count){
            return 0;
        }else if (section - 2 == _detailModel.wonderfulEvaluateArray.count){
            return PXTOPT(16);
        }else{
            return 0;
        }
    }else if(_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        return 0;
    }else if(!_detailModel.haveWonderfulEvaluate && _detailModel.haveNewestEvaluate) {// 精彩评论没有 最新评论有
        if (section == 1){
            return PXTOPT(30);
        }else if (section - 2 < _detailModel.wonderfulEvaluateArray.count){
            return 0;
        }
        return 0;
    }else if(!_detailModel.haveWonderfulEvaluate && !_detailModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        return 0;
    }else{
        return 0;
    }
}

// 缓存cell高度
- (CGFloat)cacheCellHeightWithContent:(NSString *)content withFont:(UIFont *)font withSize:(CGSize)size withId:(NSInteger)Id isReply:(BOOL)isReply{
//    NSArray *keysArray;
//    if (isReply) {
//        keysArray = [_replyscacheDict allKeys];
//    }else{
//        keysArray = [_cacheDict allKeys];
//    }
//    NSString *key = [NSString stringWithFormat:@"%ld",Id];
//    if ([keysArray containsObject:key]) {
//        if (isReply) {
//            return [_replyscacheDict[key] floatValue];
//        }else{
//            return [_cacheDict[key] floatValue];
//        }
//    }else{
//        CGFloat h = isReply ? [UILabel sizeWithString:content font:font size:size].height + 10 : [UILabel sizeWithString:content font:font size:size].height + PXTOPT(210);
//        NSLog(@"key = %@,isReply = %d,%@ = %lf",key,isReply,content,h);
//        if (isReply) {
//            [_replyscacheDict setValue:@(h) forKey:key];
//        }else{
//            [_cacheDict setValue:@(h) forKey:key];
//        }
//        return h;
//    }
    NSArray *keysArray;
    keysArray = [_cacheDict allKeys];
    NSString *key = [NSString stringWithFormat:@"%ld",Id];
    if ([keysArray containsObject:key]) {
        return [_cacheDict[key] floatValue];
    }else{
        CGFloat h = isReply ? [UILabel sizeWithString:content font:font size:size].height + 10 : [UILabel sizeWithString:content font:font size:size].height + PXTOPT(210);
        NSLog(@"key = %@,isReply = %d,%@ = %lf",key,isReply,content,h);
        [_cacheDict setValue:@(h) forKey:key];
        return h;
    }
}



- (void)watchVideoAction:(NSString *)roomId{
    BFCommunityWatchVideoVC *player = [[BFCommunityWatchVideoVC alloc] init];
    player.playMode = NO;
    player.videoId = roomId;
    player.videos = @[roomId];
    player.indexpath = 0;
    [self.navigationController pushViewController:player animated:YES];
}

//预览按钮，弹出图片浏览器
-(void)previewWithIndexPath:(NSInteger)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    if (self.photoArray.count == 0) {
        [self showHUD:@"您还没有选中图片，不需要预览"];
    }else{
        self.browserController.indexPath = indexPath;
        [self.browserController reloadData];
        [self.browserController showIn:self animation:ShowAnimationOfPresent];
    }
    
}

- (ZZBrowserPickerViewController *)browserController{
    if (!_browserController) {
        _browserController = [[ZZBrowserPickerViewController alloc]init];
        _browserController.delegate = self;
    }
    return _browserController;
}

#pragma mark -- ZZBrowserPickerDelegate
-(NSInteger)zzbrowserPickerPhotoNum:(ZZBrowserPickerViewController *)controller
{
    return self.photoArray.count;
}

-(NSArray *)zzbrowserPickerPhotoContent:(ZZBrowserPickerViewController *)controller
{
    return self.photoArray;
}

// 评论
- (void)commentBtnAction{
    evaluateType = 0;
    isEvaluate = YES;
    [self evaluateAction];
}

// 回复 评论
- (void)evaluateAction{
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        if (canReplyRevaluate == NO) {// 不允许回复别人的回复
            if (isEvaluate == YES) {
                BFEditEvaluateVC *vc = [BFEditEvaluateVC new];
                vc.modalPresentationStyle = 0;
                [self presentViewController:vc animated:YES completion:nil];
                __weak BFCommunityDetailsVC *weakSelf = self;
                vc.editBlock = ^(NSString *content) {
                    [weakSelf sendEditEvaluateWithContent:content];
                };
            }else{
                return;
            }
        }else{
            BFEditEvaluateVC *vc = [BFEditEvaluateVC new];
            vc.modalPresentationStyle = 0;
            [self presentViewController:vc animated:YES completion:nil];
            __weak BFCommunityDetailsVC *weakSelf = self;
            vc.editBlock = ^(NSString *content) {
                [weakSelf sendEditEvaluateWithContent:content];
            };
        }
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
    
}

// 帖子收藏
- (void)collectBtnAction:(UIButton *)btn{
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        
        NSInteger collInt = 0;
        if (_detailModel.pColFlag > 0) {//已收藏
            collInt = 1;
        }
        else {//未收藏
            collInt = 0;
        }
        NSString *url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@&collected=%ld",CommunityCollectURL,_detailModel.pId,GetFromUserDefaults(@"uId"),(long)collInt];
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                if (1 == collInt) {
                    [ZAlertView showSVProgressForSuccess:@"帖子取消收藏成功"];
                    [_collectBtn setTitle:@"收藏" forState:(UIControlStateNormal)];
                    [_collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:(UIControlStateNormal)];
                    _detailModel.pColFlag = 0;
                }
                else {
                    [ZAlertView showSVProgressForSuccess:@"帖子收藏成功"];
                    [_collectBtn setTitle:@"已收藏" forState:(UIControlStateNormal)];
                    [_collectBtn setImage:[UIImage imageNamed:@"收藏成功"] forState:(UIControlStateNormal)];
                    _detailModel.pColFlag = 10;
                }
            }
            else {
                [ZAlertView showSVProgressForErrorStatus:@"收藏失败"];
            }
        } failureResponse:^(NSError *error) {

        }];
        btn.userInteractionEnabled = NO;
        [self performSelector:@selector(setBtnEnabledAction:) withObject:btn afterDelay:3.0f];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

- (void)setBtnEnabled:(UIButton *)btn{
    btn.userInteractionEnabled = YES;
}

// 帖子点赞
- (void)likeBtnAction:(UIButton *)btn{
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        [btn setImage:[UIImage imageNamed:@"点赞成功"] forState:(UIControlStateNormal)];
        btn.userInteractionEnabled = NO;
        [self performSelector:@selector(setBtnEnabled:) withObject:btn afterDelay:5.0f];
        NSString *url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@&liked=%d",CommunityLikeURL,_detailModel.pId,GetFromUserDefaults(@"uId"),_detailModel.pComFlag > 0 ? 1 : 0];
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            NSInteger status = [dic[@"status"] integerValue];
            if (status == 1) {
                _detailModel.pComFlag = _detailModel.pComFlag > 0 ? 0 : 1;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [btn setImage:_detailModel.pComFlag ? [UIImage imageNamed:@"点赞成功"] : [UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
                });
                if (_detailModel.pComFlag) {
                    [self showHUD:@"点赞成功"];
                }else{
                    [self showHUD:@"取消点赞成功"];
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [btn setImage:[UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
                });
                if (_detailModel.pComFlag) {
                    [self showHUD:@"取消点赞失败"];
                }else{
                    [self showHUD:@"点赞失败"];
                }
            }
        } failureResponse:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [btn setImage:[UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
            });
            if (_detailModel.pComFlag) {
                [self showHUD:@"取消点赞失败"];
            }else{
                [self showHUD:@"点赞失败"];
            }
        }];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

-(void)setBtnEnabledAction:(UIButton *)btn {
    btn.userInteractionEnabled = YES;
}

// 评论点赞
- (void)evaluateLikeBtnClick:(BFEvaluateSecTypeCell *)cell {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        [cell.likeBtn setImage:[UIImage imageNamed:@"赞-3拷贝2"] forState:(UIControlStateNormal)];
        cell.likeBtn.userInteractionEnabled = NO;
        [self performSelector:@selector(setBtnEnabled:) withObject:cell.likeBtn afterDelay:5.0f];
        NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
        BFEvaluateModel *model = cell.model;
        NSString *url = [NSString stringWithFormat:@"%@?pCId=%ld&uId=%@&liked=%d",CommunityEvaluateLikeURL,model.pCId,GetFromUserDefaults(@"uId"),model.comFlag > 0 ? 1 : 0];
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            NSInteger status = [dic[@"status"] integerValue];
            if (status == 1) {
                model.comFlag = model.comFlag > 0 ? 0 : 1;
                model.postComCount = [dic[@"comLikeCount"] integerValue];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell.likeBtn setImage:model.comFlag ? [UIImage imageNamed:@"赞-3拷贝2"] : [UIImage imageNamed:@"赞-3拷贝6"] forState:(UIControlStateNormal)];
                    [cell.likeBtn setTitle:[NSString stringWithFormat:@"%ld",model.postComCount] forState:(UIControlStateNormal)];
                });
                if (model.comFlag) {
                    [self showHUD:@"点赞成功"];
                }else{
                    [self showHUD:@"取消点赞成功"];
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [cell.likeBtn setImage:[UIImage imageNamed:@"赞-3拷贝6"] forState:(UIControlStateNormal)];
                });
                if (model.comFlag) {
                    [self showHUD:@"取消点赞失败"];
                }else{
                    [self showHUD:@"点赞失败"];
                }
            }
        } failureResponse:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.likeBtn setImage:[UIImage imageNamed:@"赞-3拷贝6"] forState:(UIControlStateNormal)];
            });
            if (model.comFlag) {
                [self showHUD:@"取消点赞失败"];
            }else{
                [self showHUD:@"点赞失败"];
            }
        }];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

#pragma mark -BFCommunityModelDelegate-
- (void)deleteAction{
    self.navigationItem.leftBarButtonItem.enabled = NO;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@?pId=%ld",CommunityDeleteURL,_detailModel.pId];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [backView removeFromSuperview];
            self.navigationItem.leftBarButtonItem.enabled = YES;
        });
        if (status == 1) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showHUD:@"删除成功"];
                [self performSelector:@selector(goBack) withObject:nil afterDelay:1.0f];
//                [backView removeFromSuperview];
            });
        }else{
            [self showHUD:@"删除失败"];
        }
    } failureResponse:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
//            [backView removeFromSuperview];
            self.navigationItem.leftBarButtonItem.enabled = YES;
        });
        [self showHUD:@"删除失败"];
    }];
}

- (void)editActionWithBtn:(UIButton *)btn{
    NSString *loginStatus = GetFromUserDefaults(@"loginStatus");
    if ([loginStatus isEqualToString:@"1"]) { //用户已登录
        
    }else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DeleteCommunity" object:_model];
}

#pragma mark -UIWebViewDelegate-
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [webView sizeToFit];
    self.htmlHeight = webView.scrollView.contentSize.height;
    NSLog(@"htmlHeight = %lf",self.htmlHeight);
    CGRect webFrame = webView.frame;
    webFrame.size.height = self.htmlHeight;
    webView.frame = webFrame;
    //js方法遍历图片添加点击事件 返回图片个数
    static  NSString * const jsGetImages =
    @"function getImages(){\
    var objs = document.getElementsByTagName(\"img\");\
    for(var i=0;i<objs.length;i++){\
    objs[i].onclick=function(){\
    document.location=\"myweb:imageClick:\"+this.src;\
    };\
    };\
    return objs.length;\
    };";
    
    [_webView stringByEvaluatingJavaScriptFromString:jsGetImages];//注入js方法
    
    //注入自定义的js方法后别忘了调用 否则不会生效（不调用也一样生效了，，，不明白）
    NSString *resurlt = [_webView stringByEvaluatingJavaScriptFromString:@"getImages()"];
}

#pragma mark -图片点击放大-
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //将url转换为string
    NSString *requestString = [[request URL] absoluteString];
    
    //hasPrefix 判断创建的字符串内容是否以pic:字符开始
    if ([requestString hasPrefix:@"myweb:imageClick:"]) {
        NSString *imageUrl = [requestString substringFromIndex:@"myweb:imageClick:".length];
        
        self.navigationController.navigationBarHidden = YES;
        NSLog(@"%@",imageUrl);
        
//        MIPhotoBrowser *photoBrowser = [[MIPhotoBrowser alloc] init];
//        photoBrowser.delegate = self;
//        photoBrowser.sourceImagesContainerView = _webView;
//        photoBrowser.imageCount = _photoArray.count;
//        NSInteger currentImageIndex = 0;
//        for (int i = 0; i < _photoArray.count; i++) {
//            if ([_photoArray[i] isEqualToString:imageUrl]) {
//                currentImageIndex = i;
//            }
//        }
//        photoBrowser.currentImageIndex = currentImageIndex;
//        [photoBrowser show];
        
        
        if (_bgView && [imageUrl isEqualToString:_imgUrl]) {
            //设置不隐藏，还原放大缩小，显示图片
            _bgView.hidden = NO;

        }else if (_bgView){

            _bgView.hidden = NO;
            _webImage = nil;
            _webImgdata = nil;
//            _indicatorView = nil;
            [self addImgWithUrl:imageUrl];
            _imgUrl = imageUrl;
        }else{
            [self showBigImage:imageUrl];//创建视图并显示图片
            _imgUrl = imageUrl;
        }
        return NO;
    }
    return YES;
}

#pragma mark 显示大图片
-(void)showBigImage:(NSString *)imageUrl{
    //创建灰色透明背景，使其背后内容不可操作
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [_bgView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:_bgView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [_bgView addGestureRecognizer:gesture];
    
//    _indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    [_indicatorView setFrame:CGRectMake(self.view.centerX, self.view.centerY, 50, 50)];
//    _indicatorView.hidesWhenStopped = YES;
//    [_indicatorView startAnimating];
    
    //创建显示图像视图
    _imgView = [[UIImageView alloc] init];
    _imgView.userInteractionEnabled = YES;
    
    [self addImgWithUrl:imageUrl];
    
    [_bgView addSubview:_imgView];
    
    //添加捏合手势
    [_imgView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(handlePinch:)]];
    [_imgView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)]];
}

-(void)addImgWithUrl:(NSString *)imageUrl
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:imageUrl];
        _webImgdata = [NSData dataWithContentsOfURL:url];
        _webImage = [UIImage imageWithData:_webImgdata];
        
//        [_indicatorView stopAnimating];
        CGFloat imageH;
        CGFloat imageW;
        if (_webImage.size.height >= KScreenH && _webImage.size.height > _webImage.size.width*1.5) {
            imageW = (KScreenH*1.0)/_webImage.size.height * _webImage.size.width;
            [_imgView setSize:CGSizeMake(imageW, KScreenH)];
        }else{
            imageH = (KScreenW*1.0)/_webImage.size.width * _webImage.size.height;
            [_imgView setSize:CGSizeMake(KScreenW, imageH)];
        }
        
        [_imgView setCenter:_bgView.center];
        [_imgView setImage:_webImage];
    });
}

-(void)cancel
{
    self.navigationController.navigationBarHidden = NO;
    
    _bgView.hidden = YES;
    
}

//关闭按钮
-(void)removeBigImage
{
    _bgView.hidden = YES;
}

- (void) handlePinch:(UIPinchGestureRecognizer*) recognizer
{
    //缩放:设置缩放比例
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
}

- (void) handlePan:(UIPanGestureRecognizer*) recognizer
{
    
    //视图前置操作
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:self.view];
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    recognizer.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        //计算速度向量的长度，当他小于200时，滑行会很短
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult); //e.g. 397.973175, slideMult: 1.989866
        
        //基于速度和速度因素计算一个终点
        float slideFactor = 0.1 * slideMult;
        CGPoint finalPoint = CGPointMake(center.x + (velocity.x * slideFactor),
                                         center.y + (velocity.y * slideFactor));
        //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限
        finalPoint.x = MIN(MAX(finalPoint.x, cornerRadius),
                           self.view.bounds.size.width - cornerRadius);
        finalPoint.y = MIN(MAX(finalPoint.y, cornerRadius),
                           self.view.bounds.size.height - cornerRadius);
        
        //使用 UIView 动画使 view 滑行到终点
        [UIView animateWithDuration:slideFactor*2
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             recognizer.view.center = CGPointMake(_bgView.centerX, center.y);
                         }
                         completion:nil];
    }
}

#pragma mark -点击看大图 第三方-
//- (NSString *)photoBrowser:(MIPhotoBrowser *)photoBrowser placeholderImageForIndex:(NSInteger)index{
//    NSLog(@"photobrowser index = %d", index);
//
//    return _photoArray[index];
//}

#pragma mark -搜修车配合接口-
- (void)sxcNetwork{
    NSString *url;
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@",SXCCommunity,_model.pId,GetFromUserDefaults(@"uId")];
    }
    else {
        url = [NSString stringWithFormat:@"%@?pId=%ld&uId=%@",SXCCommunity,_model.pId,@"0"];
    }
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dict = data;
        NSInteger status = [dict[@"status"] integerValue];
        if (status == 1) {
            [_model fillWithDict:dict[@"data"]];
            if (_model.haveImg) {
                if (_model.postPhotoList.count > 0) {
                    for (NSDictionary *dic in _model.postPhotoList) {
                        [_photoArray addObject:dic[@"pPUrl"]];
                    }
                }
            }
            [self loadMoreData];
        }else{
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    } failureResponse:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
