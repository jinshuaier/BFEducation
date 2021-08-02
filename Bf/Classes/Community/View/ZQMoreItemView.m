//
//  ZQMoreItemView.m
//  ZQArbutus
//
//  Created by 陈大鹰 on 19/03/2017.
//  Copyright © 2017 ZQ. All rights reserved.
//

#import "ZQMoreItemView.h"

#define kItemBaseTag 300
@implementation ZQMoreItemView

- (id) initWithFrame:(CGRect)frame items:(NSArray *)items
{
  self = [super initWithFrame:frame];
  if (self) {
    
    //
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-25.f, 68.f, 14.f, 9.f)];
    arrowView.image = [UIImage imageNamed:@"item_top_arrrow.png"];
    [self addSubview:arrowView];
    
    //
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width-105.f, 77.f, 100.f, 16.5f*items.count)];
    itemView.layer.cornerRadius = 4.f;
    itemView.layer.masksToBounds = YES;
    itemView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    [self addSubview:itemView];
    
    //
    CGFloat y = 0.f;
    for (NSInteger i = 0; i < items.count; i+=2) {
      
      //
      UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
      itemButton.frame = CGRectMake(0.f, y, 100.f, 33.f);
      itemButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
      itemButton.imageEdgeInsets = UIEdgeInsetsMake(0.f, 12.f, 0.f, 0.f);
      itemButton.titleEdgeInsets = UIEdgeInsetsMake(0.f, 20.f, 0.f, 0.f);
      [itemButton setTitle:items[i] forState:UIControlStateNormal];
      [itemButton setImage:[UIImage imageNamed:items[i+1]] forState:UIControlStateNormal];
      [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      itemButton.titleLabel.font = [UIFont systemFontOfSize:14];
      [itemButton addTarget:self action:@selector(actionTouched:) forControlEvents:UIControlEventTouchUpInside];
      itemButton.tag = kItemBaseTag+i/2;
      [itemView addSubview:itemButton];
      
      //
      y += 33.f;
      
      //
      UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5.f, y, 90.f, 0.5)];
      lineView.backgroundColor = [UIColor whiteColor];
      [itemView addSubview:lineView];
    }
  }
  return self;
}

- (void) show
{
  self.alpha = 0.f;
  [[UIApplication sharedApplication].keyWindow addSubview:self];
  [UIView animateWithDuration:0.2 animations:^{
    self.alpha = 1.f;
  }];
}

- (void) hide
{
  [UIView animateWithDuration:0.2 animations:^{
    self.alpha = 0.f;
  } completion:^(BOOL finished) {
    [self removeFromSuperview];
  }];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self hide];
}

- (void) actionTouched:(UIButton *)sender
{
  self.selectedIndex = [sender tag] -kItemBaseTag;
  [self hide];
  [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
