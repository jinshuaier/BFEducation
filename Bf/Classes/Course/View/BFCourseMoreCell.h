//
//  BFCourseMoreCell.h
//  Bf
//
//  Created by 春晓 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFCourseMoreCell;

@protocol BFCourseMoreCellDelegate <NSObject>
- (void)moreCourse:(BFCourseMoreCell *)cell;
@end

@interface BFCourseMoreCell : UITableViewCell
// 代理
@property (nonatomic , weak) id<BFCourseMoreCellDelegate> delegate;
@end

