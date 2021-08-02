//
//  BFBindingViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/15.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBindingViewController.h"

@interface BFBindingViewController ()
@property (nonatomic,strong) UIImageView *qqImg;
@property (nonatomic,strong) UIImageView *wxImg;
@property (nonatomic,strong) UIButton *wxBtn;
@property (nonatomic,strong) UIButton *qqBtn;
@end

@implementation BFBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"绑定管理";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpInterface];
}

#pragma mark - 创建视图

-(void)setUpInterface {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, KScreenW, 30)];
    titleLabel.text = @"账号绑定";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    [self.view addSubview:titleLabel];
    
    UIImageView *wxImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, titleLabel.bottom + 35, 20, 20)];
    self.wxImg = wxImg;
    wxImg.image = [UIImage imageNamed:@"图层1拷贝"];
    [self.view addSubview:wxImg];
    
    UILabel *wxLabel = [[UILabel alloc] initWithFrame:CGRectMake(wxImg.right + 10, titleLabel.bottom + 30, 100, 30)];
    wxLabel.text = @"微信";
    wxLabel.textColor = [UIColor grayColor];
    wxLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    [self.view addSubview:wxLabel];
    
    UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wxBtn = wxBtn;
    wxBtn.tag = 0;
    wxBtn.frame = CGRectMake(KScreenW - 50 - 60, titleLabel.bottom + 30, 60, 30);
    [wxBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [wxBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    wxBtn.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    [wxBtn setBackgroundColor:RGBColor(0, 126, 212)];
    wxBtn.layer.cornerRadius = 3.0f;
    [wxBtn addTarget:self action:@selector(clickWxAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:wxBtn];
    
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(50, wxBtn.bottom + 10, KScreenW - 100, 0.50f)];
    line0.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line0];
    
    UIImageView *qqImg = [[UIImageView alloc] initWithFrame:CGRectMake(50, line0.bottom + 25, 20, 20)];
    self.qqImg = qqImg;
    qqImg.image = [UIImage imageNamed:@"图层2拷贝2"];
    [self.view addSubview:qqImg];
    
    UILabel *qqLabel = [[UILabel alloc] initWithFrame:CGRectMake(qqImg.right + 10, line0.bottom + 20, 100, 30)];
    qqLabel.text = @"QQ";
    qqLabel.textColor = [UIColor grayColor];
    qqLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    [self.view addSubview:qqLabel];
    
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.qqBtn = qqBtn;
    qqBtn.tag = 0;
    qqBtn.frame = CGRectMake(KScreenW - 50 - 60, line0.bottom + 20, 60, 30);
    [qqBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [qqBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qqBtn.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    [qqBtn setBackgroundColor:RGBColor(0, 126, 212)];
    qqBtn.layer.cornerRadius = 3.0f;
    [qqBtn addTarget:self action:@selector(clickQQAction1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:qqBtn];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(50, qqBtn.bottom + 10, KScreenW - 100, 0.50f)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
}

#pragma mark - 微信绑定点击事件

-(void)clickWxAction1 {
    if (self.wxBtn.tag == 0) {
        //此时还未进行绑定 点击进行绑定
        self.wxImg.image = [UIImage imageNamed:@"图层1"];
        [self.wxBtn setTitle:@"解除" forState:UIControlStateNormal];
        [self.wxBtn setBackgroundColor:RGBColor(178, 178, 178)];
        self.wxBtn.tag = 1;
    }
    else {
        //此时已经绑定 点击进行解除
        self.wxImg.image = [UIImage imageNamed:@"图层1拷贝"];
        [self.wxBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [self.wxBtn setBackgroundColor:RGBColor(0, 126, 212)];
        self.wxBtn.tag = 0;
    }
}

#pragma mark - QQ绑定点击事件

-(void)clickQQAction1 {
    if (self.qqBtn.tag == 0) {
        //此时还未进行绑定 点击进行绑定
        self.qqImg.image = [UIImage imageNamed:@"图层2"];
        [self.qqBtn setTitle:@"解除" forState:UIControlStateNormal];
        [self.qqBtn setBackgroundColor:RGBColor(178, 178, 178)];
        self.qqBtn.tag = 1;
    }
    else {
        //此时已经绑定 点击进行解除
        self.qqImg.image = [UIImage imageNamed:@"图层2拷贝2"];
        [self.qqBtn setTitle:@"绑定" forState:UIControlStateNormal];
        [self.qqBtn setBackgroundColor:RGBColor(0, 126, 212)];
        self.qqBtn.tag = 0;
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
