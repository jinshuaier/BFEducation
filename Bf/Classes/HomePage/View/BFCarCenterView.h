//
//  BFCarCenterView.h
//  Bf
//
//  Created by 陈大鹰 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFCarCenterView : UIView
/*封面图*/
@property (nonatomic,strong) UIImageView *postImg;
/*名称*/
@property (nonatomic,strong) UILabel *postLbl;
/*播放按钮*/
@property (nonatomic,strong) UIImageView *playImg;
/*播放图标*/
@property (nonatomic,strong) UIImageView *icon;
/*播放数量*/
@property (nonatomic,strong) UILabel *num;
@end
