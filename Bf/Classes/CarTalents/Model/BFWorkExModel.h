//
//  BFWorkExModel.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/22.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFWorkExModel : NSObject

/*企业名称*/
@property (nonatomic,copy) NSString *jECompany;
/*工作内容*/
@property (nonatomic,copy) NSString *jEContent;
/*离职时间时间戳*/
@property (nonatomic,copy) NSString *jEEndTime;
/*离职时间str*/
@property (nonatomic,copy) NSString *jEEndTimeStr;
/*主键*/
@property (nonatomic,copy) NSString *jEId;
/*职位*/
@property (nonatomic,copy) NSString *jEJob;
/*入职时间时间戳*/
@property (nonatomic,copy) NSString *jEStartTime;
/*入职时间str*/
@property (nonatomic,copy) NSString *jEStartTimeStr;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
