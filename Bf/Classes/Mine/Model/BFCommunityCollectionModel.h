//
//  BFCommunityCollectionModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/16.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCommunityModel.h"

@interface BFCommunityCollectionModel : BFCommunityModel
// 收藏时间
@property (nonatomic , strong) NSString *cDateTime;
// 收藏id
@property (nonatomic , assign) NSInteger pCId;
@end
