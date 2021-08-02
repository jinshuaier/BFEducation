//
//  BFPlaybackCell.h
//  Bf
//
//  Created by 春晓 on 2018/5/24.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFCoursePlaybackCell;

@protocol BFPlaybackCellDelegate <NSObject>

- (void)editAction:(BFCoursePlaybackCell *)cell;

- (void)publishAction:(BFCoursePlaybackCell *)cell;

@end

@interface BFCoursePlaybackCell : UITableViewCell

// 代理
@property (nonatomic , weak) id<BFPlaybackCellDelegate> delegate;

@end
