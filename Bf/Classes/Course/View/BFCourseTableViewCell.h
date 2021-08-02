//
//  BFCourseTableViewCell.h
//  Bf
//
//  Created by 春晓 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFCourseTableViewCell;

@protocol BFCourseTableViewCellDelegate <NSObject>
- (void)courseClickActionWithItem:(NSInteger)Item withCell:(BFCourseTableViewCell *)cell;
@end

@interface BFCourseTableViewCell : UITableViewCell
// data
@property (nonatomic , strong) NSArray *courseArray;
// delegate
@property (nonatomic , weak) id<BFCourseTableViewCellDelegate> delegate;
@end
