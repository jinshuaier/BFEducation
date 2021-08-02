//
//  BFPrivacyPolicyViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/27.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFPrivacyPolicyViewController.h"

@interface BFPrivacyPolicyViewController ()
@end

@implementation BFPrivacyPolicyViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"法律声明及隐私权政策页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"法律声明及隐私权政策页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

#pragma mark - 创建UITextView

-(void)createUI {
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(15, 20, 20, 30);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
    textView.editable = NO;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"法律声明及隐私权政策" ofType:@"txt"];
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    textView.text = content;
    [self.view addSubview:textView];
}

#pragma mark - 返回的点击事件

-(void)clickBackAction {
    [self.navigationController popViewControllerAnimated:YES];
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
