//
//  BFBFMyCourseHavePubCell.h
//  Bf
//
//  Created by 春晓 on 2018/5/24.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFMyCourseHavePubCell;

@protocol BFBFMyCourseHavePubCellDelegate <NSObject>

- (void)editAction:(BFMyCourseHavePubCell *)cell;

- (void)publishAction:(BFMyCourseHavePubCell *)cell;

@end

@interface BFMyCourseHavePubCell : UITableViewCell
// data
@property (nonatomic , strong) NSDictionary *dict;
// 代理
@property (nonatomic , weak) id<BFBFMyCourseHavePubCellDelegate> delegate;

@end
