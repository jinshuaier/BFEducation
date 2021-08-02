//
//  BFPublishViewController.m
//  Bf
//
//  Created by 春晓 on 2018/2/24.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFPublishViewController.h"
#import "CCPlayVideoController.h"
#import "LMWordView.h"
#import "LMSegmentedControl.h"
#import "LMStyleSettingsController.h"
#import "LMImageSettingsController.h"
#import "LMTextStyle.h"
#import "LMParagraphConfig.h"
#import "NSTextAttachment+LMText.h"
#import "UIFont+LMText.h"
#import "LMTextHTMLParser.h"

#define VideoViewHeight 150

@interface BFPublishViewController ()<UITextViewDelegate, UITextFieldDelegate, LMSegmentedControlDelegate, LMStyleSettingsControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIView *container;

@property (nonatomic, assign) CGFloat keyboardSpacingHeight;
@property (nonatomic, strong) LMSegmentedControl *contentInputAccessoryView;

@property (nonatomic, readonly) UIStoryboard *lm_storyboard;
@property (nonatomic, strong) LMStyleSettingsController *styleSettingsViewController;
@property (nonatomic, strong) LMImageSettingsController *imageSettingsViewController;


@property (nonatomic, assign) CGFloat inputViewHeight;

@property (nonatomic, strong) LMTextStyle *currentTextStyle;
@property (nonatomic, strong) LMParagraphConfig *currentParagraphConfig;


// ========
//视频缩略图
@property (nonatomic,strong) UIImage *image;
/*视频路径*/
@property (nonatomic,strong) NSString *videoUrl;
/*上传视频路径*/
@property (nonatomic,copy) NSString *videoPath;
// videoImageView
@property (nonatomic , strong) UIImageView *videoImageView;
// videoPlayView
@property (nonatomic , strong) UIImageView *videoPlayView;
// videoView
@property (nonatomic , strong) UIView *videoView;
//
@property (nonatomic , strong) UIScrollView *scView;

@property (strong, nonatomic)DWUploadItem *uploadItem;
/*视频id*/
@property (nonatomic,copy) NSString *videoIdStr;

// 图片地址数组
@property (nonatomic , strong) NSMutableArray *imageArray;
// 图片地址数组
@property (nonatomic , strong) NSMutableArray *imagePathArray;
// 纯文本
@property (nonatomic , strong) NSMutableString *textStr;
// HTML文本
@property (nonatomic , strong) NSString *content;
@end

@implementation BFPublishViewController{
    NSRange _lastSelectedRange;
    BOOL _keepCurrentTextStyle;
    NSInteger imageORVideo; // 0是纯文字 1图片 2有视频
    BOOL isLayoutVideo; // 是否已经布局视频z
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self addVideoFileToUpload];
    
//    [MobClick beginLogPageView:@"发布帖子页"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"发布帖子页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _container = [[UIView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:_container];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNavgationButton];
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *items = @[
                       [UIImage imageNamed:@"publishImage"],
                       [UIImage imageNamed:@"publishVideo"]
                       ];
    _contentInputAccessoryView = [[LMSegmentedControl alloc] initWithItems:items];
    _contentInputAccessoryView.delegate = self;
    _contentInputAccessoryView.changeSegmentManually = YES;
    
    _textView = [[LMWordView alloc] init];
    _textView.delegate = self;
    _textView.titleTextField.delegate = self;
    [self.view addSubview:_textView];
    CGRect rect = self.view.bounds;
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
    CGFloat textViewY = rectOfNavigationbar.size.height + rectOfStatusbar.size.height;
    rect.origin.y = textViewY;
    rect.size.height -= textViewY;
    rect.origin.x += 10;
    rect.size.width -= 20;
    _textView.frame = rect;
    
    _textView.layer.borderWidth = 0.5;
    _textView.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:1].CGColor;
    
    [self setCurrentParagraphConfig:[[LMParagraphConfig alloc] init]];
    [self setCurrentTextStyle:[LMTextStyle textStyleWithType:LMTextStyleFormatNormal]];
    [self updateParagraphTypingAttributes];
    [self updateTextStyleTypingAttributes];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    //预览视频之后删除视频的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteVideo) name:@"deleteVideo" object:nil];
    
    [_contentInputAccessoryView addTarget:self action:@selector(changeTextInputView:) forControlEvents:UIControlEventValueChanged];
}


-(void)createNavgationButton {
    //设置返回按钮
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setTitle:@"取消" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont fontWithName:BFfont size:16.0f];
    [backButton setTitleColor:RGBColor(51, 51, 51) forState:UIControlStateNormal];
    [backButton sizeToFit];
    [backButton addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    //设置导航栏右侧按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"发布" forState:UIControlStateNormal];
    btn1.backgroundColor = RGBColor(41, 127, 225);
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [btn1 setFrame:CGRectMake(0, 0, 55, 25)];
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 5;
    [btn1 addTarget:self action:@selector(clickPublishBtn) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    self.navigationItem.rightBarButtonItems = @[item1];
}

- (void)clickBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickPublishBtn{
    _content = [self exportHTML];
    if (self.textView.titleTextField.text == nil || [self.textView.titleTextField.text isEqualToString:@""]) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入帖子标题"];
    }
    else if (self.textView.titleTextField.text.length < 6) {
        [ZAlertView showSVProgressForErrorStatus:@"帖子标题最少6个字"];
    }
    else if (self.textStr.length < 16) {
        [ZAlertView showSVProgressForErrorStatus:@"帖子内容最少16个字"];
    }
    else if (self.textStr == nil || [self.textStr isEqualToString:@""] || [self.textStr isEqualToString:@"这里输入详细的描述,附加图片更易于交流哦"]) {
        [ZAlertView showSVProgressForErrorStatus:@"请输入帖子内容"];
    }else if (self.textStr.length > 30000) {
        [ZAlertView showSVProgressForErrorStatus:@"帖子内容最多3万个字"];
    }
    else {
        [ZAlertView showSVProgressNotClickForStr:@"正在发布中"];
        
        if (self.image != nil) {
            [self videoUploadStatusButtonAction];
        }
        else {
            [self uploadOtherPara];
        }
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    [self layoutTextView];
    CGRect rect = self.view.bounds;
    rect.size.height = 40.f;
    self.contentInputAccessoryView.frame = rect;
}

- (void)layoutTextView {
    CGRect rect = self.view.bounds;
    rect.origin.y = [self.topLayoutGuide length];
    rect.size.height -= rect.origin.y;
    if (imageORVideo == 2) {
        [self.view addSubview:self.videoView];
        if (!isLayoutVideo) {
            rect.size.height -= (VideoViewHeight + 20);
            isLayoutVideo = YES;
            self.textView.frame = rect;
        }
    }else{
        if (isLayoutVideo) {
            [self.videoView removeFromSuperview];
            rect.size.height += (VideoViewHeight + 20);
            isLayoutVideo = NO;
            self.textView.frame = rect;
        }
    }
    
    UIEdgeInsets insets = self.textView.contentInset;
    insets.bottom = self.keyboardSpacingHeight;
    self.textView.contentInset = insets;
}

- (void)layoutVideoView{
    [self.view addSubview:self.videoView];
    CGRect rect = self.textView.frame;
    rect.size.height -= (VideoViewHeight + 20);
    self.textView.frame = rect;
}

#pragma mark -lazy-
- (UIView *)videoView{
    if (!_videoView) {
        _videoView = [[UIView alloc] initWithFrame:CGRectMake(20, self.view.height - VideoViewHeight - 10, KScreenW - 40, VideoViewHeight)];
        _videoView.layer.masksToBounds = YES;
        _videoView.layer.cornerRadius = 5;
        [_videoView addSubview:self.videoImageView];
        [_videoView addSubview:self.videoPlayView];
        _videoPlayView.center = CGPointMake(_videoView.width / 2.0, _videoView.height / 2.0);
        _videoView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPlayVideo)];
        [_videoView addGestureRecognizer:tap];
    }
    return _videoView;
}

- (UIImageView *)videoImageView{
    if (!_videoImageView) {
        _videoImageView = [[UIImageView alloc] initWithFrame:self.videoView.bounds];
        _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
        _videoImageView.clipsToBounds = YES;
        
    }
    return _videoImageView;
}

- (UIImageView *)videoPlayView{
    if (!_videoPlayView) {
        _videoPlayView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        _videoPlayView.image = [UIImage imageNamed:@"视频-2"];
        _videoPlayView.userInteractionEnabled = NO;
    }
    return _videoPlayView;
}

- (NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

#pragma mark - 点击跳转到视频播放页面
-(void)clickPlayVideo {
    CCPlayVideoController *liveVC = [[CCPlayVideoController alloc] init];
    liveVC.videoUrl = [NSString stringWithFormat:@"file://%@",self.videoPath];
    UINavigationController * navigation = [[UINavigationController alloc] initWithRootViewController:liveVC];
    navigation.modalPresentationStyle = 0;
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - 删除视频的通知事件

-(void)deleteVideo {
    imageORVideo = 1;
    [_videoView removeFromSuperview];
    [self layoutTextView];
}

#pragma mark - Keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    if (self.keyboardSpacingHeight == keyboardSize.height) {
        return;
    }
    self.keyboardSpacingHeight = keyboardSize.height;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self layoutTextView];
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if (self.keyboardSpacingHeight == 0) {
        return;
    }
    self.keyboardSpacingHeight = 0;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self layoutTextView];
    } completion:nil];
}

-(void)loadView {
    _scView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    if(@available(iOS 11, *)) {
        _scView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view = _scView;
}

#pragma mark - <UITextViewDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length == 0) {
        textField.text = textField.placeholder;
    }
    self.textView.editable = NO;
    [textField resignFirstResponder];
    self.textView.editable = YES;
    return YES;
}

#pragma mark - <UITextViewDelegate>

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    [self.contentInputAccessoryView setSelectedSegmentIndex:0 animated:NO];
    _textView.inputAccessoryView = self.contentInputAccessoryView;
    [self.imageSettingsViewController reload];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    _textView.inputAccessoryView = nil;
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    
    if (_lastSelectedRange.location != textView.selectedRange.location) {
        
        if (_keepCurrentTextStyle) {
            // 如果当前行的内容为空，TextView 会自动使用上一行的 typingAttributes，所以在删除内容时，保持 typingAttributes 不变
            [self updateTextStyleTypingAttributes];
            [self updateParagraphTypingAttributes];
            _keepCurrentTextStyle = NO;
        }
        else {
            self.currentTextStyle = [self textStyleForSelection];
            self.currentParagraphConfig = [self paragraphForSelection];
            [self updateTextStyleTypingAttributes];
            [self updateParagraphTypingAttributes];
            [self reloadSettingsView];
        }
    }
    _lastSelectedRange = textView.selectedRange;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (range.location == 0 && range.length == 0 && text.length == 0) {
        // 光标在第一个位置时，按下退格键，则删除段落设置
        self.currentParagraphConfig.indentLevel = 0;
        [self updateParagraphTypingAttributes];
    }
    _lastSelectedRange = NSMakeRange(range.location + text.length - range.length, 0);
    if (text.length == 0 && range.length > 0) {
        _keepCurrentTextStyle = YES;
    }
    return YES;
}

#pragma mark - Change InputView

- (void)lm_segmentedControl:(LMSegmentedControl *)control didTapAtIndex:(NSInteger)index {
    
    //    if (index == control.numberOfSegments - 1) {
    //        [self.textView resignFirstResponder];
    //        return;
    //    }
    //    if (index != control.selectedSegmentIndex) {
    //        [control setSelectedSegmentIndex:index animated:YES];
    //    }
    
    [self.textView resignFirstResponder];
    
    if (index == 0) {
        ZQDialogueViewController *controller = [[ZQDialogueViewController alloc] initWithActions:@[@"拍照",@"从本地选择"] block:^(int index) {
            if (index == 0) {
                //点击取消的响应事件
            }
            else if(index == 1) {
                //拍照
                if (imageORVideo != 2) {
                    imageORVideo = 1;
                }
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.delegate = self;
                picker.modalPresentationStyle = 0;
                [self presentViewController:picker animated:YES completion:nil];
            }
            else if (index == 2) {
                //从本地选择
                if (imageORVideo != 2) {
                    imageORVideo = 1;
                }
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.delegate = self;
                picker.modalPresentationStyle = 0;
                [self presentViewController:picker animated:YES completion:nil];
            }
            else {
            }
        }];
        [controller show];
    }else if (index == 1){
        ZQDialogueViewController *controller = [[ZQDialogueViewController alloc] initWithActions:@[@"从本地选择"] block:^(int index) {
            if (index == 0) {
                //点击取消的响应事件
            }
            else if (index == 1) {
                //从本地选择
                imageORVideo = 2;
                DWVideoCompressController *imagePicker = [[DWVideoCompressController alloc] initWithQuality: DWUIImagePickerControllerQualityTypeMedium andSourceType:DWUIImagePickerControllerSourceTypePhotoLibrary andMediaType:DWUIImagePickerControllerMediaTypeMovie];
                imagePicker.delegate = self;
                imagePicker.modalPresentationStyle = 0;
                [self presentViewController:imagePicker animated:NO completion:nil];
            }
            else {
            }
        }];
        [controller show];
    }
}

- (UIStoryboard *)lm_storyboard {
    static dispatch_once_t onceToken;
    static UIStoryboard *storyboard;
    dispatch_once(&onceToken, ^{
        storyboard = [UIStoryboard storyboardWithName:@"LMWord" bundle:nil];
    });
    return storyboard;
}

- (LMStyleSettingsController *)styleSettingsViewController {
    if (!_styleSettingsViewController) {
        _styleSettingsViewController = [self.lm_storyboard instantiateViewControllerWithIdentifier:@"style"];
        _styleSettingsViewController.textStyle = self.currentTextStyle;
        _styleSettingsViewController.delegate = self;
    }
    return _styleSettingsViewController;
}

- (LMImageSettingsController *)imageSettingsViewController {
    if (!_imageSettingsViewController) {
        _imageSettingsViewController = [self.lm_storyboard instantiateViewControllerWithIdentifier:@"image"];
        //        _imageSettingsViewController.delegate = self;
    }
    return _imageSettingsViewController;
}

- (void)changeTextInputView:(LMSegmentedControl *)control {
    
    CGRect rect = self.view.bounds;
    rect.size.height = self.keyboardSpacingHeight - CGRectGetHeight(self.contentInputAccessoryView.frame);
    switch (control.selectedSegmentIndex) {
        case 1:
        {
            UIView *inputView = [[UIView alloc] initWithFrame:rect];
            self.styleSettingsViewController.view.frame = rect;
            [inputView addSubview:self.styleSettingsViewController.view];
            self.textView.inputView = inputView;
            break;
        }
        case 2:
        {
            UIView *inputView = [[UIView alloc] initWithFrame:rect];
            self.imageSettingsViewController.view.frame = rect;
            [inputView addSubview:self.imageSettingsViewController.view];
            self.textView.inputView = inputView;
            break;
        }
        default:
            self.textView.inputView = nil;
            break;
    }
    [self.textView reloadInputViews];
}

#pragma mark - settings

// 刷新设置界面
- (void)reloadSettingsView {
    
    self.styleSettingsViewController.textStyle = self.currentTextStyle;
    [self.styleSettingsViewController setParagraphConfig:self.currentParagraphConfig];
    [self.styleSettingsViewController reload];
}

- (LMTextStyle *)textStyleForSelection {
    
    LMTextStyle *textStyle = [[LMTextStyle alloc] init];
    UIFont *font = self.textView.typingAttributes[NSFontAttributeName];
    textStyle.bold = font.bold;
    textStyle.italic = font.italic;
    textStyle.fontSize = font.fontSize;
    textStyle.textColor = self.textView.typingAttributes[NSForegroundColorAttributeName] ?: textStyle.textColor;
    if (self.textView.typingAttributes[NSUnderlineStyleAttributeName]) {
        textStyle.underline = [self.textView.typingAttributes[NSUnderlineStyleAttributeName] integerValue] == NSUnderlineStyleSingle;
    }
    return textStyle;
}

- (LMParagraphConfig *)paragraphForSelection {
    
    NSParagraphStyle *paragraphStyle = self.textView.typingAttributes[NSParagraphStyleAttributeName];
    LMParagraphType type = [self.textView.typingAttributes[LMParagraphTypeName] integerValue];
    LMParagraphConfig *paragraphConfig = [[LMParagraphConfig alloc] initWithParagraphStyle:paragraphStyle type:type];
    return paragraphConfig;
}

// 获取所有选中的段落，通过"\n"来判断段落。
- (NSArray *)rangesOfParagraphForCurrentSelection {
    
    NSRange selection = self.textView.selectedRange;
    NSInteger location;
    NSInteger length;
    
    NSInteger start = 0;
    NSInteger end = selection.location;
    NSRange range = [self.textView.text rangeOfString:@"\n"
                                              options:NSBackwardsSearch
                                                range:NSMakeRange(start, end - start)];
    location = (range.location != NSNotFound) ? range.location + 1 : 0;
    
    start = selection.location + selection.length;
    end = self.textView.text.length;
    range = [self.textView.text rangeOfString:@"\n"
                                      options:0
                                        range:NSMakeRange(start, end - start)];
    length = (range.location != NSNotFound) ? (range.location + 1 - location) : (self.textView.text.length - location);
    
    range = NSMakeRange(location, length);
    NSString *textInRange = [self.textView.text substringWithRange:range];
    NSArray *components = [textInRange componentsSeparatedByString:@"\n"];
    
    NSMutableArray *ranges = [NSMutableArray array];
    for (NSInteger i = 0; i < components.count; i++) {
        NSString *component = components[i];
        if (i == components.count - 1) {
            if (component.length == 0) {
                break;
            }
            else {
                [ranges addObject:[NSValue valueWithRange:NSMakeRange(location, component.length)]];
            }
        }
        else {
            [ranges addObject:[NSValue valueWithRange:NSMakeRange(location, component.length + 1)]];
            location += component.length + 1;
        }
    }
    if (ranges.count == 0) {
        return nil;
    }
    return ranges;
}

- (void)updateTextStyleTypingAttributes {
    NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
    typingAttributes[NSFontAttributeName] = self.currentTextStyle.font;
    typingAttributes[NSForegroundColorAttributeName] = self.currentTextStyle.textColor;
    typingAttributes[NSUnderlineStyleAttributeName] = @(self.currentTextStyle.underline ? NSUnderlineStyleSingle : NSUnderlineStyleNone);
    self.textView.typingAttributes = typingAttributes;
}

- (void)updateParagraphTypingAttributes {
    NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
    typingAttributes[LMParagraphTypeName] = @(self.currentParagraphConfig.type);
    typingAttributes[NSParagraphStyleAttributeName] = self.currentParagraphConfig.paragraphStyle;
    self.textView.typingAttributes = typingAttributes;
}

- (void)updateTextStyleForSelection {
    if (self.textView.selectedRange.length > 0) {
        [self.textView.textStorage addAttributes:self.textView.typingAttributes range:self.textView.selectedRange];
    }
}

- (void)updateParagraphForSelectionWithKey:(NSString *)key {
    NSRange selectedRange = self.textView.selectedRange;
    NSArray *ranges = [self rangesOfParagraphForCurrentSelection];
    if (!ranges) {
        if (self.currentParagraphConfig.type == 0) {
            NSMutableDictionary *typingAttributes = [self.textView.typingAttributes mutableCopy];
            typingAttributes[NSParagraphStyleAttributeName] = self.currentParagraphConfig.paragraphStyle;
            self.textView.typingAttributes = typingAttributes;
            return;
        }
        ranges = @[[NSValue valueWithRange:NSMakeRange(0, 0)]];
    }
    NSInteger offset = 0;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    for (NSValue *rangeValue in ranges) {
        
        NSRange range = NSMakeRange(rangeValue.rangeValue.location + offset, rangeValue.rangeValue.length);
        LMParagraphType type;
        if ([key isEqualToString:LMParagraphTypeName]) {
            
            type = self.currentParagraphConfig.type;
            if (self.currentParagraphConfig.type == LMParagraphTypeNone) {
                [attributedText deleteCharactersInRange:NSMakeRange(range.location, 1)];
                offset -= 1;
            }
            else {
                NSTextAttachment *textAttachment = [NSTextAttachment checkBoxAttachment];
                NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
                [attributedString addAttributes:self.textView.typingAttributes range:NSMakeRange(0, 1)];
                [attributedText insertAttributedString:attributedString atIndex:range.location];
                offset += 1;
            }
            //            switch (self.currentParagraphConfig.type) {
            //                case LMParagraphTypeNone:
            //
            //                    break;
            //                case LMParagraphTypeNone:
            //
            //                    break;
            //                case LMParagraphTypeNone:
            //
            //                    break;
            //                case LMParagraphTypeNone:
            //
            //                    break;
            //            }
        }
        else {
            [attributedText addAttribute:NSParagraphStyleAttributeName value:self.currentParagraphConfig.paragraphStyle range:range];
        }
    }
    if (offset > 0) {
        _keepCurrentTextStyle = YES;
        selectedRange = NSMakeRange(selectedRange.location + 1, selectedRange.length + offset - 1);
    }
    self.textView.allowsEditingTextAttributes = YES;
    self.textView.attributedText = attributedText;
    self.textView.allowsEditingTextAttributes = NO;
    self.textView.selectedRange = selectedRange;
}

- (NSTextAttachment *)insertImage:(UIImage *)image {
    // textView 默认会有一些左右边距
    CGFloat width = CGRectGetWidth(self.textView.frame) - (self.textView.textContainerInset.left + self.textView.textContainerInset.right + 12.f);
    NSTextAttachment *textAttachment = [NSTextAttachment attachmentWithImage:image width:width];
    NSAttributedString *attachmentString = [NSAttributedString attributedStringWithAttachment:textAttachment];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    [attributedString insertAttributedString:attachmentString atIndex:0];
    if (_lastSelectedRange.location != 0 &&
        ![[self.textView.text substringWithRange:NSMakeRange(_lastSelectedRange.location - 1, 1)] isEqualToString:@"\n"]) {
        // 上一个字符不为"\n"则图片前添加一个换行 且 不是第一个位置
        [attributedString insertAttributedString:[[NSAttributedString alloc] initWithString:@"\n"] atIndex:0];
    }
    [attributedString addAttributes:self.textView.typingAttributes range:NSMakeRange(0, attributedString.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    paragraphStyle.paragraphSpacingBefore = 8.f;
    paragraphStyle.paragraphSpacing = 8.f;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    [attributedText replaceCharactersInRange:_lastSelectedRange withAttributedString:attributedString];
    self.textView.allowsEditingTextAttributes = YES;
    self.textView.attributedText = attributedText;
    self.textView.allowsEditingTextAttributes = NO;
    
    return textAttachment;
}

#pragma mark - <LMStyleSettingsControllerDelegate>

- (void)lm_didChangedTextStyle:(LMTextStyle *)textStyle {
    
    self.currentTextStyle = textStyle;
    [self updateTextStyleTypingAttributes];
    [self updateTextStyleForSelection];
}

- (void)lm_didChangedParagraphIndentLevel:(NSInteger)level {
    
    self.currentParagraphConfig.indentLevel += level;
    
    NSRange selectedRange = self.textView.selectedRange;
    NSArray *ranges = [self rangesOfParagraphForCurrentSelection];
    if (ranges.count <= 1) {
        [self updateParagraphForSelectionWithKey:LMParagraphIndentName];
    }
    else {
        self.textView.allowsEditingTextAttributes = YES;
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
        for (NSValue *rangeValue in ranges) {
            NSRange range = rangeValue.rangeValue;
            self.textView.selectedRange = range;
            LMParagraphConfig *paragraphConfig = [self paragraphForSelection];
            paragraphConfig.indentLevel += level;
            [attributedText addAttribute:NSParagraphStyleAttributeName value:paragraphConfig.paragraphStyle range:range];
        }
        self.textView.attributedText = attributedText;
        self.textView.allowsEditingTextAttributes = NO;
        self.textView.selectedRange = selectedRange;
    }
    [self updateParagraphTypingAttributes];
}

- (void)lm_didChangedParagraphType:(NSInteger)type {
    //    self.currentParagraphConfig.type = type;
    //
    //    [self updateParagraphTypingAttributes];
    //    [self updateParagraphForSelectionWithKey:LMParagraphTypeName];
}

#pragma mark -UIImagePickerControllerDelegate-

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    if ([[info objectForKey:UIImagePickerControllerMediaType] isEqualToString:@"public.image"]) {
        // 获取照片
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        CGSize targetSize = [UIScreen mainScreen].bounds.size;
        targetSize.width *= 2;
        targetSize.height = targetSize.width * originalImage.size.height / originalImage.size.width;
        
        UIGraphicsBeginImageContext(targetSize);
        [originalImage drawInRect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [self lm_imageSettingsInsertImage:scaledImage];
    }
    else {
        loginfo(@"info: %@", info);
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        self.videoPath = [videoURL path];
        loginfo(@"moviePath: %@", self.videoPath);
        [picker dismissViewControllerAnimated:YES completion:nil];
        NSURL *u = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",self.videoPath]];
        //        self.videoPath = [NSString stringWithContentsOfURL:u];
        //获取视频缩略图
        self.image = [self thumbnailImageForVideo:u atTime:0.5];
        NSLog(@"self.image : %@",self.image);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self layoutTextView];
            self.videoImageView.image = self.image;
            //            _imgView.frame = CGRectMake(10, _contentField.bottom + 10, KScreenW - 20, 162);
            //            [_videoBtn setBackgroundColor:[UIColor clearColor]];
            //            [_imgView setContentMode:UIViewContentModeScaleAspectFill];
            //            _imgView.clipsToBounds = YES;
            //            _imgView.userInteractionEnabled = YES;
            //            _imgView.image = self.image;
            //            _photoBtn.frame = CGRectMake(0, _imgView.bottom + 10, KScreenW, 50);
            //            NSLog(@"此时图片个数为:%ld",self.thumbnailImageArray.count);
            //            if (self.thumbnailImageArray.count == 0) {
            //                self.photoView.frame = CGRectMake(0,KScreenH, KScreenW, KScreenW);
            //            }
            //            else {
            //                self.photoView.frame = CGRectMake(10, self.photoBtn.originY, KScreenW - 20, KScreenW);
            //                self.photoBtn.backgroundColor = [UIColor clearColor];
            //            }
        });
        
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)lm_imageSettingsPresentPreview:(UIViewController *)previewController {
    previewController.modalPresentationStyle = 0;
    [self presentViewController:previewController animated:YES completion:nil];
}

- (void)lm_imageSettingsInsertImage:(UIImage *)image {
    
    // 降低图片质量用于流畅显示，将原始图片存入到 Document 目录下，将图片文件 URL 与 Attachment 绑定。
    float actualWidth = image.size.width * image.scale;
    float boundsWidth = CGRectGetWidth(self.view.bounds) - 8.f * 2;
    float compressionQuality = boundsWidth / actualWidth;
    if (compressionQuality > 1) {
        compressionQuality = 1;
    }
    NSData *degradedImageData = UIImageJPEGRepresentation(image, compressionQuality);
    UIImage *degradedImage = [UIImage imageWithData:degradedImageData];
    
    NSTextAttachment *attachment = [self insertImage:degradedImage];
    [self.textView resignFirstResponder];
    [self.textView scrollRangeToVisible:_lastSelectedRange];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 实际应用时候可以将存本地的操作改为上传到服务器，URL 也由本地路径改为服务器图片地址。
        NSURL *documentDir = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                    inDomain:NSUserDomainMask
                                                           appropriateForURL:nil
                                                                      create:NO
                                                                       error:nil];
        NSURL *filePath = [documentDir URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", [NSDate date].description]];
        NSData *originImageData = UIImagePNGRepresentation(image);
        if ([originImageData writeToFile:filePath.path atomically:YES]) {
            attachment.attachmentType = LMTextAttachmentTypeImage;
            attachment.userInfo = filePath;
        }
    });
}

- (void)lm_imageSettingsPresentImagePickerView:(UIViewController *)picker {
    picker.modalPresentationStyle = 0;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - 获取视频的缩略图

-(UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    return thumbnailImage;
}

# pragma mark - processer

- (void)addVideoFileToUpload {
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *videoTitle = self.textView.titleTextField.text;
    NSString *videoTag = @"北方职教";
    //    NSString *videoDescription = self.contentField.text;
    
    DWUploadItem *item = [[DWUploadItem alloc] init];
    item.videoUploadStatus = DWUploadStatusWait;
    item.videoPath = self.videoPath;
    item.videoTitle = videoTitle;
    item.videoTag = videoTag;
    //    item.videoDescripton = videoDescription;
    item.videoUploadProgress = 0.0f;
    item.videoUploadedSize = 0;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:self.videoPath]) {
        item.videoUploadStatus = DWUploadStatusLoadLocalFileInvalid;
        goto done;
    }
    
    // 文件不存在则不设置
    item.videoThumbnailPath = [NSString stringWithFormat:@"%@/%@.png", documentDirectory, videoTitle];
    [DWTools saveVideoThumbnailWithVideoPath:self.videoPath toFile:item.videoThumbnailPath Error:&error];
    if (error) {
        item.videoUploadStatus = DWUploadStatusLoadLocalFileInvalid;
        loginfo(@"save thumbnail %@ failed: %@", self.videoPath, [error localizedDescription]);
        goto done;
    }
    
    item.videoFileSize = [DWTools getFileSizeWithPath:self.videoPath Error:&error];
    if (error) {
        item.videoUploadStatus = DWUploadStatusLoadLocalFileInvalid;
        loginfo(@"get videoPath %@ failed: %@", self.videoPath, [error localizedDescription]);
        item.videoFileSize = 0;
        goto done;
    }
    
done:
    self.uploadItem = item;
    logdebug(@"add item: %@", item);
}

#pragma mark - upload

- (void)videoUploadStatusButtonAction
{
    DWUploadItem *item = self.uploadItem;
    NSLog(@"item为:%@",item);
    switch (item.videoUploadStatus) {
        case DWUploadStatusWait:
            // 状态转为 开始上传
            [self videoUploadStartWithItem:item];
            break;
            
        case DWUploadStatusStart:
            // 状态转为 暂停上传
            [self videoUploadPauseWithItem:item];
            break;
            
        case DWUploadStatusUploading:
            // 状态转为 暂停上传
            [self videoUploadPauseWithItem:item];
            break;
            
        case DWUploadStatusPause:
            // 状态转为 开始上传
            
            [self videoUploadResumeWithItem:item];
            break;
            
        case DWUploadStatusResume:
            // 状态转为 暂停上传
            
            [self videoUploadPauseWithItem:item];
            break;
            
        case DWUploadStatusLoadLocalFileInvalid:
            // 报警 告知用户 "本地文件不存在，删除任务重新添加文件"
            [self videoUploadFailedAlert:@"本地文件不存在，删除任务重新添加文件"];
            break;
            
        case DWUploadStatusFail:
            // 状态转为 继续上传
            
            [self videoUploadResumeWithItem:item];
            break;
            
        case DWUploadStatusFinish:
            // 在 DWUploadStatusStart 和 DWUploadStatusResume 状态中
            // 如果上传完成，则至 cell.statusButton.userInteractionEnabled = NO 不在接收交互事件。
            // 所以这里不需要做处理。
            break;
            
        default:
            break;
    }
}

- (void)videoUploadFailedAlert:(NSString *)info
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                    message:info
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)setUploadBlockWithItem:(DWUploadItem *)item
{
    DWUploader *uploader = item.uploader;
    
    uploader.progressBlock = ^(float progress, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
        item.videoUploadProgress = progress;
        [ZAlertView showSVProgressNotClickForStr:[NSString stringWithFormat:@"上传进度:%2.0f%%", progress * 100]];
        item.videoUploadedSize = totalBytesWritten;
        NSString *str = [NSString stringWithFormat:@"%f",progress];
        int intStr = [str intValue];
        if (intStr == 1) {
            [self uploadOtherPara];
        }
    };
    
    uploader.finishBlock = ^() {
        loginfo(@"finish");
        item.videoUploadStatus = DWUploadStatusFinish;
        
    };
    
    uploader.failBlock = ^(NSError *error) {
        loginfo(@"error: %@", [error localizedDescription]);
        item.uploader = nil;
        item.videoUploadStatus = DWUploadStatusFail;
        
    };
    
    uploader.pausedBlock = ^(NSError *error) {
        loginfo(@"error: %@", [error localizedDescription]);
        item.videoUploadStatus = DWUploadStatusPause;
    };
    
    uploader.videoContextForRetryBlock = ^(NSDictionary *videoContext) {
        loginfo(@"context: %@", videoContext);
        item.uploadContext = videoContext;
        self.videoIdStr = videoContext[@"videoid"];
        
    };
}

- (void)videoUploadStartWithItem:(DWUploadItem *)item
{
    item.uploader = [[DWUploader alloc] initWithUserId:DWACCOUNT_USERID
                                                andKey:DWACCOUNT_APIKEY
                                      uploadVideoTitle:item.videoTitle
                                      videoDescription:item.videoDescripton
                                              videoTag:item.videoTag
                                             videoPath:item.videoPath
                                             notifyURL:@"http://www.bokecc.com/"];
    
    item.videoUploadStatus = DWUploadStatusUploading;
    
    DWUploader *uploader = item.uploader;
    
    uploader.timeoutSeconds = 20;
    
    [self setUploadBlockWithItem:item];
    
    [uploader start];
}

- (void)videoUploadResumeWithItem:(DWUploadItem *)item
{
    if (item.uploadContext) {
        if (!item.uploader) {
            item.uploader = [[DWUploader alloc] initWithVideoContext:item.uploadContext];
        }
        item.videoUploadStatus  = DWUploadStatusUploading;
        item.uploader.timeoutSeconds = 20;
        [self setUploadBlockWithItem:item];
        
        [item.uploader resume];
        
        return;
    }
    item.uploader = nil;
    [self videoUploadStartWithItem:item];
}

- (void)videoUploadPauseWithItem:(DWUploadItem *)item
{
    if (!item.uploader) {
        return;
    }
    [item.uploader pause];
    item.videoUploadStatus = DWUploadStatusPause;
}

-(void) uploadOtherPara {
    
    NSString *state = @"0";
    if (self.imagePathArray.count == 0 && self.image == nil) {
        NSLog(@"该帖子没有图片和视频");
        state = @"0";
    }
    else if (self.image == nil && self.imagePathArray.count != 0) {
        NSLog(@"该帖子有图片,没有视频");
        state = @"1";
    }
    else if (self.image != nil && self.imagePathArray.count == 0) {
        NSLog(@"该帖子没有图片,有视频");
        state = @"2";
    }
    else {
        state = @"3";
    }
    
    NSString *uId = GetFromUserDefaults(@"uId");//用户id
    NSString *pSatate = state;//帖子类型 (0:文本内容 -- 1:图片类型 -- 2:视频类型 -- 3:图片视频)
    NSString *pTitle = self.textView.titleTextField.text;//帖子标题
    NSString *pCcont = _content;//帖子内容
    if (self.image != nil) {
        [self.imageArray insertObject:self.image atIndex:0];
    }
    if (self.imagePathArray.count > 0) {
        for (NSString *path in self.imagePathArray) {
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            [self.imageArray addObject:image];
        }
    }
    
    NSMutableDictionary *publishDic = [[NSMutableDictionary alloc] init];
    [publishDic setValue:uId forKey:@"uId"];
    [publishDic setValue:pSatate forKey:@"pState"];
    [publishDic setValue:pTitle forKey:@"pTitle"];
    [publishDic setValue:pCcont forKey:@"pCcont"];
    if (self.videoIdStr) {
        [publishDic setValue:self.videoIdStr forKey:@"pVideo"];
    }
    

    //发送网络请求
    [NetworkRequest changeImagesWithUrl:CommunityPublishURL parameters:publishDic imageArray:self.imageArray successResponse:^(id data) {
        NSDictionary *dic = data;
        if (1 == [dic[@"status"] intValue]) {
            NSLog(@"请求成功!");
            [ZAlertView showSVProgressForSuccess:@"发布成功!"];
//            [MobClick event:@"publishTopic"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else {
            NSLog(@"请求失败");
        }
    } failureResponse:^(NSError *error) {
        [ZAlertView showSVProgressForErrorStatus:@"发布失败!"];
        NSLog(@"请求失败!");
    }];
}

#pragma mark - 移除通知

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:@"deleteVideo"];
}

#pragma mark - export

- (NSString *)exportHTML {
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableString *str = [NSMutableString string];
    NSString *content = [LMTextHTMLParser HTMLFromAttributedString:self.textView.attributedText withImagePathArray:&arr withTextString:&str];
    _imagePathArray = arr;
    _textStr = str;
    NSLog(@"%@",_imagePathArray);
    return content;
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
