//
//  ZQCustomViewController.h
//  test
//
//  Created by Andy on 2016/12/1.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Block) (int index);

@interface ZQDialogueViewController : NSObject

- (instancetype)initWithActions:(NSArray *)arrayActions block:(Block)blk;
- (void)show;

@end
