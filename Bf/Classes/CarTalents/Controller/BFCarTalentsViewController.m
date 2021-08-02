//
//  BFCarTalentsViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCarTalentsViewController.h"
#import "MMComBoBox.h"
#import "BFCompanyListCell.h"
#import "BFCarTalentsUserCenterViewController.h"//工作台页面
#import "BFCompanyDetailViewController.h"//公司详情页面
#import "BFCompanyUnidentifyViewController.h"//企业认证页面
#import "BFCompanyInformationViewController.h"//企业信息页面
#import "BFJobHunterController.h"//求职者页面
#import "BFCarTalentsListModel.h"
#import "BFCompanyListCell.h"
#import "BFJobListModel.h"
#import "BFCompanyJobListCell.h"
#import "CCTabBarController.h"
#import "CCTabBar.h"
@interface BFCarTalentsViewController ()<MMComBoBoxViewDataSource, MMComBoBoxViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *provinceArr,*cityArr;
}
@property (nonatomic, strong) NSArray *mutableArray;
@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UITableView *companyTableView;
// 城市字典
@property (nonatomic , strong) NSMutableDictionary *citysDict;
// 省
@property (nonatomic , strong) NSString *provinceStr;
// 市
@property (nonatomic , strong) NSDictionary *cityDic;
//点击切换按钮的几种状态
@property (nonatomic,copy) NSString *style;

/*车人才个人版企业列表数组*/
@property (nonatomic,strong) NSMutableArray <BFCarTalentsListModel *>*carTalentArray;

/*车人才企业版企业列表数组*/
@property (nonatomic,strong) NSMutableArray <BFJobListModel *>*companyArray;

/*工作地址*/
@property (nonatomic,copy) NSString *locationStr;
/*学历*/
@property (nonatomic,copy) NSString *xueliStr;
/*工作经验*/
@property (nonatomic,copy) NSString *jingyanStr;
/*薪资*/
@property (nonatomic,copy) NSString *moneyStr;
/*公司规模*/
@property (nonatomic,copy) NSString *guimoStr;
/*工作性质*/
@property (nonatomic,copy) NSString *xingzhiStr;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger lastPage;
@property (nonatomic,assign) int a;
@property (nonatomic,strong) BFCompanyJobListCell *cell;
@property (nonatomic, assign) NSInteger indexRow;
@property (nonatomic , strong) NSMutableDictionary *dataDic;
/*导航栏左侧按钮*/
@property (nonatomic,strong) UIButton *leftBtn;

@property (nonatomic,strong) UIImageView * leftImageView;

@end

@implementation BFCarTalentsViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    if (GetFromUserDefaults(@"iPhoto") == nil) {
//        [self.leftBtn setBackgroundImage:[UIImage imageNamed:@"123"] forState:UIControlStateNormal];
//    }
//    else {
////        [self.leftBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:GetFromUserDefaults(@"iPhoto")]]] forState:UIControlStateNormal];
//        [self.leftBtn.imageView sd_setImageWithURL:[NSURL URLWithString:GetFromUserDefaults(@"iPhoto")] placeholderImage:[UIImage imageNamed:@"123"]];
//    }
    
    if (GetFromUserDefaults(@"iPhoto") ==nil) {
        self.leftImageView.image = [UIImage imageNamed:@"123"];
    }else{
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:GetFromUserDefaults(@"iPhoto")] placeholderImage:[UIImage imageNamed:@"123"]];
        
        
    }
    
    //通知:更改数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePersonalAction) name:@"changeStatus" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLocationAction) name:@"resetLocation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changepostAction) name:@"postJob" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSureLocationAction) name:@"sureLocation" object:nil];
    
}

-(void)changeLocationAction {
    
    NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
    NSString *urlStr = [NSString stringWithFormat:@"%@/bfJobController/bfJobWorkSelectList.do?uId=%ld&startPage=%@&bRId=%@&jWDiploma=%@&jWYear=%@&jWMoney=%@&jCSize=%@&jMState=%@",ServerURL,(long)uid,@"1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1"];
    _pageIndex = 1;
    self.locationStr = @"-1";
    self.xueliStr = @"-1";
    self.jingyanStr = @"-1";
    self.moneyStr = @"-1";
    self.guimoStr = @"-1";
    self.xingzhiStr = @"-1";
    [self networkRequest:urlStr];
}

-(void)changePersonalAction {
    [self.tableView removeFromSuperview];
    [self.companyTableView removeFromSuperview];
    self.comBoBoxView.hidden = NO;
    [self.companyTableView removeFromSuperview];
    NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
    _pageIndex = 1;
    self.locationStr = @"-1";
    self.xueliStr = @"-1";
    self.jingyanStr = @"-1";
    self.moneyStr = @"-1";
    self.guimoStr = @"-1";
    self.xingzhiStr = @"-1";
    self.a = 0;
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do?uId=%d&startPage=%d&bRId=%@&jWDiploma=%@&jWYear=%@&jWMoney=%@&jCSize=%@&jMState=%@",ServerURL,uid,_pageIndex,self.locationStr,self.xueliStr,self.jingyanStr,self.moneyStr,self.guimoStr,self.xingzhiStr];
    [self networkRequest:urlStr];
    [self setUpTableView];
}

-(void)changepostAction {
    self.a = 1;
    [self.tableView removeFromSuperview];
    [self.companyTableView removeFromSuperview];
    NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectListByCom.do?uId=%d&startPage=1",ServerURL,uid];
    [self networkRequest1:urlStr1];
    [self companyTableview];
}

-(void)changeSureLocationAction {
    NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do?uId=%d&startPage=%d&bRId=%@&jWDiploma=%@&jWYear=%@&jWMoney=%@&jCSize=%@&jMState=%@",ServerURL,uid,_pageIndex,self.locationStr,self.xueliStr,self.jingyanStr,self.moneyStr,self.guimoStr,self.xingzhiStr];
    [self networkRequest:urlStr];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"车·人才";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.a = 0;
    self.companyTableView.hidden = YES;
    self.tableView.hidden = NO;
    if (KIsiPhoneX) {
        self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, 88, kScreenWidth, 40)];
    }
    else {
        self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    }
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];
    [self setUpTableView];
    //设置导航栏顶部左右按钮
    [self createNavButton];
    _pageIndex = 1;
    _indexRow = 0;
    self.locationStr = @"-1";
    self.xueliStr = @"-1";
    self.jingyanStr = @"-1";
    self.moneyStr = @"-1";
    self.guimoStr = @"-1";
    self.xingzhiStr = @"-1";
    
    NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
    NSString *urlStr1 = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectListByCom.do?uId=%d&startPage=1",ServerURL,uid];
    [self networkRequest1:urlStr1];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do?uId=%d&startPage=%d&bRId=%@&jWDiploma=%@&jWYear=%@&jWMoney=%@&jCSize=%@&jMState=%@",ServerURL,uid,_pageIndex,self.locationStr,self.xueliStr,self.jingyanStr,self.moneyStr,self.guimoStr,self.xingzhiStr];
    [self networkRequest:urlStr];
    
    __weak typeof(self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
//    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
    if (bottomOffset < height)
    {
        //在最底部
        NSLog(@"在最底部");
        [self loadMoreData];
    }
    else
    {
        NSLog(@"不在最底部");
    }
}

-(void)createNavButton {
    //设置个人中心按钮
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftView.backgroundColor = [UIColor whiteColor];
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.leftBtn = leftBtn;
//    if (GetFromUserDefaults(@"iPhoto") == nil) {
//       [leftBtn setBackgroundImage:[UIImage imageNamed:@"123"] forState:UIControlStateNormal];
//    }
//    else {
//        [leftBtn setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:GetFromUserDefaults(@"iPhoto")]]] forState:UIControlStateNormal];
//
//    }
//    [leftBtn setFrame:CGRectMake(0, 0, 40, 40)];
//    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.layer.cornerRadius = 20.0f;
//    leftBtn.clipsToBounds = YES;
//    [leftView addSubview:leftBtn];
    
    UIImageView * leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.leftImageView = leftImage;
    leftImage.layer.cornerRadius = 20;
    leftImage.layer.masksToBounds = YES;
    [leftView addSubview:leftImage];
    
    if (GetFromUserDefaults(@"iPhoto") ==nil) {
        self.leftImageView.image = [UIImage imageNamed:@"123"];
    }else{
        [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:GetFromUserDefaults(@"iPhoto")] placeholderImage:[UIImage imageNamed:@"123"]];
        
        
    }
    leftImage.userInteractionEnabled = YES;
    UITapGestureRecognizer * leftImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(leftImageClick:)];
    [leftImage addGestureRecognizer:leftImageTap];
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc] initWithCustomView:leftView];

    self.navigationItem.leftBarButtonItems = @[item0];
    
    
    //设置切换按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"切换"] forState:(UIControlStateNormal)];
    //让按钮往左移动15个单位
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -15);
    [rightBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[item1];
}

#pragma mark - 个人中心点击事件
-(void)leftImageClick:(UITapGestureRecognizer *)tap{
    [self leftBtnClick];
}
-(void)leftBtnClick {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        NSString *str = [NSString stringWithFormat:@"%@",GetFromUserDefaults(@"uId")];
        NSDictionary *dic = @{@"uId":str};
        [NetworkRequest requestWithUrl:QueryCompanyCertification parameters:dic successResponse:^(id data) {
            NSDictionary *dict = data;
            if (1 == [dict[@"status"] intValue]) {
                NSString *authStr = [NSString stringWithFormat:@"%@",dict[@"auState"]];
                if ([authStr isEqualToString:@"1"]) {
                    if (0 == self.a) {
                        //企业认证-个人版
                        BFCarTalentsUserCenterViewController *userCenterVC = [[BFCarTalentsUserCenterViewController alloc] init];
                        userCenterVC.centerStyle = @"0";//0个人 ---- 1企业
                        [self.navigationController pushViewController:userCenterVC animated:YES];
                    }
                    else {
                        //企业认证-企业版
                        BFCarTalentsUserCenterViewController *userCenterVC = [[BFCarTalentsUserCenterViewController alloc] init];
                        userCenterVC.centerStyle = @"1";//0个人 ---- 1企业
                        [self.navigationController pushViewController:userCenterVC animated:YES];
                    }
                }
                else {
                    BFCarTalentsUserCenterViewController *userCenterVC = [[BFCarTalentsUserCenterViewController alloc] init];
                    userCenterVC.centerStyle = @"0";//0个人 ---- 1企业
                    [self.navigationController pushViewController:userCenterVC animated:YES];
                }
            }
            else if (2 == [dict[@"status"] intValue]) {
                [ZAlertView showSVProgressForErrorStatus:@"传入的参数有误"];
            }
            else if (4 == [dict[@"status"] intValue]) {
                BFCarTalentsUserCenterViewController *userCenterVC = [[BFCarTalentsUserCenterViewController alloc] init];
                userCenterVC.centerStyle = @"0";//0个人 ---- 1企业
                [self.navigationController pushViewController:userCenterVC animated:YES];
            }
        } failureResponse:^(NSError *error) {
            BFCarTalentsUserCenterViewController *userCenterVC = [[BFCarTalentsUserCenterViewController alloc] init];
            userCenterVC.centerStyle = @"0";//0个人 ---- 1企业
            [self.navigationController pushViewController:userCenterVC animated:YES];
        }];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

#pragma mark - 切换按钮点击事件

-(void)rightBtnClick {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        
        NSString *str = [NSString stringWithFormat:@"%@",GetFromUserDefaults(@"uId")];
        NSDictionary *dic = @{@"uId":str};
        [NetworkRequest requestWithUrl:QueryCompanyCertification parameters:dic successResponse:^(id data) {
            NSDictionary *dict = data;
            if (1 == [dict[@"status"] intValue]) {
                NSString *authStr = [NSString stringWithFormat:@"%@",dict[@"auState"]];
                NSString *imformationStr = [NSString stringWithFormat:@"%@",dict[@"perfect"]];
                if ([authStr isEqualToString:@"0"]) {
                    //企业认证正在审核中
                    BFCompanyUnidentifyViewController *unidentifyVC = [[BFCompanyUnidentifyViewController alloc] init];
                    unidentifyVC.style1 = @"0";
                    [self.navigationController pushViewController:unidentifyVC animated:YES];
                }
                else if ([authStr isEqualToString:@"1"] && [imformationStr isEqualToString:@"1"]) {
                    //企业认证通过但是需要完善企业信息
                    BFCompanyInformationViewController *informationVC = [[BFCompanyInformationViewController alloc] init];
                    informationVC.jCid = dict[@"jCId"];
                    [self.navigationController pushViewController:informationVC animated:YES];
                }
                else if ([authStr isEqualToString:@"1"] && [imformationStr isEqualToString:@"0"]) {
                    //企业认证通过而且企业信息已经完善 ---- 点击切换用户了就
                    if (0 == self.a) {
                        [self.tableView removeFromSuperview];
                        self.comBoBoxView.hidden = YES;
                        self.companyTableView.hidden = NO;
                        self.a = 1;
                        [ZAlertView showSVProgressForInfoStatus:@"为您切换到企业版"];
                        NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
                        NSString *urlStr1 = [NSString stringWithFormat:@"%@/bfJobController/bfJobWorkSelectListByCom.do?uId=%d&startPage=1",ServerURL,uid];
                        [self networkRequest1:urlStr1];
                        [self companyTableview];
                    }
                    else {
                        self.tableView.hidden = NO;
                        self.comBoBoxView.hidden = NO;
                        [self.companyTableView removeFromSuperview];
                        self.a = 0;
                        [ZAlertView showSVProgressForInfoStatus:@"为您切换到个人版"];
                        NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
                        NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do?uId=%d&startPage=%@&bRId=%@&jWDiploma=%@&jWYear=%@&jWMoney=%@&jCSize=%@&jMState=%@",ServerURL,uid,@"1",@"-1",@"-1",@"-1",@"-1",@"-1",@"-1"];
                        
                        _pageIndex = 1;
                        self.locationStr = @"-1";
                        self.xueliStr = @"-1";
                        self.jingyanStr = @"-1";
                        self.moneyStr = @"-1";
                        self.guimoStr = @"-1";
                        self.xingzhiStr = @"-1";

                        [self networkRequest:urlStr];
                        [self setUpTableView];
                    }
                }
                else if ([authStr isEqualToString:@"2"]) {
                    //企业认证
                    BFCompanyUnidentifyViewController *unidentifyVC = [[BFCompanyUnidentifyViewController alloc] init];
                    unidentifyVC.style1 = @"2";
                    [self.navigationController pushViewController:unidentifyVC animated:YES];
                }
            }
            else if (2 == [dict[@"status"] intValue]) {
                [ZAlertView showSVProgressForErrorStatus:@"传入的参数有误"];
            }
            else if (4 == [dict[@"status"] intValue]) {
//                [ZAlertView showSVProgressForErrorStatus:@"该企业没有进行认证"];
                //企业认证正在审核中
                BFCompanyUnidentifyViewController *unidentifyVC = [[BFCompanyUnidentifyViewController alloc] init];
                unidentifyVC.style1 = @"2";
                [self.navigationController pushViewController:unidentifyVC animated:YES];
            }
            
        } failureResponse:^(NSError *error) {
            
        }];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.comBoBoxView dimissPopView];
    
}

#pragma mark - MMComBoBoxViewDataSource
- (NSUInteger)numberOfColumnsIncomBoBoxView :(MMComBoBoxView *)comBoBoxView {
    return self.mutableArray.count;
}

- (MMItem *)comBoBoxView:(MMComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.mutableArray[column];
}

#pragma mark - MMComBoBoxViewDelegate
- (void)comBoBoxView:(MMComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    MMItem *rootItem = self.mutableArray[index];
    switch (rootItem.displayType) {
        case MMPopupViewDisplayTypeNormal:
        case MMPopupViewDisplayTypeMultilayer:{
            //拼接选择项
            NSMutableString *title = [NSMutableString string];
            __block NSInteger firstPath;
            [array enumerateObjectsUsingBlock:^(MMSelectedPath * path, NSUInteger idx, BOOL * _Nonnull stop) {
                [title appendString:idx?[NSString stringWithFormat:@";%@",[rootItem findTitleBySelectedPath:path]]:[rootItem findTitleBySelectedPath:path]];
                if (idx == 0) {
                    firstPath = path.firstPath;
                }
            }];
            for (int i = 0; i < [provinceArr count]; i++){
                NSDictionary *dic0 = provinceArr[i];
                NSArray *arr = dic0[@"citys"];
                for (int j = 0; j < [arr count]; j ++) {
                    NSDictionary *dic = arr[j];
                    if ([title isEqualToString:dic[@"brname"]]) {
                        NSLog(@"该城市的id为%@",dic[@"brid"]);
                        self.locationStr = [NSString stringWithFormat:@"%@",dic[@"brid"]];
                        [self.carTalentArray removeAllObjects];
                        NSLog(@"数组个数为:%d",self.carTalentArray.count);
                        NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
                        NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do?uId=%d&startPage=%d&bRId=%@&jWDiploma=%@&jWYear=%@&jWMoney=%@&jCSize=%@&jMState=%@",ServerURL,uid,_pageIndex,self.locationStr,self.xueliStr,self.jingyanStr,self.moneyStr,self.guimoStr,self.xingzhiStr];
                        [self networkRequest:urlStr];
                    }
                    else {
                        
                    }
                }
            }
            NSLog(@"当title为%@时，123123123为 %@",rootItem.title,title);
            break;
        }
        case MMPopupViewDisplayTypeFilters:{
            MMCombinationItem * combineItem = (MMCombinationItem *)rootItem;
            [array enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull subArray, NSUInteger idx, BOOL * _Nonnull stop) {
                if (combineItem.isHasSwitch && idx == 0) {
                    for (MMSelectedPath *path in subArray) {
                        MMAlternativeItem *alternativeItem = combineItem.alternativeArray[path.firstPath];
                        NSLog(@"当title为: %@ 时，选中状态为: %d",alternativeItem.title,alternativeItem.isSelected);
                    }
                    return;
                }
                
                NSString *title;
                NSMutableString *subtitles = [NSMutableString string];
                for (MMSelectedPath *path in subArray) {
                    MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
                    MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"%@",secondItem.title]];
                }
                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
                NSString *subtitle = [NSString stringWithFormat:@"%@",subtitles];
                
                if ([title isEqualToString:@"公司规模"]) {
                    NSLog(@"此时选中的数据为:%@",subtitles);
                    
                    if ([subtitle isEqualToString:@"少于15人"]) {
                        self.guimoStr = @"0";
                    }
                    else if ([subtitle isEqualToString:@"15-50人"]) {
                        self.guimoStr = @"1";
                    }
                    else if ([subtitle isEqualToString:@"50-150人"]) {
                        self.guimoStr = @"2";
                    }
                    else if ([subtitle isEqualToString:@"150-500人"]) {
                        self.guimoStr = @"3";
                    }
                    else if ([subtitle isEqualToString:@"500-1000人"]) {
                        self.guimoStr = @"4";
                    }
                    else if ([subtitle isEqualToString:@"1000人以上"]) {
                        self.guimoStr = @"5";
                    }
                    else {
                        self.guimoStr = @"-1";
                    }
                }
                else if ([title isEqualToString:@"工作性质"]){
                    NSLog(@"此时选中的数据为:%@",subtitles);
                    if ([subtitle isEqualToString:@"全职"]) {
                        self.xingzhiStr = @"0";
                    }
                    else if ([subtitle isEqualToString:@"兼职"]) {
                        self.xingzhiStr = @"1";
                    }
                    else if ([subtitle isEqualToString:@"实习"]) {
                        self.xingzhiStr = @"2";
                    }
                    else {
                        self.xingzhiStr = @"-1";
                    }
                }
                else if ([title isEqualToString:@"学历"]){
                    if ([subtitle isEqualToString:@"中专及以下"]) {
                        self.xueliStr = @"1";
                    }
                    else if ([subtitle isEqualToString:@"高中"]) {
                        self.xueliStr = @"2";
                    }
                    else if ([subtitle isEqualToString:@"大专"]) {
                        self.xueliStr = @"3";
                    }
                    else if ([subtitle isEqualToString:@"本科"]) {
                        self.xueliStr = @"4";
                    }
                    else {
                        self.xueliStr = @"-1";
                    }
                }
                else if ([title isEqualToString:@"经验"]){
                    if ([subtitle isEqualToString:@"应届生"]) {
                        self.jingyanStr = @"0";
                    }
                    else if ([subtitle isEqualToString:@"1-3年"]) {
                        self.jingyanStr = @"1";
                    }
                    else if ([subtitle isEqualToString:@"3-5年"]) {
                        self.jingyanStr = @"2";
                    }
                    else if ([subtitle isEqualToString:@"5-10年"]) {
                        self.jingyanStr = @"3";
                    }
                    else if ([subtitle isEqualToString:@"10年以上"]) {
                        self.jingyanStr = @"4";
                    }
                    else {
                        self.jingyanStr = @"-1";
                    }
                }
                else if ([title isEqualToString:@"薪资"]){
                    if ([subtitle isEqualToString:@"面议"]) {
                        self.moneyStr = @"0";
                    }
                    else if ([subtitle isEqualToString:@"3千以下"]) {
                        self.moneyStr = @"1";
                    }
                    else if ([subtitle isEqualToString:@"3千-5千"]) {
                        self.moneyStr = @"2";
                    }
                    else if ([subtitle isEqualToString:@"5千-7千"]) {
                        self.moneyStr = @"3";
                    }
                    else if ([subtitle isEqualToString:@"7千-1万"]) {
                        self.moneyStr = @"4";
                    }
                    else if ([subtitle isEqualToString:@"1万-1.5万"]) {
                        self.moneyStr = @"5";
                    }
                    else if ([subtitle isEqualToString:@"1.5万以上"]) {
                        self.moneyStr = @"6";
                    }
                    else {
                        self.moneyStr = @"-1";
                    }
                }
                
            }];
            
            break;
            
        }
        default:
            break;
    }
    [self.carTalentArray removeAllObjects];
    NSLog(@"数组个数为:%ld",self.carTalentArray.count);
    NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do?uId=%ld&startPage=%ld&bRId=%@&jWDiploma=%@&jWYear=%@&jWMoney=%@&jCSize=%@&jMState=%@",ServerURL,uid,_pageIndex,self.locationStr,self.xueliStr,self.jingyanStr,self.moneyStr,self.guimoStr,self.xingzhiStr];
    [self networkRequest:urlStr];
}

#pragma mark - Getter
- (NSArray *)mutableArray {
    if (_mutableArray == nil) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        //root1 城市地区选择
        MMMultiItem *rootItem1 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"城市"];
        rootItem1.displayType = MMPopupViewDisplayTypeMultilayer;
        
        NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfRegionalSelectList.do",ServerURL];
        [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
            provinceArr = data;
//            NSDictionary *totalDic =
//                                  @{
//                                      @"brid":@(1),
//                                      @"brname":@"全国",
//                                      @"brstate":@(0),
//                                      @"citys": @[
//                                                    @{
//                                                        @"brid":@(1),
//                                                        @"brname":@"全国",
//                                                        @"brstate":@(100)
//
//                                                        }
//                                                    ]
//                                      };
//
//            [provinceArr insertObject:totalDic atIndex:0];
            for (NSDictionary *dic in provinceArr) {
                [_citysDict setValue:dic[@"citys"] forKey:dic[@"brname"]];
            }
            
            NSLog(@"城市数据为:%@",cityArr);
            for (int i = 0; i < [provinceArr count]; i++){
                NSDictionary *dic0 = provinceArr[i];
                cityArr = [[provinceArr objectAtIndex:i] objectForKey:@"citys"];
                NSString *cityStr = dic0[@"brname"];
                MMItem *item1_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:cityStr subtitleName:nil];
                item1_A.isSelected = (i == 0);
                [rootItem1 addNode:item1_A];
                NSArray *arr = dic0[@"citys"];
                for (int j = 0; j < [arr count]; j ++) {
                    NSDictionary *dic = arr[j];
                    NSString *cityStr = dic[@"brname"];
                    MMItem *item1_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:NO titleName:cityStr subtitleName:nil];
                    item1_B.isSelected = (i == 0 && j == 0);
                    [item1_A addNode:item1_B];
                }
            }
        } failureResponse:^(NSError *error) {
            
        }];
        
        //root2 公司规模筛选
        MMCombinationItem *rootItem2 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:NO titleName:@"公司" subtitleName:nil];
        rootItem2.displayType = MMPopupViewDisplayTypeFilters;
        
        if (self.isMultiSelection)
            rootItem2.selectedType = MMPopupViewMultilSeMultiSelection;
        
        NSArray *arr = @[
                         @{@"公司规模":@[@"全部",@"少于15人",@"15-50人",@"50-150人",@"150-500人",@"500-1000人",@"1000人以上"]},
                         @{@"工作性质":@[@"全部",@"全职",@"兼职",@"实习"]}
                         ];
        
        for (NSDictionary *itemDic in arr) {
            MMItem *item2_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:[itemDic.allKeys lastObject]];
            [rootItem2 addNode:item2_A];
            for (int i = 0; i <  [[itemDic.allValues lastObject] count]; i++) {
                NSString *title = [itemDic.allValues lastObject][i];
                MMItem *item2_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:title];
                if (i == 0) {
                    item2_B.isSelected = YES;
                }
                [item2_A addNode:item2_B];
            }
        }
        
        //root3个人条件要求
        MMCombinationItem *rootItem3 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:NO titleName:@"要求" subtitleName:nil];
        rootItem3.displayType = MMPopupViewDisplayTypeFilters;
        if (self.isMultiSelection)
            rootItem3.selectedType = MMPopupViewMultilSeMultiSelection;
        NSArray *arr1 = @[@{@"学历":@[@"全部",@"中专及以下",@"高中",@"大专",@"本科"]},
                         @{@"经验":@[@"全部",@"应届生",@"1-3年",@"3-5年",@"5-10年",@"10年以上"]},
                         @{@"薪资":@[@"全部",@"面议",@"3千以下",@"3千-5千",@"5千-7千",@"7千-1万",@"1万-1.5万",@"1.5万以上"]} ];
        
        for (NSDictionary *itemDic in arr1) {
            MMItem *item3_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:[itemDic.allKeys lastObject]];
            [rootItem3 addNode:item3_A];
            for (int i = 0; i <  [[itemDic.allValues lastObject] count]; i++) {
                NSString *title = [itemDic.allValues lastObject][i];
                MMItem *item3_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:title];
                if (i == 0) {
                    item3_B.isSelected = YES;
                }
                [item3_A addNode:item3_B];
            }
        }
        
        [mutableArray addObject:rootItem1];
        [mutableArray addObject:rootItem2];
        [mutableArray addObject:rootItem3];
        _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
}

#pragma mark - UITableView

-(void)setUpTableView {
    
    if (KIsiPhoneX) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KNavHeight+40, KScreenW, KScreenH - 40-KNavHeight-83) style:UITableViewStyleGrouped];
    }
    else {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, KScreenW, KScreenH - 104-49) style:UITableViewStyleGrouped];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

-(void)companyTableview {
    
    if (KIsiPhoneX) {
        self.companyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, KScreenW, KScreenH - 88) style:UITableViewStyleGrouped];
    }
    else {
        self.companyTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64) style:UITableViewStyleGrouped];
    }
    self.companyTableView.delegate = self;
    self.companyTableView.dataSource = self;
    self.companyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.companyTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.companyTableView];
}

-(void)loadNewData {
    _pageIndex = 1;
    NSString *curPage = [NSString stringWithFormat:@"%ld",(long)_pageIndex];
    NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do?uId=%d&startPage=%@&bRId=%@&jWDiploma=%@&jWYear=%@&jWMoney=%@&jCSize=%@&jMState=%@",ServerURL,uid,curPage,self.locationStr,self.xueliStr,self.jingyanStr,self.moneyStr,self.guimoStr,self.xingzhiStr];
    [self networkRequest:urlStr];
}

-(void)loadMoreData {
    if (_pageIndex < _lastPage) {
        _pageIndex++;
        NSString *curPage = [NSString stringWithFormat:@"%ld",(long)_pageIndex];
        NSInteger uid = [GetFromUserDefaults(@"uId") integerValue];
        NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkSelectList.do?uId=%d&startPage=%@&bRId=%@&jWDiploma=%@&jWYear=%@&jWMoney=%@&jCSize=%@&jMState=%@",ServerURL,uid,curPage,self.locationStr,self.xueliStr,self.jingyanStr,self.moneyStr,self.guimoStr,self.xingzhiStr];
        [self networkRequest:urlStr];
    }else{
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return self.carTalentArray.count;
    }
    else if (tableView == self.companyTableView) {
        return self.companyArray.count;
    }
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITableViewCell *voidCell;
    _indexRow = indexPath.row;
    if (tableView == self.tableView) {
        BFCarTalentsListModel *model = self.carTalentArray[indexPath.row];
        BFCompanyListCell *cell = [BFCompanyListCell new];
        cell.dataModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        voidCell = cell;
    }
    else if (tableView == self.companyTableView) {
        BFJobListModel *model = self.companyArray[indexPath.row];
        BFCompanyJobListCell *cell = [BFCompanyJobListCell new];
        self.cell = cell;
        cell.dataModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.pushWatchBlock = ^(){
            //投递简历的人
            BFJobHunterController *hunterVC = [[BFJobHunterController alloc] init];
            hunterVC.jobId = model.jWId;
            [self.navigationController pushViewController:hunterVC animated:YES];
        };
        voidCell = cell;
    }
    return voidCell;
}

//指定行是否可编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        return NO;
    }
    else
        return YES;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableView) {
        return 135.0f;
    }
    else if (tableView == self.companyTableView) {
        return 175.0f;
    }
    return 110.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        if (tableView == self.tableView) {
            BFCarTalentsListModel *model = self.carTalentArray[indexPath.row];
            NSString *idStr = [NSString stringWithFormat:@"%d",model.jWId];
            NSString *uidStr = GetFromUserDefaults(@"uId");
            NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkInfoSelect.do?jWId=%@&uId=%@",ServerURL,idStr,uidStr];
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
        else if (tableView == self.companyTableView) {
            BFJobListModel *model = self.companyArray[indexPath.row];
            NSString *idStr = [NSString stringWithFormat:@"%d",model.jWId];
            NSString *uidStr = GetFromUserDefaults(@"uId");
            NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkInfoSelect.do?jWId=%@&uId=%@",ServerURL,idStr,uidStr];
            [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
                NSDictionary *dict = data;
                NSLog(@"获取到的数据为:%@",dict);
                BFCompanyDetailViewController *detailVC = [[BFCompanyDetailViewController alloc] init];
                detailVC.dic = dict[@"data"];
                detailVC.isCompany = @"1";
                [self.navigationController pushViewController:detailVC animated:YES];
            } failureResponse:^(NSError *error) {
                NSLog(@"error - %@",error);
            }];
        }
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

-(void)networkRequest:(NSString *)urlStr {
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSArray *arr = dic[@"data"];
            _pageIndex = [dic[@"curPage"] integerValue];
            _lastPage = [dic[@"lastPage"] integerValue];
            
            if (_pageIndex == 1) {
                [self.carTalentArray removeAllObjects];
                self.tableView.mj_footer.hidden = YES;
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
                if (arr.count == 0) {
                    [ZAlertView showSVProgressForInfoStatus:@"暂无职位"];
                    [self.carTalentArray removeAllObjects];
                }
            }
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BFCarTalentsListModel *model = [[BFCarTalentsListModel alloc] initWithDict:obj];
                [self.carTalentArray addObject:model];
            }];
            [self.tableView reloadData];
            
            if (_lastPage == _pageIndex) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                self.tableView.mj_footer.hidden = YES;
                
            }else{
                [self.tableView.mj_footer endRefreshing];
            }
        }
        else{
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failureResponse:^(NSError *error) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

-(void)networkRequest1:(NSString *)urlStr {
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSDictionary *dic = data;
        if ([dic[@"status"] intValue] == 1) {
            NSArray *arr = dic[@"data"];
            [self.companyArray removeAllObjects];
            [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BFJobListModel *model = [[BFJobListModel alloc] initWithDict:obj];
                [self.companyArray addObject:model];
                NSArray *imgArr = obj[@"inPhotos"];
                if (imgArr.count == 0) {
                    self.cell.backView.userInteractionEnabled = NO;
                    self.cell.rightBtn.hidden = YES;
                }
                else if (imgArr.count == 1) {
                    self.cell.backView.userInteractionEnabled = YES;
                    self.cell.rightBtn.hidden = NO;
                    [self.cell.img0 sd_setImageWithURL:[NSURL URLWithString:imgArr[0]]];
                }
                else if (imgArr.count == 2) {
                    self.cell.backView.userInteractionEnabled = YES;
                    self.cell.rightBtn.hidden = NO;
                    [self.cell.img0 sd_setImageWithURL:[NSURL URLWithString:imgArr[0]]];
                    [self.cell.img1 sd_setImageWithURL:[NSURL URLWithString:imgArr[1]]];
                }
                else if (imgArr.count == 3) {
                    self.cell.backView.userInteractionEnabled = YES;
                    self.cell.rightBtn.hidden = NO;
                    [self.cell.img0 sd_setImageWithURL:[NSURL URLWithString:imgArr[0]]];
                    [self.cell.img1 sd_setImageWithURL:[NSURL URLWithString:imgArr[1]]];
                    [self.cell.img2 sd_setImageWithURL:[NSURL URLWithString:imgArr[2]]];
                }
                else if (imgArr.count == 4) {
                    self.cell.backView.userInteractionEnabled = YES;
                    self.cell.rightBtn.hidden = NO;
                    [self.cell.img0 sd_setImageWithURL:[NSURL URLWithString:imgArr[0]]];
                    [self.cell.img1 sd_setImageWithURL:[NSURL URLWithString:imgArr[1]]];
                    [self.cell.img2 sd_setImageWithURL:[NSURL URLWithString:imgArr[2]]];
                    [self.cell.img3 sd_setImageWithURL:[NSURL URLWithString:imgArr[3]]];
                }
                
            }];
            [self.companyTableView reloadData];
        }
        
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}


/**
 *  只要实现了这个方法，左滑出现Delete按钮的功能就有了
 *  点击了“左滑出现的Delete按钮”会调用这个方法
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.companyTableView) {
        BFJobListModel *model = self.companyArray[indexPath.row];
        NSString *idStr = [NSString stringWithFormat:@"%d",model.jWId];
        NSString *url = [NSString stringWithFormat:@"%@bfJobController/bfJobWorkJWKeyUpdate.do?jWId=%@",ServerURL,idStr];
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"删除成功"];
            }
            else {
                [ZAlertView showSVProgressForSuccess:@"删除失败"];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForSuccess:@"删除失败"];
        }];
        //删除的是工作经历
        [self.companyArray removeObjectAtIndex:indexPath.row];
        // 刷新
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    else if (tableView == self.companyTableView) {
        self.tableView.scrollEnabled = NO;
    }

}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.companyTableView) {
        return @"删除";
    }
    else if (tableView == self.tableView) {
        return @"";
    }
    return @"";
}



-(NSMutableArray<BFCarTalentsListModel *> *)carTalentArray {
    if (!_carTalentArray) {
        _carTalentArray = [NSMutableArray array];
    }
    return _carTalentArray;
}

-(NSMutableArray<BFJobListModel *> *)companyArray {
    if (!_companyArray) {
        _companyArray = [NSMutableArray array];
    }
    return _companyArray;
}

#pragma mark - 移除通知

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:@"changeStatus"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"resetLocation"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"postJob"];
    [[NSNotificationCenter defaultCenter] removeObserver:@"sureLocation"];
}

@end
