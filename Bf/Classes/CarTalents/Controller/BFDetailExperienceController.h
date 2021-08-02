//
//  BFDetailExperienceController.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/22.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"
#import "BFWorkExModel.h"
#import "BFEducationExModel.h"
@interface BFDetailExperienceController : BFBaseViewController
/*title*/
@property (nonatomic,copy) NSString *exTitle;
/*标签 0-工作经历 1-教育经历*/
@property (nonatomic,copy) NSString *exStyle;
/*model*/
@property (nonatomic,strong) BFWorkExModel *model00;
/*model*/
@property (nonatomic,strong) BFEducationExModel *model11;
/*编辑 0-未编辑状态 1-编辑状态*/
@property (nonatomic,copy) NSString *edit;
@end
