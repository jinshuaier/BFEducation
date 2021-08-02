//
//  NSMutableAttributedString+BFAttributedString.h
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (BFAttributedString)
- (NSMutableAttributedString *(^)(NSString *,NSDictionary <NSString *,id > *))add;

@end



