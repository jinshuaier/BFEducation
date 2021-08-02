//
//  BFCommunityImgModel.m
//  Bf
//
//  Created by 春晓 on 2017/11/27.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCommunityModel.h"
#import "NSString+Extension.h"

@implementation BFCommunityModel

+ (instancetype)initWithDict:(NSDictionary *)dict{
    BFCommunityModel *model = [BFCommunityModel mj_objectWithKeyValues:dict];
    
    if (model.pState == 0) {// 视频图片都没有
        model.communityModelType = BFCommunityModelType_Text;
        model.haveImg = NO;
        model.haveVideo = NO;
    }else if (model.pState == 2){// 视频有 图片没有
        model.communityModelType = BFCommunityModelType_Video;
        model.haveImg = NO;
        model.haveVideo = YES;
    }else if (model.pState == 1){// 视频没有 图片有
        model.communityModelType = BFCommunityModelType_Image;
        model.haveImg = YES;
        model.haveVideo = NO;
    }else if (model.pState == 3){// 视频图片都有
        model.communityModelType = BFCommunityModelType_VideoAndImage;
        model.haveImg = YES;
        model.haveVideo = YES;
    }
    model.curPage = 0;
    model.lastPage = 1;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[model.pCcont dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [attrStr removeAttribute:NSParagraphStyleAttributeName range:NSMakeRange(0, attrStr.length)];
    model.pCcontAttributed = attrStr;
    NSString *str = [model flattenHTML:model.pCcont];
    model.disStr = str;
    
    return model;
}

#pragma mark 过滤后台返回字符串中的标签
- (NSString *)flattenHTML:(NSString *)html {
    
    if (html && html.length > 0) {
        //  过滤html标签
        NSScanner *theScanner;
        NSString *text = nil;
        theScanner = [NSScanner scannerWithString:html];
        while ([theScanner isAtEnd] == NO) {
            // find start of tag
            [theScanner scanUpToString:@"<" intoString:NULL] ;
            // find end of tag
            [theScanner scanUpToString:@">" intoString:&text] ;
            // replace the found tag with a space
            //(you can filter multi-spaces out later if you wish)
            html = [html stringByReplacingOccurrencesOfString:
                    [NSString stringWithFormat:@"%@>", text] withString:@""];
        }
        //      过滤html中的\n\r\t换行空格等特殊符号
        NSMutableString *str1 = [NSMutableString stringWithString:html];
        for (int i = 0; i < str1.length; i++) {
            unichar c = [str1 characterAtIndex:i];
            NSRange range = NSMakeRange(i, 1);

            //  在这里添加要过滤的特殊符号
            if ( c == '\r' || c == '\n' || c == '\t') {
                [str1 deleteCharactersInRange:range];
                --i;
            }
        }
        html  = [NSString stringWithString:str1];
        NSString *result = nil;
        result = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];  // 过滤&nbsp等标签
        html  = [NSString stringWithString:result];
    }
    return html;
}

- (void)fillWithDict:(NSDictionary *)dict{
    if (dict) {
        [self setValuesForKeysWithDictionary:dict];
        NSInteger pVId = [dict[@"pVId"] integerValue];
        NSArray *postPhotoList = dict[@"postPhotoList"];
        if (pVId == 0 && postPhotoList.count == 0) {// 视频图片都没有
            self.communityModelType = BFCommunityModelType_Text;
            self.haveImg = NO;
            self.haveVideo = NO;
        }else if (pVId > 0 && postPhotoList.count == 0){// 视频有 图片没有
            self.communityModelType = BFCommunityModelType_Video;
            self.haveImg = NO;
            self.haveVideo = YES;
        }else if (pVId == 0 && postPhotoList.count > 0){// 视频没有 图片有
            self.communityModelType = BFCommunityModelType_Image;
            self.haveImg = YES;
            self.haveVideo = NO;
        }else if (pVId > 0 && postPhotoList.count > 0){// 视频图片都有
            self.communityModelType = BFCommunityModelType_VideoAndImage;
            self.haveImg = YES;
            self.haveVideo = YES;
        }
        self.curPage = 0;
        self.lastPage = 1;
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[self.pCcont dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        [attrStr removeAttribute:NSParagraphStyleAttributeName range:NSMakeRange(0, attrStr.length)];
        self.pCcontAttributed = attrStr;
        NSString *str = [self flattenHTML:self.pCcont];
        self.disStr = str;
    }
}

// 防错处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"==========================%@",key);
}

@end
