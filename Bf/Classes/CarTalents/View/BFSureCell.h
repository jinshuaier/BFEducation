//
//  BFSureCell.h
//  Bf
//
//  Created by 陈大鹰 on 2018/4/3.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFSureCell : UITableViewCell
/*确认按钮*/
@property (nonatomic,strong) UIButton *sureBtn;
@property (nonatomic,copy) void(^pushSureBlock)();
@end
