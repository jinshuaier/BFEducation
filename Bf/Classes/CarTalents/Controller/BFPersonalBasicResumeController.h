//
//  BFPersonalBasicResumeController.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/19.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFPersonalBasicResumeController : BFBaseViewController
/*数据字典*/
@property (nonatomic,strong) NSDictionary *dic;
/*期望职位类别*/
@property (nonatomic,copy) NSString *hopeStr;
/*基础简历是否可编辑*/
@property (nonatomic,copy) NSString *editResume;
@end
