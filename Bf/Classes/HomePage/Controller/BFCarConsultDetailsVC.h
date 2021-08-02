//
//  BFCarConsultDetailsVC.h
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFCarNewsModel.h"

@interface BFCarConsultDetailsVC : BFBaseViewController
// 车资讯数据
@property (nonatomic , strong) BFCarNewsModel *carNewModel;
/*车资讯封面图*/
@property (nonatomic,assign) NSInteger num;
// nId
@property (nonatomic , assign) NSInteger nId;
// 是否是从其他应用里跳进来的
@property (nonatomic , assign) BOOL isFromOtherApp; // YES : 是;NO : 不是
@end
