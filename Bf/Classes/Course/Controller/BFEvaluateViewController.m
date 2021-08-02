//
//  BFEvaluateViewController.m
//  NewTest
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFEvaluateViewController.h"
#import "UILabel+MBCategory.h"
// 评价
#import "BFEvaluateCell.h"
#import "BFEvaluateReplyModel.h"
#import "BFEvaluateReplyCell.h"
#import "BFEvaluateModel.h"

@interface BFEvaluateViewController ()<UITableViewDelegate,UITableViewDataSource>
// 高度缓存字典
@property (nonatomic , strong) NSMutableDictionary *cacheDict;
// 高度缓存字典
@property (nonatomic , strong) NSMutableDictionary *replyscacheDict;
@end
// 评价重用ID
static NSString *evaluateCellId      = @"evaluateCellId";
static NSString *evaluateReplyCellId = @"evaluateReplyCellId";
@implementation BFEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cacheDict = [NSMutableDictionary dictionary];
    _replyscacheDict = [NSMutableDictionary dictionary];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
    [self.view addSubview:_tableView];
    [self prepareEvaluateTableView];
    
}

- (void)prepareEvaluateTableView{
    [_tableView registerClass:[BFEvaluateCell class] forCellReuseIdentifier:evaluateCellId];
    [_tableView registerClass:[BFEvaluateReplyCell class] forCellReuseIdentifier:evaluateReplyCellId];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark -UItableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _evaluateArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BFEvaluateModel *model = _evaluateArray[section];
    if (model.replys && model.replys.count > 0) {
        return model.replys.count + 1;
    }
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        BFEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateCellId forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFEvaluateCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateCellId];
        }
        
        if (_evaluateModelType == EvaluateModelType_Course) {
            cell.courseEvaluateModel = _evaluateArray[indexPath.section];
        }else if (_evaluateModelType == EvaluateModelType_Community){
            cell.evaluateModel = _evaluateArray[indexPath.section];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        return cell;
    }else{
        BFEvaluateReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:evaluateReplyCellId forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFEvaluateReplyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:evaluateReplyCellId];
        }
        if (_evaluateModelType == EvaluateModelType_Course) {
            BFCourseEvaluateModel *model = _evaluateArray[indexPath.section];
            cell.courseEvaluateReplyModel = model.replys[indexPath.row - 1];
        }else if (_evaluateModelType == EvaluateModelType_Community){
            BFEvaluateModel *model = _evaluateArray[indexPath.section];
            cell.evaluateReplyModel = model.replys[indexPath.row - 1];
        }
        cell.layer.shouldRasterize = YES;
        cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFCourseEvaluateModel *model = _evaluateArray[indexPath.section];
    if (indexPath.row == 0) {
        return [self cacheCellHeightWithContent:model.ceeval withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:model.ceid isReply:NO];
    }else{
        BFCourseEvaluateReplyModel *replyModel = model.replys[indexPath.row - 1];
        return [self cacheCellHeightWithContent:replyModel.ceeval withFont:[UIFont fontWithName:BFfont size:PXTOPT(24)] withSize:CGSizeMake(KScreenW - 70, 1600) withId:replyModel.ceid isReply:YES];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (void)setEvaluateArray:(NSMutableArray *)evaluateArray{
    _evaluateArray = evaluateArray;
    [self.tableView reloadData];
}

- (CGFloat)cacheCellHeightWithContent:(NSString *)content withFont:(UIFont *)font withSize:(CGSize)size withId:(NSInteger)Id isReply:(BOOL)isReply{
    NSArray *keysArray;
    if (isReply) {
        keysArray = [_replyscacheDict allKeys];
    }else{
        keysArray = [_cacheDict allKeys];
    }
    NSString *key = [NSString stringWithFormat:@"%ld",Id];
    if ([keysArray containsObject:key]) {
        if (isReply) {
            return [_replyscacheDict[key] floatValue];
        }else{
            return [_cacheDict[key] floatValue];
        }
    }else{
        CGFloat h = isReply ? [UILabel sizeWithString:content font:font size:size].height + 10 : [UILabel sizeWithString:content font:font size:size].height + 100;
        if (isReply) {
            [_replyscacheDict setValue:@(h) forKey:key];
        }else{
            [_cacheDict setValue:@(h) forKey:key];
        }
        return h;
    }
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
