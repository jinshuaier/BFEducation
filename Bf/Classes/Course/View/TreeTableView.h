//
//  TreeTableView.h
//  TreeTableView
//
//  Created by yixiang on 15/7/3.
//  Copyright (c) 2015年 yixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFCatalogueModel;

@protocol TreeTableCellDelegate <NSObject>

-(void)cellClick : (BFCatalogueModel *)node;

@end

@interface TreeTableView : UITableView

@property (nonatomic , weak) id<TreeTableCellDelegate> treeTableCellDelegate;

@property (nonatomic , strong) NSMutableArray *data;//传递过来已经组织好的数据（全量数据）

@property (nonatomic , strong) NSDictionary *dataDict;
-(instancetype)initWithFrame:(CGRect)frame withData : (NSArray *)data;
-(instancetype)initWithFrame:(CGRect)frame withDict : (NSDictionary *)data;
- (void)relodeData;// 自定义刷新
@end
