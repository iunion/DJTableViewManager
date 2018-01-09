//
//  NSAttributedString+Category.h
//  DJkit
//
//  Created by DennisDeng on 16/7/22.
//  Copyright © 2016年 DennisDeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSAttributedString (Size)

- (CGSize)sizeToFitWidth:(CGFloat)width;
- (CGSize)sizeToFitHeight:(CGFloat)height;
- (CGSize)sizeToFit:(CGSize)maxSize lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end


@interface NSMutableAttributedString (Category)

- (void)setFont:(nonnull UIFont *)font;
- (void)setFont:(nonnull UIFont *)font range:(NSRange)range;
- (void)setFontName:(nonnull NSString *)fontName size:(CGFloat)size;
- (void)setFontName:(nonnull NSString *)fontName size:(CGFloat)size range:(NSRange)range;
- (void)setFontName:(nonnull NSString *)fontName size:(CGFloat)size bold:(BOOL)isBold italic:(BOOL)isItalic range:(NSRange)range;
//- (void)setFontFamily:(NSString*)fontFamily size:(CGFloat)size bold:(BOOL)isBold italic:(BOOL)isItalic range:(NSRange)range;

- (void)setBaselineOffset:(CGFloat)offset;
- (void)setBaselineOffset:(CGFloat)offset range:(NSRange)range;

- (void)setTextColor:(nonnull UIColor *)color;
- (void)setTextColor:(nonnull UIColor *)color range:(NSRange)range;

- (void)setTextBackgroundColor:(nonnull UIColor *)color;
- (void)setTextBackgroundColor:(nonnull UIColor *)color range:(NSRange)range;

- (void)setTextIsUnderlined:(BOOL)underlined;
- (void)setTextIsUnderlined:(BOOL)underlined range:(NSRange)range;
// ! @param style is a combination of CTUnderlineStyle & CTUnderlineStyleModifiers
- (void)setTextUnderlineStyle:(int32_t)style range:(NSRange)range;
- (void)setTextUnderlineColor:(nonnull UIColor *)color;
- (void)setTextUnderlineColor:(nonnull UIColor *)color range:(NSRange)range;
- (void)setTextUnderlineStyle:(int32_t)style color:(nullable UIColor *)color range:(NSRange)range;

- (void)setTextIsDeletelined:(BOOL)underlined;
- (void)setTextIsDeletelined:(BOOL)underlined range:(NSRange)range;
- (void)setTextDeletelineStyle:(int32_t)style range:(NSRange)range;
- (void)setTextDeletelineColor:(nonnull UIColor *)color range:(NSRange)range;
- (void)setTextDeletelineStyle:(int32_t)style color:(nullable UIColor *)color range:(NSRange)range;

- (void)setLinkURL:(nonnull NSURL *)linkURL;
- (void)setLinkURL:(nonnull NSURL *)linkURL range:(NSRange)range;

- (void)setCharacterSpacing:(CGFloat)characterSpacing;
- (void)setCharacterSpacing:(CGFloat)characterSpacing range:(NSRange)range;

- (void)setParagraphStyle:(nonnull NSParagraphStyle *)paragraphStyle;
- (void)setParagraphStyle:(nonnull NSParagraphStyle *)paragraphStyle range:(NSRange)range;

- (void)setAttributeAlignmentStyle:(NSTextAlignment)textAlignment
                    lineSpaceStyle:(CGFloat)linesSpacing
               paragraphSpaceStyle:(CGFloat)paragraphSpacing
                    lineBreakStyle:(NSLineBreakMode)lineBreakMode;

- (void)setAttributeAlignmentStyle:(NSTextAlignment)textAlignment
                    lineSpaceStyle:(CGFloat)linesSpacing
               paragraphSpaceStyle:(CGFloat)paragraphSpacing
                    lineBreakStyle:(NSLineBreakMode)lineBreakMode
                             range:(NSRange)range;
@end


//@interface NSMutableAttributedString (MQ)
//
//
//@end

//NSFontAttributeName                设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
//NSForegroundColorAttributeNam      设置字体颜色，取值为 UIColor对象，默认值为黑色
//NSBackgroundColorAttributeName     设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
//NSLigatureAttributeName            设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
//NSKernAttributeName                设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
//NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
//NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
//NSUnderlineStyleAttributeName      设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
//NSUnderlineColorAttributeName      设置下划线颜色，取值为 UIColor 对象，默认值为黑色
//NSStrokeWidthAttributeName         设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
//NSStrokeColorAttributeName         填充部分颜色，不是字体颜色，取值为 UIColor 对象
//NSShadowAttributeName              设置阴影属性，取值为 NSShadow 对象
//NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
//NSBaselineOffsetAttributeName      设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
//NSObliquenessAttributeName         设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
//NSExpansionAttributeName           设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
//NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
//NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
//NSLinkAttributeName                设置链接属性，点击后调用浏览器打开指定URL地址
//NSAttachmentAttributeName          设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
//NSParagraphStyleAttributeName      设置文本段落排版格式，取值为 NSParagraphStyle 对象

