//
//  BFCooperationController.m
//  Bf
//
//  Created by 陈超 on 2018/11/9.
//  Copyright © 2018 陈大鹰. All rights reserved.
//

#import "BFCooperationController.h"
#import <WebKit/WebKit.h>
@interface BFCooperationController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIWebView *webView;
@end

@implementation BFCooperationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@",self.titleStr];
    [self createCooperationInterface];
}

#pragma mark - 创建webView

-(void)createCooperationInterface {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    //加载url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",self.urlStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}
@end
