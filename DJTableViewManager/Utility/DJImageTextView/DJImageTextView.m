//
//  DJImageTextView.m
//  DJkit
//
//  Created by DennisDeng on 15/9/03.
//  Copyright (c) 2015年 DennisDeng. All rights reserved.
//

#import "DJImageTextView.h"
#import "DJTableViewManagerDefine.h"

#import "UILabel+Category.h"
#import "UIImageView+WebCache.h"

#define IMAGE_GAP           4.0f
#define IMAGETEXT_GAP       4.0f

@interface DJImageTextView ()

@property (strong, nonatomic) UILabel *textLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIControl *controlView;

@end

@implementation DJImageTextView
@synthesize textColor = _textColor;
@synthesize textFont = _textFont;

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"init not supported, use initWithText: instead." userInfo:nil];
    return nil;
}

- (instancetype)initWithText:(NSString *)text
{
    return [self initWithText:text height:TABLE_CELL_HEIGHT];
}

- (instancetype)initWithText:(NSString *)text height:(CGFloat)height
{
    return [self initWithImage:nil text:text height:height gap:IMAGETEXT_GAP];
}

- (instancetype)initWithImage:(NSString *)image height:(CGFloat)height
{
    return [self initWithImage:image text:nil height:height gap:IMAGETEXT_GAP];
}

- (instancetype)initWithImage:(NSString *)image text:(NSString *)text height:(CGFloat)height gap:(CGFloat)gap
{
    return [self initWithImage:image text:text type:DJImageTextViewType_ImageLeft height:height gap:gap];
}

- (instancetype)initWithImage:(NSString *)image text:(NSString *)text type:(DJImageTextViewType)type height:(CGFloat)height gap:(CGFloat)gap
{
    return [self initWithImage:image text:text type:type textColor:nil textFont:nil height:height gap:gap];
}

- (instancetype)initWithImage:(nullable NSString *)image text:(nullable NSString *)text type:(DJImageTextViewType)type textColor:(UIColor *)textColor textFont:(UIFont *)textFont height:(CGFloat)height gap:(CGFloat)gap
{
    return [self initWithImage:image text:text type:type textColor:textColor textFont:textFont height:height gap:gap clicked:nil];
}

- (instancetype)initWithImage:(nullable NSString *)image text:(nullable NSString *)text type:(DJImageTextViewType)type textColor:(nullable UIColor *)textColor textFont:(nullable UIFont *)textFont height:(CGFloat)height gap:(CGFloat)gap clicked:(DJImageTextViewClicked)clicked
{
    return [self initWithImage:image text:text attributedText:nil type:type textColor:textColor textFont:textFont height:height gap:gap clicked:clicked];
}

- (instancetype)initWithImage:(nullable NSString *)image text:(nullable NSString *)text attributedText:(NSAttributedString *)attributedText type:(DJImageTextViewType)type textColor:(nullable UIColor *)textColor textFont:(nullable UIFont *)textFont height:(CGFloat)height gap:(CGFloat)gap clicked:(DJImageTextViewClicked)clicked
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    _type = type;
    
    _imageName = image;
    _imageUrl = nil;
    
    _text = text;
    _attributedText = attributedText;
    
    _textColor = textColor;
    
    _textFont = textFont;
    
    _imageTextGap = gap;
    
    if (height <= 0)
    {
        height = TABLE_CELL_HEIGHT;
    }
    self.height = height;
    
    _imageTextViewClicked = clicked;

    [self makeView];
    
    return self;
}

- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText
{
    return [self initWithAttributedText:attributedText height:TABLE_CELL_HEIGHT];
}

- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText height:(CGFloat)height
{
    return [self initWithImage:nil attributedText:attributedText height:height gap:IMAGETEXT_GAP];
}

- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText image:(NSString *)image
{
    return [self initWithImage:image attributedText:attributedText type:DJImageTextViewType_ImageRight height:TABLE_CELL_HEIGHT gap:6.0f];
}

- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText image:(NSString *)image gap:(CGFloat)gap
{
    return [self initWithImage:image attributedText:attributedText type:DJImageTextViewType_ImageRight height:TABLE_CELL_HEIGHT gap:gap];
}

- (instancetype)initWithImage:(NSString *)image attributedText:(NSAttributedString *)attributedText height:(CGFloat)height gap:(CGFloat)gap
{
    return [self initWithImage:image attributedText:attributedText type:DJImageTextViewType_ImageLeft height:height gap:gap];
}

- (instancetype)initWithImage:(NSString *)image attributedText:(NSAttributedString *)attributedText type:(DJImageTextViewType)type height:(CGFloat)height gap:(CGFloat)gap
{
    return [self initWithImage:image attributedText:attributedText type:type height:height gap:gap clicked:nil];
}

- (instancetype)initWithImage:(NSString *)image attributedText:(NSAttributedString *)attributedText type:(DJImageTextViewType)type height:(CGFloat)height gap:(CGFloat)gap clicked:(DJImageTextViewClicked)clicked
{
    return [self initWithImage:image text:nil attributedText:attributedText type:type textColor:nil textFont:nil height:height gap:gap clicked:clicked];
}

- (void)setImageTextViewClicked:(DJImageTextViewClicked)imageTextViewClicked
{
    self.controlView.hidden = (imageTextViewClicked == nil);
    
    _imageTextViewClicked = imageTextViewClicked;
}

- (void)makeView
{
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *textLable = [[UILabel alloc] init];
    textLable.backgroundColor = [UIColor clearColor];
    textLable.hidden = YES;
    
    [self addSubview:textLable];
    
    self.textLabel = textLable;
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.hidden = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:imageView];
    
    self.imageView = imageView;
    
    UIControl *control = [[UIControl alloc] init];
    control.backgroundColor = [UIColor clearColor];
    control.hidden = (_imageTextViewClicked == nil);
    control.exclusiveTouch = YES;
    [control addTarget:self action:@selector(viewClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:control];
    
    self.controlView = control;
}

- (void)viewClicked
{
    if (self.imageTextViewClicked)
    {
        self.imageTextViewClicked(self);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize textSize = CGSizeZero;
    CGFloat textMaxWidth = 0;
    if (self.text || self.attributedText)
    {
        self.textLabel.hidden = NO;
        
        self.textLabel.textColor = self.textColor;
        self.textLabel.font = self.textFont;

        if (self.text)
        {
            self.textLabel.text = self.text;
            textSize = [self.textLabel labelSizeToFit:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        }
        else
        {
            self.textLabel.attributedText = self.attributedText;
            textSize = [self.textLabel attribSizeToFit:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        }
        
        textSize.height = self.height;
        self.textLabel.height = self.height;
    }
    else
    {
        self.textLabel.hidden = YES;
    }
    
    CGFloat imageHeight = 0;
    CGFloat imageWidth = 0;
    if (self.imageName || self.imageUrl)
    {
        self.imageView.hidden = NO;
        
        if (self.imageName)
        {
            UIImage *image = [UIImage imageNamed:self.imageName];
            self.imageView.image = image;
            
            CGSize imageSize = image.size;
            imageHeight = imageSize.height;
            if (imageHeight > self.height - IMAGE_GAP)
            {
                imageHeight = self.height - IMAGE_GAP;
            }
            if (imageSize.width)
            {
                imageWidth = imageHeight * (imageSize.width / imageSize.height);
            }
            else
            {
                imageWidth = imageHeight;
            }
            
            if (!CGSizeEqualToSize(self.imageSize, CGSizeZero))
            {
                imageHeight = self.imageSize.height;
                imageWidth = self.imageSize.width;
            }
        }
        else
        {
            [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority completed:nil];
            
            imageHeight = self.height - IMAGE_GAP;
            imageWidth = imageHeight;
        }
    }
    else
    {
        self.imageView.hidden = YES;
    }
    
    self.imageView.width = imageWidth;
    self.imageView.height = imageHeight;
    
    if (self.maxWidth)
    {
        if (self.maxWidth > imageWidth + self.imageTextGap)
        {
            textMaxWidth = self.maxWidth - (imageWidth + self.imageTextGap);
            if (textMaxWidth < textSize.width)
            {
                textSize.width = textMaxWidth;
            }
        }
    }
    
    self.width = imageWidth + textSize.width + self.imageTextGap;
    self.controlView.frame = self.bounds;
    self.textLabel.width = textSize.width;
    
    self.textLabel.centerY = self.height*0.5;
    self.imageView.centerY = self.height*0.5;
    
    if (self.type == DJImageTextViewType_ImageLeft)
    {
        self.imageView.left = 0;
        self.textLabel.left = imageWidth + self.imageTextGap;
    }
    else
    {
        self.textLabel.left = 0;
        self.imageView.left = textSize.width + self.imageTextGap;
    }
}


#pragma mark settor/gettor

- (void)setType:(DJImageTextViewType)type
{
    if (_type != type)
    {
        _type = type;
        
        [self setNeedsLayout];
    }
}

- (void)setImageName:(NSString *)imageName
{
    if ([imageName isEqual:_imageName])
    {
        return;
    }
    
    _imageName = imageName;
    
    [self setNeedsLayout];
}

- (void)setText:(NSString *)text
{
    if ([text isEqual:_text])
    {
        return;
    }
    
    _text = text;
    //self.textLabel.text = text;
    
    [self setNeedsLayout];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    if ([attributedText isEqual:_attributedText])
    {
        return;
    }
    
    _attributedText = attributedText;
    //self.textLabel.attributedText = attributedText;
    
    [self setNeedsLayout];
}

- (void)setTextColor:(UIColor *)textColor
{
    if ([textColor isEqual:_textColor])
    {
        return;
    }
    if (!textColor)
    {
        textColor =  [UIColor grayColor];
    }
    _textColor = textColor;
    self.textLabel.textColor = textColor;
}

- (UIColor *)textColor
{
    if (!_textColor)
    {
        return [UIColor grayColor];
    }
    
    return _textColor;
}

- (void)setTextFont:(UIFont *)textFont
{
    if ([textFont isEqual:_textFont])
    {
        return;
    }
    if (!textFont)
    {
        textFont = [UIFont systemFontOfSize:14.0f];
    }
    _textFont = textFont;
    
    [self setNeedsLayout];
}

- (UIFont *)textFont
{
    if (!_textFont)
    {
        return [UIFont systemFontOfSize:12.0f];
    }
    
    return _textFont;
}

- (void)setImageSize:(CGSize)imageSize
{
    if (CGSizeEqualToSize(_imageSize, imageSize))
    {
        return;
    }
    
    _imageSize = imageSize;
    
    [self setNeedsLayout];
}

- (void)setImageTextGap:(CGFloat)imageTextGap
{
    if (imageTextGap == _imageTextGap)
    {
        return;
    }
    
    _imageTextGap = imageTextGap;
    
    [self setNeedsLayout];
}

- (void)setMaxWidth:(CGFloat)maxWidth
{
    if (maxWidth == _maxWidth)
    {
        return;
    }
    
    if (maxWidth < 0)
    {
        maxWidth = 0;
    }
    
    _maxWidth = maxWidth;
    
    [self setNeedsLayout];
}

- (void)setAdjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth
{
    self.textLabel.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth;
    self.textLabel.minimumScaleFactor = 0.3f;
    
    [self setNeedsLayout];
}

- (BOOL)adjustsFontSizeToFitWidth
{
    return self.textLabel.adjustsFontSizeToFitWidth;
}

@end

