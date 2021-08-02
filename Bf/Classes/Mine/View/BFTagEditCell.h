//
//  BFTagEditCell.h
//  Bf
//
//  Created by 春晓 on 2018/5/31.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFTagEditCell;

@protocol BFTagEditCellDelegate <NSObject>
- (void)deleteTagWith:(BFTagEditCell *)cell;
@end

@interface BFTagEditCell : UICollectionViewCell
// 代理
@property (nonatomic , weak) id<BFTagEditCellDelegate> delegate;

// tagLabel
@property (nonatomic , strong) UILabel *tagLabel;
// tagType 0=没有输入 1=已经输入
@property (nonatomic , assign) NSInteger tagType;
@end
