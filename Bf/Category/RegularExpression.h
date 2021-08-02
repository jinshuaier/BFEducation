//
//  RegularExpression.h
//  Bf
//
//  Created by 陈大鹰 on 2017/11/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegularExpression : NSObject
//银行卡正则表达式
+ (BOOL)checkCardNo:(NSString*)cardNo;
//身份证正则表达式
+ (BOOL) validateIdentityCard:(NSString *)identityCard;
//手机号的正则表达式
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
//网址的正则表达式
+ (NSString *)isUrlString:(NSString *)urlString;
//密码的正则表达式(数字+字母,而且在8-16位之间)
+(BOOL)judgePassWordLegal:(NSString *)pass;
@end
