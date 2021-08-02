//
//  BFCarTalentsViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol CitysPickerViewDelegate <NSObject>

@optional;

-(void)selectCityString:(NSString *)selectString;

@end

typedef NS_ENUM(NSUInteger, CitysPickerStyle)
{
    kCitysPickerStyleDefault,//默认
    kCitysPickerStyleProAndCt,//显示province和city 只返回city
    kCitysPickerStyleSetting, // 基本信息中使用
    kCitysPickerStyleProBack //只返回省份
};

@interface CitysPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>
/**
 *  picker的调用方法
 *
 *  @param frame controller
 *  @param style picker的style
 *
 *  @return picker
 */
-(instancetype)initWithFrame:(CGRect)frame pickerStyle:(CitysPickerStyle)style;
/**
 *  代理
 */
@property (nonatomic, assign) id<CitysPickerViewDelegate>delegate;
@property (nonatomic, assign) CitysPickerStyle cityspickerStyle;
@end
