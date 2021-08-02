//
//  BFCollectClassModel.h
//  Bf
//
//  Created by 陈大鹰 on 2017/12/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BFCollectClassModel : NSObject
//aBlocked = 0;
//cCId = 2;
//cCTime = 1513766112000;
//cCover = 321;
//cEndDateTime = "2017-12-24 03:48:36";
//cEndTime = 1514058516000;
//cId = 1;
//cKey = 0;
//cMaxId = 0;
//cMinId = 0;
//cNum = 0;
//cStartDateTime = "2017-12-22 03:48:31";
//cStartTime = 1513885711000;
//cState = 2;
//cTitle = 321;
//rCRedit = 0;
//roomId = 1;
@property (nonatomic,assign) NSInteger aBlocked;

@property (nonatomic,assign) NSInteger cCId;

@property (nonatomic,assign) NSInteger cCTime;

@property (nonatomic,strong) NSString *cCover;

@property (nonatomic,copy) NSString *cEndDateTime;

@property (nonatomic,assign) NSInteger cEndTime;

@property (nonatomic,assign) NSInteger cId;

@property (nonatomic,assign) NSInteger cKey;

@property (nonatomic,assign) NSInteger cMaxId;

@property (nonatomic,assign) NSInteger cMinId;

@property (nonatomic,assign) NSInteger cNum;

@property (nonatomic,copy) NSString *cStartDateTime;

@property (nonatomic,assign) NSInteger cStartTime;

@property (nonatomic,assign) NSInteger cState;

@property (nonatomic,copy) NSString *cTitle;

@property (nonatomic,assign) NSInteger rCRedit;

@property (nonatomic,strong) NSString *roomId;

@end
