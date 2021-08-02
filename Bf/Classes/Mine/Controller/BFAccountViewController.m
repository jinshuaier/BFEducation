//
//  BFAccountViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFAccountViewController.h"
#import "BFRechangeDetailController.h"//账户明细
#import "BFRechangeViewController.h"//开始充值
@interface BFAccountViewController ()

@end

@implementation BFAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
}

-(void)createInterface {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 250)];
    backView.backgroundColor = [UIColor colorWithRed:74/255.0 green:167/255.0 blue:248/255.0 alpha:1];
    [self.view addSubview:backView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 25, 20, 20);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    //明细按钮
    UIButton *detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.frame = CGRectMake(KScreenW - 15 - 40, 25, 40, 20);
    [detailBtn setTitle:@"明细" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [detailBtn setBackgroundColor:[UIColor clearColor]];
    [detailBtn addTarget:self action:@selector(clickDetailAction) forControlEvents:UIControlEventTouchUpInside];
    detailBtn.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    [self.view addSubview:detailBtn];
    //账户余额
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(25, backBtn.bottom + 30, 60, 30)];
    lbl.text = @"账户余额";
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont fontWithName:BFfont size:15.0f];
    lbl.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lbl];
    //具体数目
    UILabel *count = [[UILabel alloc] initWithFrame:CGRectMake(25, lbl.bottom + 15, 200, 60)];
    count.textColor = [UIColor whiteColor];
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"8000学分"]];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:40.0]
                          range:NSMakeRange(0,4)];
    [AttributedStr addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:15.0]
                          range:NSMakeRange(4,2)];
    count.attributedText = AttributedStr;
    [self.view addSubview:count];
    //头像
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW - 25 - 60,lbl.bottom + 10, 60, 60)];
    headImg.image = [UIImage imageNamed:@"123"];
    headImg.layer.cornerRadius = 30.0f;
    headImg.clipsToBounds = YES;
    [self.view addSubview:headImg];
    
    //立即充值按钮
    UIButton *rechangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rechangeBtn.frame = CGRectMake(20, backView.bottom + 150, KScreenW - 40, 40);
    [rechangeBtn setTitle:@"立即充值" forState:UIControlStateNormal];
    [rechangeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rechangeBtn setBackgroundColor:[UIColor colorWithRed:53/255.0 green:124/255.0 blue:206/255.0 alpha:1]];
    rechangeBtn.titleLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    rechangeBtn.layer.cornerRadius = 5.0f;
    [rechangeBtn addTarget:self action:@selector(clickRechangeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rechangeBtn];
}

#pragma mark - 返回按钮的点击事件

-(void)clickBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 账户明细的点击事件

-(void)clickDetailAction {
    BFRechangeDetailController *detailVC = [[BFRechangeDetailController alloc] init];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 立即充值的点击事件

-(void)clickRechangeAction {
    BFRechangeViewController *rechargeVC = [[BFRechangeViewController alloc] init];
    [self.navigationController pushViewController:rechargeVC animated:YES];
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
