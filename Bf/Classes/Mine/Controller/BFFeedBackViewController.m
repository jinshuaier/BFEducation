//
//  BFFeedBackViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/29.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFFeedBackViewController.h"

@interface BFFeedBackViewController ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic,strong) UITextField *titleField;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIButton *btn;
@end

@implementation BFFeedBackViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"反馈留言页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"反馈留言页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"反馈留言";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.view.backgroundColor = RGBColor(239, 239, 239);
    [self setUpInterface];
}

-(void)setUpInterface {
    //输入标题
    UITextField *titleField = [[UITextField alloc] init];
    if (KIsiPhoneX) {
        titleField.frame = CGRectMake((KScreenW - 355)/2, 74+24, 355, 40);
    }
    else {
        titleField.frame = CGRectMake((KScreenW - 355)/2, 74, 355, 40);
    }
    self.titleField = titleField;
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(_titleField.frame.origin.x,_titleField.frame.origin.y,14.0, _titleField.frame.size.height)];
    self.titleField.leftView = blankView;
    self.titleField.leftViewMode =UITextFieldViewModeAlways;
    titleField.delegate = self;
    titleField.backgroundColor = [UIColor whiteColor];
    titleField.placeholder = @"请输入您的主题";
    titleField.layer.cornerRadius = 4.0f;
    titleField.textColor = RGBColor(153, 153, 153);
    titleField.font = [UIFont fontWithName:BFfont size:15.0f];
    [self.view addSubview:titleField];
    //输入内容
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake((KScreenW - 355)/2, titleField.bottom + 9, 355, 188)];
    self.textView = textView;
    textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    textView.delegate = self;
    textView.layer.cornerRadius = 4.0f;
    textView.text = @"请在这里输入您的反馈意见";
    textView.textColor = RGBColor(153, 153, 153);
    textView.font = [UIFont fontWithName:BFfont size:13.0f];
    [self.view addSubview:textView];
    //提交
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((KScreenW - 355)/2, textView.bottom + 40, 355, 40);
    self.btn = btn;
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:RGBColor(0, 169, 255)];
    btn.layer.cornerRadius = 4.0f;
    [btn addTarget:self action:@selector(clickCommit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length > 300) {
        self.textView.text = [textView.text substringToIndex:300];
        [ZAlertView showSVProgressForInfoStatus:@"个人介绍不超过300字"];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if([self.textView.text isEqualToString:@"请在这里输入您的反馈意见"]){
        self.textView.text=@"";
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger maxLength = 30;//设置限制字数
    if (textField == self.titleField) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if (toBeString.length > maxLength && range.length!=1){
            textField.text = [toBeString substringToIndex:maxLength];
            return NO;
        }
    }
    return YES;
}

#pragma mark - 昵称敏感词汇检测

-(void)textFieldDidChange{
    if (IsValid(_titleField.text)) {
    }
    else {
        [ZAlertView showSVProgressForErrorStatus:@"您的词汇过于敏感,请重新输入"];
        self.titleField.text = @"";
    }
}

#pragma mark - 提交按钮的点击事件

-(void)clickCommit {
    if (self.titleField.text == nil || [self.titleField.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入您的主题"];
    }
    else if (self.textView.text == nil || [self.textView.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入您的反馈意见"];
    }
    else {
        [ZAlertView showSVProgressForSuccess:@"提交成功"];
        [self.navigationController popViewControllerAnimated:YES];
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
