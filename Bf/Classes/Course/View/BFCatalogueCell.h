//
//  BFCatalogueCell.h
//  Bf
//
//  Created by 春晓 on 2017/12/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCatalogueModel.h"

@interface BFCatalogueCell : UITableViewCell
// 类型
@property (nonatomic , assign) ChapterType chapterType;
// 小图标
@property (nonatomic , strong) UIImageView *titleImgView;
// 小标题
@property (nonatomic , strong) UILabel *littleTitleLabel;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;
// 小节
@property (nonatomic, strong) UIImageView *imageView2;

@property (nonatomic, strong) UILabel *chapterName2;
// 章节
@property (nonatomic , strong) UIImageView *imgView;
// 
@property (nonatomic , strong) BFCatalogueModel *node;
@end
