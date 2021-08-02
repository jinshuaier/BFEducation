//
//  BFCourseDetailsHadBuyVC.m
//  NewTest
//
//  Created by 春晓 on 2017/12/1.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCourseDetailsHadBuyVC.h"
#import "MBRunTimerView.h"
#import "HHSlideView.h"
#import "BFEvaluateModel.h"
// 目录
#import "BFCatalogueHeaderView.h"
#import "CLLThreeTreeModel.h"
#import "CLLThreeTreeTableViewCell.h"
#import "ChapterTableViewCell.h"
#import "BFCourseModel.h"
#import "BFSetCourseModel.h"
// 评价
#import "BFEvaluateCell.h"
#import "BFEvaluateReplyModel.h"
#import "BFEvaluateReplyCell.h"
#import "BFEvaluateModel.h"

#import "BFQCXSlideView.h"
#import "BFIntroduceViewController.h"
#import "BFCatalogueViewController.h"
#import "BFEvaluateViewController.h"


@interface BFCourseDetailsHadBuyVC ()<UITableViewDelegate,UITableViewDataSource,BFQCXSlideViewDelegate>
// 目录
{
    NSInteger currentSection;
    NSInteger currentRow;
}
// 头部背景
@property (nonatomic , strong) UIImageView *headBGImageView;
// 进度
@property (nonatomic , strong) MBRunTimerView *runTimerView;
// 课程
@property (nonatomic , strong) UILabel *courseName;
// 继续学习
@property (nonatomic , strong) UILabel *continueLabel;
// 头视图
@property (nonatomic , strong) BFQCXSlideView *slideView;
// 目录
//tableView 显示的数据
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *sectionArray;

// 评价
@property (nonatomic , strong) NSMutableArray *evaluateArray;

// 控制器数组
@property (nonatomic , strong) NSMutableArray *childViewControllersArray;
@end

@implementation BFCourseDetailsHadBuyVC{
    UIView *view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    [self prepareData];
    [self setupUI];
    [self layout];
}

- (void)setupUI{
    _headBGImageView = [[UIImageView alloc] init];
    _headBGImageView.backgroundColor = [UIColor redColor];
    _headBGImageView.image = [UIImage imageNamed:@"咨询"];
    [self.view addSubview:_headBGImageView];
    
    self.runTimerView = [[MBRunTimerView alloc] initWithFrame:CGRectMake(30, 30, 100, 100)];
    self.runTimerView.gradient1 = [UIColor orangeColor];
    self.runTimerView.gradient2 = [UIColor orangeColor];
    [self.view addSubview:self.runTimerView];
    self.runTimerView.center = CGPointMake(KScreenW / 2, 130);
//    self.runTimerView.delegate = self;
    [self.runTimerView setProgress:0.4 animated:YES];
    
    _courseName = [[UILabel alloc] init];
    _courseName.textAlignment = NSTextAlignmentCenter;
    _courseName.text = @"hfjkhldhfjdsk";
    [self.view addSubview:_courseName];
    
    _continueLabel = [[UILabel alloc] init];
    _continueLabel.textColor = [UIColor whiteColor];
    _continueLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _continueLabel.layer.borderWidth = 1.0f;
    _continueLabel.font = [UIFont systemFontOfSize:PXTOPT(28)];
    _continueLabel.text = @"继续学习";
    _continueLabel.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(continueBtnClick)];
    [_continueLabel addGestureRecognizer:tap];
    [self.view addSubview:_continueLabel];
    
    _slideView = [[BFQCXSlideView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH - 250 - 64)];
    _slideView.delegate = self;
    [self.view addSubview:_slideView];
}

- (void)layout{
    _headBGImageView.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.view, 64)
    .rightEqualToView(self.view)
    .heightIs(250);
    
    _courseName.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(self.runTimerView, 20)
    .heightIs(30);
    
    _continueLabel.sd_layout
    .centerXIs(KScreenW / 2)
    .topSpaceToView(_courseName, 20)
    .widthIs(100)
    .heightIs(30);
    
    _slideView.sd_layout
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .topSpaceToView(_headBGImageView, 0)
    .bottomEqualToView(self.view);
}

- (void)prepareData{
    _evaluateArray = [NSMutableArray array];
    
    if ([_model isKindOfClass:[BFCourseModel class]]) {
        BFCourseModel *m = _model;
        NSString *url = [NSString stringWithFormat:@"%@?cid=%ld",CourseCatalogueURL,m.cid];
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            
        } failureResponse:^(NSError *error) {
            
        }];
        
    }else if ([_model isKindOfClass:[BFSetCourseModel class]]) {
        BFSetCourseModel *m = _model;
        NSString *url = [NSString stringWithFormat:@"%@?csid=%ld",CourseCatalogueURL,m.csid];
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            
        } failureResponse:^(NSError *error) {
            
        }];
        
    }
    /*
    for (int i = 0; i < 10; i++) {
        BFEvaluateModel *model = [BFEvaluateModel new];
        model.headerImgName = @"timg-6";
        model.nameStr = @"王小牛";
        model.timeStr = @"8分前";
        model.evaluateStr = @"特别好，特别好，特别好。";
        model.replyArray = [NSMutableArray array];
        for (int i = 0; i < 5; i++) {
            BFEvaluateReplyModel *replyModel = [BFEvaluateReplyModel new];
            replyModel.fromNameStr = @"李敏";
            replyModel.replyContentStr = @"讲的非常好";
            [model.replyArray addObject:replyModel];
        }
        [_evaluateArray addObject:model];
    }
     */
}


#pragma mark - BFQCXSlideViewDelegate

- (NSInteger)numberOfSlideItemsInSlideView:(BFQCXSlideView *)slideView {
    
    return 3;
}

- (NSArray *)namesOfSlideItemsInSlideView:(BFQCXSlideView *)slideView {
    return @[@"介绍",@"目录",@"评价"];
}

- (void)slideView:(BFQCXSlideView *)slideView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@" index %li", index);
}

- (NSArray *)childViewControllersInSlideView:(BFQCXSlideView *)slideView {
    BFIntroduceViewController *introduceViewVC = [BFIntroduceViewController new];
    BFCatalogueViewController *catalogueVC = [BFCatalogueViewController new];
    BFEvaluateViewController *evaluateVC = [BFEvaluateViewController new];
    evaluateVC.evaluateModelType = EvaluateModelType_Course;
    _childViewControllersArray = @[introduceViewVC, catalogueVC, evaluateVC].mutableCopy;
    catalogueVC.dataSource = self.dataSource;
    evaluateVC.evaluateArray = self.evaluateArray;
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

- (void)continueBtnClick{
    
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
