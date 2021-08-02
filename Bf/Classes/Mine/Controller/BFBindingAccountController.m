//
//  BFBindingAccountController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/6.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFBindingAccountController.h"

@interface BFBindingAccountController ()<UIActionSheetDelegate>

@end

@implementation BFBindingAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"绑定%@",self.thirdTitle];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置解除绑定按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"解绑" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    [rightBtn setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 44)];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[item1];
    
    [self createInterface];
}

#pragma mark - 创建视图

-(void)createInterface {
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 90)/2, 124, 90, 90)];
    [self.view addSubview:img];
    
    if ([self.thirdTitle isEqualToString:@"新浪微博"]) {
        img.image = [UIImage imageNamed:@"新浪微博1"];
    }
    else if ([self.thirdTitle isEqualToString:@"微信"]) {
        img.image = [UIImage imageNamed:@"微信1"];
    }
    else if ([self.thirdTitle isEqualToString:@"QQ"]) {
        img.image = [UIImage imageNamed:@"qq1"];
    }
    
    UILabel *lbl0 = [[UILabel alloc] initWithFrame:CGRectMake(0, img.bottom + 55, KScreenW, 20)];
    lbl0.text = self.thirdTitle;
    lbl0.font = [UIFont fontWithName:BFfont size:16.0f];
    lbl0.textColor = RGBColor(51, 51, 51);
    lbl0.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl0];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, img.bottom + 124, KScreenW, 20)];
    lbl.text = [NSString stringWithFormat:@"已成功绑定,您可以通过%@账号登录",self.thirdTitle];
    lbl.font = [UIFont fontWithName:BFfont size:14.0f];
    lbl.textColor = RGBColor(153, 153, 153);
    lbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbl];
    
}

#pragma mark - 解除绑定的网络请求

-(void)rightBtnClick {
    
    //创建actionSheet对象
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"解除绑定" otherButtonTitles:nil, nil];
    //actionSheet样式
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    //显示
    [sheet showInView:self.view];
    sheet.delegate = self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"点击确定");
        NSInteger thirdStyle = 100;
        if ([self.thirdTitle isEqualToString:@"新浪微博"]) {
            thirdStyle = 2;
        }
        else if ([self.thirdTitle isEqualToString:@"微信"]) {
            thirdStyle = 0;
        }
        else if ([self.thirdTitle isEqualToString:@"QQ"]) {
            thirdStyle = 1;
        }
        
        [NetworkRequest requestWithUrl:[NSString stringWithFormat:@"https://www.beifangzj.com/app-api/login/bfThirdPartBindDeleteByBState.do?bState=%ld",thirdStyle] parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if ([dic[@"status"] intValue] == 1) {
                [ZAlertView showSVProgressForSuccess:@"解除绑定成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                [ZAlertView showSVProgressForErrorStatus:@"解除绑定失败"];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"解除绑定失败"];
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
