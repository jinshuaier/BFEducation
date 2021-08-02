//
//  BFCollectionViewImgCell.h
//  Bf
//
//  Created by 春晓 on 2017/11/27.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFCollectionViewImgCell : UICollectionViewCell
// 图片
@property (nonatomic , strong) UIImageView *imgView;
// 共几张
@property (nonatomic , strong) UILabel *totalCountLabel;
@end
