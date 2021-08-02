//
//  BFCommunityDetailsTopCell.h
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCommunityModel.h"

@protocol BFCommunityModelDelegate <NSObject>
- (void)deleteAction;
- (void)editActionWithBtn:(UIButton *)btn;
@end

@interface BFCommunityDetailsTopCell : UITableViewCell

@property (nonatomic , strong) BFCommunityModel *model;
// 标题
@property (nonatomic , strong) UILabel *titleLabel;
// 正文
@property (nonatomic , strong) UILabel *contentLabel;
// 是否是自己发的
@property (nonatomic , assign) BOOL isSelfSend;
// 代理
@property (nonatomic , strong) id<BFCommunityModelDelegate> delegate;
@end
