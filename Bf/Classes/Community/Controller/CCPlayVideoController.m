//
//  CCPlayVideoController.m
//  基本框架
//
//  Created by 陈大鹰 on 2017/12/1.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "CCPlayVideoController.h"

@interface CCPlayVideoController ()
@property (nonatomic, strong) JWPlayer *player;
@end

@implementation CCPlayVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _player=[[JWPlayer alloc]initWithFrame:CGRectMake(0, 0, KScreenW,KScreenH)];
    [_player updatePlayerWith:[NSURL URLWithString:self.videoUrl]];
    [self.view addSubview:_player];
    
    //返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
//    [backButton setTitle:@"返回" forState:UIControlStateHighlighted];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    //删除视频
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
     [deleteBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [deleteBtn sizeToFit];
    [deleteBtn addTarget:self action:@selector(clickDelete) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:deleteBtn];
}

//返回视频的点击事件
-(void)clickBack {
    [_player removeObserverAndNotification];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//删除视频的点击事件
-(void)clickDelete {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteVideo" object:nil];
    [_player removeObserverAndNotification];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
