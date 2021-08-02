//
//  NSMutableAttributedString+BFAttributedString.m
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "NSMutableAttributedString+BFAttributedString.h"


//FOUNDATION_EXTERN NSString *const NSImageAttributeName;  //图片，传UIImage
//FOUNDATION_EXTERN NSString *const NSImageBoundsAttributeName; //图片尺寸
@implementation NSMutableAttributedString (BFAttributedString)
- (NSMutableAttributedString *(^)(NSString *, NSDictionary<NSString *,id> *))add {
    return ^NSMutableAttributedString * (NSString *string, NSDictionary <NSString *,id>*attrDic) {
        
//        if ([[attrDic allKeys] containsObject:NSImageAttributeName] && [[attrDic allKeys] containsObject:NSImageBoundsAttributeName]) {
//            NSTextAttachment *attach = [[NSTextAttachment alloc] initWithData:nil ofType:nil];
//            CGRect rect = CGRectFromString(attrDic[NSImageBoundsAttributeName]);
//            attach.bounds = rect;
//            attach.image = attrDic[NSImageAttributeName];
//
//            [self appendAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
//        }
//        else {
//            [self appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:attrDic]];
//        }
        if (string) {
            [self appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:attrDic]];
        }
        
        return self;
    };
}
@end
