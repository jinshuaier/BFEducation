//
//  BFCommunityCollectionModel.m
//  Bf
//
//  Created by 春晓 on 2017/12/16.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCommunityCollectionModel.h"

@implementation BFCommunityCollectionModel

+ (instancetype)initWithDict:(NSDictionary *)dict{
    BFCommunityCollectionModel *model = [BFCommunityCollectionModel mj_objectWithKeyValues:dict];
    NSInteger pVId = [dict[@"pVId"] integerValue];
    NSArray *postPhotoList = dict[@"postPhotoList"];
    if (pVId == 0 && postPhotoList.count == 0) {// 视频图片都没有
        model.communityModelType = BFCommunityModelType_Text;
        model.haveImg = NO;
        model.haveVideo = NO;
    }else if (pVId == 1 && postPhotoList.count == 0){// 视频有 图片没有
        model.communityModelType = BFCommunityModelType_Video;
        model.haveImg = NO;
        model.haveVideo = YES;
    }else if (pVId == 0 && postPhotoList.count == 1){// 视频没有 图片有
        model.communityModelType = BFCommunityModelType_Image;
        model.haveImg = YES;
        model.haveVideo = NO;
    }else if (pVId == 1 && postPhotoList.count == 1){// 视频图片都有
        model.communityModelType = BFCommunityModelType_VideoAndImage;
        model.haveImg = YES;
        model.haveVideo = YES;
    }
    return model;
}
@end
