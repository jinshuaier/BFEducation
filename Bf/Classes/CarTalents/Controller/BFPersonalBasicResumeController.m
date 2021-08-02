//
//  BFPersonalBasicResumeController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/19.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFPersonalBasicResumeController.h"
#import "BFSeniorResumeController.h"
#import "BFCarTalentsUserCenterViewController.h"//工作台
#define PickerViewH 200
@interface BFPersonalBasicResumeController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,TFPickerDelegate,UITextViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
/*创建背景UIScrollView*/
@property (nonatomic,strong) UIScrollView *scrollView;
/*用户头像*/
@property (nonatomic,strong) UIImageView *headerImg;
/*用户姓名*/
@property (nonatomic,strong) UITextField *realNameField;
/*用户手机号*/
@property (nonatomic,strong) UITextField *phone;
/*按钮-男*/
@property (nonatomic,strong) UIButton *manBtn;
/*按钮-女*/
@property (nonatomic,strong) UIButton *womanBtn;
/*出生年月*/
@property (nonatomic,strong) UILabel *birthLbl;
/*最高学历*/
@property (nonatomic,strong) UILabel *degreLbl;
/*工作经验*/
@property (nonatomic,strong) UILabel *workLbl;
/*期望薪资*/
@property (nonatomic,strong) UILabel *moneyLbl;
/*个人介绍*/
@property (nonatomic,strong) UITextView *introView;
/*标签lbl*/
@property (nonatomic,strong) UILabel *lbl;
/*按钮*/
@property (nonatomic,strong) UIButton *selBtn;
/*图片数组*/
@property (nonatomic, strong) NSMutableArray *imageArray;
// 职位类别字典
@property (nonatomic , strong) NSMutableDictionary *jobsDict;
// pickViewType 0:期望职位   1:求职区域
@property (nonatomic , assign) NSInteger pickViewType;
// pickerView
@property (nonatomic , strong) UIPickerView *pickerView;
// pickerViewBG
@property (nonatomic , strong) UIView *pickerViewBG;
// 职位类别名称
@property (nonatomic , copy) NSString *jobsStr;
// 职位类别id
@property (nonatomic , copy) NSString *jobsIdStr;
// 城市字典
@property (nonatomic , strong) NSMutableDictionary *citysDict;
// 省
@property (nonatomic , copy) NSString *provinceStr;
// 市
@property (nonatomic , strong) NSDictionary *cityDic;
/*期望职位*/
@property (nonatomic,strong) UILabel *hopeLbl;
/*求职区域*/
@property (nonatomic,strong) UILabel *findLbl;
@end

@implementation BFPersonalBasicResumeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布简历";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *imageArray = [NSMutableArray array];
    self.imageArray = imageArray;
    
    [self createUIScrollView];
    
    if (!_jobsDict) {
        _jobsDict = [NSMutableDictionary dictionary];
    }
    [self networkJobStyle];
    
    if (!_citysDict) {
        _citysDict = [NSMutableDictionary dictionary];
    }
    [self getCitiesListNetWork];
}

#pragma mark - 创建UIScrollView

-(void)createUIScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = self.view.size;
    self.scrollView.bounces = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    //背景图片
    UIImageView *backImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"底图"]];
    backImg.frame = CGRectMake(0, 0, KScreenW, 104);
    [self.scrollView addSubview:backImg];
    //用户头像
    UIImageView *headerImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"添加头像"]];
    self.headerImg = headerImg;
    headerImg.frame = CGRectMake((KScreenW - 85)/2, 75/2, 85, 85);
    headerImg.clipsToBounds = YES;
    headerImg.layer.cornerRadius = 85/2;
    headerImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChangeHeadImgAciton)];
    [headerImg addGestureRecognizer:ges];
    [self.scrollView addSubview:headerImg];
    //基本资料title
    UILabel *basicLbl = [[UILabel alloc] initWithFrame:CGRectMake(16, headerImg.bottom, KScreenW - 32, 20)];
    basicLbl.text = @"基本资料";
    basicLbl.textColor = ColorRGBValue(0x999999);
    basicLbl.font = [UIFont fontWithName:BFfont size:15.0f];
    [self.scrollView addSubview:basicLbl];
    //真实姓名title
    UILabel *realName = [[UILabel alloc] initWithFrame:CGRectMake(0, basicLbl.bottom + 15, KScreenW, 15)];
    realName.text = @"真实姓名";
    realName.textColor = ColorRGBValue(0xd2d2d2);
    realName.textAlignment = NSTextAlignmentCenter;
    realName.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.scrollView addSubview:realName];
    //真实姓名输入框
    UITextField *realNameField = [[UITextField alloc] initWithFrame:CGRectMake(0, realName.bottom + 5, KScreenW, 30)];
    self.realNameField = realNameField;
    if ([self.editResume isEqualToString:@"1"]) {
        realNameField.text = self.dic[@"jRName"];
    }
    else {
        realNameField.placeholder = @"请输入真实姓名";
    }
    realNameField.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:realNameField];
    //下划线
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(16, realNameField.bottom + 5, KScreenW - 32, 0.50f)];
    line0.backgroundColor = ColorRGBValue(0xd2d2d2);
    [self.scrollView addSubview:line0];
    //性别title
    UILabel *sexLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, line0.bottom + 10, KScreenW, 15)];
    sexLbl.text = @"性别";
    sexLbl.textColor = ColorRGBValue(0xd2d2d2);
    sexLbl.textAlignment = NSTextAlignmentCenter;
    sexLbl.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.scrollView addSubview:sexLbl];
    //按钮-男
    UIButton *manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.manBtn = manBtn;
    manBtn.tag = 1;
    manBtn.frame = CGRectMake(KScreenW/2 - 60 - 10, sexLbl.bottom + 5, 60, 30);
    [manBtn setTitle:@" 男" forState:UIControlStateNormal];
    [manBtn setTitleColor:ColorRGBValue(0x999999) forState:UIControlStateNormal];
    [manBtn setImage:[UIImage imageNamed:@"男"] forState:UIControlStateNormal];
    manBtn.titleLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    manBtn.layer.borderWidth = 0.50f;
    manBtn.layer.borderColor = ColorRGBValue(0xd2d2d2).CGColor;
    manBtn.layer.cornerRadius = 15.0f;
    [manBtn addTarget:self action:@selector(clickManAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:manBtn];
    //按钮-女
    UIButton *womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.womanBtn = womanBtn;
    womanBtn.tag = 2;
    womanBtn.frame = CGRectMake(KScreenW/2 + 10, sexLbl.bottom + 5, 60, 30);
    [womanBtn setTitle:@" 女" forState:UIControlStateNormal];
    [womanBtn setTitleColor:ColorRGBValue(0x999999) forState:UIControlStateNormal];
    [womanBtn setImage:[UIImage imageNamed:@"女"] forState:UIControlStateNormal];
    womanBtn.titleLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    womanBtn.layer.borderWidth = 0.50f;
    womanBtn.layer.borderColor = ColorRGBValue(0xd2d2d2).CGColor;
    womanBtn.layer.cornerRadius = 15.0f;
    [womanBtn addTarget:self action:@selector(clickWomanAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:womanBtn];
    if ([self.editResume isEqualToString:@"1"]) {
        NSString *SexStr0 = [NSString stringWithFormat:@"%@",self.dic[@"jRSex"]];
        if ([SexStr0 isEqualToString:@"0"]) {
            //男
            [self.manBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.manBtn setBackgroundColor:RGBColor(0, 148, 231)];
            self.manBtn.layer.borderColor = RGBColor(0, 148, 231).CGColor;
            [self.womanBtn setTitleColor:ColorRGBValue(0x999999) forState:UIControlStateNormal];
            [self.womanBtn setBackgroundColor:[UIColor whiteColor]];
            self.womanBtn.layer.borderColor = ColorRGBValue(0xd2d2d2).CGColor;
        }
        else {
            //女
            [self.womanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.womanBtn setBackgroundColor:RGBColor(0, 148, 231)];
            self.womanBtn.layer.borderColor = RGBColor(0, 148, 231).CGColor;
            [self.manBtn setTitleColor:ColorRGBValue(0x999999) forState:UIControlStateNormal];
            [self.manBtn setBackgroundColor:[UIColor whiteColor]];
            self.manBtn.layer.borderColor = ColorRGBValue(0xd2d2d2).CGColor;
        }
    }
    //下划线
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(16, womanBtn.bottom + 10, KScreenW - 32, 0.50f)];
    line1.backgroundColor = ColorRGBValue(0xd2d2d2);
    [self.scrollView addSubview:line1];
    //手机号title
    UILabel *phoneLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, line1.bottom + 10, KScreenW, 15)];
    phoneLbl.text = @"手机号";
    phoneLbl.textColor = ColorRGBValue(0xd2d2d2);
    phoneLbl.textAlignment = NSTextAlignmentCenter;
    phoneLbl.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.scrollView addSubview:phoneLbl];
    //手机号输入框
    UITextField *phone = [[UITextField alloc] initWithFrame:CGRectMake(0, phoneLbl.bottom + 5, KScreenW, 30)];
    self.phone = phone;
    if ([self.editResume isEqualToString:@"1"]) {
        phone.text = [NSString stringWithFormat:@"%@",self.dic[@"jRPhone"]];
    }
    else {
        phone.placeholder = @"请输入手机号";
    }
    phone.textAlignment = NSTextAlignmentCenter;
    phone.textColor = RGBColor(138, 137, 138);
    phone.font = [UIFont fontWithName:BFfont size:16.0f];
    [self.scrollView addSubview:phone];
    //下划线
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(16, phone.bottom + 5, KScreenW - 32, 0.50f)];
    line2.backgroundColor = ColorRGBValue(0xd2d2d2);
    [self.scrollView addSubview:line2];
    //出生年月
    UILabel *birth = [[UILabel alloc] initWithFrame:CGRectMake(0, line2.bottom + 20, KScreenW/3, 20)];
    birth.text = @"出生年月";
    birth.textColor = RGBColor(138, 137, 138);
    birth.textAlignment = NSTextAlignmentCenter;
    birth.font = [UIFont fontWithName:BFfont size:16.0f];
    [self.scrollView addSubview:birth];
    
    UILabel *birthLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, birth.bottom + 20, KScreenW/3, 20)];
    self.birthLbl = birthLbl;
    if ([self.editResume isEqualToString:@"1"]) {
        birthLbl.text = [NSString stringWithFormat:@"%@",self.dic[@"jRBirthdayStr"]];
    }
    else {
        birthLbl.text = @"请选择";
    }
    birthLbl.tag = 10001;
    birthLbl.textAlignment = NSTextAlignmentCenter;
    birthLbl.textColor = ColorRGBValue(0xd2d2d2);
    birthLbl.font = [UIFont fontWithName:BFfont size:16.0f];
    birthLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickBirth)];
    [birthLbl addGestureRecognizer:ges0];
    [self.scrollView addSubview:birthLbl];
    //竖线
    UIView *line00 = [[UIView alloc] initWithFrame:CGRectMake(birth.right, line2.bottom + 20, 0.50f, 60)];
    line00.backgroundColor = ColorRGBValue(0xd2d2d2);
    [self.scrollView addSubview:line00];
    
    //最高学历
    UILabel *degree = [[UILabel alloc] initWithFrame:CGRectMake(line00.right, line2.bottom + 20, KScreenW/3, 20)];
    degree.text = @"最高学历";
    degree.textColor = RGBColor(138, 137, 138);
    degree.textAlignment = NSTextAlignmentCenter;
    degree.font = [UIFont fontWithName:BFfont size:16.0f];
    [self.scrollView addSubview:degree];
    
    UILabel *degreLbl = [[UILabel alloc] initWithFrame:CGRectMake(line00.right, birth.bottom + 20, KScreenW/3, 20)];
    self.degreLbl = degreLbl;
    
    
    NSString *str1 = [NSString stringWithFormat:@"%@",self.dic[@"jRDiploma"]];
    NSString *str11 = @"0";
    if ([str1 isEqualToString:@"0"]) {
        str11 = @" 不限";
    }
    else if ([str1 isEqualToString:@"1"]) {
        str11 = @" 中专以下";
    }
    else if ([str1 isEqualToString:@"2"]) {
        str11 = @" 高中";
    }
    else if ([str1 isEqualToString:@"3"]) {
        str11 = @" 大专";
    }
    else if ([str1 isEqualToString:@"4"]) {
        str11 = @" 本科";
    }
    if ([self.editResume isEqualToString:@"1"]) {
        degreLbl.text = str11;
    }
    else {
        degreLbl.text = @"请选择";
    }
    
    degreLbl.tag = 20002;
    degreLbl.textAlignment = NSTextAlignmentCenter;
    degreLbl.textColor = ColorRGBValue(0xd2d2d2);
    degreLbl.font = [UIFont fontWithName:BFfont size:16.0f];
    degreLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDegree)];
    [degreLbl addGestureRecognizer:ges1];
    [self.scrollView addSubview:degreLbl];
    //竖线
    UIView *line11 = [[UIView alloc] initWithFrame:CGRectMake(degree.right, line2.bottom + 20, 0.50f, 60)];
    line11.backgroundColor = ColorRGBValue(0xd2d2d2);
    [self.scrollView addSubview:line11];
    
    //工作经验
    UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake(line11.right, line2.bottom + 20, KScreenW/3, 20)];
    work.text = @"工作经验";
    work.textColor = RGBColor(138, 137, 138);
    work.textAlignment = NSTextAlignmentCenter;
    work.font = [UIFont fontWithName:BFfont size:16.0f];
    [self.scrollView addSubview:work];
    
    UILabel *workLbl = [[UILabel alloc] initWithFrame:CGRectMake(line11.right, birth.bottom + 20, KScreenW/3, 20)];
    self.workLbl = workLbl;
    
    NSString *str0 = [NSString stringWithFormat:@"%@",self.dic[@"jRYear"]];
    NSString *str00 = @"0";
    if ([str0 isEqualToString:@"0"]) {
        str00 = @" 应届生";
    }
    else if ([str0 isEqualToString:@"1"]) {
        str00 = @" 1-3年";
    }
    else if ([str0 isEqualToString:@"2"]) {
        str00 = @" 3-5年";
    }
    else if ([str0 isEqualToString:@"3"]) {
        str00 = @" 5-10年";
    }
    else if ([str0 isEqualToString:@"4"]) {
        str00 = @" 10年以上";
    }
    if ([self.editResume isEqualToString:@"1"]) {
        workLbl.text = str00;
    }
    else {
        workLbl.text = @"请选择";
    }
    workLbl.tag = 30003;
    workLbl.textAlignment = NSTextAlignmentCenter;
    workLbl.textColor = ColorRGBValue(0xd2d2d2);
    workLbl.font = [UIFont fontWithName:BFfont size:16.0f];
    workLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickWork)];
    [workLbl addGestureRecognizer:ges2];
    [self.scrollView addSubview:workLbl];
    
    //求职意向title
    UILabel *find = [[UILabel alloc] initWithFrame:CGRectMake(0, line11.bottom + 20, KScreenW, 15)];
    find.text = @"求职意向";
    find.textColor = ColorRGBValue(0xd2d2d2);
    find.textAlignment = NSTextAlignmentCenter;
    find.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.scrollView addSubview:find];
    
    //期望职位
    UILabel *hopeLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, find.bottom + 5, KScreenW, 30)];
    self.hopeLbl = hopeLbl;
    if ([self.editResume isEqualToString:@"1"]) {
        hopeLbl.text = self.hopeStr;
    }
    else {
        hopeLbl.text = @"请选择期望职位";
    }
    hopeLbl.textAlignment = NSTextAlignmentCenter;
    hopeLbl.textColor = RGBColor(138, 137, 138);
    hopeLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHopeAction)];
    [hopeLbl addGestureRecognizer:ges3];
    hopeLbl.font = [UIFont fontWithName:BFfont size:16.0f];
    [self.scrollView addSubview:hopeLbl];
    //下划线
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(16, hopeLbl.bottom + 5, KScreenW - 32, 0.50f)];
    line3.backgroundColor = ColorRGBValue(0xd2d2d2);
    [self.scrollView addSubview:line3];
    //期望薪资title
    UILabel *money = [[UILabel alloc] initWithFrame:CGRectMake(0, line3.bottom + 10, KScreenW, 15)];
    money.text = @"期望薪资";
    money.textColor = ColorRGBValue(0xd2d2d2);
    money.textAlignment = NSTextAlignmentCenter;
    money.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.scrollView addSubview:money];
    //期望薪资输入框
    UILabel *moneyLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, money.bottom + 5, KScreenW, 30)];
    self.moneyLbl = moneyLbl;
    moneyLbl.tag = 40004;
    
    NSString *str2 = [NSString stringWithFormat:@"%@",self.dic[@"jRMoney"]];
    NSString *str22 = @"0";
    if ([str2 isEqualToString:@"0"]) {
        str22 = @"面议";
    }
    else if ([str2 isEqualToString:@"1"]) {
        str22 = @"3000元以下";
    }
    else if ([str2 isEqualToString:@"2"]) {
        str22 = @"3000-5000";
    }
    else if ([str2 isEqualToString:@"3"]) {
        str22 = @"5000-7000";
    }
    else if ([str2 isEqualToString:@"4"]) {
        str22 = @"7000-10000";
    }
    else if ([str2 isEqualToString:@"5"]) {
        str22 = @"10000-15000";
    }
    else if ([str2 isEqualToString:@"6"]) {
        str22 = @"15000以上";
    }
    if ([self.editResume isEqualToString:@"1"]) {
        moneyLbl.text = str22;
    }
    else {
        moneyLbl.text = @"请输入期望薪资";
    }
    moneyLbl.textColor = RGBColor(138, 137, 138);
    moneyLbl.textAlignment = NSTextAlignmentCenter;
    moneyLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMoneyAction)];
    [moneyLbl addGestureRecognizer:ges5];
    [self.scrollView addSubview:moneyLbl];
    //下划线
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(16, moneyLbl.bottom + 5, KScreenW - 32, 0.50f)];
    line4.backgroundColor = ColorRGBValue(0xd2d2d2);
    [self.scrollView addSubview:line4];
    //求职区域title
    UILabel *fin = [[UILabel alloc] initWithFrame:CGRectMake(0, line4.bottom + 10, KScreenW, 15)];
    fin.text = @"求职区域";
    fin.textColor = ColorRGBValue(0xd2d2d2);
    fin.textAlignment = NSTextAlignmentCenter;
    fin.font = [UIFont fontWithName:BFfont size:14.0f];
    [self.scrollView addSubview:fin];
    //求职区域
    UILabel *findLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, fin.bottom + 5, KScreenW, 30)];
    self.findLbl = findLbl;
    if ([self.editResume isEqualToString:@"1"]) {
        findLbl.text = [NSString stringWithFormat:@"%@",self.dic[@"bRName"]];
    }
    else {
        findLbl.text = @"请选择求职区域";
    }
    findLbl.textColor = RGBColor(138, 137, 138);
    findLbl.tag = 50005;
    findLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges6 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickFindAction)];
    [findLbl addGestureRecognizer:ges6];
    findLbl.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:findLbl];
    //下划线
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(16, findLbl.bottom + 5, KScreenW - 32, 0.50f)];
    line5.backgroundColor = ColorRGBValue(0xd2d2d2);
    [self.scrollView addSubview:line5];
    //自我介绍title
    UILabel *intro = [[UILabel alloc] initWithFrame:CGRectMake(16, findLbl.bottom + 20, KScreenW - 32, 20)];
    intro.text = @"自我介绍";
    intro.textColor = ColorRGBValue(0x999999);
    intro.font = [UIFont fontWithName:BFfont size:15.0f];
    [self.scrollView addSubview:intro];
    //自我介绍
    UITextView *introView = [[UITextView alloc] initWithFrame:CGRectMake(16, intro.bottom+20, KScreenW - 32, 105)];
    self.introView = introView;
    introView.layer.borderWidth = 0.50f;
    if ([self.editResume isEqualToString:@"1"]) {
        introView.text = [NSString stringWithFormat:@"%@",self.dic[@"jIntroduction"]];
    }
    else {
        introView.text = @"[示例]本人从业时间较长,责任心强";
    }
    introView.textColor = RGBColor(178, 178, 178);
    introView.font = [UIFont fontWithName:BFfont size:12.0f];
    introView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    introView.delegate = self;
    [self.scrollView addSubview:introView];
    //创建基础简历按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, introView.bottom + 20, KScreenW - 20, 50);
    [btn setTitle:@"创建基础简历" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:ColorRGBValue(0x0094e7)];
    btn.titleLabel.font = [UIFont fontWithName:BFfont size:15.0f];
    btn.layer.cornerRadius = 4.0f;
    [self.scrollView addSubview:btn];
    [btn addTarget:self action:@selector(clickCreateAction) forControlEvents:UIControlEventTouchUpInside];
    self.scrollView.contentSize = CGSizeMake(KScreenW,btn.bottom + 15);
}

#pragma mark - 男生按钮点击事件

-(void)clickManAction {
    self.selBtn = self.manBtn;
    [self.manBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.manBtn setBackgroundColor:RGBColor(0, 148, 231)];
    self.manBtn.layer.borderColor = RGBColor(0, 148, 231).CGColor;
    [self.womanBtn setTitleColor:ColorRGBValue(0x999999) forState:UIControlStateNormal];
    [self.womanBtn setBackgroundColor:[UIColor whiteColor]];
    self.womanBtn.layer.borderColor = ColorRGBValue(0xd2d2d2).CGColor;
}

#pragma mark - 女生按钮点击事件

-(void)clickWomanAction {
    self.selBtn = self.womanBtn;
    [self.womanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.womanBtn setBackgroundColor:RGBColor(0, 148, 231)];
    self.womanBtn.layer.borderColor = RGBColor(0, 148, 231).CGColor;
    [self.manBtn setTitleColor:ColorRGBValue(0x999999) forState:UIControlStateNormal];
    [self.manBtn setBackgroundColor:[UIColor whiteColor]];
    self.manBtn.layer.borderColor = ColorRGBValue(0xd2d2d2).CGColor;
}

#pragma mark - 出生年月的点击事件

-(void)clickBirth {
    self.lbl = self.birthLbl;
    //出生日期
    PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    picker.delegate = self;
    picker.arrayType = agoDate;
    [self.view addSubview:picker];
}

#pragma mark - 最高学历的点击事件

-(void)clickDegree {
    self.lbl = self.degreLbl;
    //学历要求
    PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    picker.delegate = self;
    picker.arrayType = xueliArray;
    [self.view addSubview:picker];
}

#pragma mark - 工作经验的点击事件

-(void)clickWork {
    self.lbl = self.workLbl;
    //经验要求
    PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    picker.delegate = self;
    picker.arrayType = jingyanArray;
    [self.view addSubview:picker];
}

#pragma mark - 期望职位的点击事件

-(void)clickHopeAction {
    //职位类别
    self.pickViewType = 0;
    [self.view addSubview:self.pickerViewBG];
    [UIView animateWithDuration:0.1f animations:^{
        self.pickerView.frame = CGRectMake(0, KScreenH - PickerViewH, KScreenW, PickerViewH);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - 期望薪资的点击事件

-(void)clickMoneyAction {
    self.lbl = self.moneyLbl;
    //薪资范围
    PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    picker.delegate = self;
    picker.arrayType = moneyArray;
    [self.view addSubview:picker];
}

#pragma mark - 求职区域的点击事件

-(void)clickFindAction {
    self.pickViewType = 1;
    [self.view addSubview:self.pickerViewBG];
    [UIView animateWithDuration:0.1f animations:^{
        self.pickerView.frame = CGRectMake(0, KScreenH - PickerViewH, KScreenW, PickerViewH);
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - pickerView delegate

- (void)PickerSelectorIndixString:(NSString *)str andIndex:(NSInteger)selectIndex{
    if (self.lbl.tag == 10001) {
        //出生年月
        self.birthLbl.text = str;
    }
    else if (self.lbl.tag == 20002) {
        //最高学历
        self.degreLbl.text = str;
    }
    else if (self.lbl.tag == 30003) {
        //工作经验
        self.workLbl.text = str;
    }
    else if (self.lbl.tag == 40004) {
        //期望薪资
        self.moneyLbl.text = str;
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
    self.headerImg.image = image;
    [self.imageArray addObject:image];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.introView.text.length > 255) {
        self.introView.text = [textView.text substringToIndex:255];
        [ZAlertView showSVProgressForInfoStatus:@"自我简介不超过255字"];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if([self.introView.text isEqualToString:@"[示例]本人从业时间较长,责任心强"]){
        self.introView.text=@"";
    }
}

-(void)networkJobStyle{
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfJobTypeSelectList.do",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSArray *array = data;
        for (NSDictionary *dic in array) {
            [_jobsDict setValue:dic[@"jtid"] forKey:dic[@"jttitle"]];
        }
        NSLog(@"%@",_jobsDict);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pickerView reloadAllComponents];
        });
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

#pragma mark - 获取城市列表

- (void)getCitiesListNetWork{
    NSString *urlStr = [NSString stringWithFormat:@"%@bfJobController/bfRegionalSelectList.do",ServerURL];
    [NetworkRequest requestWithUrl:urlStr parameters:nil successResponse:^(id data) {
        NSArray *array = data;
        for (NSDictionary *dic in array) {
            [_citysDict setValue:dic[@"citys"] forKey:dic[@"brname"]];
        }
        NSLog(@"%@",_citysDict);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.pickerView reloadAllComponents];
        });
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
    }];
}

#pragma mark pickerview function
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_pickViewType == 0) {
        return 1;
    }
    else if (_pickViewType == 1) {
        return 2;
    }
    return 2;
}

//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_pickViewType == 0) {
        return  [_jobsDict count];
    }
    else if (_pickViewType == 1) {
        if (component==0) {
            return  [_citysDict count];
        } else {
            return  [_citysDict[_provinceStr] count];
        }
    }
    return 50;
}

//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 20.0f;
}

//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (_pickViewType == 0) {
        return KScreenW;
    }
    else if (_pickViewType == 1) {
        return KScreenW/2;
    }
    return KScreenW;
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    UILabel *text = nil;
    if (_pickViewType == 0) {
        text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 20)];
        text.text = [NSString stringWithFormat:@"%@",[[_jobsDict allKeys] objectAtIndex:row]];
    }
    else if (_pickViewType == 1) {
        text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenW / 2.0, 20)];
        if (component == 0) {
            text.text = [[_citysDict allKeys] objectAtIndex:row];
        }else {
            NSDictionary *dic = [_citysDict[_provinceStr] objectAtIndex:row];
            text.text = dic[@"brname"];
        }
    }
    text.textAlignment = NSTextAlignmentCenter;
    [view addSubview:text];
    //隐藏上下直线
    //    [self.pickerView.subviews objectAtIndex:1].backgroundColor = [UIColor clearColor];
    //    [self.pickerView.subviews objectAtIndex:2].backgroundColor = [UIColor clearColor];
    return view;
}

//被选择的行
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (_pickViewType == 0) {
        _jobsStr = [[_jobsDict allKeys] objectAtIndex:row];
        _jobsIdStr =[[_jobsDict allValues] objectAtIndex:row];
        self.hopeLbl.text = [NSString stringWithFormat:@"%@",_jobsStr];
    }
    else if (_pickViewType == 1) {
        if (component == 0) {
            _provinceStr = [[_citysDict allKeys] objectAtIndex:row];
            [_pickerView reloadComponent:1];
        }else{
            _cityDic = [_citysDict[_provinceStr] objectAtIndex:row];
        }
        self.findLbl.text = [NSString stringWithFormat:@"%@",_cityDic[@"brname"]];
    }
}

- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, KScreenH, KScreenW, PickerViewH)];
        _pickerView.backgroundColor = [UIColor whiteColor];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (void)packUPPicker{
    [UIView animateWithDuration:0.1f animations:^{
        self.pickerView.frame = CGRectMake(0, KScreenH, KScreenW, 162);
    } completion:^(BOOL finished) {
        [self.pickerViewBG removeFromSuperview];
    }];
}

#pragma mark -lazy-
- (UIView *)pickerViewBG{
    if (!_pickerViewBG) {
        _pickerViewBG = [[UIView alloc] initWithFrame:self.view.frame];
        _pickerViewBG.backgroundColor = [UIColor clearColor];
        _pickerViewBG.userInteractionEnabled = YES;
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(packUPPicker)];
        [_pickerViewBG addGestureRecognizer:tag];
        [_pickerViewBG addSubview:self.pickerView];
    }
    return _pickerViewBG;
}

#pragma mark - 创建基础简历按钮点击事件

-(void)clickCreateAction {
    //用户主键
    NSString *uidStr = GetFromUserDefaults(@"uId");
    //职位主键
    NSString *jobStr = [NSString stringWithFormat:@"%@",self.dic[@"jRId"]];
    //真实姓名
    NSString *nameStr = self.realNameField.text;
    //手机号
    NSString *phoneStr = self.phone.text;
    //出生年月
    NSString *birthStr = self.birthLbl.text;
    //性别
    NSString *sexStr = @"1";
    if (self.selBtn.tag == 1) {
        sexStr = @"0";
    }
    else if (self.selBtn.tag == 2) {
        sexStr = @"1";
    }
    //工作经历
    NSString *jingyan = [self.workLbl.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *jingyanStr = @"5";
    if ([jingyan isEqualToString:@"应届生"]) {
        jingyanStr = @"0";
    }
    else if ([jingyan isEqualToString:@"1-3年"]) {
        jingyanStr = @"1";
    }
    else if ([jingyan isEqualToString:@"3-5年"]) {
        jingyanStr = @"2";
    }
    else if ([jingyan isEqualToString:@"5-10年"]) {
        jingyanStr = @"3";
    }
    else if ([jingyan isEqualToString:@"10年以上"]) {
        jingyanStr = @"4";
    }
    else {
        jingyanStr = @"5";
    }
    //最高学历
    NSString *xueliStr = @"5";
    NSString *xueli = [self.degreLbl.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([xueli isEqualToString:@"不限"]) {
        xueliStr = @"0";
    }
    else if ([xueli isEqualToString:@"中专及以下"]) {
        xueliStr = @"1";
    }
    else if ([xueli isEqualToString:@"高中"]) {
        xueliStr = @"2";
    }
    else if ([xueli isEqualToString:@"大专"]) {
        xueliStr = @"3";
    }
    else if ([xueli isEqualToString:@"本科"]) {
        xueliStr = @"4";
    }
    else {
        xueliStr = @"5";
    }
    //期望职位
    NSString *hopeStr = @"";
    NSString *jodI = [NSString stringWithFormat:@"%@",self.jobsIdStr];
    if ([jodI isEqualToString:@""] || jodI == nil || [jodI isEqualToString:@"(null)"]) {
        hopeStr = [NSString stringWithFormat:@"%@",self.dic[@"jRJob"]];
    }
    else {
        hopeStr = [NSString stringWithFormat:@"%@",self.jobsIdStr];
    }
    //地址
    NSString *addressStr = @"";
    NSString *addS = [NSString stringWithFormat:@"%@",_cityDic[@"brid"]];
    if ([addS isEqualToString:@""] || addS == nil || [addS isEqualToString:@"(null)"]) {
        addressStr = [NSString stringWithFormat:@"%@",self.dic[@"bRId"]];
    }
    else {
        addressStr = [NSString stringWithFormat:@"%@",_cityDic[@"brid"]];
    }
    
    //期望薪资
    NSString *gongziStr = @"7";
    NSString *gongzi = [self.moneyLbl.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([gongzi isEqualToString:@"面议"]) {
        gongziStr = @"0";
    }
    else if ([gongzi isEqualToString:@"3千以下"] || [gongzi isEqualToString:@"3000以下"]) {
        gongziStr = @"1";
    }
    else if ([gongzi isEqualToString:@"3千-5千"] || [gongzi isEqualToString:@"3000-5000"]) {
        gongziStr = @"2";
    }
    else if ([gongzi isEqualToString:@"5千-7千"] || [gongzi isEqualToString:@"5000-7000"]) {
        gongziStr = @"3";
    }
    else if ([gongzi isEqualToString:@"7千-1万"] || [gongzi isEqualToString:@"7000-10000"]) {
        gongziStr = @"4";
    }
    else if ([gongzi isEqualToString:@"1万-1.5万"] || [gongzi isEqualToString:@"10000-15000"]) {
        gongziStr = @"5";
    }
    else if ([gongzi isEqualToString:@"1.5万以上"] || [gongzi isEqualToString:@"15000以上"]) {
        gongziStr = @"6";
    }
    else {
        gongziStr = @"7";
    }
    
    //自我简介
    NSString *introStr = self.introView.text;

    if ([self.editResume isEqualToString:@"1"]) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:uidStr forKey:@"uId"];
        [dic setValue:jobStr forKey:@"jRId"];
        [dic setValue:nameStr forKey:@"jRName"];
        [dic setValue:sexStr forKey:@"jRSex"];
        [dic setValue:birthStr forKey:@"jRBirthday"];
        [dic setValue:xueliStr forKey:@"jRDiploma"];
        [dic setValue:jingyanStr forKey:@"jRYear"];
        [dic setValue:phoneStr forKey:@"jRPhone"];
        [dic setValue:hopeStr forKey:@"jRJob"];
        [dic setValue:gongziStr forKey:@"jRMoney"];
        [dic setValue:addressStr forKey:@"bRId"];
        [dic setValue:introStr forKey:@"jIntroduction"];
        [NetworkRequest sendImagesWithUrl:ChangeInfomation parameters:dic imageArray:self.imageArray successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                BFCarTalentsUserCenterViewController *homeVC = [[BFCarTalentsUserCenterViewController alloc] init];
                UIViewController *target = nil;
                for (UIViewController * controller in self.navigationController.viewControllers) { //遍历
                    if ([controller isKindOfClass:[homeVC class]]) { //这里判断是否为你想要跳转的页面
                        target = controller;
                    }
                }
                if (target) {
                    [self.navigationController popToViewController:target animated:YES]; //跳转
                }
            }
        } failureResponse:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
        }];
        
    }
    else {
        if ([self.headerImg.image isEqual:[UIImage imageNamed:@"添加头像"]]) {
            [ZAlertView showSVProgressForErrorStatus:@"请您上传简历头像"];
        }
        else if ([nameStr isEqualToString:@""] || nameStr == nil) {
            [ZAlertView showSVProgressForErrorStatus:@"请您填写真实姓名"];
        }
        else if ([phoneStr isEqualToString:@""] || phoneStr == nil) {
            [ZAlertView showSVProgressForErrorStatus:@"请您填写手机号"];
        }
        else if ([birthStr isEqualToString:@""] || birthStr == nil) {
            [ZAlertView showSVProgressForErrorStatus:@"请您选择出生日期"];
        }
        else if ([jingyanStr isEqualToString:@""]) {
            [ZAlertView showSVProgressForErrorStatus:@"请您选择工作经验"];
        }
        else if ([xueliStr isEqualToString:@"5"]) {
            [ZAlertView showSVProgressForErrorStatus:@"请您选择最高学历"];
        }
        else if ([hopeStr isEqualToString:@""] || hopeStr == nil) {
            [ZAlertView showSVProgressForErrorStatus:@"请您选择期望职位"];
        }
        else if ([gongziStr isEqualToString:@"7"]) {
            [ZAlertView showSVProgressForErrorStatus:@"请您选择期望薪资"];
        }
        else if ([addressStr isEqualToString:@""] || addressStr == nil) {
            [ZAlertView showSVProgressForErrorStatus:@"请您选择求职区域"];
        }
        else if ([introStr isEqualToString:@"[示例]本人从业时间较长,责任心强"] || introStr == nil || [introStr isEqualToString:@""]) {
            [ZAlertView showSVProgressForErrorStatus:@"请您填写自我简介"];
        }
        
        else {
            NSDictionary *dic = @{@"uId":uidStr,
                                  @"jRName":nameStr,
                                  @"jRSex":sexStr,
                                  @"jRPhone":phoneStr,
                                  @"jRBirthday":birthStr,
                                  @"jRYear":jingyanStr,
                                  @"jRDiploma":xueliStr,
                                  @"jRJob":hopeStr,
                                  @"jRMoney":gongziStr,
                                  @"bRId":addressStr,
                                  @"jIntroduction":introStr,
                                  };
            [NetworkRequest sendImagesWithUrl:SendJobResumeFirst parameters:dic imageArray:self.imageArray successResponse:^(id data) {
                NSDictionary *dic = data;
                if (1 == [dic[@"status"] intValue]) {
                    BFSeniorResumeController *seniorVC = [[BFSeniorResumeController alloc] init];
                    [self.navigationController pushViewController:seniorVC animated:YES];
                }
            } failureResponse:^(NSError *error) {
                [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
            }];
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
