//
//  BFCreateCourseImgCell.h
//  Bf
//
//  Created by 春晓 on 2018/5/23.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFCreateCourseImgCellDelegate <NSObject>
- (void)selectLogoAction;
@end

@interface BFCreateCourseImgCell : UITableViewCell
// 左边的label
@property (nonatomic , strong) UILabel *leftLabel;
// 封面图
@property (nonatomic , strong) UIImageView *logoImgView;
// 代理
@property (nonatomic , weak) id<BFCreateCourseImgCellDelegate> delegate;
@end
