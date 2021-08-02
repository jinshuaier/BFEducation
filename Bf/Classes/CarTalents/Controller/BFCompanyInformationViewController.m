//
//  BFCompanyInformationViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/12.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCompanyInformationViewController.h"
#define PickerViewH 200
@interface BFCompanyInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TFPickerDelegate,CitysPickerViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
/*输入框1*/
@property (nonatomic,strong) UITextField *field1;
/*输入框2*/
@property (nonatomic,strong) UITextField *field2;
/*按钮*/
@property (nonatomic,strong) UIButton *rightBtn;
/*公司logo*/
@property (nonatomic,strong) UIImageView *logoImg;
/*cell*/
@property (nonatomic, strong) UITableViewCell *cell;
/*角标*/
@property (nonatomic,assign) NSInteger indexRow;
/*保存公司信息字典*/
@property (nonatomic,strong) NSMutableDictionary *inforDic;
/*logo*/
@property (nonatomic,strong) NSMutableArray *logoArr;
// pickViewType 0 = 地址 1 = 工作经验
@property (nonatomic , assign) NSInteger pickViewType;
// 城市字典
@property (nonatomic , strong) NSMutableDictionary *citysDict;
// 省
@property (nonatomic , strong) NSString *provinceStr;
// 市
@property (nonatomic , strong) NSDictionary *cityDic;
// pickerView
@property (nonatomic , strong) UIPickerView *pickerView;
// pickerViewBG
@property (nonatomic , strong) UIView *pickerViewBG;
@end

@implementation BFCompanyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公司信息";
    self.view.backgroundColor = GroundGraryColor;
    
    NSMutableDictionary *inforDic = [[NSMutableDictionary alloc] init];
    self.inforDic = inforDic;
    
    NSMutableArray *logoArr = [NSMutableArray array];
    self.logoArr = logoArr;
    //设置切换按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn = rightBtn;
    if ([self.informationStr isEqualToString:@"0"]) {
        [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    else {
        [rightBtn setTitle:@"提交" forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(rightDoneClick) forControlEvents:UIControlEventTouchUpInside];
    }
    rightBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(0, 0, 40, 30)];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItems = @[item1];
    [self setUpTableViewInterface];
    
    if (!_citysDict) {
        _citysDict = [NSMutableDictionary dictionary];
    }
    [self getCitiesListNetWork];
}

-(void)rightBtnClick {
    self.informationStr = @"1";
    [self.rightBtn addTarget:self action:@selector(rightDoneClick) forControlEvents:UIControlEventTouchUpInside];
    self.field1.userInteractionEnabled = YES;
    self.field2.userInteractionEnabled = YES;
    [self.rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    [self.tableView reloadData];
}

-(void)rightDoneClick {
    
    NSString *companySize = [self.inforDic objectForKey:@"2"];
    NSString *companyStyle = [self.inforDic objectForKey:@"1"];
    NSString *sizea = @"0";
    
    if ([companyStyle isEqualToString:@"少于15人"]) {
        sizea = @"0";
    }
    else if ([companyStyle isEqualToString:@"15-50人"]) {
        sizea = @"1";
    }
    else if ([companyStyle isEqualToString:@"50-150人"]) {
        sizea = @"2";
    }
    else if ([companyStyle isEqualToString:@"500-1000人"]) {
        sizea = @"3";
    }
    else if ([companyStyle isEqualToString:@"1000人以上"]) {
        sizea = @"4";
    }
    else {
        sizea = @"5";
    }
    
    
    NSString *style = @"0";
    
    if ([companySize isEqualToString:@"民营"]) {
        style = @"0";
    }
    else if ([companySize isEqualToString:@"国有"]) {
        style = @"1";
    }
    else if ([companySize isEqualToString:@"外商独资/办事处"]) {
        style = @"2";
    }
    else if ([companySize isEqualToString:@"中外合资/合作"]) {
        style = @"3";
    }
    else if ([companySize isEqualToString:@"事业单位"]) {
        style = @"4";
    }
    else {
        style = @"5";
    }
    
    NSString *companyAddress = _cityDic[@"brid"];
    NSLog(@"企业主键为:%@",self.jCid);
    NSString *jcid = self.jCid;
    NSString *detailAddress = self.field1.text;
    NSString *email = self.field2.text;
    
    
    
    if (self.inforDic.count != 2) {
        [ZAlertView showSVProgressForErrorStatus:@"请将公司信息填写完整"];
    }
    else if (self.field1.text == nil || [self.field1.text isEqualToString:@""] || self.field2.text == nil || [self.field2.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请将公司信息填写完整"];
    }
    else if (0 == companyAddress) {
        [ZAlertView showSVProgressForErrorStatus:@"请将公司信息填写完整"];
    }
    else if (0 == self.logoArr.count) {
        [ZAlertView showSVProgressForErrorStatus:@"请将公司信息填写完整"];
    }
    else {
        NSDictionary *dic = @{@"jCId":jcid,
                              @"jCSize":sizea,
                              @"jCType":style,
                              @"bRId":companyAddress,
                              @"jCAddress":detailAddress,
                              @"jCEmail":email
                              };
        //发送网络请求
        [NetworkRequest sendImagesWithUrl:CompanyInformationUpdate parameters:dic imageArray:self.logoArr successResponse:^(id data) {
            NSDictionary *dic = data;
            if ([dic[@"status"] intValue] == 1) {
                [ZAlertView showSVProgressForSuccess:@"完善信息成功"];
                [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark - 创建tableView

-(void)setUpTableViewInterface {
    
    if ([self.informationStr isEqualToString:@"0"]) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64) style:UITableViewStylePlain];
    }
    else {
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, 41)];
        topView.backgroundColor = RGBColor(0, 140, 244);
        [self.view addSubview:topView];
        //topView上的按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"未通过"] forState:UIControlStateNormal];
        [btn setTitle:@" 认证通过，补全公司信息" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:BFfont size:12.0f];
        btn.titleLabel.textColor = RGBColor(255, 255, 255);
        btn.frame = CGRectMake(0, 13, KScreenW, 15);
        [topView addSubview:btn];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, topView.bottom, KScreenW, KScreenH - 64 - 41) style:UITableViewStylePlain];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:_tableView];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    // 定义唯一标识
//     static NSString *CellIdentifier = @"Cell";
//     // 通过indexPath创建cell实例 每一个cell都是单独的
//     UITableViewCell *cell = [UITableViewCell new];
//     // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
//     if (!cell) {
//         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
//    }
//    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    self.cell = cell;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([self.informationStr isEqualToString:@"0"]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.textColor = RGBColor(51, 51, 51);
    
    
    NSLog(@"传入的企业信息数据为:%@",self.inDic);
    NSString *str = [NSString stringWithFormat:@"%@",self.inDic[@"jCAddress"]];
    NSArray * array = [str componentsSeparatedByString:@";"];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"公司Logo";
        cell.accessoryType = UITableViewCellAccessoryNone;
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW - 40 - 15, 7.5, 40, 40)];
        self.logoImg = img;
        if ([self.informationStr isEqualToString:@"0"]) {
            [img sd_setImageWithURL:[NSURL URLWithString:self.inDic[@"jCLogo"]]];
        }else {
            img.image = [UIImage imageNamed:@"WechatIMG"];
        }
        img.clipsToBounds = YES;
        img.layer.cornerRadius = 20.0f;
        cell.accessoryView = img;
    }
    else if (indexPath.row == 1) {
        cell.textLabel.text = @"公司规模";
        if ([self.informationStr isEqualToString:@"0"]) {
            NSString *str = [NSString stringWithFormat:@"%@",self.inDic[@"jCSize"]];
            NSString *guimoStr = @"";
            if ([str isEqualToString:@"0"]) {
                guimoStr = @"少于15人";
            }
            else if ([str isEqualToString:@"1"]) {
                guimoStr = @"15-50人";
            }
            else if ([str isEqualToString:@"2"]) {
                guimoStr = @"50-150人";
            }
            else if ([str isEqualToString:@"3"]) {
                guimoStr = @"500-1000人";
            }
            else if ([str isEqualToString:@"4"]) {
                guimoStr = @"1000人以上";
            }
            cell.detailTextLabel.text = guimoStr;
            cell.textLabel.textColor = [UIColor blackColor];
        }else {
           cell.detailTextLabel.text = @"请选择";
        }
    }
    else if (indexPath.row == 2) {
        cell.textLabel.text = @"公司类型";
        if ([self.informationStr isEqualToString:@"0"]) {
            NSString *str = [NSString stringWithFormat:@"%@",self.inDic[@"jCType"]];
            NSString *leixingStr = @"";
            if ([str isEqualToString:@"0"]) {
                leixingStr = @"民营";
            }
            else if ([str isEqualToString:@"1"]) {
                leixingStr = @"国有";
            }
            else if ([str isEqualToString:@"2"]) {
                leixingStr = @"外商独资/办事处";
            }
            else if ([str isEqualToString:@"3"]) {
                leixingStr = @"中外合资/合作";
            }
            else if ([str isEqualToString:@"4"]) {
                leixingStr = @"事业单位";
            }
            cell.detailTextLabel.text = leixingStr;
            
        }else {
            cell.detailTextLabel.text = @"请选择";
        }
    }
    else if (indexPath.row == 3) {
        cell.textLabel.text = @"公司地址";
        if ([self.informationStr isEqualToString:@"0"]) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",array[0]];
        }else {
            if (_cityDic) {
                cell.detailTextLabel.text = _cityDic[@"brname"];
            }
            else {
                cell.detailTextLabel.text = @"请选择";
            }
        }
    }
    else if (indexPath.row == 4) {
        cell.textLabel.text = @"详细地址";
        cell.accessoryType = UITableViewCellAccessoryNone;
        UITextField *field1 = [[UITextField alloc] initWithFrame:CGRectMake(KScreenW - 200 - 15, 12.5, 200, 30)];
        self.field1 = field1;
        if ([self.informationStr isEqualToString:@"0"]) {
            self.field1.userInteractionEnabled = NO;
            self.field1.text = [NSString stringWithFormat:@"%@",array[1]];
        }
        else if ([self.informationStr isEqualToString:@"1"]) {
            self.field1.userInteractionEnabled = YES;
            field1.placeholder = @"请输入详细地址";
        }
        field1.textAlignment = NSTextAlignmentRight;
        field1.font = [UIFont fontWithName:BFfont size:14.0f];
        cell.accessoryView = field1;
    }
    else if (indexPath.row == 5) {
        cell.textLabel.text = @"常用邮箱";
        cell.accessoryType = UITableViewCellAccessoryNone;
        UITextField *field2 = [[UITextField alloc] initWithFrame:CGRectMake(KScreenW - 200 - 15, 12.5, 200, 30)];
        self.field2 = field2;
        if ([self.informationStr isEqualToString:@"0"]) {
            self.field2.userInteractionEnabled = NO;
            self.field2.text = [NSString stringWithFormat:@"%@",self.inDic[@"jCEmail"]];
        }
        else if ([self.informationStr isEqualToString:@"1"]) {
            self.field2.userInteractionEnabled = YES;
            self.field2.placeholder = @"请输入常用邮箱";
        }
        field2.textAlignment = NSTextAlignmentRight;
        field2.font = [UIFont fontWithName:BFfont size:14.0f];
        cell.accessoryView = field2;
    }
    return cell;
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
    
    if ([self.informationStr isEqualToString:@"0"]) {
        //企业信息已经完善 不需要点击进行编辑
    }
    else {
        //cell的点击事件
        if (indexPath.row == 0) {
            //选择图片
            [self clickChangeHeadImgAciton];
        }
        else if (indexPath.row == 1) {
            self.indexRow = 1;
            //选择公司规模
            PickerChoiceView *picker = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            picker.delegate = self;
            picker.arrayType = guimoArray;
            [self.view addSubview:picker];
        }
        else if (indexPath.row == 2) {
            self.indexRow = 2;
            //选择公司性质
            PickerChoiceView *picker1 = [[PickerChoiceView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
            picker1.delegate = self;
            picker1.arrayType = xingzhiArray;
            [self.view addSubview:picker1];
        }
        else if (indexPath.row == 3) {
            //选择公司地址
            self.indexRow = 3;
            self.pickViewType = 0;
            [self.view addSubview:self.pickerViewBG];
            [UIView animateWithDuration:0.1f animations:^{
                self.pickerView.frame = CGRectMake(0, KScreenH - PickerViewH, KScreenW, PickerViewH);
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

#pragma mark - pickerView delegate

- (void)PickerSelectorIndixString:(NSString *)str andIndex:(NSInteger)selectIndex{
    _cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.indexRow inSection:0]];
    _cell.detailTextLabel.text = str;
    [self.inforDic setObject:str forKey:[NSString stringWithFormat:@"%ld",self.indexRow]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.logoImg.image = image;
    [self.logoArr addObject:image];
    _cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
    return 2;
}

//返回指定列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (_pickViewType == 0) {
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
    return KScreenW/2;
}

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    UILabel *text = nil;
    if (_pickViewType == 0) {
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
        if (component == 0) {
            _provinceStr = [[_citysDict allKeys] objectAtIndex:row];
            [_pickerView reloadComponent:1];
        }else{
            _cityDic = [_citysDict[_provinceStr] objectAtIndex:row];
        }
        _cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
        _cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",_cityDic[@"brname"]];
        [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
