//
//  NSString+Extension.h
//  ZQInfoTech
//
//  Created by jesse on 16/10/19.
//  Copyright © 2016年 众起信息科技. All rights reserved.
//

#import <Foundation/Foundation.h>

//用于处理网络请求返回的字符串, 如果是nil或者@"null", 那么统一返回@""
#define ZQStringJudge(string) [NSString stringJudge:string]

@interface NSString (Extension)
/**
*  计算字符串宽度(指当该字符串放在view时的自适应宽度)
*/
- (CGRect)stringWidthRectWithSize:(CGSize)size fontOfSize:(CGFloat)font isBold:(BOOL)isBold;

+ (CGSize)sizeOfStringWithString:(NSString *)aString limitSize:(CGSize)limitSize
                        fontSize:(CGFloat)fontSize;
+ (CGSize)sizeOfStringWithString:(NSString *)aString limitSize:(CGSize)limitSize
                        fontSize:(CGFloat)fontSize font:(NSString *)font;

+ (CGSize)sizeOfStringWithString:(NSString *)contentString
          limitContentStringSize:(CGSize)limitStringSize
               contentStringFont:(UIFont *)stringFont;

//对字符串进行转码，中文，特殊符号等，放置json或者url中出现中文和特殊字符
+ (NSString *)encodeString:(NSString *)str;

//获取字符串的长度，单行
- (CGFloat)widthWithFontSize:(float)fontSize;

//size宽度一定,获取字符串的自适应高度
- (CGSize)sizeWithFontSize:(CGFloat)fontSize size:(CGSize)aSize;

//一个指定字体的非粗体汉字所占的面积的大小
+ (float)singleAreaForFontSize:(float)fontSize;

- (BOOL)isPureInt;  //判断字符串是否是整型

//判断字符串是否为浮点数
- (BOOL)isPureFloat;

//生成16位的随机字符串
+ (NSString *)randomString;


//判断网络请求返回的数据,如果是字符串的nil或者@"null", 那么就返回空字符串@""
//如果是NSNumber,那么返回NSNumber的内容
+ (NSString *)stringJudge:(id)argument;

//计算字符串的长度, 用于昵称, 字母和表情按照一个长度计算, 汉字按照两个长度计算
- (NSUInteger)scanStringForLength;

@end

@interface NSString (md5String)

/** md5一般加密 */
+ (NSString *)md5String:(NSString *)str;

@end

@interface NSString (pinyin)

- (NSString *) pinyin;
- (NSString *) pinyinInitial;
//是否纯数字 字符串
- (BOOL)isPureNumandCharacters;
//是否为空（空格）
- (BOOL)isEmpty;
@end

@interface NSString (sha1)

+(NSString *) sha1:(NSString *)input;

// 过滤http里的标签和特殊字符
+ (NSString *)filterHtmlTag:(NSString *)originHtmlStr;
// 只过滤http里的标签
+ (NSString *)filterHtml:(NSString *)originHtmlStr;

// html转富文本
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString;
@end
