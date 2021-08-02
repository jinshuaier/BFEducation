//
//  BFResumeManagementViewController.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/22.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFResumeManagementViewController : BFBaseViewController
/*数据字典*/
@property (nonatomic,strong) NSDictionary *dic;
/*工作经历数组*/
@property (nonatomic,strong) NSMutableArray *workArr;
/*教育经历数组*/
@property (nonatomic,strong) NSMutableArray *eduArr;
@end
