//
//  BFSettingViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2017/12/7.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFSettingViewController.h"
#import "BFAboutViewController.h"//关于我们
@interface BFSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, strong) UISwitch *messageSendSwitch;
@property (nonatomic, strong) UISwitch *soundSwitch;
@property (nonatomic, strong) UISwitch *wifiSwitch;
@property (nonatomic, strong) UISwitch *fourGSwitch;
@property (nonatomic, strong) BFPlaySound *playSound;
@end

@implementation BFSettingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:@"设置页"];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [MobClick endLogPageView:@"设置页"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title = @"设置";
    self.view.backgroundColor = GroundGraryColor;
    //创建tableView
    [self setUpTableViewInterface];
}

#pragma mark - 创建tableView

-(void)setUpTableViewInterface {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KScreenW, KScreenH - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = GroundGraryColor;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell0"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 3;
    }
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *voidCell;
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell0"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textColor = RGBColor(102, 102, 102);
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"消息推送";
            _messageSendSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0.7 * KScreenW, 10, 0.2 * KScreenW, 30)];
            _messageSendSwitch.onTintColor = [UIColor colorWithRed:74/255.0 green:167/255.0 blue:248/255.0 alpha:1];
            NSString *str0 = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppPush"];
            if ([str0 isEqualToString:@"0"]) {
                _messageSendSwitch.on = NO;
            }
            else {
                _messageSendSwitch.on = YES;
            }
            [_messageSendSwitch addTarget:self action:@selector(clickMessageSendAction) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = _messageSendSwitch;
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"声音";
            _soundSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0.7 * KScreenW, 10, 0.2 * KScreenW, 30)];
            _soundSwitch.onTintColor = [UIColor colorWithRed:74/255.0 green:167/255.0 blue:248/255.0 alpha:1];
            NSString *str1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppSound"];
            if ([str1 isEqualToString:@"0"]) {
                _soundSwitch.on = NO;
            }
            else {
                _soundSwitch.on = YES;
            }
            [_soundSwitch addTarget:self action:@selector(clickSoundAction) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = _soundSwitch;
        }
        voidCell = cell;
    }
    else if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textColor = RGBColor(102, 102, 102);
        if (indexPath.row == 0) {
            cell.textLabel.text = @"仅在wi-fi下使用";
            _wifiSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0.7 * KScreenW, 10, 0.2 * KScreenW, 30)];
            _wifiSwitch.onTintColor = [UIColor colorWithRed:74/255.0 green:167/255.0 blue:248/255.0 alpha:1];
            NSString *str2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppWifi"];
            if ([str2 isEqualToString:@"0"]) {
                _wifiSwitch.on = NO;
            }
            else {
                _wifiSwitch.on = YES;
            }
            [_wifiSwitch addTarget:self action:@selector(clickwifiAction) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = _wifiSwitch;
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"切换到3g/4g网络时提醒我";
            _fourGSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0.7 * KScreenW, 10, 0.2 * KScreenW, 30)];
            _fourGSwitch.onTintColor = [UIColor colorWithRed:74/255.0 green:167/255.0 blue:248/255.0 alpha:1];
            NSString *str3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"App3G4G"];
            if ([str3 isEqualToString:@"0"]) {
                _fourGSwitch.on = NO;
            }
            else {
                _fourGSwitch.on = YES;
            }
            [_fourGSwitch addTarget:self action:@selector(clickfourGAction) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryView = _fourGSwitch;
        }
        voidCell = cell;
    }
    else if (indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell2"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.textLabel.textColor = RGBColor(102, 102, 102);
        voidCell = cell;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"清理缓存";
            NSString *str = [NSString stringWithFormat:@"%.2f",[ClearCache filePath]];
            NSString *cacheStr = [NSString stringWithFormat:@"%@M",str];
            cell.detailTextLabel.text = cacheStr;
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = @"关于我们";
        }
        else if (indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            UILabel *quitLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KScreenW, 50)];
            quitLabel.text = @"退出登录";
            quitLabel.textColor = RGBColor(236, 88, 42);
            quitLabel.font = [UIFont fontWithName:BFfont size:14.0f];
            quitLabel.textAlignment = NSTextAlignmentCenter;
            [cell addSubview:quitLabel];
        }
        voidCell = cell;
    }
    return voidCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定要清除缓存嘛?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.delegate = self;
            [alert show];
        }
        else if (indexPath.row == 1) {
            BFAboutViewController *aboutVC = [[BFAboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVC animated:YES];
        }
        else if (indexPath.row == 2) {
           NSString *str = GetFromUserDefaults(@"uId");
            NSDictionary *dic = @{@"uId":str};
            //退出登录的点击事件
            [ZAlertView showSVProgressForInfoStatus:@"用户退出登录"];
            [NetworkRequest sendDataWithUrl:LOGOUT parameters:dic successResponse:^(id data) {
                NSDictionary *dic = data;
                if (1 == [dic[@"status"] intValue]) {
                    [ZAlertView showSVProgressForSuccess:@"退出登录成功"];
                    [self userLogout];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
                else if (2 == [dic[@"status"] intValue]) {
                    
                }
                else {
                    [ZAlertView showSVProgressForErrorStatus:[NSString stringWithFormat:@"%@",dic[@"msg"]]];
                }
            } failure:^(NSError *error) {
                [ZAlertView showSVProgressForErrorStatus:@"退出登录失败"];
            }];
        }
    }
}

-(void)userLogout {
    SaveToUserDefaults(@"aBlocked", nil);
    SaveToUserDefaults(@"bTime", nil);
    SaveToUserDefaults(@"iId", nil);
    SaveToUserDefaults(@"iNickName", nil);
    SaveToUserDefaults(@"iPhoto", nil);
    SaveToUserDefaults(@"iState", nil);
    SaveToUserDefaults(@"uCredit", nil);
    SaveToUserDefaults(@"uId", nil);
    SaveToUserDefaults(@"uPhone", nil);
    SaveToUserDefaults(@"uState", nil);
    SaveToUserDefaults(@"uStateBf", nil);
    SaveToUserDefaults(@"uStateSenior", nil);
    SaveToUserDefaults(@"uStateVip", nil);
    SaveToUserDefaults(@"uTime", nil);
    SaveToUserDefaults(@"iIntr", nil);
    SaveToUserDefaults(@"token", nil);
    SaveToUserDefaults(@"session", nil);
    SaveToUserDefaults(@"loginStatus", @"0");
}

#pragma mark - UIAlertView代理事件

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
    }
    else {
        [ClearCache clearFile];
        [ZAlertView showSVProgressForSuccess:@"清除缓存成功"];
        //刷新cell
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
        [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        [_tableView endUpdates];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"headerView"];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, KScreenW, 25)];
    tipLabel.textColor = [UIColor darkGrayColor];
    tipLabel.font = [UIFont fontWithName:BFfont size:13.0f];
    tipLabel.backgroundColor = [UIColor clearColor];
    if (section == 0) {
        tipLabel.text = @" 消息通知";
    }
    else if (section == 1) {
        tipLabel.text = @" 视频服务";
    }
    [headerView addSubview:tipLabel];
    return headerView;
}

#pragma mark - 消息推送的开关点击事件

-(void)clickMessageSendAction {
    if (_messageSendSwitch.isOn) {
        NSLog(@"推送打开");
        _messageSendSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"AppPush"];
    }
    else {
        NSLog(@"推送关闭");
        _messageSendSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"AppPush"];
    }
}

#pragma mark - 声音的开关点击事件

-(void)clickSoundAction {
    if (_soundSwitch.isOn) {
        NSLog(@"打开开关");
        _soundSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"AppSound"];
    }
    else {
        NSLog(@"关闭开关");
        _soundSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"AppSound"];
    }
}

#pragma mark - wifi的开关点击事件

-(void)clickwifiAction {
    if (_wifiSwitch.isOn) {
        NSLog(@"打开开关");
        _wifiSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"AppWifi"];
    }
    else {
        NSLog(@"关闭开关");
        _wifiSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"AppWifi"];
    }
}

#pragma mark - 3G/4G的开关点击事件

-(void)clickfourGAction {
    if (_fourGSwitch.isOn) {
        NSLog(@"打开开关");
        _fourGSwitch.on = YES;
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"App3G4G"];
    }
    else {
        NSLog(@"关闭开关");
        _fourGSwitch.on = NO;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"App3G4G"];
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
