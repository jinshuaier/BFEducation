//
//  BFQCXSlideView.m
//  NewTest
//
//  Created by 春晓 on 2017/12/5.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFQCXSlideView.h"


#define Slider_Height                   2
#define SlideBar_Height                 50
#define SlideView_Height                50
#define SliderThanSliderView_WidthRatio 0.9
#define Slider_DefaultColor             [UIColor colorWithRed:148/255.0 green:214/255.0 blue:218/255.0 alpha:1.0]
#define SlideBar_DefaultColor           [UIColor colorWithRed:114/255.0 green:119/255.0 blue:123/255.0 alpha:1.0]
#define SlideView_DefaultColor          [UIColor colorWithRed:114/255.0 green:119/255.0 blue:123/255.0 alpha:1.0]
#define Title_DefaultColor              [UIColor colorWithRed:0.65 green:0.73 blue:0.75 alpha:1]
//#define HighlightedTitle_DefaultColor   [UIColor colorWithRed:0.31 green:0.95 blue:0.71 alpha:1]
#define HighlightedTitle_DefaultColor   RGBColor(0, 169, 255)

#define SCREEN_WIDTH                    ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                   ([UIScreen mainScreen].bounds.size.height)



@interface BFQCXSlideView () <UIScrollViewDelegate> {
    
    struct {
        
        unsigned int DidDefineColorOfSlider                     : 1;
        unsigned int DidDefineColorOfSlideView                  : 1;
        unsigned int DidDefineColorOfSlideItemsTitle            : 1;
        unsigned int DidDefineColorOfHighlightedSlideItemsTitle : 1;
        
    } _delegateFlags;
}

@property (assign, nonatomic) NSInteger numberOfSlideItems; /**< 组成单件数量 */

@property (strong, nonatomic) NSArray *namesOfSlideItems;   /**< 各个单件的名字 */

@property (strong, nonatomic) UIColor *colorOfSlider;       /**< 底部滑块的颜色 */

@property (strong, nonatomic) UIColor *colorOfSlideView;    /**< 视图的整体颜色 */

@property (strong, nonatomic) UIColor *colorOfSlideItemsTitle;   /**< 单件标题文本默认色 */

@property (strong, nonatomic) UIColor *colorOfHighlightedSlideItemsTitle;  /**< 单件标题文本高亮色 */

@property (strong, nonatomic) UIView *slideBar;             /**< 深灰色背景视图 */

@property (strong, nonatomic) UIView *slider;               /**< 滑块视图 */

@property (strong, nonatomic) UIScrollView *contentScrollView; /**< 内容视图 */

@property (strong, nonatomic) NSMutableArray *buttonsArray;     /**< 所有滑块上的按钮 */

@property (strong, nonatomic) NSArray *childControllersArray;   /**< 持有所有的子控制器（DEBUG） */

@end

@implementation BFQCXSlideView

#pragma mark - setter (Override)
- (void)setDelegate:(id<BFQCXSlideViewDelegate>)delegate {
    
    _delegate = delegate;
    _delegateFlags.DidDefineColorOfSlider = [delegate respondsToSelector:@selector(colorOfSliderInSlideView:)];
    _delegateFlags.DidDefineColorOfSlideView = [delegate respondsToSelector:@selector(colorOfSlideView:)];
    _delegateFlags.DidDefineColorOfSlideItemsTitle = [delegate respondsToSelector:@selector(colorOfSlideItemsTitle:)];
    _delegateFlags.DidDefineColorOfHighlightedSlideItemsTitle = [delegate respondsToSelector:@selector(colorOfHighlightedSlideItemsTitle:)];
}

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self initData];
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [self configureData];
    [self addSubviews];
}

- (void)initData {
    
    _numberOfSlideItems = 0;
    _namesOfSlideItems = [NSMutableArray new];
    _colorOfSlider = Slider_DefaultColor;
    _colorOfSlideView = SlideView_DefaultColor;
    _colorOfSlideItemsTitle = Title_DefaultColor;
    _colorOfHighlightedSlideItemsTitle = HighlightedTitle_DefaultColor;
    _buttonsArray = [NSMutableArray new];
}

- (void) configureData {
    
    self.namesOfSlideItems = [self.delegate namesOfSlideItemsInSlideView:self];
    self.numberOfSlideItems = [self.delegate numberOfSlideItemsInSlideView:self];
    
    if (_delegateFlags.DidDefineColorOfSlideItemsTitle) {
        
        self.colorOfSlideItemsTitle = [self.delegate colorOfSlideItemsTitle:self];
    }
    
    if (_delegateFlags.DidDefineColorOfHighlightedSlideItemsTitle) {
        
        self.colorOfHighlightedSlideItemsTitle = [self.delegate colorOfHighlightedSlideItemsTitle:self];
    }
}

- (void)addSubviews {
    
    [self addSlideBar];
    [self addButtons];
    [self addSlider];
    [self addContentScrollView];
}

- (void)addSlideBar {
    
    if (!_slideBar) {
        
        _slideBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, SlideBar_Height)];
//        [_slideBar setBackgroundColor:SlideBar_DefaultColor];
        [self addSubview:_slideBar];
        _slideBar.backgroundColor = [UIColor redColor];
        _slideBar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        //阴影的透明度
        _slideBar.layer.shadowOpacity = 0.3f;
        //阴影的圆角
        _slideBar.layer.shadowRadius = 1.f;
        //阴影偏移量
        _slideBar.layer.shadowOffset = CGSizeMake(0,4);
        
    }
}

- (void)addButtons {
    
    NSInteger numberOfItems = [self.namesOfSlideItems count];
    CGFloat slideItemWidth = SCREEN_WIDTH / (CGFloat)self.numberOfSlideItems;
    CGFloat sliderWidth = slideItemWidth * SliderThanSliderView_WidthRatio;
    CGFloat position_x = (slideItemWidth - sliderWidth)/2.0;
    
    for (NSInteger number=0; number < numberOfItems; number++) {
        
        [self.slideBar addSubview:[self p_customButtonWithFrame:CGRectMake( position_x+slideItemWidth*number, 5, sliderWidth, 35)
                                                       forTitle:[self.namesOfSlideItems objectAtIndex:number]
                                                        withTag:number]];
        
        if (number == 0) {
            
            if (_delegateFlags.DidDefineColorOfSlider) {
                
                _colorOfSlider = [self.delegate colorOfSliderInSlideView:self];
            }
            // [UIColor colorWithRed:255/255.0 green:188/255.0 blue:136/255.0 alpha:1.0]
            [(UIButton *)[_buttonsArray objectAtIndex:number] setTitleColor:_colorOfHighlightedSlideItemsTitle forState:UIControlStateNormal];
        }
    }
}

- (void)addSlider {
    
    CGFloat slideItemWidth = SCREEN_WIDTH / (CGFloat)self.numberOfSlideItems;
    CGFloat sliderWidth = slideItemWidth * SliderThanSliderView_WidthRatio;
    CGFloat position_x = (slideItemWidth - sliderWidth)/2.0;
    [self.slideBar addSubview:[self p_sliderWithFrame:CGRectMake(position_x, SlideView_Height-Slider_Height - 10, sliderWidth, Slider_Height)]];
}

- (void)addContentScrollView {
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, SlideBar_Height + 4, SCREEN_WIDTH, self.frame.size.height - SlideBar_Height - 4)];
    _contentScrollView.directionalLockEnabled = YES;
    _contentScrollView.backgroundColor = [UIColor whiteColor];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * _numberOfSlideItems, 0);
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.delegate = self;
    _contentScrollView.bounces = NO;
    [self addSubview:_contentScrollView];
    
    // add child view's to contentScrollView
    self.childControllersArray = [self.delegate childViewControllersInSlideView:self];
//    for (BFSecOrderViewController *vc in self.childControllersArray) {
//        NSUInteger index = [self.childControllersArray indexOfObject:vc];
//        [vc.view setFrame:CGRectMake(index * SCREEN_WIDTH, 0, SCREEN_WIDTH, _contentScrollView.height)];
//        vc.tableView.frame = CGRectMake(0, 0, vc.view.width, vc.view.height);
//        [_contentScrollView addSubview:vc.view];
//    }
}

#pragma mark - private method
- (UIButton *)p_customButtonWithFrame:(CGRect)rect forTitle:(NSString *)title withTag:(NSInteger)tag {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:rect];
    [button setTag:tag];
    [button setTitleColor:_colorOfSlideItemsTitle forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16.f]];
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_buttonsArray addObject:button];
    
    return button;
}

- (UIView *)p_sliderWithFrame:(CGRect)rect {
    
    if (!_slider) {
        
        _slider = [[UIView alloc] initWithFrame:rect];
        [_slider setBackgroundColor:Slider_DefaultColor];
        
        if (_delegateFlags.DidDefineColorOfSlider) {
            
            [_slider setBackgroundColor:[self.delegate colorOfSliderInSlideView:self]];
        }
        
        if (_delegateFlags.DidDefineColorOfSlideView) {
            
            [_slideBar setBackgroundColor:[self.delegate colorOfSlideView:self]];
        }
    }
    
    return _slider;
}

- (void)p_animateSliderWithTag:(NSInteger)tag {
    
    [_contentScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * tag, 0) animated:YES];
}

- (void)p_animateSliderToPositionWithOffset:(CGPoint)offset {
    
    CGFloat slideItemWidth = SCREEN_WIDTH / (CGFloat)self.numberOfSlideItems;
    CGFloat sliderWidth = slideItemWidth * SliderThanSliderView_WidthRatio;
    CGFloat position_x = (slideItemWidth - sliderWidth)/2.0;
    CGRect newFrame = CGRectMake((offset.x/SCREEN_WIDTH)*slideItemWidth+position_x, _slider.frame.origin.y, _slider.frame.size.width, _slider.frame.size.height);
    [_slider setFrame:newFrame];
    
    //    NSLog(@"offset.x %f", offset.x);
    //    NSLog(@"比值 %f", offset.x/SCREEN_WIDTH);
    
    
    // 未被选中的标题重置为指定颜色 Title_DefaultColor
    for (UIButton *button in _buttonsArray) {
        
        [button setTitleColor:_colorOfSlideItemsTitle forState:UIControlStateNormal];
    }
    
    // 高亮滑块最接近的按钮的文本
    int buttonTag;
    float ratio = offset.x/SCREEN_WIDTH;
    float decimal = ratio - (int)ratio;
    
    if (decimal >= 0.5) {
        
        buttonTag = (int)ratio + 1;
    }
    else {
        
        buttonTag = (int)ratio;
    }
    
    [[_buttonsArray objectAtIndex:buttonTag] setTitleColor:_colorOfHighlightedSlideItemsTitle forState:UIControlStateNormal];
    
}

#pragma mark - event response
- (void)buttonClicked:(UIButton *)button {
    
    // 未被选中的标题重置为白色
    //    for (UIButton *button in _buttonsArray) {
    //
    //        [button setTitleColor:[UIColor colorWithRed:236/255.0 green:240/255.0 blue:241/255.0 alpha:1.0] forState:UIControlStateNormal];
    //    }
    
    // 被选中的项的标题高亮
    //    [button setTitleColor:[_slider backgroundColor] forState:UIControlStateNormal];
    
    [self.delegate slideView:self didSelectItemAtIndex:button.tag];
    [self p_animateSliderWithTag:button.tag];
    [self.contentScrollView setContentOffset:CGPointMake(button.tag*SCREEN_WIDTH, 0) animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self p_animateSliderToPositionWithOffset:scrollView.contentOffset];
}

@end
