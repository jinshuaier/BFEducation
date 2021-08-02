//
//  BFAlertViewController.m
//  Bf
//
//  Created by 春晓 on 2018/5/31.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFAlertViewController.h"



@interface BFAlertViewController ()<UITextFieldDelegate>
// title
@property (nonatomic , strong) NSString *titleStr;

// tag
@property (nonatomic , strong) UITextField *tagTextField;
@end

@implementation BFAlertViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tagTextField becomeFirstResponder];
}

+ (instancetype)BFAlertViewControllerWithTitle:(NSString *)title sureAction:(sureAction)block{
    BFAlertViewController *alert = [[BFAlertViewController alloc] init];
    alert.titleStr = title;
    alert.block = block;
    return alert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [self setupUI];
}

- (void)setupUI{
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.masksToBounds = YES;
    bgView.layer.cornerRadius = 5;
    [self.view addSubview:bgView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.text = _titleStr;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:titleLabel];
    
    _tagTextField = [[UITextField alloc] init];
    _tagTextField.backgroundColor = RGBColor(248, 248, 248);
    [bgView addSubview:_tagTextField];
    
    UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancelBtn setTitleColor:RGBColor(153, 153, 153) forState:(UIControlStateNormal)];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:cancelBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [sureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [sureBtn setTitleColor:RGBColor(51,150,252) forState:(UIControlStateNormal)];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:sureBtn];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBColor(232, 232, 232);
    [self.view addSubview:lineView];
    
    bgView.sd_layout
    .widthIs(296)
    .heightIs(165)
    .centerXIs(KScreenW / 2.0)
    .topSpaceToView(self.view, 150);
    
    titleLabel.sd_layout
    .leftEqualToView(bgView)
    .topEqualToView(bgView)
    .rightEqualToView(bgView)
    .heightIs(65);
    
    _tagTextField.sd_layout
    .leftSpaceToView(bgView, 20)
    .topSpaceToView(titleLabel, 0)
    .rightSpaceToView(bgView, 20)
    .heightIs(46);
    
    cancelBtn.sd_layout
    .leftEqualToView(bgView)
    .topSpaceToView(_tagTextField, 0)
    .bottomEqualToView(bgView)
    .widthIs(296 / 2.0 - 1.5);
    
    sureBtn.sd_layout
    .rightEqualToView(bgView)
    .topSpaceToView(_tagTextField, 0)
    .bottomEqualToView(bgView)
    .widthIs(296 / 2.0 - 1.5);
    
    lineView.sd_layout
    .leftSpaceToView(cancelBtn, 0)
    .topSpaceToView(titleLabel, 20)
    .rightSpaceToView(sureBtn, 0)
    .bottomSpaceToView(bgView, 20);
}

#pragma mark -按钮点击事件-

- (void)cancelBtnClick:(UIButton *)btn {
    [_tagTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)sureBtnClick:(UIButton *)btn {
    [_tagTextField resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:^{
        if (_tagTextField.text.length > 5 || !(StrNotEmpty(_tagTextField.text))) {
            _block(@"", NO, ReasonType_LengthUnLegal);
        }else if ([_tagTextField.text containsString:@","]){
            _block(@"", NO, ReasonType_SymbolUnLegal);
        }else{
            _block(_tagTextField.text, YES, 0);
        }
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
