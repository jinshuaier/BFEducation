//
//  BFCarTalentsViewController.m
//  Bf
//
//  Created by 陈大鹰 on 2018/3/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TFPickerDelegate <NSObject>

@optional;
- (void)PickerSelectorIndixString:(NSString *)str andIndex:(NSInteger)selectIndex;

@end

typedef NS_ENUM(NSInteger, ARRAYTYPE) {
    jobStyleArray,
    guimoArray,
    xingzhiArray,
    quanzhiArray,
    moneyArray,
    jingyanArray,
    xueliArray,
    GenderArray,
    HeightArray,
    weightArray,
    DeteArray,
    Default,
    DateYear,
    agoDate
};

@interface PickerChoiceView : UIView

@property (nonatomic, assign) ARRAYTYPE arrayType;

@property (nonatomic, strong) NSArray *customArr;

@property (nonatomic,strong)UILabel *selectLb;

@property (nonatomic,assign)id<TFPickerDelegate>delegate;

@end
