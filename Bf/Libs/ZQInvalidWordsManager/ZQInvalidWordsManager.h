//
//  ZQInvalidWordsManager.h
//  ZQArbutus
//
//  Created by Andy on 2016/12/16.
//  Copyright © 2016年 ZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IsValid(content) [ZQInvalidWordsManager judge:content]

@interface ZQInvalidWordsManager : NSObject

+ (id)sharedInstance;

- (BOOL)isValid:(NSString *)textContent;

+ (BOOL)judge:(NSString *)textContent;

@end


