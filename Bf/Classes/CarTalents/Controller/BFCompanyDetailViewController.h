//
//  BFCompanyDetailViewController.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/9.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFCompanyDetailViewController : BFBaseViewController
/*获取数据*/
@property (nonatomic,strong) NSDictionary *dic;
/*企业查看自己简历详情*/
@property (nonatomic,copy) NSString *isCompany;
/*用户在投递箱中查看自己投递的公司*/
@property (nonatomic,copy) NSString *isPost;
@end
