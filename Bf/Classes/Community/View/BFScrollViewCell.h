//
//  BFScrollViewCell.h
//  Bf
//
//  Created by 春晓 on 2017/11/27.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLScrollView.h"

@protocol BFScrollViewCellDelegate <WLSubViewDelegate>


@end

@interface BFScrollViewCell : UITableViewCell
// 轮播图
@property (nonatomic , strong) WLScrollView *topScrollView;

// 数据
@property (nonatomic , strong) NSMutableArray *scrollArray;
@end
