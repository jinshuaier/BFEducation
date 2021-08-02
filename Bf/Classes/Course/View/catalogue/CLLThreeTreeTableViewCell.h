//
//  ThreeTableViewCell.h
//  WLN_Tianxing
//
//  Created by wln100-IOS1 on 15/12/23.
//  Copyright © 2015年 TianXing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLLThreeTreeTableViewCell : UITableViewCell
// 小图标
@property (nonatomic , strong) UIImageView *titleImgView;
// 小标题
@property (nonatomic , strong) UILabel *littleTitleLabel;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;
@end
