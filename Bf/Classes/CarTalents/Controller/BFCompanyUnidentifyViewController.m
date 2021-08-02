//
//  BFCompanyUnidentifyViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/9.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCompanyUnidentifyViewController.h"
#import "BFAutherViewController.h"//企业认证
#import "BFPostJobViewController.h"//发布职位
#import "BFCompanyInformationViewController.h"//企业信息
@interface BFCompanyUnidentifyViewController ()

/*企业是否完善信息*/
@property (nonatomic,copy) NSString *isInformation;
@end

@implementation BFCompanyUnidentifyViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
}

- (void)viewWillDisappear:(BOOL)animated{
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

-(void)createInterface {
    UIImageView *img = [[UIImageView alloc] init];
    if (KIsiPhoneX) {
        img.frame = CGRectMake((KScreenW - 200)/2, 88, 200, 200);
    }
    else {
        img.frame = CGRectMake((KScreenW - 200)/2, 64, 200, 200);
    }
    
    if ([self.style1 isEqualToString:@"2"]) {//企业未认证或认证失败
        img.image = [UIImage imageNamed:@"申请认证"];
    }
    else if ([self.style1 isEqualToString:@"0"]) {//企业正在审核中
        img.image = [UIImage imageNamed:@"身份验证"];
    }
    else if ([self.style1 isEqualToString:@"1"]) {//企业审核完毕
        img.image = [UIImage imageNamed:@"发布招聘"];
    }
    
    [self.view addSubview:img];
    
    UILabel *tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, img.bottom + 40, KScreenW, 20)];
    if ([self.style1 isEqualToString:@"2"]) {//企业未认证或认证失败
        tipLbl.text = @"完成企业身份审核,不错过任何一个人才";
    }
    else if ([self.style1 isEqualToString:@"0"]) {//企业正在审核中
        tipLbl.text = @"正在进行身份验证，大约需要2-5个工作日";
    }
    else if ([self.style1 isEqualToString:@"1"]) {//企业审核完毕
        tipLbl.text = @"快来招聘人才吧";
    }
    tipLbl.textColor = RGBColor(51, 51, 51);
    tipLbl.font = [UIFont fontWithName:BFfont size:14.0f];
    tipLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLbl];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, tipLbl.bottom + 70, KScreenW - 20, 50);
    if ([self.style1 isEqualToString:@"2"]) {//企业未认证
        [btn setHidden:NO];
        [btn setTitle:@"申请认证" forState:UIControlStateNormal];
    }
    else if ([self.style1 isEqualToString:@"0"]) {//企业正在审核中
        [btn setHidden:YES];
    }
    else if ([self.style1 isEqualToString:@"1"]) {//企业审核完毕
        [btn setHidden:NO];
        [btn setTitle:@"发布招聘" forState:UIControlStateNormal];
    }
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:RGBColor(0, 148, 231)];
    [btn addTarget:self action:@selector(clickBtnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 4.0f;
    [self.view addSubview:btn];
}

-(void)clickBtnAction {
    if ([self.style1 isEqualToString:@"2"]) {//企业未认证
        //进行企业认证
        BFAutherViewController *authVC = [[BFAutherViewController alloc] init];
        [self.navigationController pushViewController:authVC animated:YES];
    }
    else if ([self.style1 isEqualToString:@"0"]) {//企业正在审核中
        
    }
    else if ([self.style1 isEqualToString:@"1"]) {//企业审核完毕
        
    }
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
