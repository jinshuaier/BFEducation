//
//  BFJobListModel.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/20.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFJobListModel : NSObject
/*工作地点*/
@property (nonatomic,copy) NSString *bRName;
/*投递状态*/
@property (nonatomic,assign) int inFlag;
/*公司logo*/
@property (nonatomic,copy) NSString *jCLogo;
/*企业名称*/
@property (nonatomic,copy) NSString *jCName;
/*职位名称*/
@property (nonatomic,copy) NSString *jWName;
/*学历要求*/
@property (nonatomic,assign) int jWDiploma;
/*职位主键*/
@property (nonatomic,assign) int jWId;
/*薪资*/
@property (nonatomic,assign) int jWMoney;
/*时间*/
@property (nonatomic,copy) NSString *jWTimeStr;
/*工作年限*/
@property (nonatomic,assign) int jWYear;
/*头像数组*/
@property (nonatomic,strong) NSArray *inPhotos;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
