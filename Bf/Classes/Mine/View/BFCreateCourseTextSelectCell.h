//
//  BFCreateCourseTextSelectCell.h
//  Bf
//
//  Created by 春晓 on 2018/5/23.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BFCreateCourseTextSelectCellDelegate <NSObject>
- (void)getTextFieldTextWithTag:(NSInteger)tag withText:(NSString *)text;
@end

@interface BFCreateCourseTextSelectCell : UITableViewCell
// 左边的label
@property (nonatomic , strong) UILabel *leftLabel;
// 右边的tf
@property (nonatomic , strong) UITextField *textField;
// 类型
@property (nonatomic , assign) NSInteger cellType;// 0=输入 1=选择
// label
@property (nonatomic , strong) UILabel *rightLabel;
// 标志 0=名字/开始时间 1=标签/结束时间
@property (nonatomic , assign) NSInteger tagType;
// 代理
@property (nonatomic , weak) id<BFCreateCourseTextSelectCellDelegate> delegate;
@end
