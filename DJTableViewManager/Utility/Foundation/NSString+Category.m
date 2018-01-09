//
//  wiNSString+MD5HexDigest.m
//  DJkit
//
//  Created by DennisDeng on 12-1-6.
//  Copyright (c) 2012年 DennisDeng. All rights reserved.
//

#import "NSString+Category.h"
#import "NSObject+Category.h"


#pragma mark Size

@implementation NSString (Size)

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode
{
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font
{
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByCharWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByCharWrapping];
    return size.height;
}


- (CGSize)sizeToFitWidth:(CGFloat)width withFont:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    return [self sizeToFit:maxSize withFont:font lineBreakMode:NSLineBreakByCharWrapping];
}

- (CGSize)sizeToFitHeight:(CGFloat)height withFont:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, height);
    return [self sizeToFit:maxSize withFont:font lineBreakMode:NSLineBreakByCharWrapping];
}

- (CGSize)sizeToFit:(CGSize)maxSize withFont:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;

    if (lineBreakMode ==  NSLineBreakByTruncatingHead ||
        lineBreakMode ==  NSLineBreakByTruncatingTail ||
        lineBreakMode ==  NSLineBreakByTruncatingMiddle )
    {
        options |= NSStringDrawingTruncatesLastVisibleLine;
    }

    CGRect textRect = [self boundingRectWithSize:maxSize options:options attributes:@{NSFontAttributeName:font} context:nil];

    return textRect.size;
}

- (CGSize)sizeToFitWidth:(CGFloat)width withFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    return [self sizeToFit:maxSize withFont:font paragraphStyle:paragraphStyle];
}

- (CGSize)sizeToFitHeight:(CGFloat)height withFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, height);
    return [self sizeToFit:maxSize withFont:font paragraphStyle:paragraphStyle];
}

- (CGSize)sizeToFit:(CGSize)maxSize withFont:(UIFont *)font paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle
{
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    paragraphStyle.alignment = NSTextAlignmentLeft;
//    paragraphStyle.hyphenationFactor = 0.0f;
//    paragraphStyle.firstLineHeadIndent = 0.0f;
//    paragraphStyle.paragraphSpacing = 0.0f;
//    paragraphStyle.headIndent = 0.0f;
//    paragraphStyle.lineSpacing = 3.0f;
    
    NSDictionary *attributes = @{NSFontAttributeName : font,
                                 NSParagraphStyleAttributeName : paragraphStyle};
    
    CGRect rect = [self boundingRectWithSize:maxSize options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin) attributes:attributes context:nil];
    
    return rect.size;
}

@end

