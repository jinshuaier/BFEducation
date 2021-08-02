//
//  BFCourseBottomCell.m
//  NewTest
//
//  Created by 春晓 on 2017/11/30.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCourseBottomCell.h"
#import "BFIntroduceViewController.h"
#import "BFCatalogueViewController.h"
#import "BFEvaluateViewController.h"
#import "BFSlideView.h"

@interface BFCourseBottomCell ()<BFSlideViewDelegate>

@property (nonatomic , strong) BFSlideView *slideView;
// 控制器数组
@property (nonatomic , strong) NSMutableArray *childViewControllersArray;

@property (nonatomic , strong) BFIntroduceViewController *introduceViewVC;
@property (nonatomic , strong) BFCatalogueViewController *catalogueVC;
@property (nonatomic , strong) BFEvaluateViewController *evaluateVC;
@end

@implementation BFCourseBottomCell{
    UIView *view;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI{
    
    if (!_slideView) {
        _slideView = [[BFSlideView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, self.contentView.height)];
        _slideView.delegate = self;
        [self.contentView addSubview:_slideView];
        _slideView.sd_layout
        .leftEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .topEqualToView(self.contentView)
        .bottomEqualToView(self.contentView);
    }
    
}

#pragma mark - BFQCXSlideViewDelegate

- (NSInteger)numberOfSlideItemsInSlideView:(BFSlideView *)slideView {
    
    return 3;
}

- (NSArray *)namesOfSlideItemsInSlideView:(BFSlideView *)slideView {
    return @[@"介绍",@"目录",@"评价"];
}

- (void)slideView:(BFSlideView *)slideView didSelectItemAtIndex:(NSInteger)index {
    
    NSLog(@" index %li", index);
}

- (NSArray *)childViewControllersInSlideView:(BFSlideView *)slideView {
    _introduceViewVC = [BFIntroduceViewController new];
    _catalogueVC = [BFCatalogueViewController new];
    _evaluateVC = [BFEvaluateViewController new];
    _evaluateVC.evaluateModelType = EvaluateModelType_Course;
    _childViewControllersArray = @[_introduceViewVC, _catalogueVC, _evaluateVC].mutableCopy;
    _catalogueVC.dataSource = self.dataSource;
    _evaluateVC.evaluateArray = self.evaluateArray;
    _introduceViewVC.descriptionStr = _descriptionStr;
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

- (void)setEvaluateArray:(NSMutableArray *)evaluateArray{
    _evaluateArray = evaluateArray;
    [self setupUI];
    if (_evaluateVC) {
        _evaluateVC.evaluateArray = _evaluateArray;
    }
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    _catalogueVC.dataSource = _dataSource;
}

- (void)setDescriptionStr:(NSString *)descriptionStr{
    _descriptionStr = descriptionStr;
    _introduceViewVC.descriptionStr = _descriptionStr;
}

- (void)setCatalogueDict:(NSMutableDictionary *)catalogueDict{
    _catalogueDict = catalogueDict;
    _catalogueVC.catalogueDict = _catalogueDict;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
