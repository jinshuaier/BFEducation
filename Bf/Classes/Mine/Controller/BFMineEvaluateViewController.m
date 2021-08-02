//
//  BFMineEvaluateViewController.m
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFMineEvaluateViewController.h"

@interface BFMineEvaluateViewController ()

@end

@implementation BFMineEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
//    [_tableView registerClass:[BFCommunityImageCell class] forCellReuseIdentifier:imageCell];
//    [_tableView registerClass:[BFCommunityVideoCell class] forCellReuseIdentifier:videoCell];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
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
