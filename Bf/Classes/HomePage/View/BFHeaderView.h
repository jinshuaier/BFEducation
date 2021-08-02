//
//  BFHeaderView.h
//  test
//
//  Created by 乔春晓 on 2017/11/25.
//  Copyright © 2017年 QCX. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFHeaderViewDelegate <NSObject>
- (void)moreInformation;
@end

#define HeaderViewHeight 60
@interface BFHeaderView : UIView

// 代理
@property (nonatomic , strong) id<BFHeaderViewDelegate> delegate;

// 标题
@property (nonatomic, strong) NSString *titleStr;
// 标题图片
@property (nonatomic, strong) UIImage *titleImg;
// 是否显示更多按钮
@property (nonatomic, assign) BOOL isHiddenMoreBtn;

+ (instancetype)createHeaderView;
@end
