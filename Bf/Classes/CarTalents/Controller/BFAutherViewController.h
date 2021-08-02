//
//  BFAutherViewController.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/9.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFAutherViewController : BFBaseViewController
/*企业认证是否通过*/
@property (nonatomic,copy) NSString *isAuth;
/*企业认证信息*/
@property (nonatomic,strong) NSDictionary *authDic;
@end
