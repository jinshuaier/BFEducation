//
//  BFFindPasswordByNewPasswordViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFFindPasswordByNewPasswordViewController.h"

@interface BFFindPasswordByNewPasswordViewController ()
/*重复新密码*/
@property (nonatomic,strong) UITextField *repeatPassword;
/*新密码*/
@property (nonatomic,strong) UITextField *password;
@end

@implementation BFFindPasswordByNewPasswordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"找回密码页(重新输入密码)"];//("PageOne"为页面名称，可自定义)
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"找回密码页(重新输入密码)"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置新密码";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpInterface];
    //设置返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    //让按钮往左移动15个单位
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    backButton.size = CGSizeMake(40, 30);
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)clickBack {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)setUpInterface {
    //新密码
    UITextField *newPassword = [[UITextField alloc] initWithFrame:CGRectMake(58, 150, KScreenW - 116, 30)];
    self.password = newPassword;
    newPassword.secureTextEntry = YES;
    newPassword.placeholder = @"新密码";
    newPassword.keyboardType = UIKeyboardTypeDefault;
    newPassword.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.view addSubview:newPassword];
    //下划线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(58, newPassword.bottom, newPassword.width, 0.50f)];
    line1.backgroundColor = LineColor;
    [self.view addSubview:line1];
    //重复新密码
    UITextField *repeatPassword = [[UITextField alloc] initWithFrame:CGRectMake(58, line1.bottom + 15, KScreenW - 116, 30)];
    self.repeatPassword = repeatPassword;
    repeatPassword.secureTextEntry = YES;
    repeatPassword.placeholder = @"重复新密码";
    repeatPassword.keyboardType = UIKeyboardTypeDefault;
    repeatPassword.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.view addSubview:repeatPassword];
    //下划线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(58, repeatPassword.bottom, repeatPassword.width, 0.50f)];
    line2.backgroundColor = LineColor;
    [self.view addSubview:line2];
    //按钮
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.frame = CGRectMake(58, line2.bottom + 50, KScreenW - 116, 44);
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:RGBColor(0, 126, 212)];
    doneBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    doneBtn.layer.cornerRadius = 3.0f;
    [doneBtn addTarget:self action:@selector(clickDoneAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneBtn];
}

#pragma mark - 完成按钮的点击事件

-(void)clickDoneAction {
    //忘记密码的网络请求
    
    if ([self.password.text isEqualToString:@""] || self.password.text == nil || [self.repeatPassword.text isEqualToString:@""] || self.repeatPassword.text == nil) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入密码"];
    }
    else if (![self.password.text isEqualToString:self.repeatPassword.text]) {
        [ZAlertView showSVProgressForErrorStatus:@"前后两次密码输入不一致"];
    }
    else {
        NSString *phone = self.phoneNumer;
        NSString *vcode = self.vCode;
        NSString *password1 = [NSString sha1:self.password.text];
        NSDictionary *dic = @{@"uPhone":phone,@"code":vcode,@"newPwd":password1};
        
        [NetworkRequest sendDataWithUrl:FindPWD parameters:dic successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"找回密码成功"];
                UIViewController *present = self.presentingViewController.presentingViewController;
                [present dismissViewControllerAnimated:YES completion:nil];
            }
            else if (2 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForErrorStatus:@"用户不存在"];
            }
            else if (3 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForErrorStatus:@"验证码错误"];
            }
            else {
                [ZAlertView showSVProgressForErrorStatus:@"找回密码失败"];
            }
        } failure:^(NSError *error) {

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
