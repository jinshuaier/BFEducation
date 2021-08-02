//
//  BFSerCourseView.h
//  Bf
//
//  Created by 陈大鹰 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFSerCourseView : UIView
/*封面图*/
@property (nonatomic,strong) UIImageView *postImg;
/*名称*/
@property (nonatomic,strong) UILabel *postLbl;
/*名称*/
@property (nonatomic,strong) UIImageView *playImg;
/*图标*/
@property (nonatomic,strong) UIImageView *logoImg;
/*播放次数*/
@property (nonatomic,strong) UILabel *logoNumber;
@end
