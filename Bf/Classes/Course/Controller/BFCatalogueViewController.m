//
//  BFCatalogueViewController.m
//  NewTest
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCatalogueViewController.h"
#import "BFCourseDetailsHadApplyVC.h"
// 目录
#import "BFCatalogueHeaderView.h"
#import "CLLThreeTreeModel.h"
#import "CLLThreeTreeTableViewCell.h"
#import "ChapterTableViewCell.h"

#import "BFChapterModel.h"
#import "BFLittleChapterModel.h"

#import "TreeTableView.h"
#import "BFCatalogueModel.h"

@interface BFCatalogueViewController ()<UITableViewDelegate,UITableViewDataSource>
// 目录
{
    NSInteger currentSection;
    NSInteger currentRow;
}


// 目录
//@property (nonatomic, strong) NSMutableDictionary *cellOpen;
//标记section内标题的情况
@property (nonatomic, strong) NSArray *sectionArray;



@end

// 目录重用ID
static NSString *catalogueHeaderId    = @"catalogueHeaderId";
static NSString *catalogueCellId      = @"catalogueCellId";

@implementation BFCatalogueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self netWork];
    self.automaticallyAdjustsScrollViewInsets = false;
    _tableView = [[TreeTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) withData:_dataSource];
    [self.view addSubview:_tableView];
    if(@available(iOS 11.0, *)) {
        self.tableView.contentInset = UIEdgeInsetsMake(-34.,0,0,0);
    }else{
        self.automaticallyAdjustsScrollViewInsets = false;
    }
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    self.tableView.data = _dataSource;
}

- (void)setCatalogueDict:(NSMutableDictionary *)catalogueDict{
    _catalogueDict = catalogueDict;
    self.tableView.dataDict = _catalogueDict;
}

/*
- (void)prepareCatalogueTableView{
    currentRow = -1;
    
    //去掉tableView的横线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_tableView registerClass:[BFCatalogueHeaderView class] forHeaderFooterViewReuseIdentifier:catalogueHeaderId];
    
    [_tableView reloadData];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark -UITableView-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"章节数：%ld",self.dataSource.count);
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    BFChapterModel *chapterModel = self.dataSource[section];
    if (chapterModel.isShow) {
        //数据决定显示多少行cell
        BFChapterModel *chapterModel = self.dataSource[section];
        //section决定cell的数据
        NSArray *cellArray = chapterModel.child;
        return cellArray.count;
    }else{
        //section是收起状态时候
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChapterTableViewCell *cell = [[ChapterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.contentView.backgroundColor=[UIColor whiteColor];
    BFChapterModel *chapterModel =self.dataSource[indexPath.section];
    //section决定cell的数据
    NSArray *cellArray = chapterModel.child;
    
    //cell当前的数据
    BFLittleChapterModel *lcModel = cellArray[indexPath.row];
    [cell configureCellWithModel:lcModel];
    //判断cell的位置选择折叠图片
    if (indexPath.row == cellArray.count - 1) {
        if (lcModel.child.count == 0) {
            cell.imageView2.image = [UIImage imageNamed:@""];
        } else {
            if (!lcModel.isShow) {
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝5"];
            } else {
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝4"];
            }
        }
        [cell.imageView2 setContentMode:UIViewContentModeScaleAspectFit];
    }else{
        if (lcModel.child.count == 0) {
            cell.imageView2.image = [UIImage imageNamed:@""];
        } else {
            if (!lcModel.isShow) {
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝5"];
            } else {
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝4"];
            }
        }
        [cell.imageView2 setContentMode:UIViewContentModeScaleAspectFit];
    }
    
    cell.chapterName2.text = chapterModel.ctitle;
    
    if (lcModel.isShow == YES) {
        [cell showTableView];
    } else {
        [cell hiddenTableView];
    }
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFChapterModel *chapterModel =self.dataSource[indexPath.section];
    NSArray *cellArray = chapterModel.child;
    //cell当前的数据
    BFLittleChapterModel *lcModel = cellArray[indexPath.row];
    if (lcModel.isShow) {
        return (lcModel.child.count+1)*60;
    } else {
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    currentRow = indexPath.row;
    BFChapterModel *chapterModel =self.dataSource[indexPath.section];
    NSArray *cellArray = chapterModel.child;
    BFLittleChapterModel *lcModel = cellArray[indexPath.row];
    lcModel.isShow = !lcModel.isShow;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BFCatalogueHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:catalogueHeaderId];
    if (!headerView) {
        headerView = [[BFCatalogueHeaderView alloc] initWithReuseIdentifier:catalogueHeaderId];
    }
    headerView.frame = CGRectMake(0, 0, KScreenW, 60);
    BFChapterModel *chapterModel =self.dataSource[section];
    headerView.titleLabel.text = chapterModel.ctitle;
    //点击标题变换图片
    if (chapterModel.isShow) {
        //章节添加横线，选中加阴影
        //直接取出datasource的section,检查返回数据中是否有ksub
        if (chapterModel.child && chapterModel.child.count > 0) {
            headerView.imgView.image = [UIImage imageNamed:@"下拉"];
        }else{
            headerView.imgView.image = [UIImage imageNamed:@"下拉拷贝"];
        }
    }else{
        if (chapterModel.child && chapterModel.child.count > 0) {
            headerView.imgView.image = [UIImage imageNamed:@"下拉拷贝"];
        } else {
            headerView.imgView.image = [UIImage imageNamed:@"下拉"];
        }
    }
    [headerView.openButton addTarget:self action:@selector(sectionAction:) forControlEvents:UIControlEventTouchUpInside];
    //添加TAG
    headerView.openButton.tag = section;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60.f;
}

- (void)sectionAction:(UIButton *)button{    
    currentSection = button.tag;
    //tableview收起，局部刷新
    BFChapterModel *chapterModel = self.dataSource[currentSection];
    chapterModel.isShow = !chapterModel.isShow;
//    [_tableView reloadSections:[NSIndexSet indexSetWithIndex:currentSection] withRowAnimation:UITableViewRowAnimationAutomatic];
    [_tableView reloadData];
}

- (void)setJsonDic:(NSDictionary *)jsonDic{
    self.dataSource = jsonDic[@"dataList"];
//    self.sectionOpen = [NSMutableArray array];
//    for (NSInteger i = 0; i < self.dataSource.count; i++) {
//        [self.sectionOpen addObject:@0];
//    }
    for (NSDictionary *dic1 in self.dataSource) {
        NSArray *arr2 = dic1[@"child"];
        for (NSDictionary *dic2 in arr2) {
        }
    }
    [self.tableView reloadData];
}

- (void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
//    for (BFChapterModel *model in self.dataSource) {
//        model.isShow = NO;
//        NSArray *arr2 = model.child;
//        if (arr2 && arr2.count > 0) {
//            for (BFLittleChapterModel *lcModel in arr2) {
//                lcModel.isShow = NO;
//            }
//        }
//    }
    [self.tableView reloadData];
}
*/


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
