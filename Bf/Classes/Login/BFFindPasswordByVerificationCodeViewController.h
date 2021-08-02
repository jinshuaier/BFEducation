//
//  BFFindPasswordByVerificationCodeViewController.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

@interface BFFindPasswordByVerificationCodeViewController : BFBaseViewController
/*来源 ---- 1为三方登录绑定手机号 2-验证码登录 */
@property (nonatomic,copy) NSString *style;
/*三方登录类型*/
@property (nonatomic,copy) NSString *thirdType;
/*三方登录key*/
@property (nonatomic,copy) NSString *thirdKey;
/*昵称*/
@property (nonatomic,copy) NSString *nickName;
/*头像*/
@property (nonatomic,copy) NSString *userImg;
/*性别*/
@property (nonatomic,copy) NSString *isex;
@end
