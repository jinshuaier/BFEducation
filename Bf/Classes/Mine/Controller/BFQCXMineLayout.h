//
//  QCXCollectionViewLayout.h
//  简单的瀑布流
//
//  Created by 春晓 on 2017/11/28.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFQCXMineLayout;

@protocol BFQCXMineLayoutDelegate <NSObject>

@optional
// 列数
- (NSInteger)columnCountInFallsLayout:(BFQCXMineLayout *)fallsLayout;
// 列间距
- (CGFloat)columnMarginInFallsLayout:(BFQCXMineLayout *)fallsLayout;
// 行间距
- (CGFloat)rowMarginInFallsLayout:(BFQCXMineLayout *)fallsLayout;
// collectionView边距
- (UIEdgeInsets)edgeInsetsInFallsLayout:(BFQCXMineLayout *)fallsLayout;
@end

@interface BFQCXMineLayout : UICollectionViewLayout
// 代理
@property (nonatomic , weak) id<BFQCXMineLayoutDelegate> delegate;
@end
