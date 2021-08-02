//
//  BFDataView.h
//  Bf
//
//  Created by 陈大鹰 on 2018/4/18.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFDataView : UIView
/*资料封面图*/
@property (nonatomic,strong) UIImageView *dataImage;
/*资料名称*/
@property (nonatomic,strong) UILabel *dataTitle;
/*下载按钮*/
@property (nonatomic,strong) UILabel *download;
@end
