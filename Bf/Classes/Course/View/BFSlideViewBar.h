//
//  BFSlideViewBar.h
//  Bf
//
//  Created by 乔春晓 on 2018/1/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFSlideViewBar;
@protocol BFSlideViewBarDelegate <NSObject>

@required
- (NSInteger)numberOfSlideItemsInSlideView:(BFSlideViewBar *)slideView;

- (NSArray *)namesOfSlideItemsInSlideView:(BFSlideViewBar *)slideView;

//- (NSArray *)childViewControllersInSlideView:(BFSlideViewBar *)slideView; /**< 分段选择视图的子视图控制器 */

- (void)slideView:(BFSlideViewBar *)slideView didSelectItemAtIndex:(NSInteger)index;

@optional
- (UIColor *)colorOfSliderInSlideView:(BFSlideViewBar *)slideView;

- (UIColor *)colorOfSlideView:(BFSlideViewBar *)slideView;

- (UIColor *)colorOfSlideItemsTitle:(BFSlideViewBar *)slideView;

- (UIColor *)colorOfHighlightedSlideItemsTitle:(BFSlideViewBar *)slideView;

@end

/**
 *  带滑块效果的分段选择视图
 */
@interface BFSlideViewBar : UIView

@property (weak, nonatomic) id<BFSlideViewBarDelegate> delegate;

@property (assign, nonatomic, readonly) NSInteger numberOfSlideItems; /**< 组成单件数量 */

@property (strong, nonatomic, readonly) NSArray *namesOfSlideItems;   /**< 各个单件的名字 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlider;       /**< 底部滑块的颜色 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlideView;    /**< 视图的整体颜色 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlideItemsTitle;   /**< 单件标题文本默认色 */

@property (strong, nonatomic, readonly) UIColor *colorOfHighlightedSlideItemsTitle;  /**< 单件标题文本高亮色 */
@property (assign, nonatomic) NSInteger currentIndex; /**< 当前index */
@end
