//
//  BFAppKeyChain.h
//  Bf
//
//  Created by 陈大鹰 on 2018/5/29.
//  Copyright © 2018年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFAppKeyChain : NSObject
//将数据写入keychain中
+ (void)saveData:(id)data forKey:(NSString *)key;
//从keychain中获取数据
+ (id)loadForKey:(NSString *)key;
//删除keychain中的相应数据
+ (void)deleteKeyData:(NSString *)key;

@end
