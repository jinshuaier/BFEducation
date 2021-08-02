//
//  BFPreviewVideoController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/6.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFPreviewVideoController.h"
#import "BFPublishTopicController.h"//发布页面
@interface BFPreviewVideoController ()
@property (nonatomic, strong) JWPlayer *player;
@end

@implementation BFPreviewVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    _player=[[JWPlayer alloc]initWithFrame:CGRectMake(0, 0, KScreenW,KScreenH)];
    [_player updatePlayerWith:[NSURL URLWithString:self.videoUrl]];
    [self.view addSubview:_player];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 60, 30);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    backBtn.titleLabel.font = [UIFont fontWithName:BFfont size:13.0f];
    [backBtn addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

#pragma mark - 返回按钮的点击事件(跳转到发布页面)
-(void)clickBackAction {
    //视频录制完成.发送通知返回到上一个页面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveVideoUrl" object:@{@"videoPath":self.videoUrl}];
    self.navigationController.navigationBarHidden = NO;
    BFPublishTopicController *publishVC = [[BFPublishTopicController alloc] init];
    [self.navigationController pushViewController:publishVC animated:YES];
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
