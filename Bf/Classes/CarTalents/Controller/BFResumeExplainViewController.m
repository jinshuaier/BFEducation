//
//  BFResumeExplainViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/28.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFResumeExplainViewController.h"
#import <WebKit/WebKit.h>
@interface BFResumeExplainViewController ()<UIWebViewDelegate>
@property (nonatomic , strong) UIWebView *webView;
@end

@implementation BFResumeExplainViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传附件简历";
    [self createAgreementInterface];
    
}
#pragma mark - 创建webView

-(void)createAgreementInterface {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = true;
    NSString *agreementStr = @"http://www.beifangzj.com/bfweb/upload-h5.html";
    //加载url
    NSURL *agreementUrl = [NSURL URLWithString:agreementStr];
    //加载请求
    NSURLRequest *request = [NSURLRequest requestWithURL:agreementUrl];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
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
