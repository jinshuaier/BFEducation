//
//  BFEditEvaluateVC.h
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

typedef void(^BFEditEvaluateVCBlock)(NSString * content);

@interface BFEditEvaluateVC : BFBaseViewController

// block
@property (nonatomic , copy) BFEditEvaluateVCBlock editBlock;

@end
