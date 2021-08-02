//
//  BFCollectionModel.h
//  Bf
//
//  Created by 春晓 on 2017/11/24.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFCollectionModel : NSObject
// 图片
@property (nonatomic , strong) UIImage *img;
// 标题
@property (nonatomic , strong) NSString *title;
// 描述
@property (nonatomic , strong) NSString *descriptionStr;
// 学分
@property (nonatomic , strong) NSString *credit;
@end
