//
//  BFDetailExperienceController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/22.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFDetailExperienceController.h"

@interface BFDetailExperienceController ()<TFPickerDelegate,UITextViewDelegate>

@property (nonatomic,strong) UILabel *startLbl;
@property (nonatomic,strong) UILabel *endLbl;
@property (nonatomic,strong) UILabel *lbl;
@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) UITextField *detailField;
@property (nonatomic,strong) UITextView *introView;
@end

@implementation BFDetailExperienceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.exTitle;
    self.view.backgroundColor = [UIColor whiteColor];
    //设置完成按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 30)];
    [rightBtn addTarget:self action:@selector(rightDoneClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[item1];
    
    NSLog(@"传入的数据为:%@",self.exStyle);
    [self setUpInterface];
    
}

#pragma mark - 界面搭建

-(void)setUpInterface {
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake((KScreenW - 100)/2, 64, 100, 30)];
    if ([self.exStyle isEqualToString:@"0"]) {
        titleLbl.text = @"公司名称";
    }
    else {
        titleLbl.text = @"学校名称";
    }
    titleLbl.textColor = RGBColor(210, 210, 210);
    titleLbl.font = [UIFont fontWithName:BFfont size:13.0f];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLbl];
    
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(0, titleLbl.bottom + 10, KScreenW, 30)];
    self.nameField = nameField;
    if ([self.edit isEqualToString:@"1"]) {
        if ([self.exStyle isEqualToString:@"0"]) {
            nameField.text = _model00.jECompany;
        }
        else {
            nameField.text = _model11.jLSchool;
        }
    }
    else {
        if ([self.exStyle isEqualToString:@"0"]) {
            nameField.placeholder = @"请输入公司名称";
        }
        else {
            nameField.placeholder = @"请输入学校名称";
        }
    }
    nameField.textAlignment = NSTextAlignmentCenter;
    nameField.font = [UIFont fontWithName:BFfont size:16.0f];
    [self.view addSubview:nameField];
    
    UIView *line0 = [[UIView alloc] initWithFrame:CGRectMake(15, nameField.bottom + 20, KScreenW - 30, 0.50f)];
    line0.backgroundColor = LineColor;
    [self.view addSubview:line0];
    
    UITextField *detailField = [[UITextField alloc] initWithFrame:CGRectMake(0, line0.bottom + 20, KScreenW, 30)];
    self.detailField = detailField;
    if ([self.edit isEqualToString:@"1"]) {
        if ([self.exStyle isEqualToString:@"0"]) {
            detailField.text = _model00.jEJob;
        }
        else {
            detailField.text = _model11.jLLearn;
        }
    }
    else {
        if ([self.exStyle isEqualToString:@"0"]) {
            detailField.placeholder = @"职位名称";
        }
        else {
            detailField.placeholder = @"专业名称";
        }
    }
    detailField.textAlignment = NSTextAlignmentCenter;
    detailField.font = [UIFont fontWithName:BFfont size:16.0f];
    [self.view addSubview:detailField];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(15, detailField.bottom + 20, KScreenW - 30, 0.50f)];
    line1.backgroundColor = LineColor;
    [self.view addSubview:line1];
    
    //开始时间
    UILabel *start = [[UILabel alloc] initWithFrame:CGRectMake(0, line1.bottom + 20, KScreenW/2, 20)];
    start.text = @"开始时间";
    start.textColor = RGBColor(138, 137, 138);
    start.textAlignment = NSTextAlignmentCenter;
    start.font = [UIFont fontWithName:BFfont size:16.0f];
    [self.view addSubview:start];
    
    UILabel *startLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, start.bottom + 20, KScreenW/2, 20)];
    self.startLbl = startLbl;
    if ([self.edit isEqualToString:@"1"]) {
        if ([self.exStyle isEqualToString:@"0"]) {
            startLbl.text = _model00.jEStartTimeStr;
        }
        else {
            startLbl.text = _model11.jLStartTimeStr;
        }
    }
    else {
        startLbl.text = @"请选择";
    }
    startLbl.tag = 10001;
    startLbl.textAlignment = NSTextAlignmentCenter;
    startLbl.textColor = ColorRGBValue(0xd2d2d2);
    startLbl.font = [UIFont fontWithName:BFfont size:16.0f];
    startLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickstart)];
    [startLbl addGestureRecognizer:ges0];
    [self.view addSubview:startLbl];
    //竖线
    UIView *line00 = [[UIView alloc] initWithFrame:CGRectMake(startLbl.right, line1.bottom + 20, 0.50f, 60)];
    line00.backgroundColor = ColorRGBValue(0xd2d2d2);
    [self.view addSubview:line00];
    
    //结束时间
    UILabel *end = [[UILabel alloc] initWithFrame:CGRectMake(line00.right, line1.bottom + 20, KScreenW/2, 20)];
    end.text = @"结束时间";
    end.textColor = RGBColor(138, 137, 138);
    end.textAlignment = NSTextAlignmentCenter;
    end.font = [UIFont fontWithName:BFfont size:16.0f];
    [self.view addSubview:end];
    
    UILabel *endLbl = [[UILabel alloc] initWithFrame:CGRectMake(line00.right, end.bottom + 20, KScreenW/2, 20)];
    self.endLbl = endLbl;
    if ([self.edit isEqualToString:@"1"]) {
        if ([self.exStyle isEqualToString:@"0"]) {
            endLbl.text = _model00.jEEndTimeStr;
        }
        else {
            endLbl.text = _model11.jLEndTimeStr;
        }
    }
    else {
        endLbl.text = @"请选择";
    }
    endLbl.tag = 20002;
    endLbl.textAlignment = NSTextAlignmentCenter;
    endLbl.textColor = ColorRGBValue(0xd2d2d2);
    endLbl.font = [UIFont fontWithName:BFfont size:16.0f];
    endLbl.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickend)];
    [endLbl addGestureRecognizer:ges1];
    [self.view addSubview:endLbl];
    
    if ([self.exStyle isEqualToString:@"0"]) {
        //工作经历详情
        UITextView *introView = [[UITextView alloc] initWithFrame:CGRectMake(16, endLbl.bottom + 30, KScreenW - 32, 105)];
        self.introView = introView;
        introView.layer.borderWidth = 0.50f;
        if ([self.edit isEqualToString:@"1"]) {
            NSString *contentStr = [NSString stringWithFormat:@"%@",_model00.jEContent];
            if ([contentStr isEqualToString:@""] || [contentStr isEqualToString:@"(null)"] || contentStr == nil) {
                introView.text = @"";
            }
            else {
                introView.text = [NSString stringWithFormat:@"%@",_model00.jEContent];
            }
        }
        else {
            introView.text = @"请填写个人工作经历";
        }
        introView.textColor = RGBColor(178, 178, 178);
        introView.font = [UIFont fontWithName:BFfont size:12.0f];
        introView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        introView.delegate = self;
        [self.view addSubview:introView];
    }
    else {
        
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.introView.text.length > 1000) {
        self.introView.text = [textView.text substringToIndex:1000];
        [ZAlertView showSVProgressForInfoStatus:@"工作经历不超过1000字"];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if([self.introView.text isEqualToString:@"请填写个人工作经历"]){
        self.introView.text=@"";
    }
}

-(void)rightDoneClick {
    if (self.nameField.text == nil || [self.nameField.text isEqualToString:@""] || self.detailField.text == nil || [self.detailField.text isEqualToString:@""] || self.startLbl.text == nil || [self.startLbl.text isEqualToString:@""] || self.endLbl.text == nil || [self.endLbl.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请填写完整数据"];
    }
    else if ([self.startLbl.text integerValue] > [self.endLbl.text integerValue]) {
        [ZAlertView showSVProgressForErrorStatus:@"开始时间不能大于结束时间"];
    }
    else {
        //用户主键
        NSString *uidStr = GetFromUserDefaults(@"uId");
        //工作经历主键
        NSString *workIdStr = _model00.jEId;
        //教育经历主键
        NSString *eduIdStr = _model11.jLId;
        //公司/学校名称
        NSString *comStr = self.nameField.text;
        //职位/专业名称
        NSString *detailStr = self.detailField.text;
        //开始时间
        NSString *startStr = self.startLbl.text;
        //结束时间
        NSString *endStr = self.endLbl.text;
        //工作经历内容
        NSString *contentStr = self.introView.text;
        if ([self.edit isEqualToString:@"1"]) {
            if ([self.exStyle isEqualToString:@"0"]) {

                NSDictionary *dic = @{@"uId":uidStr,
                                      @"jEId":workIdStr,
                                      @"jECompany":comStr,
                                      @"jEJob":detailStr,
                                      @"jEStartTime":startStr,
                                      @"jEEndTime":endStr,
                                      @"jEContent":contentStr
                                      };
                
                [NetworkRequest sendDataWithUrl:ChangeWorkEx parameters:dic successResponse:^(id data) {
                    NSDictionary *dic = data;
                    if (1 == [dic[@"status"] intValue]) {
                        [ZAlertView showSVProgressForSuccess:@"添加工作经历成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else {
                        NSString *errMsg = [NSString stringWithFormat:@"%@",dic[@"msg"]];
                        [ZAlertView showSVProgressForErrorStatus:errMsg];
                    }
                } failure:^(NSError *error) {
                    [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
                }];
            }
            else {
                
                NSDictionary *dic = @{@"uId":uidStr,
                                      @"jLId":eduIdStr,
                                      @"jLSchool":comStr,
                                      @"jLLearn":detailStr,
                                      @"jLStarTime":startStr,
                                      @"jLEndTime":endStr
                                      };
                
                [NetworkRequest sendDataWithUrl:ChangeEducationEx parameters:dic successResponse:^(id data) {
                    NSDictionary *dic = data;
                    if (1 == [dic[@"status"] intValue]) {
                        [ZAlertView showSVProgressForSuccess:@"添加教育经历成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else {
                        NSString *errMsg = [NSString stringWithFormat:@"%@",dic[@"msg"]];
                        [ZAlertView showSVProgressForErrorStatus:errMsg];
                    }
                } failure:^(NSError *error) {
                    [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
                }];
            }
        }
        else {
            if ([self.exStyle isEqualToString:@"0"]) {
                
                NSDictionary *dic = @{@"uId":uidStr,
                                      @"jECompany":comStr,
                                      @"jEJob":detailStr,
                                      @"jEStartTime":startStr,
                                      @"jEEndTime":endStr,
                                      @"jEContent":contentStr
                                      };
                
                [NetworkRequest sendDataWithUrl:AddWorkEx parameters:dic successResponse:^(id data) {
                    NSDictionary *dic = data;
                    if (1 == [dic[@"status"] intValue]) {
                        [ZAlertView showSVProgressForSuccess:@"添加工作经历成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else {
                        NSString *errMsg = [NSString stringWithFormat:@"%@",dic[@"msg"]];
                        [ZAlertView showSVProgressForErrorStatus:errMsg];
                    }
                } failure:^(NSError *error) {
                    [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
                }];
            }
            else {
                
                NSDictionary *dic = @{@"uId":uidStr,
                                      @"jLSchool":comStr,
                                      @"jLLearn":detailStr,
                                      @"jLStarTime":startStr,
                                      @"jLEndTime":endStr
                                      };
                
                [NetworkRequest sendDataWithUrl:AddEducationEx parameters:dic successResponse:^(id data) {
                    NSDictionary *dic = data;
                    if (1 == [dic[@"status"] intValue]) {
                        [ZAlertView showSVProgressForSuccess:@"添加教育经历成功"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    else {
                        NSString *errMsg = [NSString stringWithFormat:@"%@",dic[@"msg"]];
                        [ZAlertView showSVProgressForErrorStatus:errMsg];
                    }
                } failure:^(NSError *error) {
                    [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
                }];
            }
        }
    }
}

-(void)clickstart {
    self.lbl = self.startLbl;
    //出生日期
    PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    picker.delegate = self;
    picker.arrayType = agoDate;
    [self.view addSubview:picker];
}

-(void)clickend {
    self.lbl = self.endLbl;
    //出生日期
    PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    picker.delegate = self;
    picker.arrayType = agoDate;
    [self.view addSubview:picker];
}

#pragma mark - pickerView delegate

- (void)PickerSelectorIndixString:(NSString *)str andIndex:(NSInteger)selectIndex{
    NSString *str00 = [str substringToIndex:7];
    if (self.lbl.tag == 10001) {
        //开始时间
        self.startLbl.text = str00;
    }
    else if (self.lbl.tag == 20002) {
        //结束时间
        self.endLbl.text = str00;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
