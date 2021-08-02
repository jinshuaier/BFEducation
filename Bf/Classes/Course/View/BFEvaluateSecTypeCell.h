//
//  BFEvaluateSecTypeCell.h
//  NewTest
//
//  Created by 春晓 on 2017/12/4.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFEvaluateModel.h"

@class BFEvaluateSecTypeCell;

@protocol BFEvaluateSecTypeCellDelegate <NSObject>
- (void)evaluateLikeBtnClick:(BFEvaluateSecTypeCell *)cell;
@end

@interface BFEvaluateSecTypeCell : UITableViewCell
// 数据
@property (nonatomic , strong) BFEvaluateModel *model;
// 点赞
@property (nonatomic , strong) UIButton *likeBtn;
// 评论
@property (nonatomic , strong) UILabel *evaluateLabel;
// 代理
@property (nonatomic , weak) id<BFEvaluateSecTypeCellDelegate> delegate;
// 分割线
@property (nonatomic , strong) UIView *lineView;
@end
