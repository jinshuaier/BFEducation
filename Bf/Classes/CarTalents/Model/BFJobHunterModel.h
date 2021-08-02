//
//  BFJobHunterModel.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/21.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFJobHunterModel : NSObject
/*姓名*/
@property (nonatomic,copy) NSString *jRName;
/*头像*/
@property (nonatomic,copy) NSString *jRPhoto;
/*工作经历*/
@property (nonatomic,assign) int jRYear;
/*用户主键*/
@property (nonatomic,assign) int uId;

-(instancetype)initWithDict:(NSDictionary *)dict;
@end
