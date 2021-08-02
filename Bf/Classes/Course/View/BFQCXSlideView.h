//
//  BFQCXSlideView.h
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BFQCXSlideView;
@protocol BFQCXSlideViewDelegate <NSObject>

@required
- (NSInteger)numberOfSlideItemsInSlideView:(BFQCXSlideView *)slideView;

- (NSArray *)namesOfSlideItemsInSlideView:(BFQCXSlideView *)slideView;

- (NSArray *)childViewControllersInSlideView:(BFQCXSlideView *)slideView; /**< 分段选择视图的子视图控制器 */

- (void)slideView:(BFQCXSlideView *)slideView didSelectItemAtIndex:(NSInteger)index;

@optional
- (UIColor *)colorOfSliderInSlideView:(BFQCXSlideView *)slideView;

- (UIColor *)colorOfSlideView:(BFQCXSlideView *)slideView;

- (UIColor *)colorOfSlideItemsTitle:(BFQCXSlideView *)slideView;

- (UIColor *)colorOfHighlightedSlideItemsTitle:(BFQCXSlideView *)slideView;

@end

/**
 *  带滑块效果的分段选择视图
 */
@interface BFQCXSlideView : UIView

@property (weak, nonatomic) id<BFQCXSlideViewDelegate> delegate;

@property (assign, nonatomic, readonly) NSInteger numberOfSlideItems; /**< 组成单件数量 */

@property (strong, nonatomic, readonly) NSArray *namesOfSlideItems;   /**< 各个单件的名字 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlider;       /**< 底部滑块的颜色 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlideView;    /**< 视图的整体颜色 */

@property (strong, nonatomic, readonly) UIColor *colorOfSlideItemsTitle;   /**< 单件标题文本默认色 */

@property (strong, nonatomic, readonly) UIColor *colorOfHighlightedSlideItemsTitle;  /**< 单件标题文本高亮色 */
@property (assign, nonatomic) NSInteger currentIndex; /**< 当前index */
@end
