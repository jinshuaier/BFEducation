//
//  BFNewsTwoView.h
//  Bf
//
//  Created by 陈大鹰 on 2018/2/1.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFNewsTwoView : UIView
/*资讯封面图*/
@property (nonatomic,strong) UIImageView *newsImgOne;
/*资讯标题*/
@property (nonatomic,strong) UILabel *newsTitleOne;
/*资讯内容*/
@property (nonatomic,strong) UILabel *newsContentOne;
/*下划线*/
@property (nonatomic,strong) UIView *line;
@end
