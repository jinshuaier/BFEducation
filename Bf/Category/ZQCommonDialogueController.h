//
//  ZQCommonDialogueController.h
//  test
//
//  Created by Andy on 2016/12/7.
//  Copyright © 2016年 Andy. All rights reserved.
//

/*
 *  用来显示提示信息
 */

#import <Foundation/Foundation.h>

@interface ZQCommonDialogueController : NSObject

- (instancetype)initWithMsgTitle:(NSString *)msgTitle buttonTitle:(NSString *)buttonTitle;

- (void)show;

@end
