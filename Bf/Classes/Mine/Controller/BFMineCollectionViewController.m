//
//  BFMineCollectionViewController.m
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFMineCollectionViewController.h"
#import "BFSecMineTopicViewController.h"
#import "BFCollectionCourseViewController.h"
#import "BFCollectionConsultViewController.h"
#import "BFSlideView.h"
#import "BFCommunityModel.h"
#import "BFCourseModel.h"

#import "BFCourseDetailsVC.h"
#import "BFCarConsultDetailsVC.h"
#import "BFCommunityDetailsVC.h"


@interface BFMineCollectionViewController ()<BFSlideViewDelegate>
// 头部滑动
@property (nonatomic , strong) BFSlideView *slideView;
// 收藏话题数据
@property (nonatomic , strong) NSMutableArray *communityArray;
// 收藏资讯数据
@property (nonatomic , strong) NSMutableArray *consultArray;
// 收藏课程数据
@property (nonatomic , strong) NSMutableArray *courseArray;
// 视图
@property (nonatomic , strong) NSArray *childViewControllersArray;

@property (nonatomic , strong) BFSecMineTopicViewController *mineTopicVC;
@property (nonatomic , strong) BFCollectionConsultViewController *collectionConsultVC;
@property (nonatomic , strong) BFCollectionCourseViewController *collectionCourseViewVC;
@end

@implementation BFMineCollectionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"我的收藏页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"我的收藏页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prepareData];
    self.title = @"我的收藏";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    BFSlideView *slideView = [BFSlideView new];
    if (KIsiPhoneX) {
        slideView.frame = CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height-88);
    }else {
        slideView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    }
    slideView.delegate = self;
    [self.view addSubview:slideView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterDetail:) name:@"EnterDetail" object:nil];// 社区
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterDetail:) name:@"CarConsultEnterDetails" object:nil];// 咨询
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterDetail:) name:@"CoursesDetailsEnterDetails" object:nil];// 课程
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)prepareData{
    _communityArray = [NSMutableArray array];
    _consultArray = [NSMutableArray array];
    _courseArray = [NSMutableArray array];
    
    UIImage *img = [UIImage imageNamed:@"组3"];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [arr addObject:img];
    }
}

#pragma mark - BFQCXSlideViewDelegate

- (NSInteger)numberOfSlideItemsInSlideView:(BFSlideView *)slideView {
    
    return 3;
}

- (NSArray *)namesOfSlideItemsInSlideView:(BFSlideView *)slideView {
    
    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"收藏帖子", @"收藏资讯",@"收藏课程", nil];
    return titleArray;
}

- (void)slideView:(BFSlideView *)slideView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@" index %li", index);
}

- (NSArray *)childViewControllersInSlideView:(BFSlideView *)slideView {
    if (!_mineTopicVC) {
        _mineTopicVC = [BFSecMineTopicViewController new];
    }
    if (!_collectionConsultVC) {
        _collectionConsultVC = [BFCollectionConsultViewController new];
    }
    if (!_collectionCourseViewVC) {
        _collectionCourseViewVC = [BFCollectionCourseViewController new];
    }
    _childViewControllersArray = @[_mineTopicVC, _collectionConsultVC, _collectionCourseViewVC];
    _mineTopicVC.modelArray = _communityArray;
    _mineTopicVC.getConsultsType = GetConsultsType_Collection;
    _collectionCourseViewVC.modelArray = _courseArray;
    return _childViewControllersArray;
}

- (UIColor *)colorOfSliderInSlideView:(BFSlideView *)slideView{
    return RGBColor(0, 169, 255);
}

- (UIColor *)colorOfSlideView:(BFSlideView *)slideView{
    return [UIColor whiteColor];
}

- (UIColor *)colorOfSlideItemsTitle:(BFSlideView *)slideView{
    return [UIColor blackColor];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)enterDetail:(NSNotification *)notification{
    UIViewController *vc = notification.object;
    [self.navigationController pushViewController:vc animated:YES];
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
