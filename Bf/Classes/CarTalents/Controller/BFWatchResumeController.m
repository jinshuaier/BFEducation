//
//  BFWatchResumeController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/3.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFWatchResumeController.h"

@interface BFWatchResumeController ()<UIWebViewDelegate>
@property (nonatomic , strong) UIWebView *webView;
@end

@implementation BFWatchResumeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线预览";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
}
#pragma mark - 创建UITextView

-(void)createUI {
    NSString *urlString = [NSString stringWithFormat:@"%@",self.url];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = true;
    [self.webView sizeToFit];
    //加载请求
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    [self.view addSubview:self.webView];
}

#pragma mark - 返回的点击事件

-(void)clickBack {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
