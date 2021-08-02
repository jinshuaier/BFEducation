//
//  BFCreateCourseBtnCell.h
//  Bf
//
//  Created by 春晓 on 2018/5/23.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFCreateCourseBtnCellDelegate <NSObject>
- (void)commitAction;
- (void)cancelAction;
@end

@interface BFCreateCourseBtnCell : UITableViewCell
// 代理
@property (nonatomic , weak) id<BFCreateCourseBtnCellDelegate> delegate;
@end
