//
//  CXsearchController.m
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "CXSearchController.h"
#import "CXSearchCollectionViewCell.h"
#import "SelectCollectionReusableView.h"
#import "SelectCollectionLayout.h"
#import "BFCourseModel.h"
#import "BFSearchDetailViewController.h"
static NSString *const cxSearchCollectionViewCell = @"CXSearchCollectionViewCell";

static NSString *const headerViewIden = @"HeadViewIden";
//屏幕宽高
#define KScreenW [UIScreen mainScreen].bounds.size.width
#define KScreenH [UIScreen mainScreen].bounds.size.height
#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"BFSearchhistories.plist"]

@interface CXSearchController()<UICollectionViewDataSource,UICollectionViewDelegate,SelectCollectionCellDelegate,UICollectionReusableViewButtonDelegate,UISearchBarDelegate>

/**
 *  存储网络请求的热搜，与本地缓存的历史搜索model数组
 */
@property (nonatomic, strong) NSMutableArray *sectionArray;
/**
 *  存搜索的数组 字典
 */
@property (nonatomic,strong) NSMutableArray *searchArray;

//@property (weak, nonatomic) IBOutlet UICollectionView *cxSearchCollectionView;
//
//@property (weak, nonatomic) IBOutlet UITextField *cxSearchTextField;
@property (strong, nonatomic) UICollectionView *cxSearchCollectionView;

@property (strong, nonatomic) UITextField *cxSearchTextField;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSMutableArray *hotArray;
/**
 *  存搜索的数组 字典
 */
@property (nonatomic,strong) NSMutableArray *mySearchArray;

@end

@implementation CXSearchController

-(NSMutableArray *)sectionArray
{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

-(NSMutableArray *)searchArray
{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self prepareData];
    [self setBarButtonItem];
    self.view.backgroundColor = [UIColor whiteColor];
    self.cxSearchCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 64, KScreenW - 30, KScreenH - 64) collectionViewLayout:[[SelectCollectionLayout alloc] init]];
    self.cxSearchCollectionView.delegate = self;
    self.cxSearchCollectionView.dataSource = self;
    self.cxSearchCollectionView.backgroundColor = [UIColor whiteColor];
    UITapGestureRecognizer *myTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollTap:)];
    [self.cxSearchCollectionView addGestureRecognizer:myTap];
    [self.view addSubview:self.cxSearchCollectionView];
    [self.cxSearchCollectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIden];
    [self.cxSearchCollectionView registerNib:[UINib nibWithNibName:@"CXSearchCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cxSearchCollectionViewCell];
    /***  可以做实时搜索*/
//    [self.cxSearchTextField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)scrollTap:(id)sender {
    [_searchBar endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.leftBarButtonItem = nil;
    self.searchBar.hidden = NO;
    self.navigationController.navigationBar.barTintColor = RGBColor(0, 126, 212);
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
    searchBar1.layer.cornerRadius = 15.0f;
    searchBar1.placeholder = @"请输入关键字搜索";
    searchBar1.delegate = self;
    searchBar1.showsCancelButton = YES;
    UIView* backgroundView = [searchBar1 subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
    backgroundView.layer.cornerRadius = 17.0f;
    backgroundView.clipsToBounds = YES;
    [self.searchBar becomeFirstResponder];
    [self.navigationController.navigationBar addSubview:searchBar1];
//    
//    
//    
//    
//    
//    
//    // 创建搜索框
//    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
//    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];
//    UIView* backgroundView = [searchBar subViewOfClassName:@"_UISearchBarSearchFieldBackgroundView"];
//    backgroundView.layer.cornerRadius = 15.0f;
//    backgroundView.clipsToBounds = YES;
//    searchBar.placeholder = @"输入关键字搜索";
//    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
//    searchBar.delegate = self;
//    searchBar.showsCancelButton = YES;
//    searchBar.layer.cornerRadius = 15.0f;
//    searchBar.layer.masksToBounds = YES;
//    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
//    [searchField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
//    UIView *searchTextField = searchTextField = [searchBar valueForKey:@"_searchField"];
//    searchTextField.layer.masksToBounds = YES;
//    searchTextField.layer.cornerRadius = 15;
//    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
//
//    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
//    //修改标题和标题颜色
//    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
//    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    cancleBtn.titleLabel.font = [UIFont fontWithName:BFfont size:14.0f];
//    
//    [titleView addSubview:searchBar];
//    self.searchBar = searchBar;
//    [self.searchBar becomeFirstResponder];
//    self.navigationItem.titleView = titleView;
}

- (void)prepareData
{
    _hotArray = [NSMutableArray arrayWithObjects:@"宝马", @"奥迪", @"奔驰", @"特斯拉", @"法拉利", @"宾利", nil];
    _mySearchArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KHistorySearchPath];
    if (!_mySearchArray) {
        _mySearchArray = [NSMutableArray array];
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _mySearchArray.count;
    }else{
        return _hotArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CXSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cxSearchCollectionViewCell forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell.contentButton setTitle:_mySearchArray[indexPath.row] forState:UIControlStateNormal];
        [cell.contentButton addTarget:self action:@selector(clickSearchHistory:) forControlEvents:UIControlEventTouchUpInside];
        NSString *str = _mySearchArray[indexPath.row];
        objc_setAssociatedObject(cell.contentButton, @"key0",str, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return cell;
    }else{
        [cell.contentButton setTitle:_hotArray[indexPath.row] forState:UIControlStateNormal];
        [cell.contentButton addTarget:self action:@selector(clickSearchHot:) forControlEvents:UIControlEventTouchUpInside];
        NSString *str1 = _hotArray[indexPath.row];
        objc_setAssociatedObject(cell.contentButton, @"key1",str1, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    cell.selectDelegate = self;
    return cell;
}

-(void)clickSearchHistory:(UIButton *)sender {
    NSLog(@"%@", objc_getAssociatedObject(sender, @"key0"));
    NSString *str0 = [NSString stringWithFormat:@"%@",objc_getAssociatedObject(sender, @"key0")];
    _searchBar.text = [self replaceUnicode:str0];
}

-(void)clickSearchHot:(UIButton *)sender {
    NSLog(@"%@", objc_getAssociatedObject(sender, @"key1"));
    NSString *str1 = [NSString stringWithFormat:@"%@",objc_getAssociatedObject(sender, @"key1")];
    _searchBar.text = [self replaceUnicode:str1];
}

- (NSString*) replaceUnicode:(NSString*)TransformUnicodeString {
    NSString *tepStr1 = [TransformUnicodeString stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tepStr2 = [tepStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tepStr3 = [[@"\"" stringByAppendingString:tepStr2]stringByAppendingString:@"\""];
    NSData *tepData = [tepStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *axiba = [NSPropertyListSerialization propertyListWithData:tepData options:NSPropertyListMutableContainers format:NULL error:NULL];
    return [axiba stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        SelectCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        if (indexPath.section == 0) {
            [view setText:@"搜索历史"];
            view.delectButton.hidden = NO;
        }else{
            [view setText:@"热门搜索"];
            view.delectButton.hidden = YES;
        }
        
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
//        if(indexPath.section == 0)
//        {
//            [view setImage:@"cxSearch"];
//            view.delectButton.hidden = NO;
//        }else{
//            [view setImage:@"cxCool"];
//            view.delectButton.hidden = YES;
//        }
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (_mySearchArray.count > 0) {
            return [CXSearchCollectionViewCell getSizeWithText:_mySearchArray[indexPath.row]];
        }else{
            return CGSizeMake(0, 0);
        }
    }else{
        if (_hotArray.count > 0) {
            return [CXSearchCollectionViewCell getSizeWithText:_hotArray[indexPath.row]];
        }else{
            return CGSizeMake(0, 0);
        }
    }

}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - SelectCollectionCellDelegate
- (void)selectButttonClick:(CXSearchCollectionViewCell *)cell;
{
    NSIndexPath* indexPath = [self.cxSearchCollectionView indexPathForCell:cell];
    [self reloadData:_hotArray[indexPath.row]];
}

#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData:(SelectCollectionReusableView *)view;
{
    [_mySearchArray removeAllObjects];
    [NSKeyedArchiver archiveRootObject:_mySearchArray toFile:KHistorySearchPath];
    [self.cxSearchCollectionView reloadData];
}
#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

- (void)reloadData:(NSString *)textString
{
    [self setHistoryArrWithStr:textString];
    [self.cxSearchCollectionView reloadData];
    _searchBar.text = @"";
}

- (void)setHistoryArrWithStr:(NSString *)str
{
    for (int i = 0; i < _mySearchArray.count; i++) {
        if ([_mySearchArray[i] isEqualToString:str]) {
            [_mySearchArray removeObjectAtIndex:i];
            break;
        }
    }
    [_mySearchArray insertObject:str atIndex:0];
    [NSKeyedArchiver archiveRootObject:_mySearchArray toFile:KHistorySearchPath];
}

#pragma mark - UISearchBarDelegate -
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([[searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return;
    }
    [self search];
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    [self reloadData:searchBar.text];
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
    NSMutableDictionary *paramet = [NSMutableDictionary dictionary];
    [paramet setValue:self.searchBar.text forKey:@"ctitle"];
    [NetworkRequest sendDataWithUrl:CoursesSearchURL parameters:paramet successResponse:^(id data) {
        NSLog(@"get成功%@",data);
        
        BFSearchDetailViewController *searchVC = [[BFSearchDetailViewController alloc] init];
        searchVC.data = data;
        searchVC.navigationItem.title = self.searchBar.text;
        [self.navigationController pushViewController:searchVC animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
}

@end
