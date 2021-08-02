//
//  ZQMoreItemView.h
//  ZQArbutus
//
//  Created by 陈大鹰 on 19/03/2017.
//  Copyright © 2017 ZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZQMoreItemView : UIControl
- (id) initWithFrame:(CGRect)frame items:(NSArray *)items;
@property (nonatomic) NSInteger selectedIndex;
- (void) show;
@end
