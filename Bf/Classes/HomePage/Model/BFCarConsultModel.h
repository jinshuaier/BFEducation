//
//  BFCarConsultModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BFCarConsultContentModel.h"
#import "BFEvaluateModel.h"

@interface BFCarConsultModel : NSObject
// 内容数组
@property (nonatomic , strong) NSArray<BFCarConsultContentModel *> *contentArray;

// 精彩评论
@property (nonatomic , strong) NSMutableArray <BFEvaluateModel *> *wonderfulEvaluateArray;
// 最新评论
@property (nonatomic , strong) NSMutableArray <BFEvaluateModel *> *newestEvaluateArray;
// 是否有精彩评论
@property (nonatomic , assign) BOOL haveWonderfulEvaluate;
// 是否有最新评论
@property (nonatomic , assign) BOOL haveNewestEvaluate;
@end
