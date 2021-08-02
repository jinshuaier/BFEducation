//
//  BFSlideView.h
//  Bf
//
//  Created by 春晓 on 2017/12/30.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BFSlideView;
@protocol BFSlideViewDelegate <NSObject>

@required
- (NSInteger)numberOfSlideItemsInSlideView:(BFSlideView *)slideView;

- (NSArray *)namesOfSlideItemsInSlideView:(BFSlideView *)slideView;

- (NSArray *)childViewControllersInSlideView:(BFSlideView *)slideView; /**< 分段选择视图的子视图控制器 */

- (void)slideView:(BFSlideView *)slideView didSelectItemAtIndex:(NSInteger)index;

@optional
- (UIColor *)colorOfSliderInSlideView:(BFSlideView *)slideView;

- (UIColor *)colorOfSlideView:(BFSlideView *)slideView;

- (UIColor *)colorOfSlideItemsTitle:(BFSlideView *)slideView;

- (UIColor *)colorOfHighlightedSlideItemsTitle:(BFSlideView *)slideView;

@end

/**
 *  带滑块效果的分段选择视图
 */
@interface BFSlideView : UIView

@property (weak, nonatomic) id<BFSlideViewDelegate> delegate;

@property (assign, nonatomic, readonly) NSInteger numberOfSlideItems; /**< 组成单件数量 */

@property (strong, nonatomic, readonly) NSArray *namesOfSlideItems;   /**< 各个单件的名字 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlider;       /**< 底部滑块的颜色 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlideView;    /**< 视图的整体颜色 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlideItemsTitle;   /**< 单件标题文本默认色 */

@property (strong, nonatomic, readonly) UIColor *colorOfHighlightedSlideItemsTitle;  /**< 单件标题文本高亮色 */
@property (assign, nonatomic) NSInteger currentIndex; /**< 当前index */
@end
