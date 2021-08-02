//
//  BFResumeAccessorySecondViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/28.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFResumeAccessorySecondViewController.h"
#import "BFResumeExplainViewController.h"
@interface BFResumeAccessorySecondViewController ()

@end

@implementation BFResumeAccessorySecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"附件简历";
    self.view.backgroundColor = RGBColor(240, 240, 240);
    [self createInterface];
}

#pragma mark - 创建视图
-(void)createInterface {
    //文件夹图标
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 130)/2, 120, 130, 130)];
    img.image = [UIImage imageNamed:@"文件夹"];
    [self.view addSubview:img];
    //简历名称
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, img.bottom + 10, KScreenW, 20)];
    titleLbl.text = self.resumeName;
    titleLbl.textColor = RGBColor(102, 102, 102);
    titleLbl.textAlignment = NSTextAlignmentCenter;
    titleLbl.font = [UIFont fontWithName:BFfont size:15.0f];
    [self.view addSubview:titleLbl];
    //简历时间
    UILabel *titleTime = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLbl.bottom + 10, KScreenW, 20)];
    titleTime.text = self.resumeTime;
    titleTime.textColor = RGBColor(153, 153, 153);
    titleTime.textAlignment = NSTextAlignmentCenter;
    titleTime.font = [UIFont fontWithName:BFfont size:11.0f];
    [self.view addSubview:titleTime];
    //重新上传按钮
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn0.frame = CGRectMake(10, KScreenH - 70 - 40, KScreenW/2 - 10 - 5, 40);
    [btn0 setTitle:@"重新上传" forState:UIControlStateNormal];
    [btn0 setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    [btn0 setBackgroundColor:RGBColor(240, 240, 240)];
    btn0.layer.cornerRadius = 4.0f;
    btn0.layer.borderWidth = 1.0f;
    btn0.layer.borderColor = RGBColor(211, 210, 210).CGColor;
    btn0.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    [btn0 addTarget:self action:@selector(clickAction0) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    //主页按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(KScreenW/2 + 5, KScreenH - 70 - 40, KScreenW/2 - 10 - 5, 40);
    [btn1 setTitle:@"开启求职之路" forState:UIControlStateNormal];
    [btn1 setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
    [btn1 setBackgroundColor:RGBColor(0, 148, 231)];
    btn1.layer.cornerRadius = 4.0f;
    btn1.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    [btn1 addTarget:self action:@selector(clickAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

-(void)clickAction0 {
    BFResumeExplainViewController *explainVC = [[BFResumeExplainViewController alloc] init];
    [self.navigationController pushViewController:explainVC animated:YES];
}

-(void)clickAction1 {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
