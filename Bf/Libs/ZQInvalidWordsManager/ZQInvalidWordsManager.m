//
//  ZQInvalidWordsManager.m
//  ZQArbutus
//
//  Created by Andy on 2016/12/16.
//  Copyright © 2016年 ZQ. All rights reserved.
//

#import "ZQInvalidWordsManager.h"

@interface ZQInvalidWordsManager ()

@property (strong, nonatomic, readwrite) NSMutableArray *arrayInvalidWords;

@end

@implementation ZQInvalidWordsManager

+ (id)sharedInstance
{
    static ZQInvalidWordsManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZQInvalidWordsManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.arrayInvalidWords = [[NSMutableArray alloc] init];
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"invalidwords" ofType:@"txt"];
        NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSArray *array = [content componentsSeparatedByString:@"|"];
        
        [self.arrayInvalidWords addObjectsFromArray:array];
        [self.arrayInvalidWords addObject:@"|"];
    }
    
    return self;
}

- (BOOL)isValid:(NSString *)textContent
{
    BOOL isOK = YES;
    
    if (textContent && ![textContent isEqualToString:@""])
    {
        for (NSString *invalidword in self.arrayInvalidWords)
        {
            if ([textContent containsString:invalidword])
            {
                isOK = NO;
                break;
            }
        }
    }
    
    return isOK;
}

+ (BOOL)judge:(NSString *)textContent
{
    ZQInvalidWordsManager *invalidWordsManager = [ZQInvalidWordsManager sharedInstance];
    return [invalidWordsManager isValid:textContent];
}

@end
