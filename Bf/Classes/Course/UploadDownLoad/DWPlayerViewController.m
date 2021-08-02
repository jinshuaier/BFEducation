#import "DWPlayerViewController.h"
#import "DWPlayerTableViewCell.h"
#import "DWCustomPlayerViewController.h"

#import <MJRefresh.h>
#import "NetworkRequest.h"
#import "InformationShowView.h"

@interface DWPlayerViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSMutableArray *videoIds;

@property(nonatomic,strong)InformationShowView  *informationView;

@end

@implementation DWPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title = @"播放";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"播放"
                                                        image:[UIImage imageNamed:@"tabbar-play"]
                                                          tag:0];
        if (IsIOS7) {
            self.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar-play-selected"];
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self generateTestData];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    if (!IsIOS7) {
        // 20 为电池栏高度
        // 44 为导航栏高度
        // 49 为标签栏的高度
        //frame.size.height = frame.size.height - 20;
    }
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60.0f;
    [self.view addSubview:self.tableView];
    logdebug(@"self.view.frame:%@ self.tableView.frame: %@", NSStringFromCGRect(self.view.frame), NSStringFromCGRect(self.tableView.frame));
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(generateTestData)];
    [self.tableView.mj_header beginRefreshing];
}

# pragma mark - processer

- (void)generateTestData
{
    
    //TODO: 待播放视频ID，可根据需求自定义
    
    [NetworkRequest requestWithUrl:FindVideoURL parameters:nil successResponse:^(id data) {
        NSArray *arr = data;
        [self.videoIds removeAllObjects];
        for (NSDictionary *dic in arr) {
            [self.videoIds addObject:dic[@"video_id"]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
        });
    } failureResponse:^(NSError *error) {
        _informationView = [[InformationShowView alloc] initWithLabel:@"网络错误，请求观看直播列表失败"];
        [self.view addSubview:_informationView];
        [_informationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(removeInformationView) userInfo:nil repeats:NO];
        [_tableView.mj_header endRefreshing];
    }];
    
    //self.videoIds =@[@"DDCB5851BD09121F9C33DC5901307461",@"84AAD143D0F9B81A9C33DC5901307461",@"6CE258E2FA2C8F459C33DC5901307461",@"30375FDBBAC1A27F9C33DC5901307461",@"50EE4D20E9E39A109C33DC5901307461",@"D8CC11D7C54E12FA9C33DC5901307461",@"B28CA64E2608D6FD9C33DC5901307461"
                     //];
}

- (NSMutableArray *)videoIds{
    if (!_videoIds) {
        _videoIds = [NSMutableArray array];
    }
    return _videoIds;
}

-(void)removeInformationView {
    [_informationView removeFromSuperview];
    _informationView = nil;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.videoIds count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"DWPlayerViewCorollerCellId";
    
    NSString *videoid = self.videoIds[indexPath.row];
    
    DWPlayerTableViewCell *cell = (DWPlayerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[DWPlayerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [cell.playButton addTarget:self action:@selector(playerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cell.playButton.tag = indexPath.row;
    }
    
    [cell setupCell:videoid];
    
    return cell;
}

- (void)playerButtonAction:(UIButton *)button
{
    NSInteger indexPath = button.tag;
    NSString *videoId = self.videoIds[indexPath];
    
    UIAlertController *playAlert = [UIAlertController alertControllerWithTitle:@"选择播放模式" message:nil preferredStyle:  UIAlertControllerStyleActionSheet];

    [playAlert addAction:[UIAlertAction actionWithTitle:@"普通版" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        DWCustomPlayerViewController *player = [[DWCustomPlayerViewController alloc] init];
        player.playMode = NO;
        player.videoId = videoId;
        player.videos = self.videoIds;
        player.indexpath = indexPath;
        player.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:player animated:NO];

    }]];
    [playAlert addAction:[UIAlertAction actionWithTitle:@"广告版" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        DWCustomPlayerViewController *player = [[DWCustomPlayerViewController alloc] init];
        player.playMode = YES;
        player.videoId = videoId;
        
        player.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:player animated:NO];

    }]];
    [playAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }]];
    [self presentViewController:playAlert animated:true completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
