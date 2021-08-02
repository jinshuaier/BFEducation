//
//  BFCarEvaluateReplyCell.h
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCarEvaluateReplyModel.h"

@interface BFCarEvaluateReplyCell : UITableViewCell
// 咨询数据
@property (nonatomic , strong) BFCarEvaluateReplyModel *evaluateReplyModel;
// 回复
@property (nonatomic , strong) UILabel *replyLabel;
@end
