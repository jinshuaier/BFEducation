//
//  BFAlertViewController.h
//  Bf
//
//  Created by 春晓 on 2018/5/31.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

typedef NS_OPTIONS(NSInteger, ReasonType){
    ReasonType_LengthUnLegal,  // 长度不合法
    ReasonType_SymbolUnLegal   // 存在特定字符（,）
};

typedef void(^sureAction)(NSString *str , BOOL isLegal, ReasonType resaon);// 输入的字符串 是否合规 不合规定的原因

@interface BFAlertViewController : BFBaseViewController
// block
@property (nonatomic , copy) sureAction block;
// 便立构造器
+ (instancetype)BFAlertViewControllerWithTitle:(NSString *)title sureAction:(sureAction)block;

@end
