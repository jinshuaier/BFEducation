//
//  ZQDialogueView.h
//  test
//
//  Created by Andy on 2016/12/1.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZQDialogueHeader.h"


@interface ZQDialogueView : UIView

- (instancetype)initWithActions:(NSArray *)arrayActions block:(BlockInner)blk;

@end
