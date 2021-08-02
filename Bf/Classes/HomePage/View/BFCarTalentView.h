//
//  BFCarTalentView.h
//  Bf
//
//  Created by 陈大鹰 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFCarTalentView : UIView
/*招聘职位*/
@property (nonatomic, strong) UILabel *companyJob;
/*招聘标签*/
@property (nonatomic,strong) UILabel *companyTip;
/*招聘地点*/
@property (nonatomic,strong) UILabel *companyLocation;
/*招聘年限*/
@property (nonatomic,strong) UILabel *companyYear;
/*招聘学位*/
@property (nonatomic,strong) UILabel *companyDegree;
/*招聘公司logo*/
@property (nonatomic,strong) UIImageView *companyLogo;
/*招聘公司名称*/
@property (nonatomic,strong) UILabel *companyName;
/*招聘薪水*/
@property (nonatomic,strong) UILabel *companyMoney;
/*招聘日期*/
@property (nonatomic,strong) UILabel *companyTime;
/*下划线*/
@property (nonatomic,strong) UIView *line;
@end
