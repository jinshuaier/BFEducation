//
//  BFCarConsultContentImageCell.h
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFCarConsultContentImageCell : UITableViewCell
// 图片
@property (nonatomic , strong) UIImageView *contentImageView;
// 是否是视频
@property (nonatomic , assign) BOOL isVideo;
@end
