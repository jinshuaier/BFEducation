//
//  BFCourseListVC.h
//  Bf
//
//  Created by 春晓 on 2017/12/20.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFCourseListVC : BFBaseViewController
// 0 即将开始 1 精彩回放 2 系列课程
@property (nonatomic , assign) NSInteger cKey;
// 0全部 1燃油汽车 2电动汽车 3混动汽车 4养护常识 5维修技能
@property (nonatomic , assign) NSInteger coid;
// 所选中tab序号
@property (nonatomic , assign) NSInteger selectedIndex;
// 新能源课堂id
@property (nonatomic , assign) NSInteger cid;

-(void)scrollToXNY;

@end
