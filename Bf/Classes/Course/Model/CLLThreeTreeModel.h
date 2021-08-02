//
//  ChapterModel.h
//  WLN_Tianxing
//
//  Created by wln100-IOS1 on 15/12/23.
//  Copyright © 2015年 TianXing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLThreeTreeModel : NSObject

@property (nonatomic, assign) BOOL isShow;

@property (nonatomic, strong) NSArray *child;

@property (nonatomic, strong) NSArray *pois;

@property (nonatomic, assign) NSInteger csort;

@property (nonatomic, strong) NSString *ctitle;
@property (nonatomic, assign) NSInteger ctype;
@property (nonatomic, assign) NSInteger cstate;
@property (nonatomic, strong) NSString *cid;

- (instancetype)initWithDic:(NSDictionary *)info;
@end
