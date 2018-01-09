//
//  NSAttributedString+Category.m
//  DJkit
//
//  Created by DennisDeng on 16/7/22.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import "NSAttributedString+Category.h"
#import <CoreText/CoreText.h>


#pragma mark -
#pragma mark NSAttributedString

@implementation NSAttributedString (Size)

- (CGSize)sizeToFitWidth:(CGFloat)width
{
    CGSize maxSize = CGSizeMake(width, CGFLOAT_MAX);
    return [self sizeToFit:maxSize lineBreakMode:NSLineBreakByCharWrapping];
}

- (CGSize)sizeToFitHeight:(CGFloat)height
{
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, height);
    return [self sizeToFit:maxSize lineBreakMode:NSLineBreakByCharWrapping];
}

- (CGSize)sizeToFit:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    if (lineBreakMode ==  NSLineBreakByTruncatingHead ||
        lineBreakMode ==  NSLineBreakByTruncatingTail ||
        lineBreakMode ==  NSLineBreakByTruncatingMiddle )
    {
        options |= NSStringDrawingTruncatesLastVisibleLine;
    }

    CGRect textRect = [self boundingRectWithSize:maxSize options:options context:nil];
    
    return textRect.size;
}

@end


#pragma mark -
#pragma mark NSMutableAttributedString

@implementation NSMutableAttributedString (Category)


#pragma mark - Text Font

- (void)setFont:(UIFont *)font
{
    [self setFont:font range:NSMakeRange(0, [self length])];
}

- (void)setFont:(UIFont *)font range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    [self removeAttribute:NSFontAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSFontAttributeName value:font range:range];
}

- (void)setFontName:(NSString *)fontName size:(CGFloat)size
{
    [self setFontName:fontName size:size range:NSMakeRange(0, [self length])];
}

//- (void)setFontName:(NSString *)fontName size:(CGFloat)size range:(NSRange)range
//{
//    // kCTFontAttributeName
//    CTFontRef aFont = CTFontCreateWithName((__bridge CFStringRef)fontName, size, NULL);
//    if (aFont)
//    {
//        [self removeAttribute:(__bridge NSString *)kCTFontAttributeName range:range]; // Work around for Apple leak
//        [self addAttribute:(__bridge NSString *)kCTFontAttributeName value:(__bridge id)aFont range:range];
//        CFRelease(aFont);
//    }
//}

- (void)setFontName:(NSString *)fontName size:(CGFloat)fontSize range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    [self removeAttribute:NSFontAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSFontAttributeName value:font range:range];
}

- (void)setFontName:(NSString *)fontName size:(CGFloat)size bold:(BOOL)isBold italic:(BOOL)isItalic range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    UIFontDescriptor *fontDesciptor = [UIFontDescriptor fontDescriptorWithName:fontName size:size];
    UIFontDescriptorSymbolicTraits symbolicTraits = 0;
    if (isBold)
    {
        symbolicTraits = symbolicTraits ^ UIFontDescriptorTraitBold;
    }
    if (isItalic)
    {
        symbolicTraits = symbolicTraits ^ UIFontDescriptorTraitItalic;
    }
    if (symbolicTraits)
    {
        fontDesciptor = [fontDesciptor fontDescriptorWithSymbolicTraits:symbolicTraits];
    }
    
    UIFont *font = [UIFont fontWithDescriptor:fontDesciptor size:0.0f];  // size:0即使用fontDesciptor中的字体大小
    [self removeAttribute:NSFontAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSFontAttributeName value:font range:range];
}

//- (void)setFontFamily:(NSString *)fontFamily size:(CGFloat)size bold:(BOOL)isBold italic:(BOOL)isItalic range:(NSRange)range
//{
//    // kCTFontFamilyNameAttribute + kCTFontTraitsAttribute
//    CTFontSymbolicTraits symTrait = (isBold?kCTFontBoldTrait:0) | (isItalic?kCTFontItalicTrait:0);
//    NSDictionary *trait = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedLong:symTrait]
//                                                      forKey:(__bridge NSString *)kCTFontSymbolicTrait];
//    NSDictionary *attr = [NSDictionary dictionaryWithObjectsAndKeys:
//                          fontFamily,kCTFontFamilyNameAttribute,
//                          trait,kCTFontTraitsAttribute,nil];
//    
//    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attr);
//    if (!desc) return;
//    CTFontRef aFont = CTFontCreateWithFontDescriptor(desc, size, NULL);
//    CFRelease(desc);
//    if (!aFont) return;
//    
//    [self removeAttribute:(__bridge NSString *)kCTFontAttributeName range:range]; // Work around for Apple leak
//    [self addAttribute:(__bridge NSString *)kCTFontAttributeName value:(__bridge id)aFont range:range];
//    CFRelease(aFont);
//}


#pragma mark - Text Baseline

- (void)setBaselineOffset:(CGFloat)offset
{
    [self setBaselineOffset:offset range:NSMakeRange(0, self.length)];
}

- (void)setBaselineOffset:(CGFloat)offset range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    [self removeAttribute:NSBaselineOffsetAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSBaselineOffsetAttributeName value:@(offset) range:range];
}


#pragma mark - Text Color

- (void)setTextColor:(UIColor *)color
{
    [self setTextColor:color range:NSMakeRange(0, [self length])];
}

- (void)setTextColor:(UIColor *)color range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    // kCTForegroundColorAttributeName
    //[self removeAttribute:(__bridge NSString *)kCTForegroundColorAttributeName range:range]; // Work around for Apple leak
    //[self addAttribute:(__bridge NSString *)kCTForegroundColorAttributeName value:(__bridge id)color.CGColor range:range];
    [self removeAttribute:NSForegroundColorAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)setTextBackgroundColor:(UIColor*)color
{
    [self setTextBackgroundColor:color range:NSMakeRange(0, self.length)];
}

- (void)setTextBackgroundColor:(UIColor*)color range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    [self removeAttribute:NSBackgroundColorAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSBackgroundColorAttributeName value:(id)color range:range];
}


#pragma mark - Text Underlining

- (void)setTextIsUnderlined:(BOOL)underlined
{
    [self setTextIsUnderlined:underlined range:NSMakeRange(0, [self length])];
}

- (void)setTextIsUnderlined:(BOOL)underlined range:(NSRange)range
{
    int32_t style = underlined ? (kCTUnderlineStyleSingle|kCTUnderlinePatternSolid) : kCTUnderlineStyleNone;
    [self setTextUnderlineStyle:style range:range];
}

- (void)setTextUnderlineStyle:(int32_t)style range:(NSRange)range
{
    [self setTextUnderlineStyle:style color:nil range:range];
}

- (void)setTextUnderlineColor:(UIColor *)color
{
    [self setTextUnderlineColor:color range:NSMakeRange(0, [self length])];
}

- (void)setTextUnderlineColor:(UIColor *)color range:(NSRange)range
{
    if (range.location == NSNotFound || color == nil)
    {
        return;
    }
    
    [self removeAttribute:NSUnderlineColorAttributeName range:range];
    [self addAttribute:NSUnderlineColorAttributeName value:color range:range];
}

- (void)setTextUnderlineStyle:(int32_t)style color:(UIColor *)color range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    [self removeAttribute:NSUnderlineStyleAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSUnderlineStyleAttributeName value:@(style) range:range];
    
    if (color)
    {
        [self removeAttribute:NSUnderlineColorAttributeName range:range]; // Work around for Apple leak
        [self addAttribute:NSUnderlineColorAttributeName value:color range:range];
    }
}


#pragma mark - Text Deletelining

- (void)setTextIsDeletelined:(BOOL)underlined
{
    [self setTextIsDeletelined:underlined range:NSMakeRange(0, [self length])];
}

- (void)setTextIsDeletelined:(BOOL)underlined range:(NSRange)range
{
    int32_t style = underlined ? (NSUnderlineStyleSingle|NSUnderlinePatternSolid) : NSUnderlineStyleNone;
    [self setTextDeletelineStyle:style range:range];
}

- (void)setTextDeletelineStyle:(int32_t)style range:(NSRange)range
{
    [self setTextDeletelineStyle:style color:nil range:range];
}

- (void)setTextDeletelineColor:(UIColor *)color range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    [self removeAttribute:NSStrikethroughColorAttributeName range:range];
    [self addAttribute:NSStrikethroughColorAttributeName value:color range:range];
}

- (void)setTextDeletelineStyle:(int32_t)style color:(UIColor *)color range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    [self removeAttribute:NSStrikethroughStyleAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInt:style] range:range];

    if (color)
    {
        [self removeAttribute:NSStrikethroughColorAttributeName range:range]; // Work around for Apple leak
        [self addAttribute:NSStrikethroughColorAttributeName value:color range:range];
    }
}


#pragma mark - LinkURL

- (void)setLinkURL:(NSURL *)linkURL
{
    [self setLinkURL:linkURL range:NSMakeRange(0, [self length])];
}

- (void)setLinkURL:(NSURL *)linkURL range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    [self removeAttribute:NSLinkAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSLinkAttributeName value:linkURL range:range];
}


#pragma mark - Character Spacing

- (void)setCharacterSpacing:(CGFloat)characterSpacing
{
    [self setCharacterSpacing:characterSpacing range:NSMakeRange(0, [self length])];
}

- (void)setCharacterSpacing:(CGFloat)characterSpacing range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    [self addAttribute:NSKernAttributeName value:@(characterSpacing) range:range];
//    [self addAttribute:(NSString *)kCTKernAttributeName
//                 value:@(characterSpacing) // http://stackoverflow.com/a/17067994
//                 range:range];
}


#pragma mark - ParagraphStyle

- (void)setParagraphStyle:(NSParagraphStyle *)paragraphStyle
{
    [self setParagraphStyle:paragraphStyle range:NSMakeRange(0, self.length)];
}

// TODO: Check the behavior when applying a paragraph style only to some
//       characters in the middle of an actual paragraph.
- (void)setParagraphStyle:(NSParagraphStyle *)paragraphStyle range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    [self removeAttribute:NSParagraphStyleAttributeName range:range]; // Work around for Apple leak
    [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

- (void)setAttributeAlignmentStyle:(NSTextAlignment)textAlignment
                    lineSpaceStyle:(CGFloat)linesSpacing
               paragraphSpaceStyle:(CGFloat)paragraphSpacing
                    lineBreakStyle:(NSLineBreakMode)lineBreakMode
{
    [self setAttributeAlignmentStyle:textAlignment lineSpaceStyle:linesSpacing paragraphSpaceStyle:paragraphSpacing lineBreakStyle:lineBreakMode range:NSMakeRange(0, self.length)];
}

- (void)setAttributeAlignmentStyle:(NSTextAlignment)textAlignment
                    lineSpaceStyle:(CGFloat)linesSpacing
               paragraphSpaceStyle:(CGFloat)paragraphSpacing
                    lineBreakStyle:(NSLineBreakMode)lineBreakMode
                             range:(NSRange)range
{
    if (range.location == NSNotFound)
    {
        return;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = textAlignment;
    paragraphStyle.lineSpacing = linesSpacing;
    paragraphStyle.paragraphSpacing = paragraphSpacing;
    paragraphStyle.lineBreakMode = lineBreakMode;
    //paragraphStyle.hyphenationFactor = 0.0f;
    //paragraphStyle.firstLineHeadIndent = 0.0f;
    //paragraphStyle.headIndent = 0.0f;

    [self setParagraphStyle:paragraphStyle range:range];
}

@end


//#pragma mark -
//#pragma mark MQ
//
//@implementation NSMutableAttributedString (MQ)
//
//@end
