//
//  BFAgreementViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/28.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFAgreementViewController.h"

@interface BFAgreementViewController ()

@end

@implementation BFAgreementViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"用户协议"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"用户协议"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}

#pragma mark - 创建UITextView

-(void)createUI {
    
    //设置返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //让按钮往左移动15个单位
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    backButton.size = CGSizeMake(40, 30);
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, KNavHeight, KScreenW, KScreenH - KNavHeight)];
    textView.editable = NO;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"用户注册协议" ofType:@"txt"];
    NSError *error;
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    textView.text = content;
    [self.view addSubview:textView];
}

#pragma mark - 返回的点击事件

-(void)clickBack {
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
