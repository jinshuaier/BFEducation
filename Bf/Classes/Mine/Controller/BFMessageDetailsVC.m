//
//  BFMessageDetailsVC.m
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMessageDetailsVC.h"
#import "BFMessageFirstCell.h"
#import "BFMessageDetailsModel.h"

@interface BFMessageDetailsVC ()<UITableViewDelegate,UITableViewDataSource>
// table
@property (nonatomic , strong) UITableView *tableView;
// 数据
@property (nonatomic , strong) NSMutableArray *displayArray;
@end

static NSString *const messageCell = @"messageCell";

@implementation BFMessageDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleStr;
    [self prepareData];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) style:(UITableViewStylePlain)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[BFMessageFirstCell class] forCellReuseIdentifier:messageCell];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

- (void)prepareData{
    _displayArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        BFMessageDetailsModel *model = [BFMessageDetailsModel new];
        model.headerImageName = @"直播";
        model.timeStr = @"2017/12/12 12:12";
        model.describeStr = @"王小二回复了你的话题";
        model.contentStr = @"《汽车》";
        [_displayArray addObject:model];
    }
}

#pragma mark -tableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _displayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFMessageFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[BFMessageFirstCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:messageCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _displayArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 5)];
    view.backgroundColor = RGBColor(240, 240, 240);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0f;
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
