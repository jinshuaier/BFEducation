//
//  BFUUIDManager.m
//  Bf
//
//  Created by 陈大鹰 on 2018/5/29.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFUUIDManager.h"
#import "BFAppKeyChain.h"
@implementation BFUUIDManager

+ (NSString *)getDeviceID {
    // 读取keyChain存储的UUID
    NSString * strUUID = (NSString *)[BFAppKeyChain loadForKey: @"uuid"];
    // 首次运行生成一个UUID并用keyChain存储
    if ([strUUID isEqualToString: @""] || !strUUID) {
        // 生成uuid
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        // 将该uuid用keychain存储
        [BFAppKeyChain saveData: strUUID forKey: @"uuid"];
    }
    return strUUID;
}

@end
