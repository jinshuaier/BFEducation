//
//  BFSearchCommunityVC.m
//  Bf
//
//  Created by 春晓 on 2018/3/2.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFSearchCommunityVC.h"
#import "BFSearchCommunityResultVC.h"

@interface BFSearchCommunityVC ()<UISearchBarDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation BFSearchCommunityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBarButtonItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
    self.searchBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    [MobClick beginLogPageView:@"搜索页"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_searchBar.isFirstResponder) {
        [self.searchBar becomeFirstResponder];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // 回收键盘
    [self.searchBar resignFirstResponder];
    
    self.searchBar.hidden = YES;
    
//    [MobClick endLogPageView:@"搜索页"];
}


- (void)setBarButtonItem
{
    [self.navigationItem setHidesBackButton:YES];
    
    UISearchBar *searchBar1 = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 7, KScreenW - 20, 25)];
    self.searchBar = searchBar1;
    searchBar1.layer.masksToBounds = YES;
    searchBar1.layer.cornerRadius = 5.0f;
    searchBar1.placeholder = @"请输入关键字搜索";
    searchBar1.delegate = self;
    searchBar1.showsCancelButton = YES;
    UIView* backgroundView = [searchBar1 subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
//    backgroundView.layer.cornerRadius = 17.0f;
    backgroundView.clipsToBounds = YES;
//    UITextField *searchField = [searchBar1 valueForKey:@"_searchField"];
    UITextField * searchField = [self findViewWithClassName:@"UITextField" inView:searchBar1];
    searchField.backgroundColor = RGBColor(200, 200, 200);
    CGRect rect = searchField.frame;
    rect.size = CGSizeMake(KScreenW - 20, 38);
    //找到取消按钮
//    UIButton *cancleBtn = [searchBar1 valueForKey:@"cancelButton"];
    UIButton *cancleBtn = [self findViewWithClassName:NSStringFromClass([UIButton class]) inView:searchBar1];
    //修改标题和标题颜色
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:RGBColor(178, 178, 178) forState:UIControlStateNormal];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    [cancleBtn addTarget:self action:@selector(goBack) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.searchBar becomeFirstResponder];
    [self.navigationController.navigationBar addSubview:searchBar1];
}
//遍历获取指定类型的属性
- (UIView *)findViewWithClassName:(NSString *)className inView:(UIView *)view{
    Class specificView = NSClassFromString(className);
    if ([view isKindOfClass:specificView]) {
        return view;
    }
 
    if (view.subviews.count > 0) {
        for (UIView *subView in view.subviews) {
            UIView *targetView = [self findViewWithClassName:className inView:subView];
            if (targetView != nil) {
                return targetView;
            }
        }
    }
    
    return nil;
}

#pragma mark - UISearchBarDelegate -
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([[searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return;
    }
    [self search];
    searchBar.text = @"";
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchBar.text == nil || [searchBar.text length] <= 0) {
        
    } else {
        
    }
}

- (void)search{
    BFSearchCommunityResultVC *vc = [BFSearchCommunityResultVC new];
    NSString *searchText = [_searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];// 空格过滤
    NSLog(@"%@",searchText);
    vc.searchStr = searchText;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    
    
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
