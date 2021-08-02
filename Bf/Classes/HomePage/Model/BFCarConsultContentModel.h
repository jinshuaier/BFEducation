//
//  BFCarConsultContentModel.h
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BFCarConsultContentModelType) {
    BFCarConsultContentModelType_Text,
    BFCarConsultContentModelType_Image,
    BFCarConsultContentModelType_Video
};

@interface BFCarConsultContentModel : NSObject
// 类型
@property (nonatomic , assign) BFCarConsultContentModelType carConsultContentModelType;
// 文字内容
@property (nonatomic , strong) NSMutableAttributedString *contentText;
// 视频图片内容
@property (nonatomic , strong) NSString *contentImageUrl;
// 内容所占高度
@property (nonatomic , assign) CGFloat contentHeight;
@end
