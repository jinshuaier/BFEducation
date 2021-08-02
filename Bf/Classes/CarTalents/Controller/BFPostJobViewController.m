//
//  BFPostJobViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/12.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFPostJobViewController.h"
#define PickerViewH 200
@interface BFPostJobViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,TFPickerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) UITextView *textView;
@property (nonatomic,assign) NSInteger indexRow;
@property (nonatomic, strong) UITableViewCell *cell;
@property (nonatomic,strong) NSMutableDictionary *dic;
@property (nonatomic,strong) UITextField *field;
// 职位类别字典
@property (nonatomic , strong) NSMutableDictionary *jobsDict;
// pickViewType
@property (nonatomic , assign) NSInteger pickViewType;
// pickerView
@property (nonatomic , strong) UIPickerView *pickerView;
// pickerViewBG
@property (nonatomic , strong) UIView *pickerViewBG;
// 职位类别名称
@property (nonatomic , strong) NSString *jobsStr;
// 职位类别id
@property (nonatomic , strong) NSString *jobsIdStr;
@end

@implementation BFPostJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布职位";
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    self.dic = dic;
    //注册观察键盘的变化
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self setUpTableViewInterface];
    
    if (!_jobsDict) {
        _jobsDict = [NSMutableDictionary dictionary];
    }
    [self networkJobStyle];
}

#pragma mark - 创建tableView

-(void)setUpTableViewInterface {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell0"];
    [self.view addSubview:_tableView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 55.0f * 6, KScreenW, 260)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.tableView addSubview:backView];
    UILabel *jobLbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 30)];
    jobLbl.text = @"职位描述";
    jobLbl.textColor = RGBColor(51, 51, 51);
    jobLbl.font = [UIFont systemFontOfSize:14.0f];
    [backView addSubview:jobLbl];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(15, jobLbl.bottom + 20, KScreenW - 30, 120)];
    self.textView = textView;
    textView.layer.borderWidth = 1.0f;
    textView.text = @"编辑职位介绍,不超过1000字";
    textView.textColor = RGBColor(178, 178, 178);
    textView.font = [UIFont fontWithName:BFfont size:12.0f];
    textView.layer.borderColor = RGBColor(178, 178, 178).CGColor;
    textView.delegate = self;
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    [backView addSubview:textView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, textView.bottom + 25, KScreenW - 20, 51);
    [btn setTitle:@"发布职位" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:RGBColor(0, 148, 231)];
    btn.userInteractionEnabled = YES;
    [btn addTarget:self action:@selector(clickPostJob) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textView.text.length > 1000) {
        self.textView.text = [textView.text substringToIndex:1000];
        [ZAlertView showSVProgressForInfoStatus:@"职位介绍不超过1000字"];
    }
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    if([self.textView.text isEqualToString:@"编辑职位介绍,不超过1000字"]){
        self.textView.text=@"";
    }
}

#pragma mark - 发布职位的点击事件

-(void)clickPostJob {
    NSString *xingzhi = [self.dic objectForKey:@"2"];
    NSString *gongzi = [self.dic objectForKey:@"3"];
    NSString *jingyan = [self.dic objectForKey:@"4"];
    NSString *xueli = [self.dic objectForKey:@"5"];
    
    NSString *xingzhiStr = @"3";
    
    if ([xingzhi isEqualToString:@"全职"]) {
        xingzhiStr = @"0";
    }
    else if ([xingzhi isEqualToString:@"兼职"]) {
        xingzhiStr = @"1";
    }
    else if ([xingzhi isEqualToString:@"实习"]) {
        xingzhiStr = @"2";
    }
    else {
        xingzhiStr = @"3";
    }
    
    
    NSString *gongziStr = @"7";
    
    if ([gongzi isEqualToString:@"面议"]) {
        gongziStr = @"0";
    }
    else if ([gongzi isEqualToString:@"3千以下"]) {
        gongziStr = @"1";
    }
    else if ([gongzi isEqualToString:@"3千-5千"]) {
        gongziStr = @"2";
    }
    else if ([gongzi isEqualToString:@"5千-7千"]) {
        gongziStr = @"3";
    }
    else if ([gongzi isEqualToString:@"7千-1万"]) {
        gongziStr = @"4";
    }
    else if ([gongzi isEqualToString:@"1万-1.5万"]) {
        gongziStr = @"5";
    }
    else if ([gongzi isEqualToString:@"1.5万以上"]) {
        gongziStr = @"6";
    }
    else {
        gongziStr = @"7";
    }
    
    
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
    NSString *xueliStr = @"4";
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
    
    if (self.field.text == nil || [self.field.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请填写职位名称"];
    }
    else if ([xingzhiStr isEqualToString:@"3"]) {
        [ZAlertView showSVProgressForErrorStatus:@"请选择工作性质"];
    }
    else if ([xingzhiStr isEqualToString:@"7"]) {
        [ZAlertView showSVProgressForErrorStatus:@"请选择薪资范围"];
    }
    else if ([xingzhiStr isEqualToString:@"5"]) {
        [ZAlertView showSVProgressForErrorStatus:@"请选择经验要求"];
    }
    else if ([xingzhiStr isEqualToString:@"4"]) {
        [ZAlertView showSVProgressForErrorStatus:@"请选择学历要求"];
    }
    else if (self.textView.text == nil || [self.textView.text isEqualToString:@"编辑个人介绍,不超过80字"] || [self.textView.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请填写职位描述"];
    }
    else {
        NSDictionary *dic = @{@"uId":GetFromUserDefaults(@"uId"),
                              @"jWName":self.field.text,
                              @"jTId":_jobsIdStr,
                              @"jMState":xingzhiStr,
                              @"jWMoney":gongziStr,
                              @"jWYear":jingyanStr,
                              @"jWDiploma":xueliStr,
                              @"jWNote":self.textView.text
                              };
        
        [NetworkRequest sendDataWithUrl:PostJob parameters:dic successResponse:^(id data) {
            NSDictionary *dic = data;
            if (1 == [dic[@"status"] intValue]) {
                [ZAlertView showSVProgressForSuccess:@"发布成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"postJob" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else {
                [ZAlertView showSVProgressForErrorStatus:@"发布失败"];
            }
        } failure:^(NSError *error) {
            [ZAlertView showSVProgressForErrorStatus:@"请检查您的网络情况"];
        }];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell0"];
    self.cell = cell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.textColor = RGBColor(51, 51, 51);
    if (indexPath.row == 0) {
        cell.textLabel.text = @"职位名称";
        cell.accessoryType = UITableViewCellAccessoryNone;
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(KScreenW - 200 - 15, 12.5, 200, 30)];
        self.field = field;
        field.placeholder = @"请输入职位名称";
        field.textAlignment = NSTextAlignmentRight;
        field.font = [UIFont fontWithName:BFfont size:14.0f];
        cell.accessoryView = field;
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"职位类别";
        cell.detailTextLabel.text = @"请选择";
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"工作性质";
        cell.detailTextLabel.text = @"请选择";
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"薪资范围";
        cell.detailTextLabel.text = @"请选择";
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"经验要求";
        cell.detailTextLabel.text = @"请选择";
    }
    else if (indexPath.row == 5) {
        cell.textLabel.text = @"学历要求";
        cell.detailTextLabel.text = @"请选择";
    }
    return cell;
}


#pragma mark - keyboardNotification
-(void)keyboardWillShow:(NSNotification *)showNot{
    
    NSLog(@"1.取出键盘frame");
    //    1.取出键盘frame
    CGRect keyboardFrame= [showNot.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat upRectFrame = keyboardFrame.size.height ;
    
    //    2.键盘弹出的时间
    CGFloat duration=[showNot.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if ([self.textView isFirstResponder]) {
        [UIView animateWithDuration:duration animations:^{
            self.tableView.frame = CGRectMake(0, -upRectFrame, KScreenW, KScreenH +upRectFrame);
        }];
    }else if([self.field isFirstResponder]){
        [UIView animateWithDuration:duration animations:^{
            self.tableView.frame = CGRectMake(0, 64, KScreenW, KScreenH -64);
        }];
    }
}


-(void)keyboardWillHide:(NSNotification *)hideNot{
    NSLog(@"3.键盘弹回的时间");
    CGFloat duration=[hideNot.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //    3.执行动画
    [UIView animateWithDuration:duration animations:^{
        self.tableView.frame = CGRectMake(0, 64, KScreenW, KScreenH -64);
    }];
}


#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 30)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        self.indexRow = 1;
        //职位类别
        self.pickViewType = 0;
        [self.view addSubview:self.pickerViewBG];
        [UIView animateWithDuration:0.1f animations:^{
            self.pickerView.frame = CGRectMake(0, KScreenH - PickerViewH, KScreenW, PickerViewH);
        } completion:^(BOOL finished) {
            
        }];
    }
    else if (indexPath.row == 2) {
        self.indexRow = 2;
        //工作性质
        PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        picker.delegate = self;
        picker.arrayType = quanzhiArray;
        [self.view addSubview:picker];
    }
    else if (indexPath.row == 3) {
        self.indexRow = 3;
        //薪资范围
        PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        picker.delegate = self;
        picker.arrayType = moneyArray;
        [self.view addSubview:picker];
    }
    else if (indexPath.row == 4) {
        self.indexRow = 4;
        //经验要求
        PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        picker.delegate = self;
        picker.arrayType = jingyanArray;
        [self.view addSubview:picker];
    }
    else if (indexPath.row == 5) {
        self.indexRow = 5;
        //学历要求
        PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        picker.delegate = self;
        picker.arrayType = xueliArray;
        [self.view addSubview:picker];
    }
}

#pragma mark - pickerView delegate

- (void)PickerSelectorIndixString:(NSString *)str andIndex:(NSInteger)selectIndex{
    _cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.indexRow inSection:0]];
    _cell.detailTextLabel.text = str;
    [self.dic setObject:str forKey:[NSString stringWithFormat:@"%ld",self.indexRow]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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

#pragma mark pickerview function
//返回有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_pickViewType == 0) {
        return  [_jobsDict count];
    }
    return 50;
}

//返回指定列，行的高度，就是自定义行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 20.0f;
}

//返回指定列的宽度
- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
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
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        _cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        _cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_jobsStr];
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

@end

