//
//  BFSearchCommunityResultVC.m
//  Bf
//
//  Created by 春晓 on 2018/3/2.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFSearchCommunityResultVC.h"
#import "BFCommunityDetailsVC.h"

#import "BFCommunityModel.h"
#import "BFCommunityImageCell.h"
#import "BFCommunityVideoCell.h"
#import "BFCommunityTextCell.h"

#import <MJRefresh.h>

@interface BFSearchCommunityResultVC ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITextField *searchBar;
// 搜索背景
@property (nonatomic , strong) UIView *searchBGView;
// 搜索的tableview
@property (nonatomic,copy) UITableView *tableView;
// 社区
@property (nonatomic , strong) NSMutableArray *communityArray;
@end

static NSString *communityImgCell   = @"communityImgCell";
static NSString *communityVideoCell = @"communityVideoCell";
static NSString *communityTextCell  = @"communityTextCell";

@implementation BFSearchCommunityResultVC{
    NSInteger communityCurPage; // 当前页
    NSInteger communityLastPage;// 总共页
    MBProgressHUD *HUD;
    NSInteger imageCellHeight;  // 图片cell的高度
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarButtonItem];
    
    imageCellHeight = PXTOPT(36) + PXTOPT(29) + PXTOPT(14) + PXTOPT(21) + PXTOPT(38) + PXTOPT(34) + PXTOPT(20) + PXTOPT(100) + PXTOPT(30) + PXTOPT(30) + PXTOPT(24) + PXTOPT(16) + PXTOPT(40) + ((KScreenW - PXTOPT(40)) / 3);
    
    communityCurPage = 0;
    communityLastPage = 1;
    _tableView.estimatedRowHeight=150.0f;
    [self setupUI];
    [self refresh];
    [self getData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
    self.searchBGView.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    [MobClick beginLogPageView:@"搜索页"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 回收键盘
    [self.searchBar resignFirstResponder];
    
    self.searchBGView.hidden = YES;
    
//    [MobClick endLogPageView:@"搜索页"];
}


- (void)setBarButtonItem
{
    [self.navigationItem setHidesBackButton:YES];
    _searchBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 44)];
    
    UITextField *searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, KScreenW - 80, 30)];
    self.searchBar = searchTextField;
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.layer.masksToBounds = YES;
    searchTextField.layer.cornerRadius = 5.0f;
    searchTextField.backgroundColor = RGBColor(200, 200, 200);
    searchTextField.placeholder = @"请输入搜索内容";
//    [searchTextField setValue:[UIFont systemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
//    [searchTextField setValue:RGBColor(102, 102, 102)  forKeyPath:@"_placeholderLabel.textColor"];
//    [searchTextField setFont:[UIFont systemFontOfSize:13.0]];
    searchTextField.text = _searchStr;
    searchTextField.userInteractionEnabled = NO;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    leftImageView.contentMode = UIViewContentModeScaleAspectFit;
    leftImageView.image = [UIImage imageNamed:@"Search_TF"];
    [leftView addSubview:leftImageView];
    leftImageView.center = leftView.center;
    searchTextField.leftView = leftView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarTap)];
    [_searchBGView addGestureRecognizer:tap];
    
    //找到取消按钮
    UIButton *cancleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //修改标题和标题颜色
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:RGBColor(102, 102, 102) forState:UIControlStateNormal];
    cancleBtn.frame = CGRectMake(KScreenW - 60, 7, 40, 30);
//    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [cancleBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    [_searchBGView addSubview:searchTextField];
    [_searchBGView addSubview:cancleBtn];
    [self.navigationController.navigationBar addSubview:_searchBGView];
}

- (void)searchBarTap{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)cancelBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setupUI{
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[BFCommunityImageCell class] forCellReuseIdentifier:communityImgCell];
    [_tableView registerClass:[BFCommunityVideoCell class] forCellReuseIdentifier:communityVideoCell];
    [_tableView registerClass:[BFCommunityTextCell class] forCellReuseIdentifier:communityTextCell];
    [self.view addSubview:self.tableView];
    self.tableView.sd_layout
    .leftEqualToView(self.view)
    .topEqualToView(self.view)
    .rightEqualToView(self.view)
    .bottomEqualToView(self.view);
}

- (void)refresh{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getData];
    }];
}

- (void)getData{
    if (communityCurPage < communityLastPage) {
        [self prepareDataWithStartpage:++communityCurPage];
        
    }else{
        [_tableView.mj_footer endRefreshingWithNoMoreData];
        _tableView.mj_footer.hidden = YES;
    }
}

#pragma mark -网络请求-
- (void)prepareDataWithStartpage:(NSInteger)currentPage {
    NSMutableDictionary *paramete = [NSMutableDictionary dictionary];
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        [paramete setValue:GetFromUserDefaults(@"uId") forKey:@"uId"];
    }else{
        [paramete setValue:@"0" forKey:@"uId"];
    }
    [paramete setValue:@(currentPage) forKey:@"startPage"];
    [paramete setValue:_searchStr forKey:@"search"];
    
    [NetworkRequest sendDataWithUrl:CommunitySearchURL parameters:paramete successResponse:^(id data) {
        NSDictionary *dic = data;
        NSInteger status = [dic[@"status"] integerValue];
        if (status == 1) {
            NSArray *arr = dic[@"data"];
            
            communityLastPage = [dic[@"lastPage"] integerValue];
            if (!_communityArray) {
                _communityArray = [NSMutableArray array];
            }
            if (communityCurPage == 1) {
                if (arr.count == 0) {
                    _tableView.mj_footer.hidden = YES;
                    [_tableView.mj_footer endRefreshing];
                }else{
                    [_communityArray removeAllObjects];
                    _tableView.mj_footer.hidden = NO;
                    [_tableView.mj_footer endRefreshing];
                }
                
            }else{
            }
            for (NSDictionary *dict in arr) {
                BFCommunityModel *model = [BFCommunityModel initWithDict:dict];
                [_communityArray addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView.mj_footer endRefreshing];
                [_tableView reloadData];
            });
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark -tableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _communityArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFCommunityModel *model = _communityArray[indexPath.row];
    if (model.communityModelType == BFCommunityModelType_Text) {
        BFCommunityTextCell *cell = [tableView dequeueReusableCellWithIdentifier:communityTextCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCommunityTextCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:communityTextCell];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.model = model;
        return cell;
    }else if (model.communityModelType == BFCommunityModelType_Image) {
        BFCommunityImageCell *cell = [tableView dequeueReusableCellWithIdentifier:communityImgCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCommunityImageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:communityImgCell];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.model = model;
        return cell;
    }else if (model.communityModelType == BFCommunityModelType_Video || model.communityModelType == BFCommunityModelType_VideoAndImage){
        BFCommunityVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:communityVideoCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCommunityVideoCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:communityVideoCell];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.model = model;
        return cell;
    }else{
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BFCommunityModel *model = _communityArray[indexPath.row];
    if (model.communityModelType == BFCommunityModelType_Text) {
        return 200;
    }else if (model.communityModelType == BFCommunityModelType_Image) {
        return imageCellHeight;
    }else if (model.communityModelType == BFCommunityModelType_Video || model.communityModelType == BFCommunityModelType_VideoAndImage){
        return 335;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BFCommunityModel *model = _communityArray[indexPath.row];
    BFCommunityDetailsVC *vc = [BFCommunityDetailsVC new];
    vc.model = model;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UISearchBarDelegate -
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
