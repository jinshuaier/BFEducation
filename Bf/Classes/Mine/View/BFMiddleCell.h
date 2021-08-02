//
//  BFMiddleCell.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/8.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFMiddleCell : UITableViewCell
/*100元*/
@property (nonatomic,strong) UIButton *Img1;
/*200元*/
@property (nonatomic,strong) UIButton *Img2;
/*300元*/
@property (nonatomic,strong) UIButton *Img3;
/*1000元*/
@property (nonatomic,strong) UIButton *Img4;
/*自定义输入框*/
@property (nonatomic,strong) UITextField *moneyField;
/*下划线*/
@property (nonatomic,strong) UIView *line;
//100元点击
@property (nonatomic,copy) void(^imgBlock1)();
//200元点击
@property (nonatomic,copy) void(^imgBlock2)();
//300元点击
@property (nonatomic,copy) void(^imgBlock3)();
//1000元点击
@property (nonatomic,copy) void(^imgBlock4)();
/*微信图标*/
@property (nonatomic,strong) UIImageView *wxImg;
/*微信提示文字*/
@property (nonatomic,strong) UILabel *wxLabel;
/*微信点击按钮*/
@property (nonatomic,strong) UIButton *wxBtn;
/*支图标*/
@property (nonatomic,strong) UIImageView *alipayImg;
/*支提示文字*/
@property (nonatomic,strong) UILabel *alipayLabel;
/*支点击按钮*/
@property (nonatomic,strong) UIButton *alipayBtn;
@end
