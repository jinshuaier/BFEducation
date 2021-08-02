//
//  LiveShowViewController.m
//  LiveVideoCoreDemo
//
//  Created by Alex.Shi on 16/3/2.
//  Copyright © 2016年 com.Alex. All rights reserved.
//

#import "LiveShowViewController.h"
#import "UIButton+UserInfo.h"
#import "Dialogue.h"
#import "AGImagePickerController.h"
#import "NetworkRequest.h"
@interface LiveShowViewController()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UIView                     *innerView;
@property(strong, nonatomic) UIActivityIndicatorView    *activityIndicatorView;
@property(nonatomic, strong) UIView                     *AllBackGroudView;
@property(nonatomic, strong) UIButton                   *ExitButton;
@property(nonatomic, strong) UILabel                    *RtmpStatusLabel;
//@property(nonatomic, strong) UILabel                    *teacherName;
//@property(nonatomic, strong) UILabel                    *onLineUserNumber;
@property(nonatomic, strong) UIButton                   *CameraChangeButton;
@property(nonatomic, strong) UIButton                   *SoundChangeButton;
@property(nonatomic, strong) UIButton                   *beautyButton;
@property(nonatomic, strong) UIButton                   *chatButton;
@property(nonatomic, assign) Boolean                    bCameraFrontFlag;
@property(nonatomic, assign) NSInteger                  width;
@property(nonatomic, assign) NSInteger                  height;
@property(nonatomic, strong) UIView                     *focusBox;

@property(nonatomic, strong) UITextField                *chatTextField;
@property(nonatomic, strong) UIButton                   *sendButton;
@property(nonatomic, assign) CGFloat                    difference;

@property(nonatomic, strong) UITableView                *tableView;
@property(nonatomic,strong) NSMutableArray              *tableArray;
@property(nonatomic, copy) NSString                     *antename;
@property(nonatomic, copy) NSString                     *anteid;

//@property(nonatomic, assign) NSInteger                  onLineCount;
//@property(nonatomic, copy) NSString                     *publisherName;
@property(nonatomic,strong) UIFont                      *font;
@property(nonatomic,assign) BOOL                        isBeautiful;
@property(nonatomic,assign) BOOL                        isQuiet;
@property(nonatomic,strong) NSTimer                     *timer;

//@property(nonatomic,strong) NSString                    *publisherId;
//@property(nonatomic,strong) NSMutableDictionary         *onlineUsers;

@property(nonatomic,assign) BOOL                        waterMask;

@property(nonatomic,strong) NSMutableArray              *selectedPhotos;
@property(nonatomic,strong) UIButton                    *selectPhotoBtn;
@property(nonatomic,strong) UIButton                    *changePhotoBigBtn;
@property(nonatomic,strong) UIButton                    *closePhotosBtn;
@property(nonatomic,assign) int                         currentShowImageIndex;
@property(nonatomic,strong) UIImage                     *currentShowImage;
@property(nonatomic,strong) UIButton                    *backPhotoBtn;
@property(nonatomic,strong) UIButton                    *frontPhotoBtn;
@property(nonatomic,strong) UILabel                     *detailLabel;

@end

@implementation LiveShowViewController
{
    AGImagePickerController *ipc;
}

-(void) UIInit {
    float cleaRance = 12;
    float btnWidth = (_width - cleaRance * 8) / 7;
    if (self.IsHorizontal) {
        double fTmp = _height;
        _height = _width;
        _width = fTmp;
        cleaRance = (_width - 7 * btnWidth) / 8;
    }
    CGRect rect = CGRectMake(0, 0, _width, _height);
    self.view.backgroundColor = [UIColor blackColor];
    _AllBackGroudView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _width, _height)];
    [self.view addSubview:_AllBackGroudView];
    
    [[CCPushUtil sharedInstanceWithDelegate:self] setPreview:_AllBackGroudView];
    
    _RtmpStatusLabel = [self createLabelWithFrame:CGRectMake(_width - btnWidth - 15, _height - 100 + btnWidth + 3, btnWidth + 15, 28) text:@"未连接" font:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    _RtmpStatusLabel.hidden = YES;
    
    //    _teacherName = [self createLabelWithFrame:CGRectMake(_width - 140, 50, 120, 30) text:@"主播: " font:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    //    _onLineUserNumber = [self createLabelWithFrame:CGRectMake(_width - 140, 80, 120, 30) text:@"在线人数: " font:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    
    _chatButton = [self createButtonWith:CGRectMake(20,_height - btnWidth - 10, btnWidth, btnWidth) imageName:@"聊天" action:@selector(chatButtonClick)];
    
    _CameraChangeButton = [self createButtonWith:CGRectMake(cleaRance * 4 + btnWidth * 3, _height - btnWidth - 10, btnWidth, btnWidth) imageName:@"镜头反转" action:@selector(OnCameraChangeClicked:)];
    
    _SoundChangeButton = [self createButtonWith:CGRectMake(cleaRance * 5 + btnWidth * 4, _height - btnWidth - 10, btnWidth, btnWidth) imageName:@"声音开" action:@selector(soundChange)];
    [[CCPushUtil sharedInstanceWithDelegate:self] setMicGain:10];
    
    _beautyButton = [self createButtonWith:CGRectMake(cleaRance * 6 + btnWidth * 5,_height - btnWidth - 10, btnWidth, btnWidth) imageName:@"美颜" action:@selector(beautyFilter)];
    [[CCPushUtil sharedInstanceWithDelegate:self] setCameraBeautyFilterWithSmooth:0 white:0 pink:0];
    
    _ExitButton = [self createButtonWith:CGRectMake(cleaRance * 7 + btnWidth * 6, _height - btnWidth - 10, btnWidth, btnWidth) imageName:@"关闭" action:@selector(OnExitClicked)];
    
    _selectPhotoBtn = [self createButtonWith:CGRectMake(cleaRance * 7 + btnWidth * 6, _height - 2*btnWidth - 2*10, btnWidth, btnWidth) imageName:@"AGImagePickerController.bundle/photo" action:@selector(openAction:)];
    [_selectPhotoBtn setTitle:@"图片" forState:(UIControlStateNormal)];
    _closePhotosBtn = [self createButtonWith:CGRectMake(cleaRance * 7 + btnWidth * 6,  2*10, btnWidth, btnWidth) imageName:@"close" action:@selector(closePhotos:)];
    _closePhotosBtn.hidden = YES;
    [_closePhotosBtn setTitle:@"关闭图片" forState:(UIControlStateNormal)];
    _changePhotoBigBtn = [self createButtonWith:CGRectMake(cleaRance * 6 + btnWidth * 5,_height - 2*btnWidth - 2*10, btnWidth, btnWidth) imageName:@"AGImagePickerController.bundle/change" action:@selector(changePhotosBig:)];
    _changePhotoBigBtn.hidden = YES;
    [_changePhotoBigBtn setTitle:@"大小" forState:(UIControlStateNormal)];
    
    _backPhotoBtn = [self createButtonWith:CGRectMake(20, _height/2, btnWidth*2, btnWidth*2) imageName:@"AGImagePickerController.bundle/back" action:@selector(backImage)];
    _backPhotoBtn.hidden = YES;
    [_backPhotoBtn setTitle:@"背景" forState:(UIControlStateNormal)];
    _frontPhotoBtn = [self createButtonWith:CGRectMake(cleaRance * 7 + btnWidth * 5, _height/2, btnWidth*2, btnWidth*2) imageName:@"AGImagePickerController.bundle/back" action:@selector(frontImage)];
    _frontPhotoBtn.transform = CGAffineTransformMakeRotation(M_PI);
    _frontPhotoBtn.hidden = YES;
    [_frontPhotoBtn setTitle:@"前景" forState:(UIControlStateNormal)];
    
    self.detailLabel = [[UILabel alloc] init];
    [self.view addSubview:self.detailLabel];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dealSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    
    _focusBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    _focusBox.backgroundColor = [UIColor clearColor];
    _focusBox.layer.borderColor = [UIColor brownColor].CGColor;
    _focusBox.layer.borderWidth = 1.0f;
    _focusBox.hidden = YES;
    [self.view addSubview:_focusBox];
    
    //输入框
    _chatTextField = [[UITextField alloc] initWithFrame:CGRectMake(10,_height - 100,_width - 100,37)]; //初始化大小并自动释放
    _chatTextField.textColor = [UIColor blackColor];//设置textview里面的字体颜色
    _chatTextField.font = [UIFont systemFontOfSize:16];//设置字体名字和字体大小
    _chatTextField.delegate = self;//设置它的委托方法
    _chatTextField.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    _chatTextField.returnKeyType = UIReturnKeySend;//返回键的类型
    _chatTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _chatTextField.keyboardType = UIKeyboardTypeDefault;//键盘类型
    _chatTextField.placeholder = @" 请输入文字";
    _chatTextField.layer.masksToBounds = YES;
    _chatTextField.layer.cornerRadius = _chatTextField.frame.size.height / 2;
    _chatTextField.layer.borderColor = [[UIColor grayColor] CGColor];
    _chatTextField.layer.borderWidth = 0.6f;
    _chatTextField.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    [self.view addSubview:_chatTextField];//加入到整个页面中
    [_chatTextField setHidden:YES];
    
    //发送
    _sendButton = [[UIButton alloc]initWithFrame:CGRectMake(_width - 100 + 20, _height - 100,70 , 37)];
    [_sendButton setBackgroundColor:[UIColor colorWithRed:142/255.0 green:226/255.0 blue:211/255.0 alpha:1.0]];
    [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [_sendButton addTarget:self action:@selector(chatSendMessage) forControlEvents:UIControlEventTouchUpInside];
    _sendButton.layer.masksToBounds = YES;
    _sendButton.layer.cornerRadius = _sendButton.frame.size.height / 3;
    [self.view addSubview:_sendButton];
    [_sendButton setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10,_chatTextField.frame.origin.y + _chatTextField.frame.size.height - _height * 0.3, _width * 0.75, _height * 0.3) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _innerView = [[UIView alloc] initWithFrame:rect];
    _innerView.backgroundColor = [[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0];
    [self.view addSubview:_innerView];
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activityIndicatorView.center = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    [_activityIndicatorView startAnimating];
    [_innerView addSubview:_activityIndicatorView];
}

#pragma mark tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_chatTextField resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    } else {
        for(UIView *cellView in cell.subviews){
            [cellView removeFromSuperview];
        }
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Dialogue *dialogue = [_tableArray objectAtIndex:indexPath.row];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, dialogue.userNameSize.width, dialogue.userNameSize.height)];
    [button setTitle:dialogue.username forState:UIControlStateNormal];
    [button setFont:_font];
    [button setUserid:dialogue.userid];
    [button setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(antesomeone:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor clearColor]];
    [cell addSubview:button];
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:dialogue.msg];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = dialogue.userNameSize.width;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, dialogue.msgSize.height)];
    label.backgroundColor = [UIColor clearColor];
    label.font = _font;
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.attributedText = text;
    [cell addSubview:label];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Dialogue *dialogue = [_tableArray objectAtIndex:indexPath.row];
    return dialogue.msgSize.height + 10;
}

#pragma mark keyboard notification

- (void)keyboardWillShow:(NSNotification *)notif {
    
    NSDictionary *userInfo = [notif userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat y = keyboardRect.size.height;
    //    CGFloat x = keyboardRect.size.width;
    //    //NSLog(@"键盘高度是  %d",(int)y);
    //    //NSLog(@"键盘宽度是  %d",(int)x);
    _isBeautiful = false;
    _difference = 0.0;
    if ([_chatTextField isFirstResponder] == true && (self.height - (_chatTextField.frame.origin.y + 37 + 10) < y)) {
        self.difference = y - (self.height - (_chatTextField.frame.origin.y + 37 + 5));
        [UIView animateWithDuration:0.25f animations:^{
            [_chatTextField setHidden:NO];
            [_sendButton setHidden:NO];
//            _chatTextField.frame = CGRectMake(10, _chatTextField.frame.origin.y - self.difference, _width - 100,37);
//            _sendButton.frame = CGRectMake(_width - 100 + 20, _sendButton.frame.origin.y - self.difference,70 , 37);
            _tableView.frame = CGRectMake(10,_chatTextField.frame.origin.y - 5 - _height * 0.3, _width * 0.75, _height * 0.3);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notif {
    if (self.difference > 0) {
        [UIView animateWithDuration:0.25f animations:^{
            _chatTextField.frame = CGRectMake(10,_height - 100,_width - 100,37);
            [_chatTextField setHidden:YES];
            [_sendButton setHidden:YES];
            _sendButton.frame = CGRectMake(_width - 100 + 20, _height - 100,70 , 37);
            _tableView.frame = CGRectMake(10,_chatTextField.frame.origin.y + _chatTextField.frame.size.height - _height * 0.3, _width * 0.75, _height * 0.3);
        }];
        self.difference = 0;
    }
}

-(void)antesomeone:(UIButton *)sender {
    NSString *str = [sender titleForState:UIControlStateNormal];
    
    NSRange range = [str rangeOfString:@": "];
    if(range.location == NSNotFound) {
        _antename = str;
    } else {
        _antename = [str substringToIndex:range.location];
    }
    //    NSLog(@"str = %@,range = %@,_antename = %@",str,NSStringFromRange(range),_antename);
    _anteid = sender.userid;
    _chatTextField.text = [[@"@"stringByAppendingString:_antename]stringByAppendingString:@" "];
    [_chatTextField becomeFirstResponder];
}

-(void)chatSendMessage {
    NSString *str = _chatTextField.text;
    if(str == nil || str.length == 0) {
        return;
    }
    
    if([_antename length] == 0) {
        if([str length] == 0) return;
        [[CCPushUtil sharedInstanceWithDelegate:self] chatMessage:str];
    } else {
        NSString *subStr = [[@"@"stringByAppendingString:_antename] stringByAppendingString:@" "];
        NSRange range = [str rangeOfString:subStr];
        NSString *msgStr = [str substringFromIndex:(range.location + range.length)];
        //        NSLog(@"msgStr = %@,_anteid = %@",msgStr,_anteid);
        
        if([msgStr length] != 0) {
            [[CCPushUtil sharedInstanceWithDelegate:self]privateChatWithTouserid:_anteid msg:msgStr];
        }
        _antename = nil;
    }
    _chatTextField.text = nil;
    [_chatTextField resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self chatSendMessage];
    return YES;
}

-(UIButton *)createButtonWith:(CGRect)rect imageName:(NSString *)imageName action:(SEL)action {
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    return button;
}

-(UILabel *)createLabelWithFrame:(CGRect)rect text:(NSString *)text font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:rect];
    label.text = text;
    if(font) {
        label.font = font;
    }
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    return label;
}

- (ASValueTrackingSlider *)createSliderWithFrame:(CGRect)rect {
    ASValueTrackingSlider *slider = [[ASValueTrackingSlider alloc] initWithFrame:rect];
    slider.hidden = YES;
    slider.maximumValue = 10.0;
    slider.minimumValue = 0.0;
    slider.popUpViewCornerRadius = 4;
    [slider setMaxFractionDigitsDisplayed:0];
    slider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    slider.font = [UIFont fontWithName:@"GillSans-Bold" size:18];
    slider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
    slider.popUpViewWidthPaddingFactor = 1.7;
    slider.delegate = self;
    slider.value = 0.0;
    [self.view addSubview:slider];
    slider.dataSource = self;
    return slider;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self OnExitClicked];
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)chatButtonClick {
    [_chatTextField becomeFirstResponder];
}

- (void)beautyFilter {
    if(_isBeautiful) {
        [[CCPushUtil sharedInstanceWithDelegate:self] setCameraBeautyFilterWithSmooth:0 white:0 pink:0];
        [_beautyButton setImage:[UIImage imageNamed:@"美颜"] forState:UIControlStateNormal];
    } else {
        [[CCPushUtil sharedInstanceWithDelegate:self] setCameraBeautyFilterWithSmooth:0.5 white:0.5 pink:0.5];
        [_beautyButton setImage:[UIImage imageNamed:@"美颜"] forState:UIControlStateNormal];
    }
    _isBeautiful = !_isBeautiful;
}

-(void)soundChange {
    if(_isQuiet) {
        [[CCPushUtil sharedInstanceWithDelegate:self] setMicGain:10];
        [_SoundChangeButton setImage:[UIImage imageNamed:@"声音关"] forState:UIControlStateNormal];
    } else {
        [[CCPushUtil sharedInstanceWithDelegate:self] setMicGain:0];
        [_SoundChangeButton setImage:[UIImage imageNamed:@"声音开"] forState:UIControlStateNormal];
    }
    _isQuiet = !_isQuiet;
}

-(void)dealloc {
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    self.navigationController.navigationBarHidden = NO;
}


-(void) OnCameraChangeClicked:(id)sender{
    //    [[CCPushUtil sharedInstanceWithDelegate:self] addWaterMask:nil rect:CGRectZero];
    
    _bCameraFrontFlag = !_bCameraFrontFlag;
    [[CCPushUtil sharedInstanceWithDelegate:self] setCameraFront:_bCameraFrontFlag];
    
    if (self.waterMask)
    {
        UIImage *image = [UIImage imageNamed:@"3"];
        CGRect rect = CGRectMake(0, 0, image.size.width/2.f, image.size.height/2.f);
        [[CCPushUtil sharedInstanceWithDelegate:self] addWaterMask:image rect:rect];
    }
    
    if (self.selectedPhotos.count > 0)
    {
        UIImage *image = self.currentShowImage;
        [[CCPushUtil sharedInstanceWithDelegate:self] publishImage:image isBig:isBig];
    }
}

- (void)dealSingleTap:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self.view];
    if(CGRectContainsPoint(self.tableView.frame, point)) {
        [_chatTextField resignFirstResponder];
    } else {
        [self runBoxAnimationOnView:_focusBox point:point];
        printf("pointx:%f,pointy:%f",point.x,point.y);
        [[CCPushUtil sharedInstanceWithDelegate:self] focuxAtPoint:point];
    }
    
    [self addImage];
}

//对焦的动画效果
- (void)runBoxAnimationOnView:(UIView *)view point:(CGPoint)point {
    view.center = point;
    view.hidden = NO;
    [UIView animateWithDuration:0.2f
                          delay:0.2f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         view.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1.0);
                     }
                     completion:^(BOOL complete) {
                         double delayInSeconds = 1.0f;
                         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                         dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                             view.hidden = YES;
                             view.transform = CGAffineTransformIdentity;
                         });
                     }];
}

-(void) OnExitClicked {
    
    [self stopTimer];
    [[CCPushUtil sharedInstanceWithDelegate:self] stopPush];
    [CCPushUtil sharedInstanceWithDelegate:nil];
    
//    NSDictionary *dic = @{@"roomId":self.roomId};
//    [NetworkRequest requestWithUrl:EndLiveURL parameters:dic successResponse:^(id data) {
//        NSLog(@"请求成功,数据是:%@",data);
//    } failureResponse:^(NSError *error) {
//        NSLog(@"请求失败,原因是:%@",error);
//    }];
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if(self.IsHorizontal){
        bool bRet = ((toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft));
        return bRet;
    }else{
        return false;
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if(self.IsHorizontal){
        return UIInterfaceOrientationMaskLandscapeRight|UIInterfaceOrientationMaskLandscapeLeft;
    }else{
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _antename = GetFromUserDefaults(@"iNickName");
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(timerfunc) userInfo:nil repeats:YES];
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    self.navigationController.navigationBarHidden=YES;
    _width = self.view.frame.size.width;
    _height = self.view.frame.size.height;
    _bCameraFrontFlag = false;
    _isQuiet = false;
    _tableArray = [[NSMutableArray alloc] init];
    //    _onLineCount = 0;
    _font = [UIFont systemFontOfSize:18];
    
    [self UIInit];
    [[CCPushUtil sharedInstanceWithDelegate:self] startPushWithCameraFront:YES];
}

-(void) stopTimer {
    if([_timer isValid]) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value{
    [[CCPushUtil sharedInstanceWithDelegate:self] setMicGain:value/10.0];
    return nil;
}

- (void)timerfunc {
    [[CCPushUtil sharedInstanceWithDelegate:self] roomContext];
    [[CCPushUtil sharedInstanceWithDelegate:self] roomUserCount];
}

- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider {
    return;
}
/**
 *    @brief    正在连接网络，UI不可动
 */
- (void) isConnectionNetWork {
    _innerView.hidden = NO;
}
/**
 *    @brief    连接网络完成
 */
- (void) connectedNetWorkFinished {
    _innerView.hidden = YES;
}

/**
 *    @brief    设置连接状态
 */
- (void) setConnectionStatus:(NSInteger)status {
    switch (status) {
        case 1:
            _RtmpStatusLabel.text = @"正在连接";
            break;
        case 3:
            _RtmpStatusLabel.text = @"已连接";
            _innerView.hidden = YES;
            [self addImage];
            break;
        case 5:
            _RtmpStatusLabel.text = @"未连接";
            break;
        default:
            break;
    }
}

/**
 *    @brief    推流失败
 */
-(void)pushFailed:(NSError *)error reason:(NSString *)reason {
    NSString *message = nil;
    if (reason == nil) {
        message = [error localizedDescription];
    } else {
        message = reason;
    }
    _innerView.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"推流失败" message:[@"原因：" stringByAppendingString:message] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

/**
 *    @brief    点击开始推流按钮，获取liveid
 */
- (void) getLiveidBeforPush:(NSString *)liveid {
    //    NSLog(@"liveid = %@",liveid);
}

-(CGSize)getTitleSizeByFont:(NSString *)str width:(CGFloat)width font:(UIFont *)font {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, 20000.0f) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

- (void)on_private_chat:(NSString *)str {
    //    NSLog(@"on_private_chat = %@",str);
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    Dialogue *dialogue = [[Dialogue alloc] init];
    dialogue.fromuserid = dic[@"fromuserid"] ;
    dialogue.fromusername = dic[@"fromusername"];
    dialogue.fromuserrole = dic[@"fromuserrole"];
    
    dialogue.touserid = dic[@"touserid"];
    dialogue.tousername = dic[@"tousername"];
    
    dialogue.username = dialogue.fromusername;
    dialogue.userid = dialogue.fromuserid;
    
    dialogue.msg = [[[@" 对 " stringByAppendingString:dialogue.tousername] stringByAppendingString:@": "] stringByAppendingString:dic[@"msg"]];
    dialogue.time = dic[@"time"];
    
    dialogue.msgSize = [self getTitleSizeByFont:[dialogue.username stringByAppendingString:dialogue.msg] width:_tableView.frame.size.width font:_font];
    
    dialogue.userNameSize = [self getTitleSizeByFont:dialogue.username width:_tableView.frame.size.width font:_font];
    
    [_tableArray addObject:dialogue];
    
    if([_tableArray count] >= 1){
        [_tableView reloadData];
        NSIndexPath *indexPathLast = [NSIndexPath indexPathForItem:([_tableArray count]-1) inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPathLast atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

//- (void)private_question:(NSString *)str {
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
//
//    Dialogue *dialogue = [[Dialogue alloc] init];
//    dialogue.userid = dic[@"userid"];
//    dialogue.username = dic[@"username"];
//    dialogue.userrole = dic[@"userrole"];
//    dialogue.msg = [[[@" 对 "stringByAppendingString:@"我"] stringByAppendingString:@": "] stringByAppendingString:dic[@"msg"]];
//    dialogue.time = dic[@"time"];
//
//    dialogue.msgSize = [self getTitleSizeByFont:[dialogue.username stringByAppendingString:dialogue.msg] width:_tableView.frame.size.width font:_font];
//
//    dialogue.userNameSize = [self getTitleSizeByFont:dialogue.username width:_tableView.frame.size.width font:_font];
//
//    [_tableArray addObject:dialogue];
//
//    if([_tableArray count] >= 1){
//        [_tableView reloadData];
//        NSIndexPath *indexPathLast = [NSIndexPath indexPathForItem:([_tableArray count]-1) inSection:0];
//        [_tableView scrollToRowAtIndexPath:indexPathLast atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//    }
//}

- (void)on_chat_message:(NSString *)str {
        NSLog(@"on_chat_message = %@",str);
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
    Dialogue *dialogue = [[Dialogue alloc] init];
    dialogue.userid = dic[@"userid"];
    dialogue.username = [dic[@"username"] stringByAppendingString:@": "];
    dialogue.userrole = dic[@"userrole"];
    dialogue.msg = dic[@"msg"];
    dialogue.time = dic[@"time"];
    NSLog(@"用户昵称是%@ ---- 用户发言为%@ ---- 发言时间为%@",dialogue.username,dialogue.msg,dialogue.time);
    dialogue.msgSize = [self getTitleSizeByFont:[dialogue.username stringByAppendingString:dialogue.msg] width:_tableView.frame.size.width font:_font];
    
    dialogue.userNameSize = [self getTitleSizeByFont:dialogue.username width:_tableView.frame.size.width font:_font];
    
    [_tableArray addObject:dialogue];
    
    if([_tableArray count] >= 1){
        [_tableView reloadData];
        NSIndexPath *indexPathLast = [NSIndexPath indexPathForItem:([_tableArray count]-1) inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPathLast atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)room_user_count:(NSString *)str {
    //    _onLineCount = [str integerValue];
    //    NSLog(@"---str = %@",str);
}

- (void)receivePublisherId:(NSString *)str onlineUsers:(NSMutableDictionary *)dict {
    //    _publisherId = str;
    //    _onlineUsers = dict;
}

- (void)stopPushSuccessful {
    //    NSLog(@"退出推流成功！");
}


- (void)addImage
{
    /*
    if (self.waterMask)
    {
        //清除
        [[CCPushUtil sharedInstanceWithDelegate:self] addWaterMask:nil rect:CGRectZero];
    }
    else
    {
        //添加
        UIImage *image = [UIImage imageNamed:@"3"];
        CGRect rect = CGRectMake(0, 0, image.size.width/2.f, image.size.height/2.f);
        [[CCPushUtil sharedInstanceWithDelegate:self] addWaterMask:image rect:rect];
    }
    self.waterMask = !self.waterMask;
     */
}

- (void)customMessage:(NSString *)message {
    //        NSLog(@"message = %@",message);
}


#pragma mark - Public methods
static bool isBig = YES;
- (void)changePhotosBig:(UIButton *)sender
{
    isBig = !isBig;
    UIImage *image = self.currentShowImage;
    [[CCPushUtil sharedInstanceWithDelegate:self] publishImage:image isBig:isBig];
    if (self.waterMask)
    {
        UIImage *image = [UIImage imageNamed:@"3"];
        CGRect rect = CGRectMake(0, 0, image.size.width/2.f, image.size.height/2.f);
        [[CCPushUtil sharedInstanceWithDelegate:self] addWaterMask:image rect:rect];
    }
}

- (void)closePhotos:(UIButton *)sender
{
    sender.hidden = YES;
    _changePhotoBigBtn.hidden = YES;
    _frontPhotoBtn.hidden = YES;
    _backPhotoBtn.hidden = YES;
    _detailLabel.hidden = YES;
    //    CGImageRelease(self.currentShowImage.CGImage);
    //    self.currentShowImage = nil;
    self.currentShowImageIndex = 0;
    [self.selectedPhotos removeAllObjects];
    self.selectedPhotos = nil;
    isBig = NO;
    [[CCPushUtil sharedInstanceWithDelegate:self] addWaterMask:nil rect:CGRectZero];
    [[CCPushUtil sharedInstanceWithDelegate:self] clearPublishImage];
}

- (void)backImage
{
    if (self.currentShowImageIndex <= 0)
    {
        return;
    }
    self.currentShowImageIndex--;
    ALAsset *asset = [self.selectedPhotos objectAtIndex:self.currentShowImageIndex];
    ALAssetRepresentation *rep = asset.defaultRepresentation;
    CGImageRef imageRef = rep.fullScreenImage;
    UIImage *iamge = [UIImage imageWithCGImage:imageRef];
    self.currentShowImage = iamge;
    [[CCPushUtil sharedInstanceWithDelegate:self] publishImage:iamge isBig:isBig];
    [self updateDetailLabel];
}

- (void)frontImage
{
    if (self.currentShowImageIndex >= self.selectedPhotos.count - 1)
    {
        return;
    }
    self.currentShowImageIndex++;
    ALAsset *asset = [self.selectedPhotos objectAtIndex:self.currentShowImageIndex];
    ALAssetRepresentation *rep = asset.defaultRepresentation;
    CGImageRef imageRef = rep.fullScreenImage;
    UIImage *iamge = [UIImage imageWithCGImage:imageRef];
    self.currentShowImage = iamge;
    [[CCPushUtil sharedInstanceWithDelegate:self] publishImage:iamge isBig:isBig];
    [self updateDetailLabel];
}

- (void)updateDetailLabel
{
    NSString *detail = [NSString stringWithFormat:@"%d/%lu", self.currentShowImageIndex+1, (unsigned long)self.selectedPhotos.count];
    self.detailLabel.text = detail;
    [self.detailLabel sizeToFit];
    
    CGRect frame = self.detailLabel.frame;
    frame.origin.x = (self.view.frame.size.width - frame.size.width)/2.f;
    frame.origin.y = 20;
    self.detailLabel.frame = frame;
}

- (void)openAction:(id)sender
{
    self.selectedPhotos = [NSMutableArray array];
    ipc = [AGImagePickerController sharedInstance:self];
    
    __weak LiveShowViewController *blockSelf = self;
    ipc.didFailBlock = ^(NSError *error) {
        NSLog(@"Fail. Error: %@", error);
        
        if (error == nil) {
            [blockSelf.selectedPhotos removeAllObjects];
            NSLog(@"User has cancelled.");
            
            [blockSelf dismissViewControllerAnimated:YES completion:NULL];
        } else {
            
            // We need to wait for the view controller to appear first.
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [blockSelf dismissViewControllerAnimated:YES completion:NULL];
            });
        }
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
        
    };
    ipc.didFinishBlock = ^(NSArray *info) {
        if (info.count > 0)
        {
            blockSelf.closePhotosBtn.hidden = NO;
            blockSelf.changePhotoBigBtn.hidden = NO;
            blockSelf.frontPhotoBtn.hidden = NO;
            blockSelf.backPhotoBtn.hidden = NO;
            blockSelf.detailLabel.hidden = NO;
        }
        [blockSelf.selectedPhotos setArray:info];
        [blockSelf dismissViewControllerAnimated:YES completion:^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ALAsset *asset = blockSelf.selectedPhotos.firstObject;
                ALAssetRepresentation *rep = asset.defaultRepresentation;
                CGImageRef imageRef = rep.fullScreenImage;
                UIImage *iamge = [UIImage imageWithCGImage:imageRef];
                blockSelf.currentShowImageIndex = 0;
                blockSelf.currentShowImage = iamge;
                [blockSelf updateDetailLabel];
                [[CCPushUtil sharedInstanceWithDelegate:blockSelf] publishImage:iamge isBig:isBig];
                if (blockSelf.waterMask)
                {
                    UIImage *image = [UIImage imageNamed:@"3"];
                    CGRect rect = CGRectMake(0, 0, image.size.width/2.f, image.size.height/2.f);
                    [[CCPushUtil sharedInstanceWithDelegate:blockSelf] addWaterMask:image rect:rect];
                }
            });
        }];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    };
    // Show saved photos on top
    ipc.shouldShowSavedPhotosOnTop = NO;
    ipc.shouldChangeStatusBarStyle = YES;
    ipc.selection = self.selectedPhotos;
    ipc.maximumNumberOfPhotosToBeSelected = 9;
    ipc.modalPresentationStyle = 0;
    [self presentViewController:ipc animated:YES completion:NULL];
    
    [ipc showFirstAssetsController];
}

#pragma mark - AGImagePickerControllerDelegate methods

- (NSUInteger)agImagePickerController:(AGImagePickerController *)picker
         numberOfItemsPerRowForDevice:(AGDeviceType)deviceType
              andInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if (deviceType == AGDeviceTypeiPad)
    {
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
            return 11;
        else
            return 8;
    } else {
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation)) {
            if (480 == self.view.bounds.size.width) {
                return 6;
            }
            return 7;
        } else
            return 4;
    }
}

- (BOOL)agImagePickerController:(AGImagePickerController *)picker shouldDisplaySelectionInformationInSelectionMode:(AGImagePickerControllerSelectionMode)selectionMode
{
    return (selectionMode == AGImagePickerControllerSelectionModeSingle ? NO : YES);
}

- (BOOL)agImagePickerController:(AGImagePickerController *)picker shouldShowToolbarForManagingTheSelectionInSelectionMode:(AGImagePickerControllerSelectionMode)selectionMode
{
    return (selectionMode == AGImagePickerControllerSelectionModeSingle ? NO : YES);
}

- (AGImagePickerControllerSelectionBehaviorType)selectionBehaviorInSingleSelectionModeForAGImagePickerController:(AGImagePickerController *)picker
{
    return AGImagePickerControllerSelectionBehaviorTypeRadio;
}
@end

