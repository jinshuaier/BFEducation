//
//  BFExperienceListCell.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/20.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFWorkExModel.h"
#import "BFEducationExModel.h"
@interface BFExperienceListCell : UITableViewCell
/*时间轴图标*/
@property (nonatomic,strong) UIImageView *timeLineImage;
/*时间轴竖线*/
@property (nonatomic,strong) UIView *timeLine;
/*经历时间*/
@property (nonatomic,strong) UILabel *experienceTime;
/*毕业学校/工作公司*/
@property (nonatomic,strong) UILabel *company;
/*职位*/
@property (nonatomic,strong) UILabel *position;
/*经历内容*/
@property (nonatomic,strong) UILabel *experienceContent;
/*编辑按钮*/
@property (nonatomic,strong) UIButton *editBtn;
/*是否显示编辑按钮*/
@property (nonatomic,copy) NSString *isShow;
/*是否是最后一组数据 1-显示时间轴 0-不显示时间轴*/
@property (nonatomic,copy) NSString *isLastData;
@property (nonatomic,copy) void(^pushEditBlock)();

/*model*/
@property (nonatomic,strong) BFWorkExModel *dataModel;

/*model*/
@property (nonatomic,strong) BFEducationExModel *dataModel1;
@end
