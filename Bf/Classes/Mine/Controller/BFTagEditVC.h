//
//  BFTagEditVC.h
//  Bf
//
//  Created by 春晓 on 2018/5/31.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFBaseViewController.h"

typedef void(^CommitAction)(NSArray *arr);

@interface BFTagEditVC : BFBaseViewController
// block
@property (nonatomic , copy) CommitAction block;
// data
@property (nonatomic , strong) NSMutableArray *tagArray;
@end
