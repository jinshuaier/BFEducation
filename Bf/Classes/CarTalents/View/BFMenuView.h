//
//  BFMenuView.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/26.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

//颜色
#define RGBACOLOR(R,G,B,A) [UIColor colorWithRed:(R)/255.0f green:(G)/255.0f blue:(B)/255.0f alpha:(A)]
typedef NS_ENUM(NSInteger, menuViewLayoutType){
    menuViewLayoutTypeNormal,  //图片在左，文字在右
    menuViewLayoutTypeTitle,   //只显示文字
};
typedef NS_ENUM(NSInteger, menuViewDirectionType){
    menuViewDirectionDown,   //下拉菜单
    menuViewDirectionUp,     //上弹菜单
};

@protocol menuViewDelegate<NSObject>
@optional
-(void)didSelectRowAtIndex:(NSInteger)index title:(NSString *)title img:(NSString *)img;
@end
@interface BFMenuView : UIView
/** 布局类型 (图片再左, 文字在右) */
@property (nonatomic, assign) menuViewLayoutType layoutType;
/** 三角形弹出方向类型 (默认向下) */
@property (nonatomic, assign) menuViewDirectionType directionType;
/** 文字颜色 */
@property (nonatomic, strong) UIColor *titleColor;
/** 线条颜色 */
@property (nonatomic, strong) UIColor *lineColor;
/** 背景颜色 */
@property (nonatomic, strong) UIColor *bgColor;
/** 三角形颜色 */
@property (nonatomic, strong) UIColor *arrowColor;

/**
 * 显示下拉菜单
 * frame  显示的位置以及大小
 * titleArr  标题数组
 * imgArr  如果不需要显示图片可穿空
 * arrowOffset  箭头的x偏移值
 * rowHeight 每一行的高度
 * layoutType 显示图片和文字或者只显示文字(默认显示图片和文字)
 * directionType 菜单的弹出方向(默认向下)
 */
-(instancetype)initWithFrame:(CGRect)frame titleArr:(NSArray *)titleArr imgArr:(NSArray *)imgArr arrowOffset:(CGFloat)arrowOffset rowHeight:(CGFloat)rowHeight layoutType:(menuViewLayoutType)layoutType directionType:(menuViewDirectionType)directionType delegate:(id<menuViewDelegate>)delegate;
@end

/**
 *   自定义的cell类
 */
@class menuViewModel;
@interface menuViewCell : UITableViewCell
/** 布局类型 (图片再左, 文字在右) */
@property (nonatomic, assign) menuViewLayoutType layoutType;
/** 数据模型 */
@property(strong,nonatomic)menuViewModel *menuViewModel;
/** 图片 */
@property(strong,nonatomic)UIImageView *imgView;
/** 标题 */
@property(strong,nonatomic)UILabel *titleLab;
/** 分割线 */
@property(strong,nonatomic)UIView *lineView;

+(instancetype)MenuViewCellWithTableView:(UITableView *)tableView;
@end

/**
 *   自定义的model类
 */
@interface menuViewModel : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *img;
/** 文字 */
@property (nonatomic, copy) NSString *title;
-(instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)menuViewWithDictonary:(NSDictionary *)dic;
@end
