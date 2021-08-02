//
//  ZQDialogueView.m
//  test
//
//  Created by Andy on 2016/12/1.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ZQDialogueView.h"

@interface ZQDialogueView ()

@property (strong, nonatomic, readwrite) BlockInner blk;

@end

@implementation ZQDialogueView

- (instancetype)initWithActions:(NSArray *)arrayActions block:(BlockInner)blk
{
    self = [super init];
    if (self)
    {
        self.blk = [blk copy];
        self.backgroundColor = [UIColor whiteColor];
        
        float heightSum = 50 * arrayActions.count + 50 + (arrayActions.count - 1) * 1 + 5;
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, heightSum);
        
        float height = 0.0f;
        
        for (int i = 0; i < arrayActions.count; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i + 1;
            button.frame = CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, 50);
            [button setTitle:[arrayActions objectAtIndex:i] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
            [button setTitleColor:ColorRGBValue(0x000000) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            height += 50;
            
            UIView *viewLine = [[UIView alloc] init];
            viewLine.backgroundColor = ColorRGBValue(0xdedede);
            if (i == arrayActions.count - 1)
            {
                viewLine.frame = CGRectMake(0, height , [UIScreen mainScreen].bounds.size.width, 5);
                height += 5;
            }
            else
            {
                viewLine.frame = CGRectMake(0, height , [UIScreen mainScreen].bounds.size.width, 1);
                height += 1;
            }
            [self addSubview:viewLine];
        }
        
        UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancel.tag = 0;
        buttonCancel.frame = CGRectMake(0, height, [UIScreen mainScreen].bounds.size.width, 50);
        [buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [buttonCancel.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [buttonCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonCancel addTarget:self action:@selector(onClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:buttonCancel];

        CGRect rect = self.frame;
        rect.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.frame = rect;
        
        [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:self];
        
    }
    
    return self;
}

- (void)onClickButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    self.blk((int)button.tag);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
