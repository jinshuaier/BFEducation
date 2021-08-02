//
//  HeaderScrollview.h
//  ScrollviewDemo
//
//  Created by zzq on 2018/2/8.
//  Copyright © 2018年 zzq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderScrollviewDelegate<NSObject>

@required
- (void)header_disSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HeaderScrollview : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/**数据源**/
@property (nonatomic, strong) NSMutableArray *dataSource;
/**使用代理不使用 block 的原因是 block 很难释放掉**/
@property (nonatomic, assign) id<HeaderScrollviewDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedIndex;

- (void)scrollCollectionItemToDesWithDesIndex:(NSInteger)index;

- (void)reloadData;

- (void)changeSelectedItemWithIndex:(NSInteger)index;
@end
