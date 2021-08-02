//
//  NSString+Extension.m
//  ZQInfoTech
//
//  Created by jesse on 16/10/19.
//  Copyright © 2016年 众起信息科技. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (CGRect)stringWidthRectWithSize:(CGSize)size fontOfSize:(CGFloat)fontOfSize isBold:(BOOL)isBold{
    NSDictionary * attributes;
    if (isBold) {
        attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:fontOfSize]};
    }else{
        attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:fontOfSize]};
    }
    
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}

+ (CGSize)sizeOfStringWithString:(NSString *)aString limitSize:(CGSize)limitSize fontSize:(CGFloat)fontSize{
    if (aString == nil || aString.length == 0) {
        return CGSizeZero;
    }
    //获取字符串的range
    NSRange range = NSMakeRange(0, aString.length);
    
    //创建 NSMutableAttributedString
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:aString];
    
    //为attributeString添加相关属性
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:range];
    
    //计算字符串rect
    //可选枚举的使用
    CGRect stringRect = [attributeString boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:NULL];
    
    return stringRect.size;
}

+ (CGSize)sizeOfStringWithString:(NSString *)aString limitSize:(CGSize)limitSize fontSize:(CGFloat)fontSize font:(NSString *)font
{
    if (aString == nil || aString.length == 0) {
        return CGSizeZero;
    }
    //获取字符串的range
    NSRange range = NSMakeRange(0, aString.length);
    
    //创建 NSMutableAttributedString
    NSMutableAttributedString * attributeString = [[NSMutableAttributedString alloc]initWithString:aString];
    
    //为attributeString添加相关属性
    [attributeString addAttribute:NSFontAttributeName value:[UIFont fontWithName:font size:fontSize] range:range];
    
    //计算字符串rect
    //可选枚举的使用
    CGRect stringRect = [attributeString boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:NULL];
    
    return stringRect.size;
}

+ (CGSize)sizeOfStringWithString:(NSString *)contentString limitContentStringSize:(CGSize)limitStringSize contentStringFont:(UIFont *)stringFont
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:stringFont, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize labelsize = [contentString boundingRectWithSize:limitStringSize options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return labelsize;
}

+ (NSString *)encodeString:(NSString *)str
{
    NSString *t_originalString = str;
    NSString *t_encodedValue = nil;
    
    if (t_originalString.length > 0) {
        
        NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]";
        NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        t_encodedValue = [t_originalString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    }
    return t_encodedValue;
}

- (CGFloat)widthWithFontSize:(float)fontSize
{
    NSDictionary *dic  = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize], NSFontAttributeName, nil];
    CGSize size = [self sizeWithAttributes:dic];
    return size.width;
}

- (CGSize)sizeWithFontSize:(CGFloat)fontSize size:(CGSize)aSize
{
    NSDictionary *attributesDict = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    
    CGSize maxSize = CGSizeMake(aSize.width, MAXFLOAT);
    
    CGRect subviewRect = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDict context:nil];
    
    CGSize size = subviewRect.size;
    size.height = ceil(size.height);
    
    return size;
}

//一个指定字体的汉字所占的面积的大小
+ (float)singleAreaForFontSize:(float)fontSize;
{
    float t_singleArea = 0.0f;
    UILabel *t_label = [[UILabel alloc] init];
    t_label.text = @"一二三四五六七八九十";
    [t_label setFont:[UIFont systemFontOfSize:fontSize]];
    [t_label sizeToFit];
    CGSize size = t_label.bounds.size;
    float width = size.width;
    float height = size.height;
    double allArea = width * height;
    NSUInteger length = t_label.text.length;
    t_singleArea = allArea / length;
    
    return t_singleArea;
}

- (BOOL)isPureInt
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

//判断字符串是否为浮点数
- (BOOL)isPureFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//生成随机字符串
+ (NSString *)randomString
{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 16; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    NSLog(@"%@", string);
    
    return  string;
}

//判断网络请求返回的数据,如果是字符串的nil或者@"null", 那么就返回空字符串@""
//如果是NSNumber,那么返回NSNumber的内容
+ (NSString *)stringJudge:(id)argument
{
    NSString *string = @"";
    if ([argument isKindOfClass:[NSString class]])
    {
        if (!argument)
        {
            string = @"";
        }
        else if ([argument isEqualToString:@"null"])
        {
            string = @"";
        }
        else
        {
            string = argument;
        }
    }
    else if ([argument isKindOfClass:[NSNumber class]])
    {
        string = [NSString stringWithFormat:@"%@", [argument description]];
    }
    else
    {
        string = @"";
    }
    
    return string;
}


- (NSUInteger)scanStringForLength
{
    __block NSUInteger allLength = 0;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        
        NSInteger length = [substring length];
        if (length == 1)
        {
            const unichar ch = [substring characterAtIndex:0];
            if (isascii(ch))
            {
                allLength += 1;
            }
            else
            {
                allLength += 2;
            }
        }
        else
        {
            allLength += 1;
        }
        
    }];
    
    NSLog(@"长度是: %lu", allLength);
    return allLength;
}

@end


@implementation NSString (md5String)

+(NSString *)md5String:(NSString *)str
{
    
    const char *myPassword = [str UTF8String];
    unsigned char mdc[16];
    CC_MD5(myPassword,(CC_LONG)strlen(myPassword),mdc);
    NSMutableString *md5String = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [md5String appendFormat:@"%02x",mdc[i]];
    }
    return md5String;
}

@end

@implementation NSString (sha1)

+ (NSString *) sha1:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

@end

@implementation NSString (pinyin)

- (NSString *) pinyin
{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString *) pinyinInitial
{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    NSArray *word = [str componentsSeparatedByString:@" "];
    NSMutableString *initial = [[NSMutableString alloc] initWithCapacity:str.length / 3];
    for (NSString *str in word) {
        [initial appendString:[str substringToIndex:1]];
    }
    
    return initial;
}
//是否纯数字 字符串
- (BOOL)isPureNumandCharacters;
{
    if (!self || self.length == 0) {
        return NO;
    }
    NSString *string = [self stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0)
    {
        return NO;
    }
    return YES;
}

- (BOOL)isEmpty;
{
    if (!self) {
        return YES;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}


+ (NSString *)filterHtmlTag:(NSString *)originHtmlStr{
    NSString *result = nil;
    if (originHtmlStr) {
        NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
        if (arrowTagStartRange.location != NSNotFound) { //如果找到
            NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
            //        NSLog(@"start-> %d   end-> %d", arrowTagStartRange.location, arrowTagEndRange.location);
            //        NSString *arrowSubString = [originHtmlStr substringWithRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location)];
            result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];
            // NSLog(@"Result--->%@", result);
            return [self filterHtmlTag:result];    //递归，过滤下一个标签
        }else{
            result = [originHtmlStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];  // 过滤&nbsp等标签
            //result = [originHtmlStr stringByReplacingOccurrencesOf  ........
        }
    }
    return result;
}

// 只过滤标签
+ (NSString *)filterHtml:(NSString *)originHtmlStr {
    NSString *result = nil;
    if (originHtmlStr) {
        NSRange arrowTagStartRange = [originHtmlStr rangeOfString:@"<"];
        if (arrowTagStartRange.location != NSNotFound) { //如果找到
            NSRange arrowTagEndRange = [originHtmlStr rangeOfString:@">"];
            result = [originHtmlStr stringByReplacingCharactersInRange:NSMakeRange(arrowTagStartRange.location, arrowTagEndRange.location - arrowTagStartRange.location + 1) withString:@""];
            return [self filterHtml:result];    //递归，过滤下一个标签
        }else{
            return originHtmlStr;
        }
    }
    return result;
}


// 富文本计算高度
-(CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    /** 行高 */
    paraStyle.lineSpacing = lineSpeace;
    // NSKernAttributeName字体间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}


// html转富文本
- (NSAttributedString *)attributedStringWithHTMLString:(NSString *)htmlString

{
    
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType,
                               
                               NSCharacterEncodingDocumentAttribute :@(NSUTF8StringEncoding) };
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[NSAttributedString alloc] initWithData:data options:options documentAttributes:nil error:nil];
    
}

@end
