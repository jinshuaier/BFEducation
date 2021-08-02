//
//  BFCompanyJobListCell.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/20.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFJobListModel.h"
@interface BFCompanyJobListCell : UITableViewCell
/*投递简历人头像0*/
@property (nonatomic,strong) UIImageView *img0;
/*投递简历人头像1*/
@property (nonatomic,strong) UIImageView *img1;
/*投递简历人头像2*/
@property (nonatomic,strong) UIImageView *img2;
/*投递简历人头像3*/
@property (nonatomic,strong) UIImageView *img3;
/*投递简历的人视图*/
@property (nonatomic,strong) UIView *backView;
/*点击按钮*/
@property (nonatomic,strong) UIButton *rightBtn;
/*model*/
@property (nonatomic,strong) BFJobListModel *dataModel;

@property (nonatomic,copy) void(^pushWatchBlock)();
@end
