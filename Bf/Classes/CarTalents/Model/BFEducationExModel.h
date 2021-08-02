//
//  BFEducationExModel.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/22.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFEducationExModel : NSObject
/*学校名称*/
@property (nonatomic,copy) NSString *jLSchool;
/*毕业时间时间戳*/
@property (nonatomic,copy) NSString *jLEndTime;
/*毕业时间str*/
@property (nonatomic,copy) NSString *jLEndTimeStr;
/*主键*/
@property (nonatomic,copy) NSString *jLId;
/*专业*/
@property (nonatomic,copy) NSString *jLLearn;
/*入学时间时间戳*/
@property (nonatomic,copy) NSString *jLStarTime;
/*入学时间str*/
@property (nonatomic,copy) NSString *jLStartTimeStr;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
