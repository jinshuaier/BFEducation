//
//  BFPreviewTopCell.h
//  Bf
//
//  Created by 陈大鹰 on 2018/4/4.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFPreviewTopCell : UITableViewCell
/*背景视图*/
@property (nonatomic,strong) UIView *backView;
/*简历标题*/
@property (nonatomic,strong) UILabel *titleOne;
/*简历头像*/
@property (nonatomic,strong) UIImageView *headImg;
/*简历名称*/
@property (nonatomic,strong) UILabel *nickName;
/*附件简历*/
@property (nonatomic,strong) UILabel *exResume;
@property (nonatomic,copy) void(^pushResumeBlock)();
@end
