//
//  BFBoutiqueClassCollectionViewCell.h
//  Bf
//
//  Created by 春晓 on 2017/11/24.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCourseModel.h"
#import "BFSetCourseModel.h"

@interface BFBoutiqueClassCollectionViewCell : UITableViewCell
@property (nonatomic , strong) BFCourseModel *courseModel;
@property (nonatomic , strong) BFSetCourseModel *setCourseModel;
@end
