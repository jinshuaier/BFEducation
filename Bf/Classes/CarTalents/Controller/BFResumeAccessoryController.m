//
//  BFResumeAccessoryController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/28.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFResumeAccessoryController.h"
#import "BFResumeExplainViewController.h"//上传附件简历H5
@interface BFResumeAccessoryController ()

@end

@implementation BFResumeAccessoryController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附件简历";
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
}

#pragma mark - 创建视图
-(void)createInterface {
    //占位图
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 182)/2, 130, 182, 135)];
    img.image = [UIImage imageNamed:@"nodata"];
    [self.view addSubview:img];
    //备注
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, img.bottom + 10, KScreenW, 20)];
    lbl.text = @"暂无附件简历,点击按钮去上传吧";
    lbl.textColor = RGBColor(102,102,102);
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont fontWithName:BFfont size:15.0f];
    [self.view addSubview:lbl];
    //按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(15, lbl.bottom + 50, KScreenW - 30, 40);
    [btn setTitle:@"手机上传" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:RGBColor(0, 148, 231)];
    btn.layer.cornerRadius = 4.0f;
    [btn addTarget:self action:@selector(clickUploadResume) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)clickUploadResume {
    BFResumeExplainViewController *explainVC = [[BFResumeExplainViewController alloc] init];
    [self.navigationController pushViewController:explainVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
