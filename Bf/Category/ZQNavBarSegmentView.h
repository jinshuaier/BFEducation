//
//  ZQNavBarSegmentView.h
//  Bf
//
//  Created by 陈大鹰 on 2017/11/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQNavBarSegmentViewDelegate <NSObject>

@optional;
- (void)selectAtIdx:(NSString *)idx with:(NSString *)selectString;

@end

@interface ZQNavBarSegmentView : UIView
@property (nonatomic, strong) NSArray * titlesArray;
@property (nonatomic,assign)id<ZQNavBarSegmentViewDelegate>delegate;
@property (nonatomic, strong) UIColor * toolsColor;

@property (nonatomic, strong) NSString * changeColor;

@property (nonatomic, assign) BOOL badgeHidden;
@property (nonatomic, assign) NSInteger currentIndex;
@end

