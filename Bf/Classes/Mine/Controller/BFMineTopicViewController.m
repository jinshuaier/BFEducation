//
//  BFMineTopicViewController.m
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFMineTopicViewController.h"
#import "BFSecMineTopicViewController.h"
#import "BFMineEvaluateViewController.h"
#import "BFQCXSlideView.h"
#import "BFCommunityModel.h"

@interface BFMineTopicViewController ()<BFQCXSlideViewDelegate>
// 头部滑动
@property (nonatomic , strong) BFQCXSlideView *slideView;
// 我的话题数据
@property (nonatomic , strong) NSMutableArray *communityArray;
// 我的评论数据
@property (nonatomic , strong) NSMutableArray *evaluateArray;
// 视图
@property (nonatomic , strong) NSArray *childViewControllersArray;
@end

@implementation BFMineTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self prepareData];
    
    BFQCXSlideView *slideView = [[BFQCXSlideView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    slideView.delegate = self;
    [self.view addSubview:slideView];
}

- (void)prepareData{
    _communityArray = [NSMutableArray array];
    _evaluateArray = [NSMutableArray array];
    
    UIImage *img = [UIImage imageNamed:@"图层18"];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        [arr addObject:img];
    }
    /*
    for (int i = 0; i < 6; i++) {
        BFCommunityModel *model = [[BFCommunityModel alloc] init];
        model.communityModelType = BFCommunityModelType_Image;
        model.headerImg = [UIImage imageNamed:@"timg-2"];
        model.nameStr = @"走钢丝的加菲猫";
        model.timeStr = @"2017-11-27";
        model.titleStr = @"今天维修了一辆宝马车";
        model.contentStr = @"ancyNode是一个有爱的团队，执着于产品本身，不惧世俗。以下所有软件也均为团队业余时间开发，为了维持软件的完善与站点的开销，会有部分软件的高级功能采取订阅式收费的方式进行提供。也感谢你对FancyNode团队的肯定与支持:)";
        model.imgArray = arr;
        model.lookCount = 288;
        model.discussCount = 28;
        model.likeCount = 45;
        [_communityArray addObject:model];
    }
    
    UIImage *videoImg = [UIImage imageNamed:@"矩形1拷贝4"];
    for (int i = 0; i < 2; i++) {
        BFCommunityModel *model = [[BFCommunityModel alloc] init];
        model.communityModelType = BFCommunityModelType_Video;
        model.headerImg = [UIImage imageNamed:@"timg-2"];
        model.nameStr = @"打怪兽的凹凸曼";
        model.timeStr = @"2017-11-28";
        model.titleStr = @"今天修理了一个小怪兽";
        model.contentStr = @"ancyNode是一个有爱的团队，执着于产品本身，不惧世俗。以下所有软件也均为团队业余时间开发，为了维持软件的完善与站点的开销，会有部分软件的高级功能采取订阅式收费的方式进行提供。也感谢你对FancyNode团队的肯定与支持:)";
        model.videoImage = videoImg;
        model.lookCount = 288;
        model.discussCount = 28;
        model.likeCount = 45;
        [_communityArray addObject:model];
    }
    */
    
}

#pragma mark - BFQCXSlideViewDelegate

- (NSInteger)numberOfSlideItemsInSlideView:(BFQCXSlideView *)slideView {
    
    return 2;
}

- (NSArray *)namesOfSlideItemsInSlideView:(BFQCXSlideView *)slideView {
    
    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"我的话题", @"我的评论", nil];
    return titleArray;
}

- (void)slideView:(BFQCXSlideView *)slideView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@" index %li", index);
}

- (NSArray *)childViewControllersInSlideView:(BFQCXSlideView *)slideView {
    
    BFSecMineTopicViewController *mineTopicVC = [BFSecMineTopicViewController new];       // 
    BFMineEvaluateViewController *mineEvaluateVC = [BFMineEvaluateViewController new];    //
    _childViewControllersArray = @[mineTopicVC, mineEvaluateVC];
    mineTopicVC.modelArray = _communityArray;
    return _childViewControllersArray;
}

- (UIColor *)colorOfSliderInSlideView:(BFQCXSlideView *)slideView{
    return RGBColor(0, 169, 255);
}

- (UIColor *)colorOfSlideView:(BFQCXSlideView *)slideView{
    return [UIColor whiteColor];
}

- (UIColor *)colorOfSlideItemsTitle:(BFQCXSlideView *)slideView{
    return [UIColor blackColor];
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
