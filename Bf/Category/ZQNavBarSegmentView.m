//
//  ZQNavBarSegmentView.m
//  Bf
//
//  Created by 陈大鹰 on 2017/11/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "ZQNavBarSegmentView.h"
#import "UIButton+Badge.h"
@interface ZQNavBarSegmentView ()
@property (nonatomic, strong) NSArray * segmentArray;
@property (nonatomic, strong) UIImageView * bottomView;
@property (nonatomic, assign) BOOL isFirst;

@end

@implementation ZQNavBarSegmentView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置文字下划线颜色为蓝色
//        _toolsColor = RGBColor(0, 126, 212);
        _isFirst = YES;
        [self setupButton];
    }
    return self;
}

-(void)setBadgeHidden:(BOOL)badgeHidden
{
    for (UIButton * targetButton in self.subviews) {
        
        if (targetButton.tag == _titlesArray.count - 1) {
            UIImageView * red = [[UIImageView alloc] initWithFrame:CGRectMake(targetButton.width - 10, 10, 7, 7)];
            red.layer.cornerRadius = 3.5;
            red.backgroundColor = [UIColor redColor];
            [targetButton addSubview:red];
            if (badgeHidden == YES) {
                red.hidden = YES;
                
            }else {
                red.hidden = NO;
            }
        }
    }
}

-(void)setupButton
{
    self.bottomView = [[UIImageView alloc] init];
    self.bottomView.backgroundColor = self.toolsColor;
    [self addSubview:self.bottomView];
    NSMutableArray * segmentTempArray = [NSMutableArray array];
    for (int i =0; i < 2; i ++) {
        UIButton * segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i == 0) {
            [segmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [segmentButton.titleLabel setFont:[UIFont fontWithName:BFfont size:15.0f]];
        }else {
            [segmentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [segmentButton.titleLabel setFont:[UIFont fontWithName:BFfont size:13.0f]];
        }
        [segmentButton addTarget:self action:@selector(segmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        segmentButton.tag = i;
        [self addSubview:segmentButton];
        [segmentTempArray addObject:segmentButton];
    }
    self.segmentArray = [segmentTempArray copy];
}

-(void)setChangeColor:(NSString *)changeColor
{
    _changeColor = changeColor;
    if ([_changeColor isEqualToString:@"change"]) {
        UIButton * button = [self.segmentArray objectAtIndex:1];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    else if ([_changeColor isEqualToString:@"special"]) {
        UIButton * button = [self.segmentArray objectAtIndex:0];
        [button setTitleColor:ColorRGBValue(0x999999) forState:UIControlStateNormal];
        
        UIButton *btn1 = [self.segmentArray objectAtIndex:1];
        [btn1 setTitleColor:ColorRGBValue(0xffdc30) forState:UIControlStateNormal];
        self.bottomView.frame = CGRectMake(btn1.left - 8, self.frame.size.height - 2, btn1.size.width + 16, 2);
    }
    else if ([_changeColor isEqualToString:@"specialOne"]) {
        
        UIButton *btn1 = [self.segmentArray objectAtIndex:1];
        [btn1 setTitleColor:ColorRGBValue(0xffdc30) forState:UIControlStateNormal];
        [self.bottomView setBackgroundColor:ColorRGBValue(0xffdc30)];
        self.bottomView.frame = CGRectMake(btn1.left - 8, self.frame.size.height - 2, btn1.size.width + 16, 2);
    }
    else {
        UIButton * manButton = [self.segmentArray objectAtIndex:2];
        [manButton setTitleColor:self.toolsColor forState:UIControlStateNormal];
    }
}

-(void)setToolsColor:(UIColor *)toolsColor
{
    //ColorRGBValue(0xffdc30)
//    _toolsColor = toolsColor;
    self.bottomView.backgroundColor = [UIColor clearColor];
    UIButton * tempButton = [self.segmentArray objectAtIndex:0];
    if (_isFirst) {
        [tempButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempButton.titleLabel setFont:[UIFont fontWithName:BFfont size:15.0f]];
        _isFirst = NO;
    }
    else {
        [tempButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempButton.titleLabel setFont:[UIFont fontWithName:BFfont size:13.0f]];
    }
}

-(void)segmentButtonAction:(UIButton *)sender
{
    for (long i = 0; i < self.segmentArray.count; i++) {
        UIButton * tempButton = [self.segmentArray objectAtIndex:i];
        [tempButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [tempButton.titleLabel setFont:[UIFont fontWithName:BFfont size:13.0f]];
        
        if (tempButton.tag == sender.tag) {
            [tempButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [tempButton.titleLabel setFont:[UIFont fontWithName:BFfont size:15.0f]];
        }
    }
    [self.delegate selectAtIdx:[NSString stringWithFormat:@"%ld",(long)sender.tag] with:sender.titleLabel.text];
    CGFloat buttonWidth = 60;
    CGFloat bottomWidth = 40;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.frame = CGRectMake(bottomWidth / 2 + buttonWidth * sender.tag - 10, self.frame.size.height - 2, 40, 2);
    }];
}

-(void)setTitlesArray:(NSArray *)titlesArray
{
    _titlesArray = titlesArray;
    for (long i = titlesArray.count; i < self.segmentArray.count; i++) {
        UIButton * tempButton = [self.segmentArray objectAtIndex:i];
        tempButton.hidden = YES;
    }
    __block CGRect oldRect = CGRectZero;
    [_titlesArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton * segmentButton = [self.segmentArray objectAtIndex:idx];
        [segmentButton setTitle:obj forState:UIControlStateNormal];
        
        CGFloat buttonWidth = self.width / titlesArray.count;
        
        segmentButton.frame = CGRectMake(buttonWidth * idx, 0, buttonWidth, self.height - 2);
        oldRect = segmentButton.frame;
    }];
    self.bottomView.frame = CGRectMake(10, self.frame.size.height - 2, 40, 2);
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    UIButton * sender = [self.segmentArray objectAtIndex:currentIndex];
    if (currentIndex < self.segmentArray.count) {
        for (long i = 0; i < self.segmentArray.count; i++) {
            UIButton * tempButton = [self.segmentArray objectAtIndex:i];
            if (i == currentIndex) {
                [tempButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [tempButton.titleLabel setFont:[UIFont fontWithName:BFfont size:15.0f]];
            }else{
                [tempButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [tempButton.titleLabel setFont:[UIFont fontWithName:BFfont size:13.0f]];
            }
        }
    }
    CGFloat buttonWidth = 60;
    CGFloat bottomWidth = 40;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.frame = CGRectMake(bottomWidth / 2 + buttonWidth * sender.tag - 10, self.frame.size.height - 2, 40, 2);
    }];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}
@end
