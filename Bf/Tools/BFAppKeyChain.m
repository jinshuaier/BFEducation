//
//  BFAppKeyChain.m
//  Bf
//
//  Created by 陈大鹰 on 2018/5/29.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import "BFAppKeyChain.h"
#import <Security/Security.h>
@implementation BFAppKeyChain

#pragma mark - 保存和读取UUID

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)key {
    
    
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            key, (id)kSecAttrService,
            key, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible, nil];
}

+ (void)saveData:(id)data forKey:(NSString *)key {
    //获得keychain字典
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    
    //删除旧值
    SecItemDelete((CFDictionaryRef)keychainQuery);
    
    //添加新值
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    //    将新的信息添加到keychain中
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)loadForKey:(NSString *)key {
    
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    
    CFDataRef keyData = NULL;
    
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"存储失败，key-- %@  exception-- %@", key, e);
        } @finally {
        }
    }
    
    if (keyData) {
        CFRelease(keyData);
    }
    
    return ret;
}

+ (void)deleteKeyData:(NSString *)key {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

@end
