//
//  BFIntroduceViewController.m
//  NewTest
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFIntroduceViewController.h"
#import "UILabel+MBCategory.h"

@interface BFIntroduceViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

static NSString *introduceCell = @"IntroduceCell";

static NSString *description = @"暂无简介";

@implementation BFIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:(UITableViewStylePlain)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:introduceCell];
}

#pragma mark -UItableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:introduceCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:introduceCell];
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:BFfont size:15];
    cell.textLabel.textColor = RGBColor(153, 153, 153);
    if (_descriptionStr) {
        cell.textLabel.text = _descriptionStr;
        [UILabel changeSpaceForLabel:cell.textLabel withLineSpace:5 WordSpace:1];
    }else{
        cell.textLabel.text = description;
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_descriptionStr) {
        CGSize size = [UILabel sizeWithString:_descriptionStr font:[UIFont fontWithName:BFfont size:15] size:CGSizeMake(KScreenW - 40, 2000)];
        return size.height;
    }else{
        return 100;
    }
}

- (void)setDescriptionStr:(NSString *)descriptionStr{
    _descriptionStr = descriptionStr;
    [_tableView reloadData];
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
