//
//  BFCarEvalucateCell.h
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCarEvaluateModel.h"

@class BFCarEvalucateCell;

@protocol BFCarEvalucateCellDelegate <NSObject>
- (void)evaluateLikeBtnClick:(BFCarEvalucateCell *)cell;
@end

@interface BFCarEvalucateCell : UITableViewCell
// 数据
@property (nonatomic , strong) BFCarEvaluateModel *model;
// 点赞
@property (nonatomic , strong) UIButton *likeBtn;
// 评论
@property (nonatomic , strong) UILabel *evaluateLabel;
// 代理
@property (nonatomic , weak) id<BFCarEvalucateCellDelegate> delegate;
// 分割线
@property (nonatomic , strong) UIView *lineView;
@end
