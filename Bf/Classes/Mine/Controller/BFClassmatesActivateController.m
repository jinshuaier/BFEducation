//
//  BFClassmatesActivateController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFClassmatesActivateController.h"

@interface BFClassmatesActivateController ()
@property (nonatomic ,strong) UITextField *numberField;
@end

@implementation BFClassmatesActivateController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"校友激活页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"校友激活页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"校友激活";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createInterface];
}

#pragma mark - 创建视图

-(void)createInterface {
    //背景图片
    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123123"]];
    backImg.frame = CGRectMake(20, 64 + 80, KScreenW - 40, 260);
    [self.view addSubview:backImg];
    //头像
    NSURL *url = [NSURL URLWithString:GetFromUserDefaults(@"iPhoto")];
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 80)/2, backImg.top - 40, 80, 80)];
    [headImg sd_setImageWithURL:url placeholderImage:PLACEHOLDER];
    headImg.layer.cornerRadius = 40;
    headImg.clipsToBounds = YES;
    [self.view addSubview:headImg];
    //昵称
    UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, headImg.bottom, KScreenW - 40, 20)];
    NSString *str = GetFromUserDefaults(@"iNickName");
    nicknameLabel.text = str;
    nicknameLabel.textAlignment = NSTextAlignmentCenter;
    nicknameLabel.textColor = [UIColor whiteColor];
    nicknameLabel.font = [UIFont fontWithName:BFfont size:13.0f];
    [self.view addSubview:nicknameLabel];
    //输入框
    UITextField *numberField = [[UITextField alloc] initWithFrame:CGRectMake(64, nicknameLabel.bottom + 30, KScreenW - 128, 30)];
    self.numberField = numberField;
    numberField.backgroundColor = [UIColor whiteColor];
    numberField.placeholder = @" 请输入校友卡号";
    UIView *blankView1 = [[UIView alloc] initWithFrame:CGRectMake(numberField.frame.origin.x,numberField.frame.origin.y,14.0, numberField.frame.size.height)];
    numberField.leftView = blankView1;
    numberField.leftViewMode =UITextFieldViewModeAlways;
    numberField.layer.cornerRadius = 5.0f;
    numberField.font = [UIFont fontWithName:BFfont size:13.0f];
    [self.view addSubview:numberField];
    //激活按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(64, backImg.bottom - 50, KScreenW - 128, 30);
    NSString *strAuth = GetFromUserDefaults(@"classAuth");
    if ([strAuth isEqualToString:@"1"]) {
        [btn setTitle:@"已激活" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        btn.userInteractionEnabled = NO;
    }
    else {
        [btn setTitle:@"立即激活" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:53/255.0 green:124/255.0  blue:206/255.0  alpha:1]];
        btn.userInteractionEnabled = YES;
    }
    btn.titleLabel.font = [UIFont fontWithName:BFfont size:13.0f];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5.0f;
    [self.view addSubview:btn];
}

#pragma mark - 激活按钮的点击事件

-(void)clickAction {
    NSString *vipCodeStr = self.numberField.text;
    if (vipCodeStr == nil || [vipCodeStr isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入激活码"];
    }
    else {
        NSString *url = [NSString stringWithFormat:@"%@?vipcode=%@&uid=%@",SchoolVip,vipCodeStr,GetFromUserDefaults(@"uId")];
        [NetworkRequest requestWithUrl:url parameters:nil successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"success"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"校友认证成功"];
                [self.navigationController popViewControllerAnimated:YES];
                SaveToUserDefaults(@"classAuth", @"1");
            }
            else {
                [ZAlertView showSVProgressForErrorStatus:@"校友认证失败"];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"校友认证失败"];
        }];
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
