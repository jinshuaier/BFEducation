//
//  BFAboutViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFAboutViewController.h"
#import "BFPrivacyPolicyViewController.h"
@interface BFAboutViewController ()

@end

@implementation BFAboutViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpInterface];
}

#pragma mark - 关于我们
-(void)setUpInterface {
    UIImageView *logoImg = [[UIImageView alloc] initWithFrame:CGRectMake((KScreenW - 70)/2, 170, 70, 70)];
    logoImg.image = [UIImage imageNamed:@"logo-2"];
    [self.view addSubview:logoImg];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, logoImg.bottom + 10, KScreenW, 20)];
    nameLabel.text = @"北方职教";
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font = [UIFont fontWithName:BFfont size:15.0f];[self.view addSubview:nameLabel];
    
    UILabel *verLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLabel.bottom + 10, KScreenW, 20)];
    NSString *clientVersion = [NSString stringWithFormat:@"V %@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    verLabel.text = clientVersion;
    verLabel.textColor = [UIColor grayColor];
    verLabel.textAlignment = NSTextAlignmentCenter;
    verLabel.font = [UIFont fontWithName:BFfont size:12.0f];[self.view addSubview:nameLabel];
    [self.view addSubview:verLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, KScreenH - 60, KScreenW, 30);
    [btn setTitle:@"使用条款和隐私政策" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:BFfont size:13.0f];
    [btn setTitleColor:RGBColor(0, 126, 212) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)clickAction {
    BFPrivacyPolicyViewController *privacyVC = [[BFPrivacyPolicyViewController alloc] init];
    [self.navigationController pushViewController:privacyVC animated:YES];
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
