//
//  ZQCustomViewController.m
//  test
//
//  Created by Andy on 2016/12/1.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ZQDialogueViewController.h"
#import "ZQDialogueView.h"
#import "ZQDialogueViewBackground.h"

@interface ZQDialogueViewController ()

@property (strong, nonatomic, readwrite) ZQDialogueView *dialogueView;
@property (strong, nonatomic, readwrite) ZQDialogueViewBackground *dialogueViewBackground;

@end

@implementation ZQDialogueViewController

- (instancetype)initWithActions:(NSArray *)arrayActions  block:(Block)blk
{
    self = [super init];
    
    if (self)
    {
        self.dialogueViewBackground = [[ZQDialogueViewBackground alloc] initWithBlock:^(int index) {
            [self removeView];
        }];
        
        self.dialogueView = [[ZQDialogueView alloc] initWithActions:arrayActions block:^(int index) {
            [self removeView];
            blk(index);
            
        }];
    }
    
    return self;
}

- (void)removeView
{
    [UIView animateWithDuration:0.3f animations:^{
        self.dialogueViewBackground.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.dialogueViewBackground removeFromSuperview];
    }];
    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = self.dialogueView.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.dialogueView.frame = rect;
        
    } completion:^(BOOL finished) {
        [self.dialogueView removeFromSuperview];
        
    }];
}

- (void)show
{
    //Add backgroud
    [UIView animateWithDuration:0.3f animations:^{
        self.dialogueViewBackground.alpha = 0.8f;
    }];
    
    [UIView animateWithDuration:0.3f animations:^{
        CGRect rect = self.dialogueView.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height - rect.size.height;
        self.dialogueView.frame = rect;
    }];
}


@end
