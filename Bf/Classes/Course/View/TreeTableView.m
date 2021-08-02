//
//  TreeTableView.m
//  TreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import "TreeTableView.h"
#import "BFCatalogueModel.h"
#import "BFCatalogueCell.h"

@interface TreeTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) NSMutableArray *tempData;//用于存储数据源（部分数据）

// 现在选中的cell
@property (nonatomic , strong) BFCatalogueCell *curCell;
// 上一次选中的cell
@property (nonatomic , strong) BFCatalogueCell *lastCell;
@end
static NSString *NODE_CELL_ID = @"node_cell_id";
@implementation TreeTableView{
    NSArray *AList;
    NSArray *BList;
    NSArray *CList;
}

-(instancetype)initWithFrame:(CGRect)frame withData : (NSArray *)data{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _data = data;
        _tempData = [self createTempData:data];
        [self registerClass:[BFCatalogueCell class] forCellReuseIdentifier:NODE_CELL_ID];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame withDict : (NSDictionary *)data{
    self = [super initWithFrame:frame style:UITableViewStyleGrouped];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _dataDict = data;
        [self createTempDataWithDict:data];
        [self registerClass:[BFCatalogueCell class] forCellReuseIdentifier:NODE_CELL_ID];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

/**
 * 初始化数据源
 */
-(NSMutableArray *)createTempData : (NSArray *)data{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<data.count; i++) {
        BFCatalogueModel *node = [_data objectAtIndex:i];
        if (node.isShow) {
            if (node.parentId == 0) {
                [tempArray addObject:node];
            }else{
                node.isShow = NO;
            }
        }
    }
    
    return tempArray;
}

-(void)createTempDataWithDict: (NSDictionary *)dict{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    if (!_tempData) {
        _tempData = [NSMutableArray array];
    }
    [_data removeAllObjects];
    AList = dict[@"AList"];
    BList = dict[@"BList"];
    CList = dict[@"CList"];
    
    for (BFCatalogueModel *node in AList) {
        [_data addObject:node];
    }
    for (BFCatalogueModel *node in BList) {
        [_data addObject:node];
    }
    for (BFCatalogueModel *node in CList) {
        [_data addObject:node];
    }
    
    [_tempData removeAllObjects];
    for (int i = 0; i < AList.count; i++) {
        BFCatalogueModel *nodeA = [AList objectAtIndex:i];
        [_tempData addObject:nodeA];
        for (int j = 0; j < BList.count; j++) {
            BFCatalogueModel *nodeB = [BList objectAtIndex:j];
            if (nodeB.parentId == nodeA.cTId) {
                if (nodeB.isShow) {
                    [_tempData addObject:nodeB];
                    for (int k = 0; k < CList.count; k++) {
                        BFCatalogueModel *nodeC = [CList objectAtIndex:k];
                        if (nodeC.parentId == nodeB.cTId) {
                            if (nodeC.isShow) {
                                [_tempData addObject:nodeC];
                            }
                        }
                    }
                }
            }
        }
        
    }
}

- (void)relodeData{
    [_tempData removeAllObjects];
    for (int i = 0; i < AList.count; i++) {
        BFCatalogueModel *nodeA = [AList objectAtIndex:i];
        [_tempData addObject:nodeA];
        for (int j = 0; j < BList.count; j++) {
            BFCatalogueModel *nodeB = [BList objectAtIndex:j];
            if (nodeB.parentId == nodeA.cTId) {
                if (nodeB.isShow) {
                    [_tempData addObject:nodeB];
                    for (int k = 0; k < CList.count; k++) {
                        BFCatalogueModel *nodeC = [CList objectAtIndex:k];
                        if (nodeC.parentId == nodeB.cTId) {
                            if (nodeC.isShow) {
                                [_tempData addObject:nodeC];
                            }
                        }
                    }
                }
            }
        }
    }
    [self reloadData];
}

- (void)setData:(NSArray *)data{
    _data = data;
    _tempData = [self createTempData:data];
    NSLog(@"%@",_data);
    [self reloadData];
}

- (void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    [self createTempDataWithDict:_dataDict];
    [self reloadData];
}

#pragma mark - UITableViewDataSource

#pragma mark - Required

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tempData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BFCatalogueCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    if (!cell) {
        cell = [[BFCatalogueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL_ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BFCatalogueModel *node = [_tempData objectAtIndex:indexPath.row];
    cell.chapterType = node.chapterType;
//    cell.node = node;
    
    // cell有缩进的方法
//    cell.indentationLevel = node.depth; // 缩进级别
//    cell.indentationWidth = 30.f; // 每个缩进级别的距离

    
//    NSMutableString *name = [NSMutableString string];
//    for (int i=0; i<node.depth; i++) {
//        [name appendString:@"     "];
//    }
//    [name appendString:node.name];
    
    if (node.chapterType == ChapterType_Chapter ||node.chapterType ==  ChapterType_LittleChapter) {
        cell.chapterName2.text = node.cTTitle;
        if (node.isExpand) {
            if (node.chapterType == ChapterType_Chapter) {
                cell.imgView.image = [UIImage imageNamed:@"下拉"];
                cell.chapterName2.font = [UIFont fontWithName:BFfont size:15];
            }else if (node.chapterType == ChapterType_LittleChapter){
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝4"];
                cell.chapterName2.font = [UIFont fontWithName:BFfont size:14];
            }
        }else{
            if (node.chapterType == ChapterType_Chapter) {
                cell.imgView.image = [UIImage imageNamed:@"下拉拷贝"];
                cell.chapterName2.font = [UIFont fontWithName:BFfont size:15];
            }else if (node.chapterType == ChapterType_LittleChapter){
                cell.imageView2.image = [UIImage imageNamed:@"返回拷贝5"];
                cell.chapterName2.font = [UIFont fontWithName:BFfont size:14];
            }
        }
    }else if (node.chapterType == ChapterType_Course){
        cell.littleTitleLabel.text = node.cTitle;
        cell.timeLabel.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",node.cstarttime] dateFormat:@"MM月dd号 hh:mm"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",node.cendtime] dateFormat:@"hh:mm"]];
//        if (node.cKey == 0) {
//            cell.titleImgView.image = [UIImage imageNamed:@"直播"];
//        }else{
//            cell.titleImgView.image = [UIImage imageNamed:@"直播拷贝"];
//        }
        if (node.isSelect) {
            cell.titleImgView.image = [UIImage imageNamed:@"直播"];
            _curCell = cell;
        }else{
            cell.titleImgView.image = [UIImage imageNamed:@"直播拷贝"];
        }
    }
    NSLog(@"%@",node);
    
    return cell;
}


#pragma mark - Optional
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark - UITableViewDelegate

#pragma mark - Optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //先修改数据源
    BFCatalogueModel *parentNode = [_tempData objectAtIndex:indexPath.row];
    if (_treeTableCellDelegate && [_treeTableCellDelegate respondsToSelector:@selector(cellClick:)]) {
        [_treeTableCellDelegate cellClick:parentNode];
        if (parentNode.chapterType == ChapterType_Course) {
//            [MobClick event:@"watchVideoCourse"];
            _lastCell = _curCell;
            _curCell = [tableView cellForRowAtIndexPath:indexPath];
            _lastCell.titleImgView.image = [UIImage imageNamed:@"直播拷贝"];
            _curCell.titleImgView.image = [UIImage imageNamed:@"直播"];
            if (!parentNode.isSelect) {
                for (BFCatalogueModel *model in CList) {
                    if (model == parentNode) {
                        model.isSelect = YES;
                    }else{
                        model.isSelect = NO;
                    }
                }
            }
        }
    }
    NSUInteger startPosition = indexPath.row+1;
    NSUInteger endPosition = startPosition;
    BOOL expand = NO;
    for (int i=0; i<_data.count; i++) {
        BFCatalogueModel *node = [_data objectAtIndex:i];
        if (node.parentId == parentNode.cTId) {
            node.isShow = !node.isShow;
            if (node.isShow) {
                [_tempData insertObject:node atIndex:endPosition];
                expand = YES;
                endPosition++;
            }else{
                expand = NO;
                endPosition = [self removeAllNodesAtParentNode:parentNode];
                break;
            }
        }
    }
    
    //获得需要修正的indexPath
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (NSUInteger i=startPosition; i<endPosition; i++) {
        NSIndexPath *tempIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArray addObject:tempIndexPath];
    }
    
    BFCatalogueCell *cell = [self cellForRowAtIndexPath:indexPath];
    parentNode.isExpand = expand;
    //插入或者删除相关节点
    if (expand) {
        [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
        if(parentNode.chapterType == ChapterType_LittleChapter){
            cell.imageView2.image = [UIImage imageNamed:@"返回拷贝4"];
        }else if (parentNode.chapterType == ChapterType_Chapter){
            cell.imgView.image = [UIImage imageNamed:@"下拉"];
        }
    }else{
        [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
        if(parentNode.chapterType ==  ChapterType_LittleChapter){
            cell.imageView2.image = [UIImage imageNamed:@"返回拷贝5"];
        }else if (parentNode.chapterType ==  ChapterType_Chapter){
            cell.imgView.image = [UIImage imageNamed:@"下拉拷贝"];
        }
    }
//    [self reloadData];
}

/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param parentNode 父节点
 *
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */
-(NSUInteger)removeAllNodesAtParentNode : (BFCatalogueModel *)parentNode{
    NSUInteger startPosition = [_tempData indexOfObject:parentNode];
    NSUInteger endPosition = startPosition;
    for (NSUInteger i=startPosition+1; i<_tempData.count; i++) {
        BFCatalogueModel *node = [_tempData objectAtIndex:i];
        endPosition++;
        if (node.chapterType <= parentNode.chapterType) {
            break;
        }
        if(endPosition == _tempData.count-1){
            endPosition++;
            node.isShow = NO;
            break;
        }
        node.isShow = NO;
    }
    if (endPosition>startPosition) {
        [_tempData removeObjectsInRange:NSMakeRange(startPosition+1, endPosition-startPosition-1)];
    }
    return endPosition;
    
    
}

@end
