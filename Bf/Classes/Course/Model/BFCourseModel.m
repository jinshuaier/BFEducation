//
//  BFCourseModel.m
//  Bf
//
//  Created by 春晓 on 2017/12/6.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCourseModel.h"
#import "BFCollectClassModel.h"
@implementation BFCourseModel

- (instancetype)initWithBFCollectClassModel:(BFCollectClassModel *)model{
    if (self = [super init]) {
        self.cscover = model.cCover;
        self.ctitle = model.cTitle;
        self.cstarttime = model.cStartTime;
        self.cendtime = model.cEndTime;
        self.cnum = model.cNum;
        self.cid = model.cId;
        self.ckey = model.cKey;
        self.cstate = model.cState;
        self.roomid = model.roomId;
        
    }
    return self;
}

- (void)fillWithDict:(NSDictionary *)dict{
    if (dict) {
        [self setValuesForKeysWithDictionary:dict];
    }
}

// 防错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
