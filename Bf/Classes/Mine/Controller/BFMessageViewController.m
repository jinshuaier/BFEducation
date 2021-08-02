//
//  BFMessageViewController.m
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMessageViewController.h"
#import "BFMessageDetailsVC.h"
#import "BFMessageCell.h"


@interface BFMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
// table
@property (nonatomic , strong) UITableView *tableView;
// 数据
@property (nonatomic , strong) NSMutableArray *displayArray;
@end

static NSString *const messageCell = @"messageCell";

@implementation BFMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息中心";
    [self prepareData];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) style:(UITableViewStylePlain)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[BFMessageCell class] forCellReuseIdentifier:messageCell];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
}

- (void)prepareData{
    UIImage *img = [UIImage imageNamed:@"直播"];
    _displayArray = @[@{@"icon":img,@"title":@"通知消息"},@{@"icon":img,@"title":@"收到的回复"},@{@"icon":img,@"title":@"收到的赞和收藏"}].mutableCopy;
}

#pragma mark -tableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _displayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[BFMessageCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:messageCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dict = _displayArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BFMessageDetailsVC *vc = [BFMessageDetailsVC new];
    NSDictionary *dic = _displayArray[indexPath.row];
    vc.titleStr = dic[@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
