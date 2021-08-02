//
//  BFRegisterByPasswordViewController.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/13.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFRegisterByPasswordViewController : BFBaseViewController
/*手机号*/
@property (nonatomic,copy) NSString *phoneNum;
/*验证码*/
@property (nonatomic,copy) NSString *yzCode;
@end
