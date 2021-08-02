//
//  BFCollectionViewCell.h
//  Bf
//
//  Created by 春晓 on 2017/11/28.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCourseModel.h"
#import "BFSetCourseModel.h"

@interface BFCollectionViewCell : UICollectionViewCell
@property (nonatomic , strong) BFCourseModel *courseModel;
@property (nonatomic , strong) BFSetCourseModel *setCourseModel;
@end
