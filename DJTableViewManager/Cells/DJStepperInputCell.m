//
//  DJStepperInputCell.m
//  DJTableViewManagerSample
//
//  Created by jiang deng on 2018/8/16.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "DJStepperInputCell.h"
#import "DJTableViewManager.h"
#import "DJStepperInputView.h"
#import "DJStepperInputItem.h"

@interface DJStepperInputCell ()
<
    DJStepperInputViewDelegate
>

@property (nonatomic, assign) BOOL enabled;
@property (nonatomic, assign) BOOL stepperable;

@property (nonatomic, strong) DJStepperInputItem *item;

@property (nonatomic, strong) DJStepperInputView *stepperInputView;

@end

@implementation DJStepperInputCell
@synthesize item = _item;

- (void)dealloc
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"stepperable"];
    }
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.stepperInputView = [[DJStepperInputView alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 20.0f)];
    self.stepperInputView.delegate = self;
    
    [self.contentView addSubview:self.stepperInputView];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.accessoryType = UITableViewCellAccessoryNone;
    self.accessoryView = nil;
    
    self.stepperInputView.minNumberValue = self.item.minNumberValue;
    self.stepperInputView.maxNumberValue = self.item.maxNumberValue;
    self.stepperInputView.numberValue = self.item.numberValue;
    
    // 递增步长，默认步长为1
    self.stepperInputView.stepNumberValue = self.item.stepNumberValue;
    
    // 是否可以使用键盘输入，默认YES
    self.stepperInputView.useKeyBord = self.item.useKeyBord;
    
    // 数字颜色
    self.stepperInputView.numberColor = self.item.numberColor;
    // 数字字体
    self.stepperInputView.numberFont = self.item.numberFont;
    
    // 边框颜色
    self.stepperInputView.borderColor = self.item.borderColor;
    // 边框线宽
    self.stepperInputView.borderWidth = self.item.borderWidth;
    
    // 加按钮背景图片
    self.stepperInputView.increaseImage = self.item.increaseImage;
    // 减按钮背景图片
    self.stepperInputView.decreaseImage = self.item.decreaseImage;
    
    // 长按加减的触发时间间隔,默认0.2s
    self.stepperInputView.longPressSpaceTime = self.item.longPressSpaceTime;
    
    // 第一阶段加速倍数，默认1，加速值为firstMultiple*stepNumberValue
    self.stepperInputView.firstMultiple = self.item.firstMultiple;
    // 开始第二阶段加速倍数计数点，默认10
    self.stepperInputView.secondTimeCount = self.item.secondTimeCount;
    // 第二阶段加速倍数，默认10，一般大于firstMultiple
    self.stepperInputView.secondMultiple = self.item.secondMultiple;
    
    // 最小值时隐藏减号按钮，默认NO
    self.stepperInputView.minHideDecrease = self.item.minHideDecrease;
    // 是否开启抖动动画，默认NO，minHideDecrease为YES时不执行动画
    self.stepperInputView.limitShakeAnimation = self.item.limitShakeAnimation;

    self.enabled = self.item.enabled;
    self.stepperable = self.item.stepperable;
}

- (void)cellLayoutSubviews
{
    [super cellLayoutSubviews];
    
    CGFloat cellOffset = 4.0;
    if (self.section.style.contentViewMargin <= 0)
    {
        cellOffset += 4.0f;
    }
    
    self.stepperInputView.frame = CGRectMake(self.contentView.frame.size.width - self.item.stepperInputSize.width - cellOffset, (self.contentView.frame.size.height - self.item.stepperInputSize.height) * 0.5f, self.item.stepperInputSize.width, self.item.stepperInputSize.height);
    
    if (self.textLabel.frame.origin.x + self.textLabel.frame.size.width >= self.stepperInputView.frame.origin.x)
    {
        self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, self.textLabel.frame.size.width - self.stepperInputView.frame.size.width - self.section.style.contentViewMargin - cellOffset, self.textLabel.frame.size.height);
    }
    self.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

#pragma mark -
#pragma mark Handle state

- (void)setItem:(DJStepperInputItem *)item
{
    if (_item != nil)
    {
        [_item removeObserver:self forKeyPath:@"enabled"];
        [_item removeObserver:self forKeyPath:@"stepperable"];
    }
    
    _item = item;
    
    [_item addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:NULL];
    [_item addObserver:self forKeyPath:@"stepperable" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    self.userInteractionEnabled = _enabled;
    
    self.textLabel.enabled = _enabled;
    self.stepperInputView.userInteractionEnabled = _enabled;
}

- (void)setStepperable:(BOOL)enabled
{
    if (!_enabled)
    {
        NSLog(@"Cell is disabled");
        enabled = NO;
    }
    
    _stepperable = enabled;
    
    self.userInteractionEnabled = _stepperable;
    self.stepperInputView.userInteractionEnabled = _stepperable;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([object isKindOfClass:[DJBoolItem class]] && [keyPath isEqualToString:@"enabled"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.enabled = newValue;
    }
    else if ([object isKindOfClass:[DJBoolItem class]] && [keyPath isEqualToString:@"sliderable"])
    {
        BOOL newValue = [[change objectForKey: NSKeyValueChangeNewKey] boolValue];
        
        self.stepperable = newValue;
    }
}

- (void)stepperInputView:(DJStepperInputView *)stepperInputView changeToNumber:(NSDecimalNumber *)number stepStatus:(DJStepperInputViewStepStatus)stepStatus
{
    self.item.numberValue = number;
    if (self.item.valueChangeHandler)
    {
        self.item.valueChangeHandler(self.item, stepStatus);
    }
}

@end
