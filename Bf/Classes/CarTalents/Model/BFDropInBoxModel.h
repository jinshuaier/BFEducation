//
//  BFDropInBoxModel.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/27.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFDropInBoxModel : NSObject
/*工作地址*/
@property (nonatomic,copy) NSString *bRName;
/*投递状态*/
@property (nonatomic,assign) int inFlag;
/*企业主键*/
@property (nonatomic,assign) int jCId;
/*企业LOGO*/
@property (nonatomic,copy) NSString *jCLogo;
/*企业名称*/
@property (nonatomic,copy) NSString *jCName;
/*最低学历*/
@property (nonatomic,assign) int jWDiploma;
/*职位主键*/
@property (nonatomic,assign) int jWId;
/*职位状态*/
@property (nonatomic,assign) int jWKey;
/*职位薪资*/
@property (nonatomic,assign) int jWMoney;
/*职位名称*/
@property (nonatomic,copy) NSString *jWName;
/*创建时间*/
@property (nonatomic,copy) NSString *jWTimeStr;
/*工作经历*/
@property (nonatomic,assign) int jWYear;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
