//
//  BFFourClassView.h
//  Bf
//
//  Created by 陈大鹰 on 2018/1/15.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFFourClassView : UIView
/*课程封面图*/
@property (nonatomic,strong) UIImageView *classImg;
/*课程播放按钮*/
@property (nonatomic,strong) UIImageView *playImg;
/*课程类型标签*/
@property (nonatomic,strong) UIButton *classStyle;
/*课程标题*/
@property (nonatomic,strong) UILabel *classTitle;
/*主讲人头像*/
@property (nonatomic,strong) UIImageView *classTeacher;
/*主讲人名称*/
@property (nonatomic,strong) UILabel *teacherName;
/*主讲人标签*/
@property (nonatomic,strong) UIImageView *teacherImg;
/*播放次数*/
@property (nonatomic,strong) UILabel *playNumber;
@end
