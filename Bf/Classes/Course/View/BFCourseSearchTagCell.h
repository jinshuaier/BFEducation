//
//  BFCourseSearchTagCell.h
//  Bf
//
//  Created by 春晓 on 2018/4/17.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFCourseSearchTagCell : UICollectionViewCell
// Label
@property (nonatomic , strong) UILabel *tagLabel;
// 是否选择
@property (nonatomic , assign) BOOL isSelect;
+ (CGSize) getSizeWithText:(NSString*)text;
@end
