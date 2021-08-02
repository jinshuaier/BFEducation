//
//  ZQCommonDialogueController.m
//  test
//
//  Created by Andy on 2016/12/7.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQCommonDialogueController.h"

@interface ZQCommonDialogueController ()

@property (strong, nonatomic, readwrite) UIAlertController *alertController;

@end

@implementation ZQCommonDialogueController

- (instancetype)initWithMsgTitle:(NSString *)msgTitle buttonTitle:(NSString *)buttonTitle
{
    self = [super init];
    if (self)
    {
        self.alertController = [UIAlertController alertControllerWithTitle:msgTitle message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:nil];
        
        [self.alertController addAction:alertAction];
    }
    
    return self;
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:self.alertController animated:YES completion:nil];
}

@end
