//
//  BFCreateLiveCourseVC.m
//  Bf
//
//  Created by 春晓 on 2018/5/23.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFCreateLiveCourseVC.h"
#import "BFTagEditVC.h"

#import "BFCreateCourseTextSelectCell.h"
#import "BFCreateCourseImgCell.h"
#import "BFCreateCourseBtnCell.h"
#import "BFCoursePlayBackSignCell.h"
#import "THDatePickerView.h"

@interface BFCreateLiveCourseVC ()<UITableViewDelegate,UITableViewDataSource,BFCreateCourseImgCellDelegate,BFCreateCourseBtnCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,THDatePickerViewDelegate,BFCreateCourseTextSelectCellDelegate>
// table
@property (nonatomic , strong) UITableView *tableView;
// pickerView
@property (nonatomic , strong) THDatePickerView *dateView;
// 点击的cell
@property (nonatomic , strong) BFCreateCourseTextSelectCell *textSelectCell;

// data
// 课程标题
@property (nonatomic , strong) NSString *cTitle;
// 标签
@property (nonatomic , strong) NSString *tagStr;
// 标签数组
@property (nonatomic , strong) NSArray *tagArr;
// 开始时间
@property (nonatomic , strong) NSString *startTime;
// 结束时间
@property (nonatomic , strong) NSString *endTime;
// 课程封面图
@property (nonatomic , strong) UIImage *courseLogo;
@end

static NSString *textSelectCell = @"textSelectCell";
static NSString *imgCell = @"imgCell";
static NSString *signCell = @"signCell";
static NSString *btnCell = @"btnCell";

@implementation BFCreateLiveCourseVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"课程编辑页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"课程编辑页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"课程编辑";
    // 测试 导航栏宽高
    CGRect navRect = self.navigationController.navigationBar.frame;
    // 测试 状态栏宽高
    CGRect rectStartsBar = [UIApplication sharedApplication].statusBarFrame;
    CGFloat h = navRect.size.height + rectStartsBar.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, h, KScreenW, KScreenH - h) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[BFCreateCourseTextSelectCell class] forCellReuseIdentifier:textSelectCell];
    [_tableView registerClass:[BFCreateCourseImgCell class] forCellReuseIdentifier:imgCell];
    [_tableView registerClass:[BFCoursePlayBackSignCell class] forCellReuseIdentifier:signCell];
    [_tableView registerClass:[BFCreateCourseBtnCell class] forCellReuseIdentifier:btnCell];
    [self.view addSubview:_tableView];
    
    THDatePickerView *dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    //    dateView.isSlide = NO;
    //    dateView.date = @"2017-03-23 12:43";
    dateView.minuteInterval = 1;
    [self.view addSubview:dateView];
    self.dateView = dateView;
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dict) {
        return 7;
    }
    return 6;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        BFCreateCourseImgCell *cell = [tableView dequeueReusableCellWithIdentifier:imgCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCreateCourseImgCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:imgCell];
        }
        cell.delegate = self;
        cell.leftLabel.text = @"课程封面图";
        if (_dict) {
            [cell.logoImgView sd_setImageWithURL:[NSURL URLWithString:_dict[@"ccover"]] placeholderImage:[UIImage imageNamed:@"组3"]];
//            [cell.logoImgView sd_setImageWithURL:[NSURL URLWithString:_dict[@"ccover"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                _courseLogo = image;
//            }];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 5) {
        if (_dict) {
            BFCoursePlayBackSignCell *cell = [tableView dequeueReusableCellWithIdentifier:signCell forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFCoursePlayBackSignCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:signCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            BFCreateCourseBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:btnCell forIndexPath:indexPath];
            if (!cell) {
                cell = [[BFCreateCourseBtnCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:btnCell];
            }
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.row == 6) {
        BFCreateCourseBtnCell *cell = [tableView dequeueReusableCellWithIdentifier:btnCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCreateCourseBtnCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:btnCell];
        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 0 || indexPath.row == 1) {
        BFCreateCourseTextSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:textSelectCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCreateCourseTextSelectCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:textSelectCell];
        }
        
        _textSelectCell = cell;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.tagType = 0;
            cell.cellType = 0;
            cell.leftLabel.text = @"课程名称";
            if (_dict) {
                cell.textField.text = _dict[@"ctitle"];
            }
        }else{
            cell.tagType = 1;
            cell.cellType = 1;
            cell.leftLabel.text = @"授课标签";
            if (_dict) {
                cell.rightLabel.text = [NSString stringWithFormat:@"%ld个标签",_tagArr.count];
            }
            if (_tagArr) {
                cell.rightLabel.text = [NSString stringWithFormat:@"%ld个标签",_tagArr.count];
            }else{
                cell.rightLabel.text = @"请填写";
            }
        }
        cell.delegate = self;
        return cell;
    }else if (indexPath.row == 2 || indexPath.row == 3) {
        BFCreateCourseTextSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:textSelectCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[BFCreateCourseTextSelectCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:textSelectCell];
        }
        cell.cellType = 1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 2) {
            cell.tagType = 0;
            cell.leftLabel.text = @"开始时间";
            if (_dict) {
                cell.rightLabel.text = [BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dict[@"cstarttime"]] dateFormat:@"YYYY-MM-dd HH:mm"];
            }
        }else{
            cell.tagType = 1;
            cell.leftLabel.text = @"结束时间";
            if (_dict) {
                cell.rightLabel.text = [BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dict[@"cendtime"]] dateFormat:@"YYYY-MM-dd HH:mm"];
            }
        }
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        return 200;
    }else if (indexPath.row == 5) {
        if (_dict) {
            return 70;
        }else{
            return 101;
        }
    }else if (indexPath.row == 6) {
        return 101;
    }
    return 60.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2 || indexPath.row == 3) {
        NSInteger state = 0;
        if (_dict) {
            state = [_dict[@"state"] integerValue];
            if (state == 1) {
                _textSelectCell = [_tableView cellForRowAtIndexPath:indexPath];
                [UIView animateWithDuration:0.3 animations:^{
                    self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
                    [self.dateView show];
                }];
            }
        }else{
            _textSelectCell = [_tableView cellForRowAtIndexPath:indexPath];
            [UIView animateWithDuration:0.3 animations:^{
                self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
                [self.dateView show];
            }];
        }
    }else if (indexPath.row == 1) {
        BFTagEditVC *vc = [BFTagEditVC new];
        vc.tagArray = _tagArr.mutableCopy;
        vc.block = ^(NSArray *arr) {
            if (_tagArr) {
                _tagArr = nil;
            }
            _tagArr = arr.mutableCopy;
            [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:(UITableViewRowAnimationFade)];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark -BFCreateCourseImgCellDelegate-

- (void)selectLogoAction{
    [self clickLogoImgAciton];
}

#pragma mark -BFCreateCourseBtnCellDelegate-

-(void)commitAction{
    if (_dict && _courseLogo == nil) {
        _courseLogo = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_dict[@"ccover"]];
    }
    for (int i = 0; i < _tagArr.count; i++) {
        if (i == 0) {
            _tagStr = _tagArr[0];
        }else{
            _tagStr = [NSString stringWithFormat:@"%@,%@",_tagStr,_tagArr[i]];
        }
    }
    if (StrNotEmpty(_cTitle) && StrNotEmpty(_tagStr) && StrNotEmpty(_startTime) && StrNotEmpty(_endTime) && _courseLogo != nil) {
        if (_dict) {
            [self editLiveCourseNetWork];
        }else{
            [self createLiveCourseNetWork];
        }
    }else{
        [ZAlertView showSVProgressForErrorStatus:@"请填写完整信息"];
    }
}

- (void)cancelAction{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -BFCreateCourseTextSelectCellDelegate-

-(void)getTextFieldTextWithTag:(NSInteger)tag withText:(NSString *)text {
    if (tag == 0) {
        _cTitle = text;
    }else{
        _tagStr = text;
    }
}

#pragma mark - 点击添加logo

-(void)clickLogoImgAciton {
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
            imagePicker.allowsEditing = NO;
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
            imagePicker.allowsEditing = NO;
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
    UIImage * image = [info valueForKey:UIImagePickerControllerOriginalImage];
    BFCreateCourseImgCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    cell.logoImgView.contentMode = UIViewContentModeScaleAspectFill;
    cell.logoImgView.image = image;
    _courseLogo = image;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    _textSelectCell.rightLabel.text = timer;
    if (_textSelectCell.tagType == 0) {
        _startTime = timer;
    }else{
        _endTime = timer;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

#pragma mark -setter-

- (void)setDict:(NSDictionary *)dict{
    _dict = dict;
    _cTitle = _dict[@"ctitle"];
    _tagArr = _dict[@"tags"];
    _startTime = [BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dict[@"cstarttime"]] dateFormat:@"YYYY-MM-dd HH:mm"];
    _endTime = [BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_dict[@"cendtime"]] dateFormat:@"YYYY-MM-dd HH:mm"];
    _courseLogo = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_dict[@"ccover"]];
}

- (void)createLiveCourseNetWork {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:_cTitle forKey:@"cTitle"];
    [dic setValue:_tagStr forKey:@"label"];
    [dic setValue:_startTime forKey:@"startTime"];
    [dic setValue:_endTime forKey:@"endTime"];
    [dic setValue:GetFromUserDefaults(@"uId") forKey:@"uId"];
    [NetworkRequest sendImagesWithUrl:CreateLiveCourseURL parameters:dic image:_courseLogo imageName:@"coverFile" successResponse:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if(status == 1){
            [ZAlertView showSVProgressForSuccess:@"创建成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else if (status == 5){
            [ZAlertView showSVProgressForErrorStatus:@"时间冲突，请调整时间"];
        }else{
            [ZAlertView showSVProgressForErrorStatus:@"创建失败,请稍后再试"];
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"创建失败,请稍后再试"];
    }];
}

- (void)editLiveCourseNetWork {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:_cTitle forKey:@"cTitle"];
    [dic setValue:_tagStr forKey:@"label"];
    [dic setValue:_startTime forKey:@"startTime"];
    [dic setValue:_endTime forKey:@"endTime"];
    [dic setValue:GetFromUserDefaults(@"uId") forKey:@"uId"];
    [dic setValue:_dict[@"cid"] forKey:@"cId"];
    [dic setValue:@(0) forKey:@"timeFlag"];
    [NetworkRequest sendImagesWithUrl:EditLiveCourseURL parameters:dic image:_courseLogo imageName:@"coverFile" successResponse:^(id data) {
        NSInteger status = [data[@"status"] integerValue];
        if(status == 1){
            [ZAlertView showSVProgressForSuccess:@"修改成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else if (status == 5){
            [ZAlertView showSVProgressForErrorStatus:@"时间冲突，请调整时间"];
        }else{
            [ZAlertView showSVProgressForErrorStatus:@"修改失败,请稍后再试"];
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"修改失败,请稍后再试"];
    }];
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
