//
//  BFTipsCell.h
//  Bf
//
//  Created by 陈大鹰 on 2018/2/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BFTipsCell : UITableViewCell
/*用户头像*/
@property (nonatomic,strong) UIImageView *headImg;
/*用户昵称*/
@property (nonatomic,strong) UILabel *headNickname;
/*帖子标题*/
@property (nonatomic,strong) UILabel *tipTitle;
/*帖子缩略图*/
@property (nonatomic,strong) UIImageView *tipImg;
/*观看图标*/
@property (nonatomic,strong) UIImageView *watchImg;
/*观看人数*/
@property (nonatomic,strong) UILabel *watchLbl;
/*点赞图标*/
@property (nonatomic,strong) UIImageView *zanImg;
/*点赞人数*/
@property (nonatomic,strong) UILabel *zanLbl;
/*下划线*/
@property (nonatomic,strong) UIView *line;
@end
