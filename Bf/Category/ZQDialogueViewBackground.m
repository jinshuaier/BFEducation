//
//  ZQDialogueViewBackground.m
//  test
//
//  Created by Andy on 2016/12/1.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ZQDialogueViewBackground.h"

@interface ZQDialogueViewBackground ()

@property (strong, nonatomic, readwrite) BlockInner block;

@end

@implementation ZQDialogueViewBackground

- (instancetype)initWithBlock:(BlockInner)block
{
    self = [super init];
    if (self)
    {
        self.block = block;
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.0f;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGestureRecognizer:)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
    }
    
    return self;
}

- (void)onTapGestureRecognizer:(id)sender
{
    self.block(0);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
