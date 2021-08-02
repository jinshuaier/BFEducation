//
//  BFChatViewController.m
//  Bf
//
//  Created by 春晓 on 2017/12/28.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFChatViewController.h"
#import <WebKit/WebKit.h>

@interface BFChatViewController ()<UIWebViewDelegate>

@property (nonatomic , strong) UIWebView *webView;
@end

@implementation BFChatViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createAgreementInterface];
    
}
#pragma mark - 创建webView

-(void)createAgreementInterface {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = true;
    NSString *agreementStr = @"http://talk.beifang.net/LR/Chatpre.aspx?id=MGG20239022&lng=cn";
    //加载url
    NSURL *agreementUrl = [NSURL URLWithString:agreementStr];
    //加载请求
    NSURLRequest *request = [NSURLRequest requestWithURL:agreementUrl];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

@end
