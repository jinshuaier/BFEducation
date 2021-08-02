//
//  BFCommunityDetailsVC.h
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFCommunityModel.h"

@interface BFCommunityDetailsVC : BFBaseViewController
// 数据
@property (nonatomic , strong) BFCommunityModel *model;
// 是否是从其他应用里跳进来的
@property (nonatomic , assign) BOOL isFromOtherApp; // YES : 是;NO : 不是
@end
