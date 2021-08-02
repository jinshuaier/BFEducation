//
//  BFCompanyListCell.h
//  Bf
//
//  Created by 陈大鹰 on 2018/3/2.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFCarTalentsListModel.h"
#import "BFDropInBoxModel.h"
@interface BFCompanyListCell : UITableViewCell

/*model*/
@property (nonatomic,strong) BFCarTalentsListModel *dataModel;

/*model*/
@property (nonatomic,strong) BFDropInBoxModel *dataModel1;

@end
