//
//  BFAutherViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/9.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFAutherViewController.h"

@interface BFAutherViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
/*点击图片时全屏的背景视图*/
@property (nonatomic,strong) UIView *bgView;
/*点击图片时全屏的图片*/
@property (nonatomic,strong) UIImageView *browseImgView;
/*公司名称输入框*/
@property (nonatomic,strong) UITextField *companyField;
/*营业执照图片*/
@property (nonatomic,strong) UIImageView *uploadImg;
/*工作证明图片*/
@property (nonatomic,strong) UIImageView *workImg;

@property (nonatomic,strong) UIImageView *img0;
/*图片数组*/
@property (nonatomic, strong) NSMutableArray *imageArray;

/*编辑按钮*/
@property (nonatomic,strong) UIButton *rightBtn;
/*查看示例*/
@property (nonatomic,strong) UILabel *clickLbl;
/*完成按钮*/
@property (nonatomic,strong) UIButton *sureBtn;

@property (nonatomic,strong) UILabel *tipLbl;
@property (nonatomic,strong) UILabel *tipLbl1;
@end

@implementation BFAutherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份认证";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
    self.scrollView.backgroundColor = RGBColor(238, 240, 244);
    self.scrollView.contentSize = self.view.size;
    self.scrollView.bounces = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    self.imageArray = imageArray;
    
    
    if ([self.isAuth isEqualToString:@"0"]) {
        //设置切换按钮
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn = rightBtn;
        [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [rightBtn setFrame:CGRectMake(0, 0, 40, 30)];
        [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
        self.navigationItem.rightBarButtonItems = @[item1];
    }
    
    [self setUpInterface];
}

-(void)rightBtnClick {
    self.isAuth = @"1";
    self.companyField.userInteractionEnabled = YES;
    self.uploadImg.userInteractionEnabled = YES;
    self.workImg.userInteractionEnabled = YES;
    self.clickLbl.hidden = NO;
    self.sureBtn.hidden = YES;
    self.rightBtn.hidden = NO;
    self.tipLbl.hidden = NO;
    self.tipLbl1.hidden = NO;
    [self.rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightNewAuthClick) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 创建视图

-(void)setUpInterface {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 41)];
    topView.backgroundColor = RGBColor(0, 140, 244);
    [self.scrollView addSubview:topView];
    
    //topView上的按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if ([self.isAuth isEqualToString:@"0"]) {
        [btn setImage:[UIImage imageNamed:@"通过"] forState:UIControlStateNormal];
        [btn setTitle:@" 认证已通过" forState:UIControlStateNormal];
    }else {
        [btn setImage:[UIImage imageNamed:@"未通过"] forState:UIControlStateNormal];
        [btn setTitle:@" 认证未通过，修改公司信息" forState:UIControlStateNormal];
    }
    btn.titleLabel.font = [UIFont fontWithName:BFfont size:12.0f];
    btn.titleLabel.textColor = RGBColor(255, 255, 255);
    btn.frame = CGRectMake(0, 13, KScreenW, 15);
    [btn addTarget:self action:@selector(clickDeleteBtn) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn];
    
    //第一个View
    UIView *backView0 = [[UIView alloc] initWithFrame:CGRectMake(10, topView.bottom + 9, KScreenW - 20, 225)];
    backView0.backgroundColor = [UIColor whiteColor];
    backView0.layer.cornerRadius = 4.0f;
    [self.scrollView addSubview:backView0];
    //公司名称
    UILabel *companyLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 15)];
    companyLbl.text = @"公司名称";
    companyLbl.textColor = RGBColor(51, 51, 51);
    companyLbl.font = [UIFont fontWithName:BFfont size:14.0f];
    [backView0 addSubview:companyLbl];
    //公司名称输入框
    UITextField *companyField = [[UITextField alloc] initWithFrame:CGRectMake(companyLbl.right + 30, 20, 200, 15)];
    self.companyField = companyField;
    if ([self.isAuth isEqualToString:@"0"]) {
        companyField.text = self.authDic[@"jcname"];
        companyField.userInteractionEnabled = NO;
    }
    else {
        companyField.placeholder = @"请与营业执照保持一致";
        companyField.userInteractionEnabled = YES;
    }
    companyField.textColor = RGBColor(153, 153, 153);
    companyField.font = [UIFont fontWithName:BFfont size:12.0f];
    [backView0 addSubview:companyField];
    //上传营业执照
    UILabel *uploadLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, companyLbl.bottom + 30, 100, 15)];
    uploadLbl.text = @"上传营业执照";
    uploadLbl.textColor = RGBColor(51, 51, 51);
    uploadLbl.font = [UIFont fontWithName:BFfont size:14.0f];
    [backView0 addSubview:uploadLbl];
    //图片
    UIImageView *uploadImg = [[UIImageView alloc] initWithFrame:CGRectMake(uploadLbl.right + 30, companyLbl.bottom + 30, 159, 120)];
    self.uploadImg = uploadImg;
    if ([self.isAuth isEqualToString:@"0"]) {
        uploadImg.userInteractionEnabled = NO;
        [uploadImg sd_setImageWithURL:[NSURL URLWithString:self.authDic[@"jccard"]]];
    }
    else {
        uploadImg.userInteractionEnabled = YES;
        uploadImg.image = [UIImage imageNamed:@"添加1"];
    }
    
    uploadImg.tag = 10001;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickUploadImg)];
    [uploadImg addGestureRecognizer:ges];
    [backView0 addSubview:uploadImg];
    //提示文字
    UILabel *tipLbl = [[UILabel alloc] initWithFrame:CGRectMake(uploadLbl.right + 30, uploadImg.bottom + 10, 159, 15)];
    self.tipLbl = tipLbl;
    tipLbl.text = @"确保公司名称与所在公司一致";
    tipLbl.textColor = RGBColor(153, 153, 153);
    tipLbl.font = [UIFont fontWithName:BFfont size:12.0f];
    [backView0 addSubview:tipLbl];
    
    //第二个View
    UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(10, backView0.bottom + 9, KScreenW - 20, 195)];
    backView1.backgroundColor = [UIColor whiteColor];
    backView1.layer.cornerRadius = 4.0f;
    [self.scrollView addSubview:backView1];
    //工作证明或名片
    UILabel *workCard = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 15)];
    workCard.text = @"工作证明或名片";
    workCard.textColor = RGBColor(51, 51, 51);
    workCard.font = [UIFont fontWithName:BFfont size:14.0f];
    [backView1 addSubview:workCard];
    //图片
    UIImageView *workImg = [[UIImageView alloc] initWithFrame:CGRectMake(workCard.right + 30, 20, 159, 131)];
    self.workImg = workImg;
    workImg.tag = 20002;
    if ([self.isAuth isEqualToString:@"0"]) {
        workImg.userInteractionEnabled = NO;
        [workImg sd_setImageWithURL:[NSURL URLWithString:self.authDic[@"jcworkcard"]]];
    }
    else {
        workImg.userInteractionEnabled = YES;
        workImg.image = [UIImage imageNamed:@"工作证明"];
    }
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWorkImg)];
    [workImg addGestureRecognizer:ges1];
    [backView1 addSubview:workImg];
    
    //提示文字
    UILabel *tipLbl1 = [[UILabel alloc] initWithFrame:CGRectMake(workCard.right + 30, workImg.bottom + 10, 200, 15)];
    self.tipLbl1 = tipLbl1;
    tipLbl1.text = @"支持jpg、png、pdf 文件不超过10M";
    tipLbl1.textColor = RGBColor(153, 153, 153);
    tipLbl1.font = [UIFont fontWithName:BFfont size:12.0f];
    [backView1 addSubview:tipLbl1];
    
    //点击查看示例
    UILabel *clickLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, workCard.bottom + 20, 100, 15)];
    clickLbl.text = @"点击查看示例";
    self.clickLbl = clickLbl;
    clickLbl.textColor = RGBColor(0, 149, 227);
    clickLbl.font = [UIFont fontWithName:BFfont size:11.0f];
    clickLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesLbl = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLblAction)];
    [clickLbl addGestureRecognizer:gesLbl];
    [backView1 addSubview:clickLbl];
    
    //完成按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn = sureBtn;
    sureBtn.frame = CGRectMake(10, backView1.bottom + 25, KScreenW - 20, 51);
    [sureBtn setTitle:@"提交审核" forState:UIControlStateNormal];
    [sureBtn setTitleColor:RGBColor(255, 255, 255) forState:UIControlStateNormal];
    [sureBtn setBackgroundColor:RGBColor(0, 148, 231)];
    sureBtn.layer.cornerRadius = 4.0f;
    [sureBtn addTarget:self action:@selector(clickSureBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:sureBtn];
    
    if ([self.isAuth isEqualToString:@"0"]) {
        clickLbl.hidden = YES;
        sureBtn.hidden = YES;
        self.tipLbl.hidden = YES;
        self.tipLbl1.hidden = YES;
    }
    else {
        clickLbl.hidden = NO;
        sureBtn.hidden = NO;
        self.tipLbl.hidden = NO;
        self.tipLbl1.hidden = NO;
    }
}

#pragma mark - 点击上传营业执照的事件

-(void)clickUploadImg {
    self.img0 = self.uploadImg;
    [self clickChangeHeadImgAciton];
}

#pragma mark - 点击上传工作证明的事件

-(void)clickWorkImg {
    self.img0 = self.workImg;
    [self clickChangeHeadImgAciton];
}

#pragma mark - 点击关闭顶部提示的事件

-(void)clickDeleteBtn {
    //TODO
}

#pragma mark - 点击查看示例的事件

-(void)clickLblAction {
    [self getBigPhoto];
}

#pragma mark - 点击完成按钮的事件

-(void)clickSureBtn {
    NSDictionary *dic = @{@"uId":GetFromUserDefaults(@"uId"),
                          @"jCName":self.companyField.text
                          };
    
    if ([self.uploadImg.image isEqual:[UIImage imageNamed:@"添加1"]] || [self.workImg.image isEqual:[UIImage imageNamed:@"工作证明"]]) {
        [ZAlertView showSVProgressForErrorStatus:@"请您上传完整的认证照片"];
    }
    else if (self.companyField.text == nil || [self.companyField.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请您填写公司名称"];
    }
    else if (self.companyField.text.length > 30) {
        [ZAlertView showSVProgressForErrorStatus:@"请您输入不要超过30个字的名称"];
    }
    else {
        NSLog(@"传入图片:%@ ---- 个数为:%ld",self.imageArray,self.imageArray.count);
        //发送网络请求
        [NetworkRequest sendImagesWithUrl:CompanyCertification parameters:dic imageArray:self.imageArray successResponse:^(id data) {
            NSDictionary *dic = data;
            if ([dic[@"status"] intValue] == 1) {
                [ZAlertView showSVProgressForSuccess:@"提交成功!"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else {
                NSString *errStr = dic[@"msg"];
                [ZAlertView showSVProgressForErrorStatus:[NSString stringWithFormat:@"%@",errStr]];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
        }];
    }
}

#pragma mark - 重新认证接口

-(void)rightNewAuthClick {
    NSDictionary *dic = @{@"uId":GetFromUserDefaults(@"uId"),
                          @"jCName":self.companyField.text
                          };
    [self.imageArray removeAllObjects];
    [self.imageArray addObject:self.uploadImg.image];
    [self.imageArray addObject:self.workImg.image];
    if ([self.uploadImg.image isEqual:[UIImage imageNamed:@"添加1"]] || [self.workImg.image isEqual:[UIImage imageNamed:@"工作证明"]]) {
        [ZAlertView showSVProgressForErrorStatus:@"请您上传完整的认证照片"];
    }
    else if (self.companyField.text == nil || [self.companyField.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请您填写公司名称"];
    }
    else if (self.companyField.text.length > 30) {
        [ZAlertView showSVProgressForErrorStatus:@"请您输入不要超过30个字的名称"];
    }
    else {
        NSLog(@"传入图片:%@ ---- 个数为:%ld",self.imageArray,self.imageArray.count);
        //发送网络请求
        [NetworkRequest sendImagesWithUrl:CompanyCertificationNew parameters:dic imageArray:self.imageArray successResponse:^(id data) {
            NSDictionary *dic = data;
            if ([dic[@"status"] intValue] == 1) {
                [ZAlertView showSVProgressForSuccess:@"提交成功!请等待审核"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeStatus" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else {
                NSString *errStr = dic[@"msg"];
                [ZAlertView showSVProgressForErrorStatus:[NSString stringWithFormat:@"%@",errStr]];
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
        }];
    }
}

#pragma mark - 查看大图

-(void)getBigPhoto {
    self.navigationController.navigationBarHidden = YES;
    //创建一个黑色背景
    //初始化一个用来当做背景的View。
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    [bgView setBackgroundColor:[UIColor colorWithRed:0/250.0 green:0/250.0 blue:0/250.0 alpha:1.0]];
    self.bgView = bgView;
    [self.view addSubview:bgView];
    //创建显示图像的视图
    //初始化要显示的图片内容的imageView
    UIImageView *browseImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    browseImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.browseImgView = browseImgView;
    //要显示的图片，即要放大的图片
    _browseImgView.image = [UIImage imageNamed:@"工作证明（大）"];
    [bgView addSubview:browseImgView];
    browseImgView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeView)];
    [browseImgView addGestureRecognizer:tapGesture];
    //放大过程中的动画
    [self shakeToShow:bgView];
}

#pragma mark - 点击关闭放大的全屏图片

-(void)closeView{
    self.navigationController.navigationBarHidden = NO;
    [self.bgView removeFromSuperview];
}

#pragma mark - 点击放大图片的动画

- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

#pragma mark - 添加图片

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
    if (self.img0.tag == 10001) {
        self.uploadImg.image = image;
        NSLog(@"获取到的图片为:%@",image);
        [self.imageArray addObject:image];
    }
    else if (self.img0.tag == 20002){
        self.workImg.image = image;
        [self.imageArray addObject:image];
        NSLog(@"获取到的图片为:%@",image);
    }
    
    NSLog(@"数组现在的情况为:%@ ---- 个数为:%ld",self.imageArray,self.imageArray.count);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
