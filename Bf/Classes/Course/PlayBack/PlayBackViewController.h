//
//  PlayBackViewController.h
//  NewCCDemo
//
//  Created by cc on 2016/11/26.
//  Copyright © 2016年 cc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFPlayLive.h"

@interface PlayBackViewController : UIViewController
// 数据源
@property (nonatomic , strong) BFPlayLive *playLive;
@end
