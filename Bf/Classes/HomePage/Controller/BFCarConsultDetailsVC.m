//
//  BFCarConsultDetailsVC.m
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCarConsultDetailsVC.h"
#import "BFCarConsultContentModel.h"
#import "BFCarConsultTopCell.h"
#import "BFCarConsultContentImageCell.h"
#import "BFCarConsultContentTextCell.h"
#import "BFCommunityDetailsMoreCell.h"
#import "UILabel+MBCategory.h"
// 评价
#import "BFCarEvaluateModel.h"
#import "BFCarEvaluateReplyModel.h"
#import "BFCarEvalucateCell.h"
#import "BFCarEvaluateReplyCell.h"


#import "BFTitleCell.h"
#import "BFTempCell.h"
#import "NSMutableAttributedString+BFHeight.h"
#import "BFEditEvaluateVC.h"

#define ImgCount 5

@interface BFCarConsultDetailsVC ()<UITableViewDelegate,UITableViewDataSource,BFCarEvalucateCellDelegate>
// tabel
@property (nonatomic , strong) UITableView *tableView;
// 评论
@property (nonatomic , strong) UIButton *commentBtn;
// 收藏
@property (nonatomic , strong) UIButton *collectBtn;
// 点赞
@property (nonatomic , strong) UIButton *likeBtn;
// 高度缓存字典
@property (nonatomic , strong) NSMutableDictionary *cacheDict;
// 高度缓存字典
@property (nonatomic , strong) NSMutableDictionary *replyscacheDict;
/*点赞状态*/
@property (nonatomic,assign) NSInteger like;
// cell高度
@property (nonatomic , assign) CGFloat cellHeight;

// 图片数组
@property (nonatomic , strong) NSMutableArray *imageurlArray;
// 图片数组
@property (nonatomic , strong) NSMutableArray *rangeArr;
@end

static NSString *topCellId           = @"topCellId";
static NSString *imgVideoCellId      = @"imgVideoCellId";
static NSString *textCellId          = @"textCellId";
static NSString *moreCellId          = @"moreCellId";
// 评价重用ID
static NSString *evaluateCellId      = @"evaluateCellId";
static NSString *evaluateReplyCellId = @"evaluateReplyCellId";

static NSString *tempCellId          = @"tempCellId";
static NSString *titleCellId         = @"titleCellId";
@implementation BFCarConsultDetailsVC{
    UIView *bottomView;
    BOOL isExtend;// 如果图片超过展示最大张数是否已经展开
    BOOL canReplyRevaluate;// 是否可以回复别人的回复 YES:能。NO:不能
    NSMutableArray *imgArray;
    NSInteger evaluateType;// 评论的类型，0为评论，大于0是所回复的评论或者回复的id
    BOOL isEvaluate;// 是否是评论 YES:是评论 NO:是回复
    NSIndexPath *evaluateIndexPath;
    
    UIView *lineView;
    UIView *lineView1;
    UIView *lineView2;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"资讯详情页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"资讯详情页"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"资讯详情";
    canReplyRevaluate = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self prepareData];
    [self setupUI];
    [self layout];
    
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(0, 0, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"分享"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(shareBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    self.navigationItem.rightBarButtonItem = item1;
}

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
    
    BFCarConsultContentModel *model = self.carNewModel.contentArray[0];
    NSString *Str = [NSString stringWithFormat:@"%@",model.contentText];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"[北方职教]%@",self.carNewModel.pTitle] descr:Str thumImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",self.num]]];
    //设置网页地址
    shareObject.webpageUrl = [NSString stringWithFormat:@"https://www.beifangzj.com/bfweb/infoDetail-h5.html?nId=%d",self.carNewModel.nId];;
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

- (void)prepareData{
    if (_isFromOtherApp) {
        [self sxcNetwork];
    }else{
        [self manageData];
    }
    
}

- (void)manageData{
    if (!_cacheDict) {
        _cacheDict = [NSMutableDictionary dictionary];
    }
    if (!_replyscacheDict) {
        _replyscacheDict = [NSMutableDictionary dictionary];
    }
    if (_carNewModel.nCCont) {// 如果有内容
        if (_carNewModel.contentArray.count > 0) {// 如果已经解析过
            BFCarConsultContentModel *model = _carNewModel.contentArray[0];
            _cellHeight = model.contentHeight;
//            if (_cellHeight > 400) {
//                isExtend = NO;
//            }else{
//                isExtend = YES;
//            }
            isExtend = YES;
        }else{// 还没解析过
            _carNewModel.contentArray = [NSMutableArray array];
            BFCarConsultContentModel *model = [BFCarConsultContentModel new];
            NSMutableAttributedString *string = [self replacingStringWithHtml:_carNewModel.nCCont];
            [string addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0, string.length)];
            model.contentText = string;
            model.carConsultContentModelType = BFCarConsultContentModelType_Text;
            [_carNewModel.contentArray addObject:model];
            
            CGSize si = [model.contentText boundingRectWithSize:CGSizeMake(KScreenW - PXTOPT(50), 1000) font:[UIFont fontWithName:BFfont size:PXTOPT(32.0f)] lineSpacing:3];
            NSLog(@"%@,%lf",model.contentText,si.height);
            model.contentHeight = si.height + 50;
            _cellHeight = model.contentHeight;
//            if (_cellHeight > 400) {
//                isExtend = NO;
//            }else{
//                isExtend = YES;
//            }
            isExtend = YES;
        }
        
    }else{
        _carNewModel.contentArray = [NSMutableArray array];
        isExtend = YES;
    }
}

- (void)setupUI{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[BFCarEvalucateCell class] forCellReuseIdentifier:evaluateCellId];
    [_tableView registerClass:[BFCarEvaluateReplyCell class] forCellReuseIdentifier:evaluateReplyCellId];
    [_tableView registerClass:[BFCarConsultTopCell class] forCellReuseIdentifier:topCellId];
    [_tableView registerClass:[BFCarConsultContentImageCell class] forCellReuseIdentifier:imgVideoCellId];
    [_tableView registerClass:[BFCarConsultContentTextCell class] forCellReuseIdentifier:textCellId];
    [_tableView registerClass:[BFCommunityDetailsMoreCell class] forCellReuseIdentifier:moreCellId];
    [_tableView registerClass:[BFTitleCell class] forCellReuseIdentifier:titleCellId];
    [_tableView registerClass:[BFTempCell class] forCellReuseIdentifier:tempCellId];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight=150.0f;
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    [self.tableView.mj_footer beginRefreshing];
    [self.view addSubview:_tableView];
    bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    UIFont *font = [UIFont fontWithName:BFfont size:PXTOPT(28.0)];
    _commentBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _commentBtn.titleLabel.font = font;
    _commentBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4.5);
    _commentBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4.5);
    [_commentBtn setTitle:@"评论" forState:(UIControlStateNormal)];
    [_commentBtn setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    [_commentBtn setImage:[UIImage imageNamed:@"评论"] forState:(UIControlStateNormal)];
    [_commentBtn addTarget:self action:@selector(commentBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_commentBtn];
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBColor(231, 229, 229);
    [bottomView addSubview:lineView];
    lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = RGBColor(231, 229, 229);
    [bottomView addSubview:lineView1];
    lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = RGBColor(231, 229, 229);
    [bottomView addSubview:lineView2];
    _collectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _collectBtn.titleLabel.font = font;
    _collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4.5);
    _collectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4.5);
    if (_carNewModel.collFlag > 0) {//已收藏
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
    [_likeBtn setTitle:[NSString stringWithFormat:@"%ld",_carNewModel.likeCount] forState:(UIControlStateNormal)];

    
    if (_carNewModel.likeFlag > 0) {//已点赞
        [_likeBtn setImage:[UIImage imageNamed:@"点赞成功"] forState:(UIControlStateNormal)];
        [_likeBtn setTitle:@"已点赞" forState:(UIControlStateNormal)];
    }
    else {
        [_likeBtn setImage:[UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
        [_likeBtn setTitle:[NSString stringWithFormat:@"%ld",_carNewModel.likeCount] forState:(UIControlStateNormal)];
    }
    [_likeBtn setTitleColor:RGBColor(102, 102, 102) forState:(UIControlStateNormal)];
    [_likeBtn addTarget:self action:@selector(likeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bottomView addSubview:_likeBtn];
}

- (void)layout{
    bottomView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view)
    .heightIs(55);
    
    _tableView.sd_layout
    .topEqualToView(self.view)
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomSpaceToView(bottomView, 0);
    
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

#pragma mark -UItableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger tempCount = 1;
    if (_carNewModel.contentArray.count > 0) {
        tempCount += 1;
    }
    if (_carNewModel.haveWonderfulEvaluate) {
        tempCount += (_carNewModel.wonderfulEvaluateArray.count + 1);
    }
    if (_carNewModel.haveNewestEvaluate) {
        tempCount += (_carNewModel.newestEvaluateArray.count + 1);
    }
    return tempCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        if (!isExtend) {// 没有展开
            return _carNewModel.contentArray.count + 1;
        }else{
            return _carNewModel.contentArray.count;
        }
    }else if(_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (section == 2){
            return 1;
        }else if (section - 2 - 1 < _carNewModel.wonderfulEvaluateArray.count){
            BFCarEvaluateModel *evaluateModel = _carNewModel.wonderfulEvaluateArray[section - 3];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }else if (section - 2 - 1 == _carNewModel.wonderfulEvaluateArray.count){
            return 1;
        }else{
            NSInteger tempCount = 4 + _carNewModel.wonderfulEvaluateArray.count;
            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[section - tempCount];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }
    }else if(_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        if (section == 2){
            return 1;
        }else if (section - 2 - 1 < _carNewModel.wonderfulEvaluateArray.count){
            BFCarEvaluateModel *evaluateModel = _carNewModel.wonderfulEvaluateArray[section - 3];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }else if (section - 2 - 1 == _carNewModel.wonderfulEvaluateArray.count){
            return 1;
        }else{
            NSInteger tempCount = 4 + _carNewModel.wonderfulEvaluateArray.count;
            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[section - tempCount];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }
    }else if(!_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论没有最新评论有
        if (section == 2){
            return 1;
        }else if (section - 2 - 1 < _carNewModel.newestEvaluateArray.count){
            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[section - 3];
            if (evaluateModel.haveReply) {
                return 1 + evaluateModel.replys.count;
            }
            return 1;
        }
        return 0;
    }else if(!_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        return 0;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        BFCarConsultTopCell *cell = [tableView dequeueReusableCellWithIdentifier:topCellId forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCarConsultTopCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:topCellId];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.carNewsModel = _carNewModel;
        return cell;
    }else if (indexPath.section == 1 ){
        if (_carNewModel.contentArray.count > 0){
            if (!isExtend) {// 没展开
                if (indexPath.row == _carNewModel.contentArray.count) {
                    BFCommunityDetailsMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellId forIndexPath:indexPath];
                    if (!cell) {
                        cell = [[BFCommunityDetailsMoreCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:moreCellId];
                    }
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    return cell;
                }else{
                    BFCarConsultContentModel *model = _carNewModel.contentArray[indexPath.row];
                    if (model.carConsultContentModelType == BFCarConsultContentModelType_Text) {
                        BFCarConsultContentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellId forIndexPath:indexPath];
                        if (!cell) {
                            cell = [[BFCarConsultContentTextCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:textCellId];
                        }
                        cell.contentTextField.attributedText = model.contentText;
//                        [cell.contentLabel alignTop];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        return cell;
                        
                    }else if (model.carConsultContentModelType == BFCarConsultContentModelType_Image){
                        BFCarConsultContentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:imgVideoCellId forIndexPath:indexPath];
                        if (!cell) {
                            cell = [[BFCarConsultContentImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:imgVideoCellId];
                        }
                        cell.isVideo = NO;
                        [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.contentImageUrl] placeholderImage:[UIImage imageNamed:@"组2"]];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        return cell;
                    }else if (model.carConsultContentModelType == BFCarConsultContentModelType_Video){
                        BFCarConsultContentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:imgVideoCellId forIndexPath:indexPath];
                        if (!cell) {
                            cell = [[BFCarConsultContentImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:imgVideoCellId];
                        }
                        cell.isVideo = YES;
                        [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.contentImageUrl] placeholderImage:[UIImage imageNamed:@"组2"]];
                        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                        return cell;
                    }
                }
            }else{// 展开
                BFCarConsultContentModel *model = _carNewModel.contentArray[indexPath.row];
                if (model.carConsultContentModelType == BFCarConsultContentModelType_Text) {
                    BFCarConsultContentTextCell *cell = [tableView dequeueReusableCellWithIdentifier:textCellId forIndexPath:indexPath];
                    if (!cell) {
                        cell = [[BFCarConsultContentTextCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:textCellId];
                    }
                    cell.contentTextField.attributedText = model.contentText;
//                    [cell.contentTextField alignTop];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    return cell;
                    
                }else if (model.carConsultContentModelType == BFCarConsultContentModelType_Image){
                    BFCarConsultContentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:imgVideoCellId forIndexPath:indexPath];
                    if (!cell) {
                        cell = [[BFCarConsultContentImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:imgVideoCellId];
                    }
                    cell.isVideo = NO;
                    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.contentImageUrl] placeholderImage:[UIImage imageNamed:@"组2"]];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    return cell;
                }else if (model.carConsultContentModelType == BFCarConsultContentModelType_Video){
                    BFCarConsultContentImageCell *cell = [tableView dequeueReusableCellWithIdentifier:imgVideoCellId forIndexPath:indexPath];
                    if (!cell) {
                        cell = [[BFCarConsultContentImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:imgVideoCellId];
                    }
                    cell.isVideo = YES;
                    [cell.contentImageView sd_setImageWithURL:[NSURL URLWithString:model.contentImageUrl] placeholderImage:[UIImage imageNamed:@"组2"]];
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    return cell;
                }
            }
        }else{// 占位cell
            BFTempCell *cell = [tableView dequeueReusableCellWithIdentifier:tempCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFTempCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:tempCellId];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }
    }else if(_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (indexPath.section == 2){
            BFTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:titleCellId];
            }
            cell.nameLabel.text = @"精彩评论";
            cell.nameLabel.textColor = RGBColor(51, 51, 51);
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else if (indexPath.section - 2 - 1 < _carNewModel.wonderfulEvaluateArray.count){
            BFCarEvaluateModel *evaluateModel = _carNewModel.wonderfulEvaluateArray[indexPath.section - 3];
            if (indexPath.row == 0) {
                BFCarEvalucateCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFCarEvalucateCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateCellId];
                }
                cell.delegate = self;
                cell.model = evaluateModel;
                if (indexPath.section == 3){
                    cell.lineView.frame = CGRectMake(0, 0, KScreenW, 0.5f);
                }else{
                    cell.lineView.frame = CGRectMake(0, 4, KScreenW, 0.5f);
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }else{
                BFCarEvaluateReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateReplyCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFCarEvaluateReplyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateReplyCellId];
                }
                cell.evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }
        }else if (indexPath.section - 2 - 1 == _carNewModel.wonderfulEvaluateArray.count){
            BFTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:titleCellId];
            }
            cell.nameLabel.text = @"最新评论";
            cell.nameLabel.textColor = RGBColor(51, 51, 51);
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else{
            NSInteger tempCount = 4 + _carNewModel.wonderfulEvaluateArray.count;
            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[indexPath.section - tempCount];
            if (indexPath.row == 0) {
                BFCarEvalucateCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFCarEvalucateCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateCellId];
                }
                cell.delegate = self;
                cell.model = evaluateModel;
                if (indexPath.section - 2 - 1 == _carNewModel.wonderfulEvaluateArray.count + 1){
                    cell.lineView.frame = CGRectMake(0, 0, KScreenW, 0.5f);
                }else{
                    cell.lineView.frame = CGRectMake(0, 4, KScreenW, 0.5f);
                }
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }else{
                BFCarEvaluateReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateReplyCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFCarEvaluateReplyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateReplyCellId];
                }
                cell.evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }
        }
    }else if(_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        return nil;
    }else if(!_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论没有最新评论有
        if (indexPath.section == 2){
            BFTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCellId forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFTitleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:titleCellId];
            }
            cell.nameLabel.text = @"最新评论";
            cell.nameLabel.textColor = RGBColor(51, 51, 51);
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else if (indexPath.section - 2 - 1 < _carNewModel.newestEvaluateArray.count){
            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[indexPath.section - 3];
            if (indexPath.row == 0) {
                BFCarEvalucateCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFCarEvalucateCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateCellId];
                }
                cell.delegate = self;
                cell.model = evaluateModel;
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                if (indexPath.section == 3){
                    cell.lineView.frame = CGRectMake(0, 0, KScreenW, 0.5f);
                }else{
                    cell.lineView.frame = CGRectMake(0, 4, KScreenW, 0.5f);
                }
                return cell;
            }else{
                BFCarEvaluateReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateReplyCellId forIndexPath:indexPath];
                if (!cell) {
                    cell = [[BFCarEvaluateReplyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateReplyCellId];
                }
                cell.evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
            }
        }
    }else if(!_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        return nil;
    }else{
        return nil;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CGFloat h = PXTOPT(10) + PXTOPT(68) + PXTOPT(38) + PXTOPT(30) + [UILabel sizeWithString:_carNewModel.pTitle font:[UIFont fontWithName:BFfont size:25] size:CGSizeMake(KScreenW - PXTOPT(56), 100)].height;
        NSLog(@"%@,%lf",_carNewModel.pTitle,h);
        return h;
    }else if (indexPath.section == 1){
        if (_carNewModel.contentArray.count > 0) {
            if (!isExtend) {// 没展开
                if (indexPath.row == _carNewModel.contentArray.count) {
                    return 80;
                }else{
                    return 400;
                }
            }else{// 展开
                return _cellHeight;
            }
        }else{
            return 1;
        }
    }else if(_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (indexPath.section == 2){
            return 50;
        }else if (indexPath.section - 2 - 1 < _carNewModel.wonderfulEvaluateArray.count){
            BFCarEvaluateModel *evaluateModel = _carNewModel.wonderfulEvaluateArray[indexPath.section - 3];
            if (indexPath.row == 0) {
                return [self cacheCellHeightWithContent:evaluateModel.nCComment withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateModel.nCId isReply:NO];
            }else{
                BFCarEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                return [self cacheCellHeightWithContent:evaluateReplyModel.nCComment withFont:[UIFont fontWithName:BFfont size:13] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateReplyModel.nCId isReply:YES];
            }
        }else if (indexPath.section - 2 - 1 == _carNewModel.wonderfulEvaluateArray.count){
            return 50;
        }else{
            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[indexPath.section - 4 - _carNewModel.wonderfulEvaluateArray.count];
            if (indexPath.row == 0) {
                return [self cacheCellHeightWithContent:evaluateModel.nCComment withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateModel.nCId isReply:NO];
            }else{
                BFCarEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                return [self cacheCellHeightWithContent:evaluateReplyModel.nCComment withFont:[UIFont fontWithName:BFfont size:13] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateReplyModel.nCId isReply:YES];
            }
        }
    }else if(_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        return 0;
    }else if(!_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论没有 最新评论有
        if (indexPath.section == 2){
            return 50;
        }else if (indexPath.section - 2 - 1 < _carNewModel.newestEvaluateArray.count){
            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[indexPath.section - 3];
            if (indexPath.row == 0) {
                return [self cacheCellHeightWithContent:evaluateModel.nCComment withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateModel.nCId isReply:NO];
            }else{
                BFCarEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                return [self cacheCellHeightWithContent:evaluateReplyModel.nCComment withFont:[UIFont fontWithName:BFfont size:13] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateReplyModel.nCId isReply:YES];
            }
        }
        return 0;
    }else if(!_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        return 0;
    }else{
        return 0;
    }
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    if (indexPath.section == 0) {
//        CGFloat h = PXTOPT(10) + PXTOPT(68) + PXTOPT(38) + PXTOPT(30) + [UILabel sizeWithString:_carNewModel.pTitle font:[UIFont fontWithName:BFfont size:25] size:CGSizeMake(KScreenW - PXTOPT(56), 100)].height;
//        NSLog(@"%@,%lf",_carNewModel.pTitle,h);
//        return h;
//    }else if (indexPath.section == 1){
//        if (_carNewModel.contentArray > 0) {
//            if (_carNewModel.contentArray.count > ImgCount) {// 图片大于规定显示张数
//                if (!isExtend) {// 没有展开
//                    if (indexPath.row == ImgCount + 1) {// 最后一个cell
//                        return 80;
//                    }else{// 其余显示图片视频的cell
//                        BFCarConsultContentModel *model = _carNewModel.contentArray[indexPath.row];
//                        if (model.carConsultContentModelType == BFCarConsultContentModelType_Text) {
//
////                            return [UILabel sizeWithString:model.contentText font:[UIFont fontWithName:BFfont size:15] size:CGSizeMake(KScreenW - PXTOPT(50), 1000)].height + 10;
//                            CGSize si = [model.contentText boundingRectWithSize:CGSizeMake(KScreenW - PXTOPT(50), 1000) font:[UIFont fontWithName:BFfont size:15] lineSpacing:3];
//                            NSLog(@"%@,%lf",model.contentText,si.height);
//                            return si.height + 50;
//                        }else{
//                            return 200;
//                        }
//                    }
//                }else{
//                    BFCarConsultContentModel *model = _carNewModel.contentArray[indexPath.row];
//                    if (model.carConsultContentModelType == BFCarConsultContentModelType_Text) {
////                        return [UILabel sizeWithString:model.contentText font:[UIFont fontWithName:BFfont size:15] size:CGSizeMake(KScreenW - PXTOPT(50), 1000)].height + 10;
//                        CGSize si = [model.contentText boundingRectWithSize:CGSizeMake(KScreenW - PXTOPT(50), 1000) font:[UIFont fontWithName:BFfont size:15] lineSpacing:3];
//                        NSLog(@"%@,%lf",model.contentText,si.height);
//                        return si.height + 50;
//                    }else{
//                        return 200;
//                    }
//                }
//            }else{// 图片小于规定显示张数
//                BFCarConsultContentModel *model = _carNewModel.contentArray[indexPath.row];
//                if (model.carConsultContentModelType == BFCarConsultContentModelType_Text) {
////                    return [UILabel sizeWithString:model.contentText font:[UIFont fontWithName:BFfont size:15] size:CGSizeMake(KScreenW - PXTOPT(50), 1000)].height + 10;
//                    CGSize si = [model.contentText boundingRectWithSize:CGSizeMake(KScreenW - PXTOPT(50), 1000) font:[UIFont fontWithName:BFfont size:15] lineSpacing:3];
//                    NSLog(@"%@,%lf",model.contentText,si.height);
//                    return si.height + 50;
//                }else{
//                    return 200;
//                }
//            }
//        }else{
//            return 1;
//        }
//    }else if(_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
//        if (indexPath.section == 2){
//            return 50;
//        }else if (indexPath.section - 2 - 1 < _carNewModel.wonderfulEvaluateArray.count){
//            BFCarEvaluateModel *evaluateModel = _carNewModel.wonderfulEvaluateArray[indexPath.section - 3];
//            if (indexPath.row == 0) {
//                return [self cacheCellHeightWithContent:evaluateModel.nCComment withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateModel.nId isReply:NO];
//            }else{
//                BFCarEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
//                return [self cacheCellHeightWithContent:evaluateReplyModel.nCComment withFont:[UIFont fontWithName:BFfont size:13] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateReplyModel.nId isReply:YES];
//            }
//        }else if (indexPath.section - 2 - 1 == _carNewModel.wonderfulEvaluateArray.count){
//            return 50;
//        }else{
//            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[indexPath.section - 4 - _carNewModel.wonderfulEvaluateArray.count];
//            if (indexPath.row == 0) {
//                return [self cacheCellHeightWithContent:evaluateModel.nCComment withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateModel.nId isReply:NO];
//            }else{
//                BFCarEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
//                return [self cacheCellHeightWithContent:evaluateReplyModel.nCComment withFont:[UIFont fontWithName:BFfont size:13] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateReplyModel.nId isReply:YES];
//            }
//        }
//    }else if(_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
//        return 0;
//    }else if(!_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论没有 最新评论有
//        if (indexPath.section == 2){
//            return 50;
//        }else if (indexPath.section - 2 - 1 < _carNewModel.newestEvaluateArray.count){
//            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[indexPath.section - 3];
//            if (indexPath.row == 0) {
//                return [self cacheCellHeightWithContent:evaluateModel.nCComment withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateModel.nId isReply:NO];
//            }else{
//                BFCarEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
//                return [self cacheCellHeightWithContent:evaluateReplyModel.nCComment withFont:[UIFont fontWithName:BFfont size:13] withSize:CGSizeMake(KScreenW - 70, 1600) withId:evaluateReplyModel.nId isReply:YES];
//            }
//        }
//        return 0;
//    }else if(!_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
//        return 0;
//    }else{
//        return 0;
//    }
//
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }else if (indexPath.section == 1 ){
        if (_carNewModel.contentArray.count > 0) {
            if (!isExtend) {// 没展开
                if (indexPath.row == _carNewModel.contentArray.count) {
                    isExtend = YES;
                    [_tableView reloadData];
                }else{
                    
                }
            }else{// 展开
                
            }
        }else{
            
        }
    }else if(_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (indexPath.section == 2){
            
        }else if (indexPath.section - 3 < _carNewModel.wonderfulEvaluateArray.count){
            BFCarEvaluateModel *evaluateModel = _carNewModel.wonderfulEvaluateArray[indexPath.section - 3];
            if (indexPath.row == 0) {
                evaluateType = evaluateModel.nCId;
                evaluateIndexPath = indexPath;
                isEvaluate = YES;
            }else{
                BFCarEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                evaluateType = evaluateReplyModel.nCId;
                evaluateIndexPath = indexPath;
                isEvaluate = NO;
            }
        }else if (indexPath.section - 2 - 1 == _carNewModel.wonderfulEvaluateArray.count){
            
        }else{
            NSInteger tempCount = 4 + _carNewModel.wonderfulEvaluateArray.count;
            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[indexPath.section - tempCount];
            if (indexPath.row == 0) {
                evaluateType = evaluateModel.nCId;
                evaluateIndexPath = indexPath;
                isEvaluate = YES;
            }else{
                BFCarEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                evaluateType = evaluateReplyModel.nCId;
                evaluateIndexPath = indexPath;
                isEvaluate = NO;
            }
        }
        [self evaluateAction];
    }else if(_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        
    }else if(!_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论没有最新评论有
        if (indexPath.section == 2){
            
        }else if (indexPath.section - 2 - 1 < _carNewModel.newestEvaluateArray.count){
            BFCarEvaluateModel *evaluateModel = _carNewModel.newestEvaluateArray[indexPath.section - 3];
            if (indexPath.row == 0) {
                evaluateType = evaluateModel.nCId;
                evaluateIndexPath = indexPath;
                isEvaluate = YES;
            }else{
                BFCarEvaluateReplyModel *evaluateReplyModel = evaluateModel.replys[indexPath.row - 1];
                evaluateType = evaluateReplyModel.nCId;
                evaluateIndexPath = indexPath;
                isEvaluate = NO;
            }
        }
        [self evaluateAction];
    }else if(!_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        
    }else{
        
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RGBColor(240, 240, 240);
        return lineView;
    }else if (section == 1){
        return nil;
    }else if(_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (section == 2){
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = RGBColor(240, 240, 240);
            return lineView;
        }else if (section - 2 - 1 < _carNewModel.wonderfulEvaluateArray.count){
            return nil;
        }else if (section - 2 - 1 == _carNewModel.wonderfulEvaluateArray.count){
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = RGBColor(240, 240, 240);
            return lineView;
        }else{
            return nil;
        }
    }else if(_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        return nil;;
    }else if(!_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论没有 最新评论有
        if (section == 2){
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = RGBColor(240, 240, 240);
            return lineView;
        }else if (section - 2 - 1 < _carNewModel.wonderfulEvaluateArray.count){
            return nil;
        }
        return nil;
    }else if(!_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        return nil;;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if (section == 1){
        if (_carNewModel.contentArray.count > 0){
            if (_carNewModel.contentArray.count > ImgCount) {// 图片大于规定显示张数
                return 0;
            }else{// 图片小于规定显示张数
                return 0;
            }
        }else{// 占位cell
            return 0;
        }
    }else if(_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都有
        if (section == 2){
            return PXTOPT(16);
        }else if (section - 2 - 1 < _carNewModel.wonderfulEvaluateArray.count){
            return 0;
        }else if (section - 2 - 1 == _carNewModel.wonderfulEvaluateArray.count){
            return PXTOPT(16);
        }else{
            return 0;
        }
    }else if(_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论有最新评论没有 (不可能)
        return 0;
    }else if(!_carNewModel.haveWonderfulEvaluate && _carNewModel.haveNewestEvaluate) {// 精彩评论没有 最新评论有
        if (section == 2){
            return PXTOPT(16);
        }else if (section - 2 - 1 < _carNewModel.wonderfulEvaluateArray.count){
            return 0;
        }
        return 0;
    }else if(!_carNewModel.haveWonderfulEvaluate && !_carNewModel.haveNewestEvaluate) {// 精彩评论和最新评论都没有
        return 0;
    }else{
        return 0;
    }
}

//- (void)collectBtnAction:(UIButton *)btn{
//    NSString *url = [NSString stringWithFormat:@"%@?nId=%ld&uId=1&collected=%ld",NewsCollectURL,_carNewModel.nId,_carNewModel.collFlag];
//    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
//        NSDictionary *dic = data;
//        NSInteger status = [dic[@"status"] integerValue];
//        if (status) {
//            _carNewModel.collFlag = !_carNewModel.collFlag;
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [btn setImage:_carNewModel.collFlag ? [UIImage imageNamed:@"收藏成功"] : [UIImage imageNamed:@"收藏"] forState:(UIControlStateNormal)];
//            });
//
//        }
//    } failureResponse:^(NSError *error) {
//
//    }];
////    dispatch_async(dispatch_get_main_queue(), ^{
////
////    });
//    btn.userInteractionEnabled = NO;
//    [self performSelector:@selector(setBtnEnabled:) withObject:btn afterDelay:3.0f];
//}

- (void)collectBtnAction:(UIButton *)btn{
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        
        NSInteger collInt = 0;
        if (_carNewModel.collFlag > 0) {//已收藏
            collInt = 1;
        }
        else {//未收藏
            collInt = 0;
        }
        NSString *url = [NSString stringWithFormat:@"%@?nId=%ld&uId=%d&colled=%ld",NewsCollectURL,(long)_carNewModel.nId,[GetFromUserDefaults(@"uId") intValue],(long)collInt];
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                if (1 == collInt) {
                    [ZAlertView showSVProgressForSuccess:@"资讯取消收藏成功"];
                    [_collectBtn setTitle:@"收藏" forState:(UIControlStateNormal)];
                    [_collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:(UIControlStateNormal)];
                    _carNewModel.collFlag = 0;
                }
                else {
                    [ZAlertView showSVProgressForSuccess:@"资讯收藏成功"];
                    [_collectBtn setTitle:@"已收藏" forState:(UIControlStateNormal)];
                    [_collectBtn setImage:[UIImage imageNamed:@"收藏成功"] forState:(UIControlStateNormal)];
                    _carNewModel.collFlag = 10;
                }
            }
            else {
                [ZAlertView showSVProgressForErrorStatus:@"收藏失败"];
            }
        } failureResponse:^(NSError *error) {
        }];
        btn.userInteractionEnabled = NO;
        [self performSelector:@selector(setBtnEnabled:) withObject:btn afterDelay:3.0f];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

- (void)likeBtnAction:(UIButton *)btn{
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        
        
        if (_carNewModel.likeFlag > 0) {//已点赞
            _carNewModel.likeFlag = 1;

        }
        else {//未收藏
            _carNewModel.likeFlag = 0;
        }
        
        NSString *url = [NSString stringWithFormat:@"%@?nId=%ld&uId=%@&liked=%ld",CARNEWSLikeURL,_carNewModel.nId,GetFromUserDefaults(@"uId"),_carNewModel.likeFlag];
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                if (1 == _carNewModel.likeFlag) {
                    [ZAlertView showSVProgressForSuccess:@"取消点赞成功"];
                    [_likeBtn setTitle:[NSString stringWithFormat:@"%ld",_carNewModel.likeCount] forState:(UIControlStateNormal)];
                    _carNewModel.likeFlag = 0;
                    [btn setImage:[UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
                }
                else {
                    [ZAlertView showSVProgressForSuccess:@"点赞成功"];
                    [_likeBtn setTitle:@"已点赞" forState:(UIControlStateNormal)];
                    _carNewModel.likeFlag = 1;
                    [btn setImage:[UIImage imageNamed:@"点赞成功"] forState:(UIControlStateNormal)];
                }
            }
        } failureResponse:^(NSError *error) {
            
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        btn.userInteractionEnabled = NO;
        [self performSelector:@selector(setBtnEnabled:) withObject:btn afterDelay:5.0f];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

- (void)setBtnEnabled:(UIButton *)btn{
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //
    //    });
    btn.userInteractionEnabled = YES;
}

- (void)evaluateLikeBtnClick:(BFCarEvalucateCell *)cell {
//    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    BFCarEvaluateModel *model = cell.model;
    NSString *url = [NSString stringWithFormat:@"%@?nCId=%ld&uId=%@&liked=%ld",NewsCommentLikedURL,model.nCId,GetFromUserDefaults(@"uId"),model.comFlag];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            model.comFlag = !model.comFlag;
            model.nComCount = [dic[@"comLikeCount"] integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.likeBtn setImage:model.comFlag ? [UIImage imageNamed:@"赞-3拷贝2"] : [UIImage imageNamed:@"赞-3拷贝6"] forState:(UIControlStateNormal)];
                [cell.likeBtn setTitle:[NSString stringWithFormat:@"%ld",model.nComCount] forState:(UIControlStateNormal)];

            });

        }else{

        }
    } failureResponse:^(NSError *error) {
        
    }];
    
    cell.likeBtn.userInteractionEnabled = NO;
    [self performSelector:@selector(setBtnEnabled:) withObject:cell.likeBtn afterDelay:3.0f];
}


#pragma mark 过滤后台返回字符串中的标签
- (NSString *)flattenHTML:(NSString *)html {
    if (html && html.length > 0) {
        NSScanner *theScanner;
        NSString *text = nil;
        
        theScanner = [NSScanner scannerWithString:html];
        
        while ([theScanner isAtEnd] == NO) {
            // find start of tag
            [theScanner scanUpToString:@"<" intoString:NULL] ;
            // find end of tag
            [theScanner scanUpToString:@">" intoString:&text] ;
            // replace the found tag with a space
            //(you can filter multi-spaces out later if you wish)
            
            if (![text containsString:@"src=\""]) {
                html = [html stringByReplacingOccurrencesOfString:
                        [NSString stringWithFormat:@"%@>", text]
                                                       withString:@""];
            }
        }
        //      过滤html中的\n\r\t换行空格等特殊符号
//        NSMutableString *str1 = [NSMutableString stringWithString:html];
//        for (int i = 0; i < str1.length; i++) {
//            unichar c = [str1 characterAtIndex:i];
//            NSRange range = NSMakeRange(i, 1);
//
//            //  在这里添加要过滤的特殊符号
//            if ( c == '\r' || c == '\n' || c == '\t') {
//                [str1 deleteCharactersInRange:range];
//                --i;
//            }
//        }
//        html  = [NSString stringWithString:str1];
        
//        NSMutableString *str1 = [NSMutableString stringWithString:html];
//        for (int i = 0; i < str1.length; i++) {
//            if (i != 0) {
//                unichar c = [str1 characterAtIndex:i];
//                NSRange range = NSMakeRange(i, 1);
//                
//                //  在这里添加要过滤的特殊符号
//                if ( c == '\r' || c == '\n' || c == '\t') {
//                    [str1 deleteCharactersInRange:range];
//                    --i;
//                }
//            }
//        }
//        html  = [NSString stringWithString:str1];
        
        NSString *result = nil;
        result = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];  // 过滤&nbsp等标签
        html  = [NSString stringWithString:result];
    }
    return html;
}
/*
- (NSArray *)filterTheImgUrlArrFromfahterHtml:(NSString *)html{
    //<(img|IMG)[^\<\>]*>找img标签的正则
    
    NSString *ss = @"<(img|IMG)[^\\<\\>]*>";//img标签的正则表达式
    NSRegularExpression *pre = [[NSRegularExpression alloc] initWithPattern:ss options:0 error:nil];
    
    NSArray *arr = [pre matchesInString:html options:NSMatchingReportProgress range:NSMakeRange(0, html.length)];//这个方法匹配正则，找到符合的结果返回数组集合，返回的类型是NSTextCheckingResult下面会提到。
    NSMutableArray *mutArr = [NSMutableArray arrayWithCapacity:1];
    NSLog(@"---%@",arr);
    for (NSTextCheckingResult *match in arr) {
        NSRange matchRange = [match range];//返回的是每个imgb标签的位置
        NSString *imgDivStr = [html substringWithRange:matchRange];//根据位置找对应img标签
        imgDivStr = [imgDivStr stringByReplacingOccurrencesOfString:@" " withString:@""];//此处我为了找出图片URL过滤掉空格
        NSString *imgUrl = [[imgDivStr componentsSeparatedByString:@"src=\""] lastObject];
        imgUrl = [[imgUrl componentsSeparatedByString:@"\""] firstObject];
        [mutArr addObject:imgUrl];
        
    }
    NSLog(@"%@",mutArr);
    return [NSArray arrayWithArray:mutArr];
}

- (void)classifyStrAndImageWithStr:(NSString *)str{
    if ([str containsString:@"<"]) {
        NSMutableArray *arr = [str componentsSeparatedByString:@"<"].mutableCopy;
        for (int i = 0; i < arr.count; i++) {
            NSString *imgStr = nil;
            NSString *subStr = arr[i];
            if ([subStr containsString:@"src=\""]) {
                imgStr = [NSString stringWithFormat:@"<%@",subStr];
            }
            if ([imgStr containsString:@">"]) {
                NSMutableArray *subArr = [imgStr componentsSeparatedByString:@">"].mutableCopy;
                for (int j = 0; j < subArr.count; j++) {
                    NSString *imgStr = nil;
                    NSString *subStr = subArr[j];
                    if ([subStr containsString:@"src=\""]) {
                        imgStr = [NSString stringWithFormat:@"%@>",subStr];
                        [subArr replaceObjectAtIndex:j withObject:imgStr];
                    }
                }
                [arr replaceObjectAtIndex:i withObject:subArr];
            }
            
        }
        for (int k = 0; k < arr.count; k++) {
            if ([arr[k] isKindOfClass:[NSString class]]) {
                BFCarConsultContentModel *model = [BFCarConsultContentModel new];
                model.contentText = arr[k];
                model.carConsultContentModelType = BFCarConsultContentModelType_Text;
                [_carNewModel.contentArray addObject:model];
            }else if ([arr[k] isKindOfClass:[NSMutableArray class]]){
                NSArray *littleArr = arr[k];
                for (NSString *str in littleArr) {
                    if ([str containsString:@"src=\""]) {
                        NSString *imgUrl = nil;
                        for (int l = 0; l < imgArray.count; l++) {
                            if ([str containsString:imgArray[l]]) {
                                imgUrl = imgArray[l];
                                break;
                            }
                        }
                        BFCarConsultContentModel *model = [BFCarConsultContentModel new];
                        model.contentImageUrl = imgUrl;
                        model.carConsultContentModelType = BFCarConsultContentModelType_Image;
                        [_carNewModel.contentArray addObject:model];
                        [imgArray removeObject:imgUrl];
                    }else{
                        BFCarConsultContentModel *model = [BFCarConsultContentModel new];
                        model.contentText = str;
                        model.carConsultContentModelType = BFCarConsultContentModelType_Text;
                        [_carNewModel.contentArray addObject:model];
                    }
                }
                
            }
        }
    }
}
*/

#pragma mark -html处理-
- (NSMutableAttributedString *)replacingStringWithHtml:(NSString *)htmlStr{
    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    NSString *tempString = [self flattenHTML:htmlStr];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:tempString];
    [self getImageurlFromHtml:string];//具体实现放在文章后面
    // 循环遍历创建图片附件 并 替换原有范围的字符串
    
    for (int i= 0 ; i < self.rangeArr.count; i++) {
        // 创建图片图片附件
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        
        NSString *imageUrlStr = self.imageurlArray[i];
        
        NSURL *url = [NSURL URLWithString:imageUrlStr];
        
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        
        attach.image = [UIImage imageWithData:imageData];
        CGFloat imgW = KScreenW - PXTOPT(20);
        CGFloat imgH = (imgW / attach.image.size.width) * attach.image.size.height;
        attach.bounds = CGRectMake(0, 0, imgW, imgH);
        
        NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
        
        // 点击图片跳转到safari
        NSMutableAttributedString *maImageStr = [[NSMutableAttributedString alloc] initWithAttributedString:attachString];
        
        [maImageStr addAttribute:NSLinkAttributeName value:self.imageurlArray[i] range:NSMakeRange(0, maImageStr.length)];
        
        NSString *rangeStr = self.rangeArr[i];
        
        NSRange range = NSRangeFromString(rangeStr);
        
        if (i>0) {
            NSInteger length = 0;
            for (int j = 0; j<i; j++) {
                NSString *rangeStr0 = self.rangeArr[j];
                
                NSRange range0 = NSRangeFromString(rangeStr0);
                length = length + range0.length;
                NSLog(@"\nlocation:%ld\nlength:%ld\nstringlength:%ld",range0.location,range0.length,string.length);
            }
            
            range.location = range.location - length + i;
        }
        //创建NSMutableParagraphStyle实例
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
        //设置行距
        [style setLineSpacing:0];
        //根据给定长度与style设置attStr式样
        [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
        [string replaceCharactersInRange:range withAttributedString:maImageStr];
        
    }
    return string;
}

// 获取图片URL方法
- (NSArray *) getImageurlFromHtml:(NSMutableAttributedString *) webString
{
    if (webString.length==0) {
        return nil;
    }
    NSString *webStr  = [NSString stringWithFormat:@"%@",webString];
    if (!self.imageurlArray) {
        self.imageurlArray = [NSMutableArray array];
    }
    if (!self.rangeArr) {
        self.rangeArr = [NSMutableArray array];
    }
    
    //标签匹配
    NSString *parten = @"<img(.*?)>";
    NSError* error = NULL;
    NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
    
    NSArray* match = [reg matchesInString:webStr options:0 range:NSMakeRange(0, [webString length] - 1)];
    if (match.count > 0) {
        for (NSTextCheckingResult * result in match) {
            
            //过去数组中的标签
            NSRange range = [result range];
            [self.rangeArr addObject:NSStringFromRange(range)];
            NSString * subString = [webStr substringWithRange:range];
            
            
            //从图片中的标签中提取ImageURL
            NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)\"" options:0 error:NULL];
            NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
            NSTextCheckingResult * subRes = match[0];
            NSRange subRange = [subRes range];
            subRange.length = subRange.length -1;
            NSString * imagekUrl = [subString substringWithRange:subRange];
            
            //将提取出的图片URL添加到图片数组中
            [self.imageurlArray addObject:imagekUrl];
        }
    }
    return self.imageurlArray;
}

#pragma mark -获取评论-
- (void)getEvaluateNetWorkWithURL:(NSString *)url{
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            NSArray *arr = dic[@"data"];
            _carNewModel.curPage = [dic[@"curPage"] integerValue];
            _carNewModel.lastPage = [dic[@"lastPage"] integerValue];
            if (_carNewModel.curPage == 1) {
                if (arr && arr.count > 0) {
                    _carNewModel.haveNewestEvaluate = YES;
                    if (!_carNewModel.newestEvaluateArray) {
                        _carNewModel.newestEvaluateArray = [NSMutableArray array];
                    }
                }else{
                    _carNewModel.haveNewestEvaluate = NO;
                }
                [_carNewModel.newestEvaluateArray removeAllObjects];
            }else{
                
            }
            for (NSDictionary *dict in arr) {
                BFCarEvaluateModel *evaluateModel = [BFCarEvaluateModel initWithDict:dict];
                [_carNewModel.newestEvaluateArray addObject:evaluateModel];
            }
            
            NSArray *wCommentArr = dic[@"wData"];
            if (wCommentArr && wCommentArr.count > 0) {
                _carNewModel.haveWonderfulEvaluate = YES;
                if (!_carNewModel.wonderfulEvaluateArray) {
                    _carNewModel.wonderfulEvaluateArray = [NSMutableArray array];
                }
            }else{
                _carNewModel.haveWonderfulEvaluate = NO;
            }
            [_carNewModel.wonderfulEvaluateArray removeAllObjects];
            for (NSDictionary *dict in wCommentArr) {
                BFCarEvaluateModel *evaluateModel = [BFCarEvaluateModel initWithDict:dict];
                [_carNewModel.wonderfulEvaluateArray addObject:evaluateModel];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            [self.tableView.mj_footer endRefreshing];
            if (_carNewModel.lastPage == _carNewModel.curPage) {
                self.tableView.mj_footer.hidden = YES;
            }
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failureResponse:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}


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
//        CGFloat h = isReply ? [UILabel sizeWithString:content font:font size:size].height + 10 : [UILabel sizeWithString:content font:font size:size].height + 105;
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

- (void)loadNewData{
    NSString *url = [NSString stringWithFormat:@"%@?startPage=1&nId=%ld&uId=%@",NewsGetEvaluateURL,_carNewModel.nId,GetFromUserDefaults(@"uId")];
    [self getEvaluateNetWorkWithURL:url];
}

- (void)loadMoreData{
    if (_carNewModel.curPage < _carNewModel.lastPage) {
        NSString *url;
        NSString *str = GetFromUserDefaults(@"loginStatus");
        if ([str isEqualToString:@"1"]) { //用户已登录
            url = [NSString stringWithFormat:@"%@?startPage=%ld&nId=%ld&uId=%@",NewsGetEvaluateURL,_carNewModel.curPage + 1,_carNewModel.nId,GetFromUserDefaults(@"uId")];
        }
        else {
            url = [NSString stringWithFormat:@"%@?startPage=%ld&nId=%ld&uId=%@",NewsGetEvaluateURL,_carNewModel.curPage + 1,_carNewModel.nId,@"0"];
        }
        [self getEvaluateNetWorkWithURL:url];
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
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
                __weak BFCarConsultDetailsVC *weakSelf = self;
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
            __weak BFCarConsultDetailsVC *weakSelf = self;
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

- (void)sendEditEvaluateWithContent:(NSString *)content{
    NSMutableDictionary *paramet = [NSMutableDictionary dictionary];
    [paramet setValue:@([GetFromUserDefaults(@"uId") integerValue]) forKey:@"uId"];
    [paramet setValue:@(_carNewModel.nId) forKey:@"nId"];
    [paramet setValue:@(evaluateType) forKey:@"nCState"];
    [paramet setValue:content forKey:@"nCComment"];
    [NetworkRequest sendDataWithUrl:NewsEvaluateURL parameters:paramet successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            _carNewModel.curPage = [dic[@"curPage"] integerValue];
            _carNewModel.lastPage = [dic[@"lastPage"] integerValue];
            NSArray *arr = dic[@"data"];
            if (arr && arr.count > 0) {
                _carNewModel.haveNewestEvaluate = YES;
                if (!_carNewModel.newestEvaluateArray) {
                    _carNewModel.newestEvaluateArray = [NSMutableArray array];
                }
                [_carNewModel.newestEvaluateArray removeAllObjects];
                
            }else{
                _carNewModel.haveNewestEvaluate = NO;
            }
            for (NSDictionary *dict in arr) {
                BFCarEvaluateModel *evaluateModel = [BFCarEvaluateModel initWithDict:dict];
                [_carNewModel.newestEvaluateArray addObject:evaluateModel];
            }
            NSArray *wCommentArr = dic[@"wDate"];
            if (wCommentArr && wCommentArr.count > 0) {
                _carNewModel.haveWonderfulEvaluate = YES;
                if (!_carNewModel.wonderfulEvaluateArray) {
                    _carNewModel.wonderfulEvaluateArray = [NSMutableArray array];
                }
                [_carNewModel.wonderfulEvaluateArray removeAllObjects];
            }else{
                _carNewModel.haveWonderfulEvaluate = NO;
            }
            for (NSDictionary *dict in wCommentArr) {
                BFCarEvaluateModel *evaluateModel = [BFCarEvaluateModel initWithDict:dict];
                [_carNewModel.wonderfulEvaluateArray addObject:evaluateModel];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
            [self showHUD:@"评论成功"];
            [self.tableView.mj_footer endRefreshing];
            self.tableView.mj_footer.hidden = NO;
        }else{
            [self showHUD:@"评论失败"];
        }
        
    } failure:^(NSError *error) {
        [self showHUD:@"评论失败"];
    }];
}


#pragma mark -搜修车配合接口-
- (void)sxcNetwork{
    NSString *url;
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        url = [NSString stringWithFormat:@"%@?nId=%ld&uId=%@",SXCConsult,_carNewModel.nId,GetFromUserDefaults(@"uId")];
    }
    else {
        url = [NSString stringWithFormat:@"%@?nId=%ld&uId=%@",SXCConsult,_carNewModel.nId,@"0"];
    }
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSDictionary *dict = data;
        NSInteger status = [dict[@"status"] integerValue];
        if (status == 1) {
            [_carNewModel fillWithDict:dict[@"data"]];
            [self manageData];
            [self loadNewData];
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
