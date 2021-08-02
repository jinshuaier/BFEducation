//
//  BFJobStyleModel.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/29.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFJobStyleModel : NSObject
/*职位类别id*/
@property (nonatomic,copy) NSString *jtid;
/*职位类别名称*/
@property (nonatomic,copy) NSString *jttitle;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
