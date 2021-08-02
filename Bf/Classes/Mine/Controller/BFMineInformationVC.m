//
//  BFMineInformationVC.m
//  Bf
//
//  Created by 春晓 on 2017/12/11.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFMineInformationVC.h"
#import "BFFindPasswordByVerificationCodeViewController.h"

#define IsValid(content) [ZQInvalidWordsManager judge:content]
@interface BFMineInformationVC ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
/*创建背景UIScrollView*/
@property (nonatomic,strong) UIScrollView *scrollView;
/*大头像*/
@property (nonatomic,strong) UIImageView *headImg;
/*小头像*/
@property (nonatomic,strong) UIImageView *smallHeadImg;
/*修改头像按钮*/
@property (nonatomic,strong) UIButton *changeHeadImgBtn;
/*修改密码按钮*/
@property (nonatomic,strong) UIButton *changePwdBtn;
/*保存按钮*/
@property (nonatomic,strong) UIButton *saveBtn;
/*身份标签*/
@property (nonatomic,strong) UILabel *idenLabel;
/*个人介绍*/
@property (nonatomic,strong) UITextView *introView;
/*昵称输入框*/
@property (nonatomic,strong) UITextField *nickNameField;
/*用户头像数组*/
@property (nonatomic,strong) NSMutableArray *imgArr;

@end

@implementation BFMineInformationVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"个人资料页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"个人资料页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.view.backgroundColor = [UIColor blueColor];
    [self createUIScrollView];
    [self setUpInterface];
}

#pragma mark - 创建UIScrollView

-(void)createUIScrollView {
    UIView *topView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 64)];
    
    topView.backgroundColor = RGBColor(0, 159, 255);
    topView.userInteractionEnabled = YES;
    [self.view addSubview:topView];
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(5, 20, 40, 30);
    [backBtn setImage:[UIImage imageNamed:@"backWhite"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(clickBackAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];

    //标题
    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = @"我的资料";
    lbl.textColor = [UIColor whiteColor];
    lbl.font = [UIFont fontWithName:BFfont size:17.0f];
    lbl.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.bottom.mas_equalTo(topView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(120, 64));
        
    }];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lbl.mas_centerY);
        make.left.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(40, 30));
        
    }];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = self.view.size;
    self.scrollView.bounces = YES;
    self.scrollView.userInteractionEnabled = YES;
    
    if (KIsiPhoneX) {
        topView.frame = CGRectMake(0, 0, KScreenW, 88);
        self.scrollView.frame = CGRectMake(0, 88, KScreenW, KScreenH-88);
    }
    
    [self.view addSubview:self.scrollView];
}

#pragma mark - 返回的点击事件

-(void)clickBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 创建视图

-(void)setUpInterface {
    UIView *backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 121)];
    backV.backgroundColor = RGBColor(0, 159, 255);
    [self.scrollView addSubview:backV];
    //头像
    self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 60)/2, 13, 60, 60)];
    NSURL *url = [NSURL URLWithString:GetFromUserDefaults(@"iPhoto")];
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    [self.headImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"123"]];
//    self.headImg.image = image;
    self.headImg.layer.cornerRadius = 30.0f;
    [self.headImg.layer setMasksToBounds:YES];
    [backV addSubview:_headImg];
    //修改头像按钮
    self.changeHeadImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changeHeadImgBtn.frame = CGRectMake((KScreenW - 120)/2, self.headImg.bottom + 13, 120, 15);
    [self.changeHeadImgBtn setTitle:@"点击修改头像" forState:UIControlStateNormal];
    self.changeHeadImgBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.changeHeadImgBtn setTitleColor:RGBColor(248, 250, 252) forState:UIControlStateNormal];
    [self.changeHeadImgBtn addTarget:self action:@selector(clickChangeHeadImgAciton) forControlEvents:UIControlEventTouchUpInside];
    self.changeHeadImgBtn.backgroundColor = [UIColor clearColor];
    [backV addSubview:self.changeHeadImgBtn];
    //下划线
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(0, backV.bottom, KScreenW, 11.0f)];
    line0.backgroundColor = RGBColor(240, 240, 240);
    [self.scrollView addSubview:line0];
    //用户名
    UILabel *userName = [[UILabel alloc] initWithFrame:CGRectMake(20, line0.bottom, 60, 50)];
    userName.text = @"用户名 : ";
    userName.textColor = RGBColor(102, 102, 102);
    userName.font = [UIFont fontWithName:BFfont size:12.0f];
    [self.scrollView addSubview:userName];
    //用户名输入框
    UILabel *userName1 = [[UILabel alloc] initWithFrame:CGRectMake(userName.right, line0.bottom, 200, 50)];
    userName1.text = GetFromUserDefaults(@"uPhone") ? : @"19216811151";
    userName1.textColor = RGBColor(178, 178, 178);
    userName1.font = [UIFont fontWithName:BFfont size:12.0f];
    [self.scrollView addSubview:userName1];
    //密码
    UILabel *password = [[UILabel alloc] initWithFrame:CGRectMake(20, userName.bottom, 60, 50)];
    password.text = @"密码 : ";
    password.textColor = RGBColor(102, 102, 102);
    password.font = [UIFont fontWithName:BFfont size:12.0f];
    [self.scrollView addSubview:password];
    //密码输入框
    UILabel *password1 = [[UILabel alloc] initWithFrame:CGRectMake(userName.right, userName.bottom, 200, 50)];
    password1.text = @"******";
    password1.font = [UIFont fontWithName:BFfont size:12.0f];
    password1.textColor = RGBColor(178, 178, 178);
    [self.scrollView addSubview:password1];
    //修改密码按钮
    self.changePwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.changePwdBtn.frame = CGRectMake(KScreenW - 20 - 60, userName.bottom, 60, 50);
    [self.changePwdBtn setTitleColor:RGBColor(178, 178, 178) forState:UIControlStateNormal];
    [self.changePwdBtn setTitle:@"修改" forState:UIControlStateNormal];
    self.changePwdBtn.titleLabel.font = [UIFont fontWithName:BFfont size:12.0f];
    [self.changePwdBtn addTarget:self action:@selector(clickChangePwd) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.changePwdBtn];
    //下划线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, password.bottom, KScreenW, 8.0f)];
    line1.backgroundColor = RGBColor(240, 240, 240);
    [self.scrollView addSubview:line1];
    //昵称
    UILabel *nickName = [[UILabel alloc] initWithFrame:CGRectMake(20, line1.bottom, 60, 40)];
    nickName.text = @"昵称 : ";
    nickName.textColor = RGBColor(102, 102, 102);
    nickName.font = [UIFont fontWithName:BFfont size:12.0f];
    [self.scrollView addSubview:nickName];
    //昵称输入框
    UITextField *nickNameField = [[UITextField alloc] initWithFrame:CGRectMake(nickName.right, line1.bottom, KScreenW - 40 - 60, 40)];
    self.nickNameField = nickNameField;
    self.nickNameField.text = GetFromUserDefaults(@"iNickName");
    nickNameField.textColor = RGBColor(178, 178, 178);
    nickNameField.font = [UIFont fontWithName:BFfont size:12.0f];
    nickNameField.delegate = self;
    [nickNameField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.scrollView addSubview:nickNameField];
    //个人介绍
    UILabel *introduce = [[UILabel alloc] initWithFrame:CGRectMake(20, nickNameField.bottom, 60, 40)];
    introduce.text = @"介绍 : ";
    introduce.textColor = RGBColor(102, 102, 102);
    introduce.font = [UIFont fontWithName:BFfont size:12.0f];
    [self.scrollView addSubview:introduce];
    //个人介绍输入框
    UITextView *introView = [[UITextView alloc] initWithFrame:CGRectMake((KScreenW - 334)/2, introduce.bottom, 334, 105)];
    self.introView = introView;
    introView.layer.borderWidth = 1.0f;
    introView.text = GetFromUserDefaults(@"iIntr") ? : @"编辑个人介绍,不超过80字";
    introView.textColor = RGBColor(178, 178, 178);
    introView.font = [UIFont fontWithName:BFfont size:12.0f];
    introView.layer.borderColor = RGBColor(178, 178, 178).CGColor;
    introView.delegate = self;
    [self.scrollView addSubview:introView];
    //保存按钮
    self.saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn.frame = CGRectMake((KScreenW - 335)/2, introView.bottom + 30, 335, 40);
    [self.saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [self.saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.saveBtn setBackgroundColor:RGBColor(0, 159, 255)];
    self.saveBtn.layer.cornerRadius = 4.0f;
    [self.saveBtn addTarget:self action:@selector(clickSaveInformation) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.saveBtn];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.introView.text.length > 80) {
        self.introView.text = [textView.text substringToIndex:80];
        [ZAlertView showSVProgressForInfoStatus:@"个人介绍不超过80字"];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if([self.introView.text isEqualToString:@"编辑个人介绍,不超过80字"]){
        self.introView.text=@"";
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSInteger maxLength = 6;//设置限制字数
    if (textField == _nickNameField) {
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
    if (IsValid(_nickNameField.text)) {
    }
    else {
        [ZAlertView showSVProgressForErrorStatus:@"您的词汇过于敏感,请重新输入昵称"];
        self.nickNameField.text = @"";
    }
}


#pragma mark - 点击修改头像

-(void)clickChangeHeadImgAciton {
    ZQDialogueViewController *controller = [[ZQDialogueViewController alloc] initWithActions:@[@"拍照",@"相册"] block:^(int index) {
        if (index == 0) {
            //点击取消的响应事件
        }
        else if(index == 1) {
            //拍照
            //创建UIImagePickerController对象，并设置代理和可编辑
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.editing = YES;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            //选择相机时，设置UIImagePickerController对象相关属性
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
            imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
            imagePicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            //跳转到UIImagePickerController控制器弹出相机
            imagePicker.modalPresentationStyle = 0;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        else if (index == 2) {
            //相册
            //创建UIImagePickerController对象，并设置代理和可编辑
            UIImagePickerController * imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.editing = YES;
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            //选择相册时，设置UIImagePickerController对象相关属性
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //跳转到UIImagePickerController控制器弹出相册
            imagePicker.modalPresentationStyle = 0;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
        else {
        }
    }];
    [controller show];
}

#pragma mark - imagePickerController delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    //获取到的图片
    UIImage * image = [info valueForKey:UIImagePickerControllerEditedImage];
    self.headImg.image = image;
    [self.imgArr addObject:image];
    NSDictionary *dic = @{@"uId":GetFromUserDefaults(@"uId")};
    [NetworkRequest changeImagesWithUrl:UpdateUserImg parameters:dic imageArray:self.imgArr successResponse:^(id data) {
        NSLog(@"成功!%@",data);
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            [ZAlertView showSVProgressForSuccess:@"更改头像成功!"];
            SaveToUserDefaults(@"iPhoto", nil);
            SaveToUserDefaults(@"iPhoto", dic[@"url"]);
            [self.navigationController popViewControllerAnimated:YES];
          
        }
        else {
            [ZAlertView showSVProgressForSuccess:[NSString stringWithFormat:@"%@",dic[@"errMsg"]]];
        }
        
    } failureResponse:^(NSError *error) {
        NSLog(@"失败!");
    }];
}

#pragma mark - 点击修改密码

-(void)clickChangePwd {
    BFFindPasswordByVerificationCodeViewController *findPasswordVC = [[BFFindPasswordByVerificationCodeViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:findPasswordVC];
    navigation.modalPresentationStyle = 0;
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - 点击保存个人信息

-(void)clickSaveInformation {
    if ([self.introView.text isEqualToString:@"编辑个人介绍,不超过80字"]) {
        [ZAlertView showSVProgressForErrorStatus:@"请填写个人介绍"];
    }
    else if (self.nickNameField.text == nil || [self.nickNameField.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请填写昵称"];
    }
    else if (self.nickNameField.text.length < 1) {
        [ZAlertView showSVProgressForErrorStatus:@"您的昵称长度过短,请重新输入"];
    }
    else {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        if ([self.nickNameField.text isEqualToString:GetFromUserDefaults(@"iNickName")]) {
            [dic setObject:GetFromUserDefaults(@"uId") forKey:@"uId"];
            [dic setObject:self.introView.text forKey:@"iIntr"];
        }
        else {
            [dic setObject:GetFromUserDefaults(@"uId") forKey:@"uId"];
            [dic setObject:self.nickNameField.text forKey:@"iNickName"];
            [dic setObject:self.introView.text forKey:@"iIntr"];
        }
        [NetworkRequest sendDataWithUrl:UpdatePersonalCenter parameters:dic successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"信息保存成功"];
                SaveToUserDefaults(@"iNickName", self.nickNameField.text);
                SaveToUserDefaults(@"iIntr", self.introView.text);
               
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                NSString *errMsg = dic[@"msg"];
                [ZAlertView showSVProgressForErrorStatus:errMsg];
            }
            
        } failure:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"信息保存失败"];
        }];
    }
}

-(NSMutableArray *)imgArr {
    if (_imgArr == nil) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

@end

