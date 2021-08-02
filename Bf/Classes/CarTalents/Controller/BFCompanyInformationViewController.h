//
//  BFCompanyInformationViewController.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/12.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFCompanyInformationViewController : BFBaseViewController
/*企业信息是否完善状态值*/
@property (nonatomic,copy) NSString *informationStr;
/*企业认证信息*/
@property (nonatomic,strong) NSDictionary *inDic;
/*企业主键*/
@property (nonatomic,strong) NSString *jCid;

@end
