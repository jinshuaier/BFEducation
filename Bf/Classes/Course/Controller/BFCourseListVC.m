//
//  BFCourseListVC.m
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCourseListVC.h"
#import "BFCourseModel.h"
#import "BFCourseDetailsVC.h"
#import "BFMoreCourseListVC.h"
#import "SelectCollectionLayout.h"

#import "HeaderScrollview.h"
#import "BFCourseTableViewCell.h"
#import "BFCourseHeaderView.h"
#import "BFCourseMoreCell.h"
#import "BFCourseCollectionViewCell.h"
#import "BFCourseSearchTagCell.h"

#import "SDCycleScrollView.h"
#import "BFWatchCourseVC.h"
#import <MJRefresh.h>

#import "CCNavigationController.h"
#import "BFLatestHomePageViewController.h"


@interface BFCourseListVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,HeaderScrollviewDelegate,SDCycleScrollViewDelegate,BFCourseMoreCellDelegate,BFCourseTableViewCellDelegate>
// 滚动头部
@property(nonatomic, strong) HeaderScrollview *titleView;
// 课程列表
@property (nonatomic , strong) UITableView *tableView;
// 按钮
@property (nonatomic , strong) UIButton *searchBtn;
// 课程列表
@property (nonatomic , strong) UICollectionView *collectionView;
// 轮播图
@property (nonatomic , strong) SDCycleScrollView *scrollView;
// 轮播图高度
@property (nonatomic , assign) CGFloat scrollViewH;
// 筛选侧滑背景
@property (nonatomic , strong) UIView *searchBGView;
// 筛选侧滑背景
@property (nonatomic , strong) UICollectionView *searchCollectionView;


// data
// 课程目录数据（有全部课程）
@property (nonatomic , strong) NSMutableArray *titleCourseCategoryArray;
// 课程目录数据（没有全部课程）
@property (nonatomic , strong) NSMutableArray *courseCategoryArray;
// 课程目录一级
@property (nonatomic , strong) NSMutableDictionary *courseCategoryDictFirst;
// 课程目录二级
@property (nonatomic , strong) NSMutableDictionary *courseCategoryDictSecond;
// banner
@property (nonatomic , strong) NSMutableArray *bannerArray;

// 全部课程数据
@property (nonatomic , strong) NSMutableDictionary *courseListAllDic;
// 某一类课程数据
@property (nonatomic , strong) NSMutableArray *aCourseListArray;

// titleView当前index
@property (nonatomic , assign) NSInteger currentIndex;

@property (nonatomic, assign) BOOL fromHome;
@end

static NSString *scrollViewCell        = @"ScrollViewCell";
static NSString *courseTableViewCell   = @"CourseTableViewCell";
static NSString *courseTableViewHeader = @"CourseTableViewHeader";
static NSString *courseTableViewMore   = @"CourseTableViewMore";

static NSString *collectionCell        = @"collectionCell";
static NSString *courseSearchTagCell   = @"CourseSearchTagCell";

@implementation BFCourseListVC{
    NSInteger courseCurrentPage;
    NSInteger courseTotalPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"课程";
    self.view.backgroundColor = GroundGraryColor;
    _bannerArray = [NSMutableArray array];
    _courseCategoryArray = [NSMutableArray array];
    _titleCourseCategoryArray = [NSMutableArray array];
    _courseCategoryDictFirst = [NSMutableDictionary dictionary];
    _courseCategoryDictSecond = [NSMutableDictionary dictionary];
    _courseListAllDic = [NSMutableDictionary dictionary];
    _aCourseListArray = [NSMutableArray array];
    [self setupUI];
    [self getBannerNetWork];
    [self getSearchListNetWork];
    [self getAllCourseListNetWork];
    
    for (CCNavigationController *vc in self.tabBarController.childViewControllers) {
        if ([vc.childViewControllers.firstObject isKindOfClass:[BFLatestHomePageViewController class]]) {
            BFLatestHomePageViewController *corseVC = vc.childViewControllers.firstObject;
            corseVC.isFirstLoad = false;
        }
    }
}

//- (void)setSelectedIndex:(NSInteger)selectedIndex {
//    [_titleView changeSelectedItemWithIndex:selectedIndex];
//}

- (void)scrollToXNY {
//    [_titleView changeSelectedItemWithIndex:self.selectedIndex];
    [self getSearchListNetWork];
}

- (void)setupUI{
    
    // 网络加载图片的轮播器
    _scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenW, 150) delegate:self placeholderImage:[UIImage imageNamed:@"组2"]];
    //当前分页控件小圆标图片
    _scrollView.pageDotImage = [UIImage imageNamed:@"轮播-默认"];
    
    //其他分页控件小圆标图片
    _scrollView.currentPageDotImage = [UIImage imageNamed:@"轮播-选中"];

    if (KIsiPhoneX) {
        _titleView  = [[HeaderScrollview alloc] initWithFrame:CGRectMake(0,88, KScreenW - 55,44)];
    }
    else {
        _titleView  = [[HeaderScrollview alloc] initWithFrame:CGRectMake(0,64, KScreenW - 55,44)];
    }
    //设置代理,获取点击事件
    _titleView.delegate = self;
    _titleView.selectedIndex = self.selectedIndex;
    //    _titleView.dataSource = [NSMutableArray arrayWithArray:@[@"全部课程",@"故障案例",@"电动汽车",@"混动汽车",@"奔驰",@"宝马",@"奥迪",@"比亚迪",@"迈巴赫",@"长城",@"北京"]];
    [self.view addSubview:_titleView];
    
    _searchBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    if (KIsiPhoneX) {
        _searchBtn.frame = CGRectMake(CGRectGetMaxX(_titleView.frame), 88, 55, 44);
    }
    else {
        _searchBtn.frame = CGRectMake(CGRectGetMaxX(_titleView.frame), 64, 55, 44);
    }
    [_searchBtn setImage:[UIImage imageNamed:@"课程筛选"] forState:(UIControlStateNormal)];
    [_searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_searchBtn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleView.frame), KScreenW, KScreenH - CGRectGetMaxY(_titleView.frame)) style:(UITableViewStylePlain)];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.hidden = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[BFCourseMoreCell class] forCellReuseIdentifier:courseTableViewMore];
    [_tableView registerClass:[BFCourseTableViewCell class] forCellReuseIdentifier:courseTableViewCell];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:scrollViewCell];
    [_tableView registerClass:[BFCourseHeaderView class] forHeaderFooterViewReuseIdentifier:courseTableViewHeader];
//    [_tableView registerClass:[BFCourseFooterView class] forHeaderFooterViewReuseIdentifier:courseTableViewFooter];
    
    UIView *tableFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 61)];
    tableFooter.backgroundColor = RGBColor(245, 247, 250);
    UILabel *label = [[UILabel alloc] initWithFrame:tableFooter.frame];
    label.text = @"-  四千余节热门车型常见故障案例 -";
    label.textColor = RGBColor(153, 153, 153);
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    [tableFooter addSubview:label];
    _tableView.tableFooterView = tableFooter;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(20, CollectionRowMargin, 0, CollectionRowMargin);
    layout.itemSize = CGSizeMake(CollectionCellWidth, 160);
    _collectionView = [[UICollectionView alloc] initWithFrame:_tableView.frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [_collectionView registerClass:[BFCourseCollectionViewCell class] forCellWithReuseIdentifier:collectionCell];
    [self.view addSubview:_collectionView];
    _collectionView.hidden = YES;
    // 下拉刷新
    _collectionView.mj_header= [MJRefreshNormalHeader  headerWithRefreshingBlock:^{
        // 增加数据
//        [_collectionView.mj_header  beginRefreshing];
        [self getNewData];
    }];
    // 上拉刷新
    _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self getMoreData];
        
    }];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}


- (void)getNewData{
    NSInteger cid = [_courseCategoryDictFirst[_courseCategoryArray[_currentIndex - 1]] integerValue];
    [self getACourseListNetWorkWithCurrentPage:1 withcid:cid];
}

- (void)getMoreData{
    if (courseCurrentPage < courseTotalPage) {
        NSInteger cid = [_courseCategoryDictFirst[_courseCategoryArray[_currentIndex - 1]] integerValue];
        [self getACourseListNetWorkWithCurrentPage:courseCurrentPage + 1 withcid:cid];
    }else{
        [_collectionView.mj_footer  endRefreshingWithNoMoreData];
    }
}

- (void)searchBtnClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.searchBGView];
    [_searchCollectionView reloadData];
}

- (void)tapAction{
    [self.searchBGView removeFromSuperview];
}

#pragma mark -lazy-
- (UIView *)searchBGView{
    if (!_searchBGView) {
        _searchBGView = [[UIView alloc] initWithFrame:self.view.frame];
        _searchBGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        
        UIView *liftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, KScreenH)];
        liftView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        [_searchBGView addSubview:liftView];
        liftView.userInteractionEnabled = YES;
        [liftView addGestureRecognizer:tap];
        
        UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(60, 0, KScreenW - 60, KScreenH)];
        rightView.backgroundColor = [UIColor whiteColor];
        [_searchBGView addSubview:rightView];
        [rightView addSubview:self.searchCollectionView];
    }
    return _searchBGView;
}

- (UICollectionView *)searchCollectionView{
    if (!_searchCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 0, 10);
        layout.headerReferenceSize = CGSizeMake(KScreenW - 80, 30); //设置collectionView头视图的大小
        _searchCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(20, 20, KScreenW - 80, KScreenH - 40) collectionViewLayout:layout];
        _searchCollectionView.delegate = self;
        _searchCollectionView.dataSource = self;
        _searchCollectionView.backgroundColor = [UIColor whiteColor];
        [_searchCollectionView registerClass:[BFCourseSearchTagCell class] forCellWithReuseIdentifier:courseSearchTagCell];
        [_searchCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    return _searchCollectionView;
}


#pragma mark - table -

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _courseCategoryArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        NSArray *array = _courseListAllDic[_courseCategoryArray[section - 1]];
        if (array.count > 0) {
            return 2;
        }
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:scrollViewCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:scrollViewCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:_scrollView];
        return cell;
    }else{
        if (indexPath.row == 0) {
            BFCourseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:courseTableViewCell forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFCourseTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:courseTableViewCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            NSArray *array = _courseListAllDic[_courseCategoryArray[indexPath.section - 1]];
            cell.delegate = self;
            if (array.count > 0) {
                cell.courseArray = array;
            }
            return cell;
        }else{
            BFCourseMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:courseTableViewMore forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFCourseMoreCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:courseTableViewMore];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
            return cell;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (_bannerArray.count > 0) {
            if (_scrollViewH == 0) {
                return 150;
            }
            return _scrollViewH;
        }else{
            return 0;
        }
    }else{
        if (indexPath.row == 0) {
            NSArray *array = _courseListAllDic[_courseCategoryArray[indexPath.section - 1]];
            if (array.count % 2 == 0) {
                return 170 * array.count / 2;
            }else{
                return 170 * (array.count / 2 + 1);
            }
        }else{
            return 60;
        }
    }
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        BFCourseHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:courseTableViewHeader];
        if (!view) {
            view = [[BFCourseHeaderView alloc] initWithReuseIdentifier:courseTableViewHeader];
        }
        view.titleStr = _courseCategoryArray[section - 1];
        return view;
    }
    return nil;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    if (section != 0) {
//        BFCourseFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:courseTableViewFooter];
//        if (!view) {
//            view = [[BFCourseFooterView alloc]initWithReuseIdentifier:courseTableViewFooter];
//        }
//        view.delegate = self;
//        return view;
//    }
//    return nil;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return 60;
    }
    return 0;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    if (section != 0) {
//        return 60;
//    }
//    return 0;
//}


#pragma mark -collectionView-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == _collectionView) {
        return 1;
    }
    return _courseCategoryArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == _collectionView) {
        return _aCourseListArray.count;
    }
    NSString *title = _courseCategoryArray[section];
    NSArray *arr = _courseCategoryDictSecond[title];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _collectionView) {
        BFCourseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
        cell.courseDict = _aCourseListArray[indexPath.item];
        return cell;
    }else{
        BFCourseSearchTagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:courseSearchTagCell forIndexPath:indexPath];
        NSString *title = _courseCategoryArray[indexPath.section];
        NSArray *arr = _courseCategoryDictSecond[title];
        NSDictionary *dic = arr[indexPath.item];
        cell.tagLabel.text = dic[@"cstitle"];
        return cell;
    }
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectionView) {
        return CGSizeMake(CollectionCellWidth, 160);
    }else{
        NSString *title = _courseCategoryArray[indexPath.section];
        NSArray *arr = _courseCategoryDictSecond[title];
        NSDictionary *dic = arr[indexPath.item];
        CGSize size = [BFCourseSearchTagCell getSizeWithText:dic[@"cstitle"]];
        size.width += 0;
        return size;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _collectionView) {
        return nil;
    }else{
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"forIndexPath:indexPath];
        header.backgroundColor = [UIColor whiteColor];
        
        if (header.subviews.count > 0) {
            UILabel *label = [header.subviews lastObject];
            label.text = _courseCategoryArray[indexPath.section];
        }else{
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, _searchCollectionView.width, 30)];
            label.text = _courseCategoryArray[indexPath.section];
            label.font = [UIFont systemFontOfSize:14.0];
            label.textColor = RGBColor(51, 51, 51);
            [header addSubview:label];
        }
        return header;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == _collectionView) {
        NSString *str = GetFromUserDefaults(@"loginStatus");
        NSDictionary *dic = _aCourseListArray[indexPath.item];
        [self watchVideoAction:dic[@"roomid"] withCid:[dic[@"csid"] integerValue]];
//        if ([str isEqualToString:@"1"]) { //用户已登录
//            NSDictionary *dic = _aCourseListArray[indexPath.item];
//            [self watchVideoAction:dic[@"roomid"] withCid:[dic[@"csid"] integerValue]];
//        }
//        else {
//            BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
//            UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
//            [self presentViewController:navigation animated:YES completion:nil];
//        }
    }else{
        [self tapAction];
        BFCourseDetailsVC *vc = [BFCourseDetailsVC new];
        vc.model = [BFCourseModel new];
        NSArray *arr = _courseCategoryDictSecond[_courseCategoryArray[indexPath.section]];
        NSDictionary *dic = arr[indexPath.item];
        vc.model.cid = [dic[@"csid"] integerValue];
        vc.isFromOtherApp = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)moreCourse:(BFCourseMoreCell *)cell{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSInteger cid = [_courseCategoryDictFirst[_courseCategoryArray[indexPath.section - 1]] integerValue];
    BFMoreCourseListVC *vc = [BFMoreCourseListVC new];
    vc.cid = cid;
    vc.titleStr = _courseCategoryArray[indexPath.section - 1];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -HeaderScrollviewDelegate-
- (void)header_disSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        _tableView.hidden = NO;
        _collectionView.hidden = YES;
    }else{
        _tableView.hidden = YES;
        _collectionView.hidden = NO;
        if (indexPath.item != _currentIndex) {
            _currentIndex = indexPath.item;
            [_collectionView.mj_header  beginRefreshing];
//            NSInteger cid = [_courseCategoryDictFirst[_courseCategoryArray[indexPath.item - 1]] integerValue];
//            [self getACourseListNetWorkWithCurrentPage:1 withcid:cid];
            
        }
    }
}

#pragma mark -BFCourseTableViewCellDelegate-
- (void)courseClickActionWithItem:(NSInteger)Item withCell:(BFCourseTableViewCell *)cell{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    NSString *title = _courseCategoryArray[indexPath.section - 1];
    NSArray *arr = _courseListAllDic[title];
    NSDictionary *dic = arr[Item];
    [self watchVideoAction:dic[@"roomid"] withCid:[dic[@"csid"] integerValue]];
//    NSString *str = GetFromUserDefaults(@"loginStatus");
//    if ([str isEqualToString:@"1"]) { //用户已登录
//
//    }
//    else {
//        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
//        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
//        [self presentViewController:navigation animated:YES completion:nil];
//    }
}

#pragma mark -SDCycleScrollViewDelegate-
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

#pragma mark -NetWork-
#pragma mark -banner-
- (void)getBannerNetWork{
    [NetworkRequest requestWithUrl:CourseListBannerURL parameters:nil successResponse:^(id data) {
        NSArray *arr = data;
        [_bannerArray removeAllObjects];
        for (NSDictionary *dic in arr) {
            [_bannerArray addObject:dic[@"abcover"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            _scrollView.imageURLStringsGroup = _bannerArray;
            if (_bannerArray.count > 0) {
                [self getscrollViewImageWithUrlString:_bannerArray[0]];
            }
        });
        
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark -筛选列表-
- (void)getSearchListNetWork{
    [NetworkRequest requestWithUrl:CourseCategoryURL parameters:nil successResponse:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            NSArray *arr = data[@"data"];
            for (int i = 0; i < arr.count; i++) {
                NSDictionary *dic = arr[i];
                [_titleCourseCategoryArray addObject:dic[@"ctitle"]];
                if (i != 0) {
                    [_courseCategoryArray addObject:dic[@"ctitle"]];
                    [_courseCategoryDictFirst setValue:dic[@"cid"] forKey:dic[@"ctitle"]];
                    [_courseCategoryDictSecond setValue:dic[@"series"] forKey:dic[@"ctitle"]];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _titleView.dataSource = _titleCourseCategoryArray;
                [_titleView reloadData];
                [_tableView reloadData];
                [_titleView scrollCollectionItemToDesWithDesIndex:self.selectedIndex];
                [_titleView changeSelectedItemWithIndex:self.selectedIndex];
                
            });
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark -全部课程-
- (void)getAllCourseListNetWork{
    [NetworkRequest requestWithUrl:CourseListALLURL parameters:nil successResponse:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            NSArray *arr = data[@"data"];
            for (NSDictionary *dic in arr) {
                [_courseListAllDic setValue:dic[@"course"] forKey:dic[@"ctitle"]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }
    } failureResponse:^(NSError *error) {
        
    }];
}

#pragma mark -根据id查询课程-
- (void)getACourseListNetWorkWithCurrentPage:(NSInteger)currentPage withcid:(NSInteger)cid{
    NSString *url = [NSString stringWithFormat:@"%@?cid=%ld&pageNo=%ld&pageSize=%d",CourseListByIdURL,cid,currentPage,20];
    [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if (status == 1) {
            NSDictionary *dict = data[@"data"];
            courseCurrentPage = [dict[@"pageNum"] integerValue];
            courseTotalPage = [dict[@"pages"] integerValue];
            
            
            NSArray *arr = dict[@"list"];
            if (courseCurrentPage == 1) {
                [_aCourseListArray removeAllObjects];
                [_aCourseListArray addObjectsFromArray:arr];
            }else{
                [_aCourseListArray addObjectsFromArray:arr];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_collectionView reloadData];
            });
        }
        [_collectionView.mj_header  endRefreshing];
        [_collectionView.mj_footer  endRefreshing];
    } failureResponse:^(NSError *error) {
        [_collectionView.mj_header  endRefreshing];
        [_collectionView.mj_footer  endRefreshing];
    }];
}

#pragma mark -观看视频-
- (void)watchVideoAction:(NSString *)roomId withCid:(NSInteger)cid {
    BFWatchCourseVC *player = [[BFWatchCourseVC alloc] init];
    player.playMode = NO;
    player.videoId = roomId;
    player.cid = cid;
    player.isInstroduce = NO;
    player.canClick = YES;
    player.indexpath = 0;
    [self.navigationController pushViewController:player animated:YES];
}

- (void)getscrollViewImageWithUrlString:(NSString *)urlStr{
    
    NSLog(@"urlStr = %@",urlStr);
    UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlStr];
    if (!img) {
        
        dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
        dispatch_async(globalQueue, ^{
            
            NSLog(@"开始下载图片:%@", [NSThread currentThread]);
            //NSString -> NSURL -> NSData -> UIImage
            NSURL *imageURL = [NSURL URLWithString:urlStr];
            //下载图片
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            UIImage *image = [UIImage imageWithData:imageData];
            CGFloat imgW = image.size.width;
            CGFloat imgH = image.size.height;
            _scrollViewH = imgH * KScreenW / imgW;
            //从子线程回到主线程(方式二：常用)
            //组合：主队列异步执行
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"回到主线程:%@", [NSThread currentThread]);
                _scrollView.frame = CGRectMake(0, 0, KScreenW, _scrollViewH);
                [_tableView reloadData];
//                [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
            });
            
            NSLog(@"xxxxxxxx");
        });
    }else{
        CGFloat imgW = img.size.width;
        CGFloat imgH = img.size.height;
        _scrollViewH = imgH * KScreenW / imgW;
        dispatch_async(dispatch_get_main_queue(), ^{
//            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:(UITableViewRowAnimationNone)];
            _scrollView.frame = CGRectMake(0, 0, KScreenW, _scrollViewH);
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
