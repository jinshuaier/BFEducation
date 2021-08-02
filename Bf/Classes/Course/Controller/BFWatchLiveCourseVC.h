//
//  BFWatchLiveCourseVC.h
//  Bf
//
//  Created by 春晓 on 2017/12/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFWatchLiveCourseVC : BFBaseViewController

// 老师信息
@property (nonatomic , strong) NSDictionary *dict;

// 课程ID
@property (nonatomic , assign) NSInteger cid;

-(instancetype)initWithLeftLabelText:(NSString *)leftLabelText ;

@end
