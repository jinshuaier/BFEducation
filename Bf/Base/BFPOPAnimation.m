//
//  BFPOPAnimation.m
//  Bf
//
//  Created by 春晓 on 2017/12/12.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFPOPAnimation.h"


@implementation BFPOPAnimation
// 实现两个协议的方法

// 返回动画执行的时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

//
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    __block UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey]; // 动画来自哪个vc
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey]; // 转场到哪个vc
    
    // 转场动画是两个控制器视图的动画，需要一个containerView作为“舞台”
    UIView *containerView = [transitionContext containerView];
    [containerView insertSubview:toVC.view belowSubview:fromVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext]; // 获取动画执行时间（实现的协议方法）
    
    // 执行动画，让fromVC的view移动到屏幕最右侧
    [UIView animateWithDuration:duration animations:^{
        fromVC.view.transform = CGAffineTransformMakeTranslation([UIScreen mainScreen].bounds.size.width, 0);
    } completion:^(BOOL finished) {
        // 当动画执行完时，这个方法必须要调用，否则系统会认为你的其余操作都在动画执行过程中
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
    
}
@end
