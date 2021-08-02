//
//  BFCommunityDetailsImgVideoCell.h
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFCommunityDetailsImgVideoCell : UITableViewCell
// 是否是视频
@property (nonatomic , assign) BOOL isVideo;
// 图片视频
@property (nonatomic , strong) UIImageView *imgVideoImageView;
// 文字
@property (nonatomic , strong) UILabel *bottomTextLabel;
@end
