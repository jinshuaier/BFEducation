//
//  BFCatalogueModel.m
//  Bf
//
//  Created by 春晓 on 2017/12/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCatalogueModel.h"

@implementation BFCatalogueModel

+ (instancetype)initWithDict:(NSDictionary *)dic{
    BFCatalogueModel *model = [BFCatalogueModel mj_objectWithKeyValues:dic];
    return model;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%ld,%ld,%ld",_cTitle,_cTTitle,_cTId,_cTType,_parentId];
}

- (id)copyWithZone:(NSZone *)zone
{
    BFCatalogueModel *model = [[BFCatalogueModel allocWithZone:zone] init];
    
    return model;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    BFCatalogueModel *model = [[BFCatalogueModel allocWithZone:zone] init];
    
    return model;
}


@end
