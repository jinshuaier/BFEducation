//
//  BFEditEvaluateVC.m
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFEditEvaluateVC.h"

@interface BFEditEvaluateVC ()<UITextViewDelegate>
// 返回按钮
@property (nonatomic , strong) UIButton *goBackBtn;
// 发送按钮
@property (nonatomic , strong) UIButton *sendBtn;
// 评论编辑框
@property (nonatomic , strong) UITextView *editTextView;
// 提示文字
@property (nonatomic , strong) UILabel *placeHolderLabel;
@end

@implementation BFEditEvaluateVC{
    UIView *topBackView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    [self layout];
    [_editTextView becomeFirstResponder];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewTextDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setupUI{
    topBackView = [[UIView alloc] initWithFrame:CGRectMake(0, KNavHeight, KScreenW, 40)];
    topBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topBackView];
    _goBackBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _goBackBtn.frame = CGRectMake(20, 5, 40, 30);
    [_goBackBtn addTarget:self action:@selector(goBackBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_goBackBtn setTitle:@"返回" forState:(UIControlStateNormal)];
    _goBackBtn.titleLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(30.0f)];
    [_goBackBtn setTitleColor:RGBColor(153, 153, 153) forState:(UIControlStateNormal)];
    [topBackView addSubview:_goBackBtn];
    _sendBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _sendBtn.frame = CGRectMake(KScreenW - 20 - 40, 5, 40, 30);
    [_sendBtn setTitle:@"发送" forState:(UIControlStateNormal)];
    [_sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    _sendBtn.titleLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(30.0f)];
    [_sendBtn setTitleColor:RGBColor(153, 153, 153) forState:(UIControlStateNormal)];
    [topBackView addSubview:_sendBtn];
    _editTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 60, KScreenW - 40, 200)];
    _editTextView.font = [UIFont fontWithName:BFfont size:13];
    _editTextView.textColor = RGBColor(150, 150, 150);
    _editTextView.delegate = self;
    [self.view addSubview:_editTextView];
    
    _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 65, KScreenW - 60, 20)];
    _placeHolderLabel.textColor = RGBColor(201, 201, 201);
    [_placeHolderLabel setFont:[UIFont fontWithName:BFfont size:PXTOPT(30)]];
    [self.view addSubview:_placeHolderLabel];
    _placeHolderLabel.text = @"编辑评论，不超过140个字";
}

- (void)layout{
    topBackView.sd_layout
    .leftEqualToView(self.view)
    .topSpaceToView(self.view, KNavHeight-40)
    .rightEqualToView(self.view)
    .heightIs(40);
    
    _goBackBtn.sd_layout
    .leftSpaceToView(topBackView, 20)
    .topSpaceToView(topBackView, 10)
    .bottomSpaceToView(topBackView, 10)
    .widthIs(40);
    
    _sendBtn.sd_layout
    .rightSpaceToView(topBackView, 20)
    .topSpaceToView(topBackView, 10)
    .bottomSpaceToView(topBackView, 10)
    .widthIs(40);
    
    _editTextView.sd_layout
    .leftSpaceToView(self.view, 20)
    .topSpaceToView(topBackView, 10)
    .rightSpaceToView(self.view, 20)
    .heightIs(200);
    
    _placeHolderLabel.sd_layout
    .leftSpaceToView(self.view, 40)
    .topSpaceToView(topBackView, 20)
    .rightSpaceToView(self.view, 40)
    .heightIs(20);
}



#pragma mark -UITextViewDelegate-
- (void)textViewDidBeginEditing:(UITextView *)textView{
    _placeHolderLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        _placeHolderLabel.hidden = NO;
    }
}

- (void)textViewTextDidChange:(NSNotification *)notification{
    NSLog(@"文字改变了");
//    UITextView *textView = notification.object;
//    if (textView.text.length >= 140) {
//        [textView resignFirstResponder];
//        [self showHUD:@"字数超过140字，请精简"];
//    }
}

#pragma mark keyboard notification
- (void)keyboardWillShow:(NSNotification *)notif {
    
    NSDictionary *userInfo = [notif userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat y = keyboardRect.size.height;
    CGFloat x = keyboardRect.size.width;
    //    NSLog(@"键盘高度是  %d",(int)y);
    //    NSLog(@"键盘宽度是  %d",(int)x);
    
//    CGRect topBackViewFrame = topBackView.frame;
//    topBackViewFrame.origin.y += 20;
//    topBackView.frame = topBackViewFrame;
//
//    CGRect editTextViewFrame = _editTextView.frame;
//    editTextViewFrame.size.height = editTextViewFrame.size.height - (KScreenH - y);
//    editTextViewFrame.origin.y += 20;
//    _editTextView.frame = editTextViewFrame;
    
//    _editTextView.sd_resetLayout
//    .leftSpaceToView(self.view, 20)
//    .topSpaceToView(topBackView, 10)
//    .rightSpaceToView(self.view, 20)
//    .heightIs(200);
    
//    for (int i = 1; i <= 4; i++) {
//        UITextField *textField = [self.view viewWithTag:i];
//        //        NSLog(@"textField = %@,%f,%f",NSStringFromCGRect(textField.frame),CGRectGetMaxY(textField.frame),SCREENH_HEIGHT);
//        if ([textField isFirstResponder] == true && (KScreenH - (CGRectGetMaxY(textField.frame) + CCGetRealFromPt(10))) < y) {
//
//        }
//    }
}

-(void)keyboardWillHide:(NSNotification *)notification{
    [_editTextView resignFirstResponder];
//    CGRect topBackViewFrame = topBackView.frame;
//    topBackViewFrame.origin.y -= 20;
//    topBackView.frame = topBackViewFrame;
//    _editTextView.frame = CGRectMake(20, 60, KScreenW - 40, KScreenH - 60);
//    WS(ws)
//    [UIView animateWithDuration:0.25f animations:^{
//        [ws.view layoutIfNeeded];
//    }];
    
    
//    _editTextView.sd_resetLayout
//    .leftSpaceToView(self.view, 20)
//    .topSpaceToView(topBackView, 10)
//    .rightSpaceToView(self.view, 20)
//    .heightIs(200);
}

- (void)goBackBtnClick:(UIButton *)btn{
    [_editTextView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)sendBtnClick:(UIButton *)btn{
    [_editTextView resignFirstResponder];
    if (_editTextView.text.length < 2) {
        [self showHUD:@"字数必须超过两个字"];
    }else if (_editTextView.text.length > 140) {
        [self showHUD:@"字数超过140字，请精简"];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        _editBlock(_editTextView.text);
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
