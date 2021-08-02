//
//  BFRechangeViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFRechangeViewController.h"
#import "BFTopRechangeCell.h"
#import "BFMiddleCell.h"
@interface BFRechangeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation BFRechangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"校友激活";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpTableViewInterface];
    
}

#pragma mark - 创建tableView

-(void)setUpTableViewInterface {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = GroundGraryColor;
    [_tableView registerClass:[BFTopRechangeCell class] forCellReuseIdentifier:@"topCell"];
    [_tableView registerClass:[BFMiddleCell class] forCellReuseIdentifier:@"middleCell"];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *voidCell;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if (indexPath.row == 0) {
        BFTopRechangeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 1) {
        BFMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"middleCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imgBlock1 = ^(){
            //点击100元
            NSLog(@"点击100元");
            [cell.Img1 setImage:[UIImage imageNamed:@"100元"] forState:UIControlStateNormal];
            [cell.Img2 setImage:[UIImage imageNamed:@"200元不可点击"] forState:UIControlStateNormal];
            [cell.Img3 setImage:[UIImage imageNamed:@"300元不可点击"] forState:UIControlStateNormal];
            [cell.Img4 setImage:[UIImage imageNamed:@"1000元不可点击"] forState:UIControlStateNormal];
        };
        
        cell.imgBlock2 = ^(){
            //点击200元
            NSLog(@"点击200元");
            [cell.Img1 setImage:[UIImage imageNamed:@"100元不可点击"] forState:UIControlStateNormal];
            [cell.Img2 setImage:[UIImage imageNamed:@"200元"] forState:UIControlStateNormal];
            [cell.Img3 setImage:[UIImage imageNamed:@"300元不可点击"] forState:UIControlStateNormal];
            [cell.Img4 setImage:[UIImage imageNamed:@"1000元不可点击"] forState:UIControlStateNormal];
        };
        
        cell.imgBlock3 = ^(){
            //点击300元
            NSLog(@"点击300元");
            [cell.Img1 setImage:[UIImage imageNamed:@"100元不可点击"] forState:UIControlStateNormal];
            [cell.Img2 setImage:[UIImage imageNamed:@"200元不可点击"] forState:UIControlStateNormal];
            [cell.Img3 setImage:[UIImage imageNamed:@"300元"] forState:UIControlStateNormal];
            [cell.Img4 setImage:[UIImage imageNamed:@"1000元不可点击"] forState:UIControlStateNormal];
        };
        
        cell.imgBlock4 = ^(){
            //点击1000元
            NSLog(@"点击1000元");
            [cell.Img1 setImage:[UIImage imageNamed:@"100元不可点击"] forState:UIControlStateNormal];
            [cell.Img2 setImage:[UIImage imageNamed:@"200元不可点击"] forState:UIControlStateNormal];
            [cell.Img3 setImage:[UIImage imageNamed:@"300元不可点击"] forState:UIControlStateNormal];
            [cell.Img4 setImage:[UIImage imageNamed:@"1000元"] forState:UIControlStateNormal];
        };
        return cell;
    }
    else if (indexPath.row == 2) {
    }
    return voidCell;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
    }
    else if (indexPath.row == 1) {
        return 250;
    }
    return 10.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor redColor]];
    return headerView;
}

#pragma mark - 筛选按钮的点击事件

-(void)clickFiltrateAction {
    
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
