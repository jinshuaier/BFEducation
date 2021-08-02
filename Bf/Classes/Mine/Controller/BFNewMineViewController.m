//
//  BFNewMineViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/4/23.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFNewMineViewController.h"
#import "BFMineView.h"

#import "BFSettingViewController.h"
#import "BFMineInformationVC.h"
#import "BFMyCourseViewController.h"
#import "BFSecMineTopicViewController.h"
#import "BFMineCollectionViewController.h"
#import "BFClassmatesActivateController.h"
#import "BFFeedBackViewController.h"
#import "BFAccountManagerController.h"

#import "BFMyCourseTeaVC.h"

@interface BFNewMineViewController ()
/*创建背景UIScrollView*/
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic, strong) AppDelegate *appDelegate;

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *headImg;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton * editBtn;
@end

@implementation BFNewMineViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) {//用户已登录
        _nameLabel.text = GetFromUserDefaults(@"iNickName");
        _nameLabel.layer.borderWidth = 0;
        _nameLabel.userInteractionEnabled = NO;
        [_editBtn setHidden:NO];
        //创建一个并发队列
//        dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
//        //将任务加入到队列
//        dispatch_async(queue, ^{
//            NSURL *url = [NSURL URLWithString:GetFromUserDefaults(@"iPhoto")];
//            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
//            _headImg.image = image;
//
//        });
        NSURL *url = [NSURL URLWithString:GetFromUserDefaults(@"iPhoto")];
        [_headImg sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"123"]];
    }
    else {//用户未登录
        _nameLabel.text = @"注册 | 登录";
        _nameLabel.userInteractionEnabled = YES;
        [_editBtn setHidden:YES];
        //创建一个并发队列
//        dispatch_queue_t queue = dispatch_queue_create(nil, DISPATCH_QUEUE_CONCURRENT);
//        //将任务加入到队列
//        dispatch_async(queue, ^{
//            _headImg.image = [UIImage imageNamed:@"123"];
//            _nameLabel.font = [UIFont fontWithName:BFfont size:15.0f];
//        });
        _headImg.image = [UIImage imageNamed:@"123"];
        _nameLabel.font = [UIFont fontWithName:BFfont size:15.0f];

    }
    _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    CGSize maximumLabelSize = CGSizeMake(200, 20);
    CGSize expectSize = [_nameLabel sizeThatFits:maximumLabelSize];
    _nameLabel.frame = CGRectMake((KScreenW - expectSize.width)/ 2, _headImg.bottom + 15, expectSize.width, expectSize.height);
    _editBtn.frame = CGRectMake(_nameLabel.right + 5, _headImg.bottom + 15, 23, 20);

}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUIScrollView];
    [self createInterfce];
    AppDelegate  *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.appDelegate = appDelegate;
    

}

#pragma mark - 创建UIScrollView

-(void)createUIScrollView {
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
    self.scrollView.backgroundColor = RGBColor(247, 249, 251);
    self.scrollView.contentSize = self.view.size;
    self.scrollView.bounces = YES;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
}

#pragma mark - 创建视图

-(void)createInterfce {
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, KScreenW, 493)];
    self.backView = backView;
    backView.backgroundColor = RGBColor(0, 148, 213);
    [self.scrollView addSubview:backView];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [settingBtn setImage:[UIImage imageNamed:@"Gear_512px_1177844_easyicon.net"] forState:UIControlStateNormal];
    [settingBtn setImage:[UIImage imageNamed:@"new-shezhi-white"] forState:UIControlStateNormal];
    settingBtn.frame = CGRectMake(KScreenW - 40 - 15, 15, 40, 30);
    [settingBtn addTarget:self action:@selector(clickSettingAction) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:settingBtn];
    
    UIImageView *headImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 70)/2, 40    , 70   , 70   )];
    self.headImg = headImg;
    headImg.image = [UIImage imageNamed:@"123"];
    headImg.clipsToBounds = YES;
    headImg.layer.cornerRadius = 70   /2;
    [self.scrollView addSubview:headImg];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((KScreenW - 200)/2, headImg.bottom + 10, 200, 20)];
    self.nameLabel = nameLabel;
    nameLabel.text = @"小陈同学";
    nameLabel.textColor = RGBColor(248, 250, 252);
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(30)];
    nameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickLoginAction)];
    [nameLabel addGestureRecognizer:ges];
    [self.scrollView addSubview:nameLabel];
    
    UIButton * editBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.editBtn = editBtn;
    editBtn.frame = CGRectMake(nameLabel.right, headImg.bottom + 10, 23   , 20    );
    [editBtn setImage:[UIImage imageNamed:@"edit_512px_1101471_easyicon.net"] forState:(UIControlStateNormal)];
    [editBtn addTarget:self action:@selector(editInformation) forControlEvents:(UIControlEventTouchUpInside)];
    [self.scrollView addSubview:editBtn];
    
    UIView *middleView = [[UIView alloc] initWithFrame:CGRectMake(15, editBtn.bottom + 20, KScreenW - 30, 90    )];
    middleView.backgroundColor = [UIColor whiteColor];
    middleView.layer.cornerRadius = 4.f;
    middleView.layer.borderWidth = 1.0f;
    middleView.layer.borderColor = ColorRGBValue(0xf0f0f0).CGColor;
    [self.scrollView addSubview:middleView];
    
    UIButton *classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [classBtn setImage:[UIImage imageNamed:@"kc1"] forState:UIControlStateNormal];
    [classBtn setTitle:@"我的课程" forState:UIControlStateNormal];
    classBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [classBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    classBtn.frame = CGRectMake(25   , 15    , (middleView.width - 25 * 4)/3, 60    );
    [classBtn addTarget:self action:@selector(clickClassAction) forControlEvents:UIControlEventTouchUpInside];
    classBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -classBtn.imageView.frame.size.width, -classBtn.imageView.frame.size.height, 0);
    classBtn.imageEdgeInsets = UIEdgeInsetsMake(-classBtn.titleLabel.intrinsicContentSize.height, 0, 0, -classBtn.titleLabel.intrinsicContentSize.width);
    [middleView addSubview:classBtn];
    
    UIButton *tipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tipBtn setImage:[UIImage imageNamed:@"ht"] forState:UIControlStateNormal];
    [tipBtn setTitle:@"我的帖子" forState:UIControlStateNormal];
    tipBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [tipBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    tipBtn.frame = CGRectMake(classBtn.right + 25, 15    , (middleView.width - 25 * 4)/3, 60    );
    [tipBtn addTarget:self action:@selector(clickTipAction) forControlEvents:UIControlEventTouchUpInside];
    tipBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -tipBtn.imageView.frame.size.width, -tipBtn.imageView.frame.size.height, 0);
    tipBtn.imageEdgeInsets = UIEdgeInsetsMake(-tipBtn.titleLabel.intrinsicContentSize.height, 0, 0, -tipBtn.titleLabel.intrinsicContentSize.width);
    [middleView addSubview:tipBtn];
    
    UIButton *scBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scBtn setImage:[UIImage imageNamed:@"sc"] forState:UIControlStateNormal];
    [scBtn setTitle:@"我的收藏" forState:UIControlStateNormal];
    scBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
    [scBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    scBtn.frame = CGRectMake(tipBtn.right + 25, 15    , (middleView.width - 25 * 4)/3, 60    );
    [scBtn addTarget:self action:@selector(clickScAction) forControlEvents:UIControlEventTouchUpInside];
    scBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -scBtn.imageView.frame.size.width, -scBtn.imageView.frame.size.height, 0);
    scBtn.imageEdgeInsets = UIEdgeInsetsMake(-scBtn.titleLabel.intrinsicContentSize.height, 0, 0, -scBtn.titleLabel.intrinsicContentSize.width);
    [middleView addSubview:scBtn];
    
    BFMineView *view0 = [[BFMineView alloc] initWithFrame:CGRectMake(15, middleView.bottom + 15, KScreenW - 30, 45    )];
    view0.img.image = [UIImage imageNamed:@"校友激活"];
    view0.backgroundColor = [UIColor whiteColor];
    view0.layer.cornerRadius = 4.f;
    view0.layer.borderWidth = 1.0f;
    view0.layer.borderColor = ColorRGBValue(0xf0f0f0).CGColor;
    view0.title.text = @"校友激活";
    view0.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges0 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click0Action)];
    [view0 addGestureRecognizer:ges0];
    [self.scrollView addSubview:view0];
    
    BFMineView *view1 = [[BFMineView alloc] initWithFrame:CGRectMake(15, view0.bottom + 10, KScreenW - 30, 45    )];
    view1.img.image = [UIImage imageNamed:@"留言"];
    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.cornerRadius = 4.f;
    view1.layer.borderWidth = 1.0f;
    view1.layer.borderColor = ColorRGBValue(0xf0f0f0).CGColor;
    view1.title.text = @"反馈管理";
    view1.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click1Action)];
    [view1 addGestureRecognizer:ges1];
    [self.scrollView addSubview:view1];
    
    BFMineView *view2 = [[BFMineView alloc] initWithFrame:CGRectMake(15, view1.bottom + 10, KScreenW - 30, 45    )];
    view2.img.image = [UIImage imageNamed:@"绑定管理"];
    view2.backgroundColor = [UIColor whiteColor];
    view2.layer.cornerRadius = 4.f;
    view2.layer.borderWidth = 1.0f;
    view2.layer.borderColor = ColorRGBValue(0xf0f0f0).CGColor;
    view2.title.text = @"账号管理";
    view2.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click2Action)];
    [view2 addGestureRecognizer:ges2];
    [self.scrollView addSubview:view2];
}


#pragma mark - 我的设置点击事件

-(void)clickSettingAction {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        BFSettingViewController *settingView = [BFSettingViewController new];
        [self.navigationController pushViewController:settingView animated:YES];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

#pragma mark - 登录注册点击事件

-(void)clickLoginAction {
    BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
    navigation.modalPresentationStyle = 0;
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - 编辑个人信息点击事件

-(void)editInformation {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        BFMineInformationVC *vc = [BFMineInformationVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

#pragma mark - 我的课程点击事件

-(void)clickClassAction {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        NSString *userStateStr = [NSString stringWithFormat:@"%@",GetFromUserDefaults(@"uStateBf")];
        if ([userStateStr isEqualToString:@"1"]) {
            BFMyCourseTeaVC *myCourseVC = [BFMyCourseTeaVC new];
            [self.navigationController pushViewController:myCourseVC animated:YES];
        }
        else {
            BFMyCourseViewController *myCourseVC = [BFMyCourseViewController new];
            [self.navigationController pushViewController:myCourseVC animated:YES];
        }
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

#pragma mark - 我的帖子点击事件

-(void)clickTipAction {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        BFSecMineTopicViewController *vc = [BFSecMineTopicViewController new];
        vc.getConsultsType = GetConsultsType_Send;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

#pragma mark - 我的收藏点击事件

-(void)clickScAction {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        BFMineCollectionViewController *mineCollectionVC = [BFMineCollectionViewController new];
        [self.navigationController pushViewController:mineCollectionVC animated:YES];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

#pragma mark - 校友激活点击事件

-(void)click0Action {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        BFClassmatesActivateController *classVC = [[BFClassmatesActivateController alloc] init];
        [self.navigationController pushViewController:classVC animated:YES];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

#pragma mark - 反馈管理点击事件

-(void)click1Action {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        //反馈留言
        BFFeedBackViewController * feedBackVC = [[BFFeedBackViewController alloc] init];
        [self.navigationController pushViewController:feedBackVC animated:YES];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

#pragma mark - 账号管理点击事件

-(void)click2Action {
    NSString *str = GetFromUserDefaults(@"loginStatus");
    if ([str isEqualToString:@"1"]) { //用户已登录
        //账号管理
        BFAccountManagerController * feedBackVC = [[BFAccountManagerController alloc] init];
        [self.navigationController pushViewController:feedBackVC animated:YES];
    }
    else {
        BFLoginViewController *loginVC = [[BFLoginViewController alloc] init];
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVC];
        navigation.modalPresentationStyle = 0;
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
