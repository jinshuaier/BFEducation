//
//  BFCarNewsCell.h
//  Bf
//
//  Created by 陈大鹰 on 2017/11/24.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCarNewsModel.h"
@interface BFCarNewsCell : UITableViewCell
/*model*/
@property (nonatomic,strong) BFCarNewsModel *dataModel;
@property (nonatomic, strong) UIImageView *carImage;
@end
