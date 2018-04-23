//
//  VerifiVC.m
//  DJTableViewManagerSample
//
//  Created by DJ on 2018/1/10.
//  Copyright © 2018年 DJ. All rights reserved.
//

#import "VerifiVC.h"
#import "DJVerifiTimeManager.h"
#import "UIView+VerifiTimeManager.h"

#define VERIFICATIONCODE_LENGTH     6

@interface VerifiVC ()

@property (strong, nonatomic) DJTableViewItem *phoneNumItem;
@property (strong, nonatomic) DJTextItem *verifyCodeItem;
@property (strong, nonatomic) DJTextItem *verifyCodeItem1;

@property (strong, nonatomic) UIButton *clockBtn;

@property (strong, nonatomic) UIButton *clockBtn1;

@end

@implementation VerifiVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"AccessoryView";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self makeFooter];
    
    // Add sections and items
    //
    DJTableViewSection *section = [DJTableViewSection section];
    [self.manager addSection:section];

    self.phoneNumItem = [DJTableViewItem itemWithTitle:@"11011999999"];
    self.phoneNumItem.enabled = NO;
    self.phoneNumItem.isShowHighlightBg = NO;
    self.phoneNumItem.underLineDrawType = DJTableViewCell_UnderLineDrawType_SeparatorAllLeftInset;

    self.verifyCodeItem = [DJTextItem itemWithTitle:nil value:nil placeholder:@"验证码"];
    self.verifyCodeItem.keyboardType = UIKeyboardTypeNumberPad;
    self.verifyCodeItem.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verifyCodeItem.underLineDrawType = DJTableViewCell_UnderLineDrawType_SeparatorAllLeftInset;
    self.verifyCodeItem.onChangeCharacterInRange =  ^ BOOL (DJInputItem *item, NSRange range, NSString *replacementString) {
        
        if (range.length == 1)
        {
            return YES;
        }
        if (item.value.length > VERIFICATIONCODE_LENGTH - 1)
        {
            return NO;
        }
        
        return YES;
    };
    
    // 获取验证码
    UIButton *clockBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90.0f, 30.0f)];
    self.clockBtn = clockBtn;
    clockBtn.titleLabel.font = UI_DJ_FONT(14.0f);
    [clockBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [clockBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.verifyCodeItem.accessoryView = clockBtn;
    [clockBtn addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    clockBtn.exclusiveTouch = YES;

    clockBtn.layer.cornerRadius = clockBtn.height*0.5;
    clockBtn.layer.borderWidth = 1.0f;
    clockBtn.layer.borderColor = [[UIColor redColor] CGColor];
    clockBtn.layer.masksToBounds = YES;

    __weak typeof(self) weakSelf = self;
    [[DJVerifiTimeManager manager] checkTimeWithType:DJVerificationCodeType_Type1 process:^(DJVerificationCodeType type, NSInteger ticket, BOOL stop) {
        if (ticket>0)
        {
            weakSelf.clockBtn.userInteractionEnabled = NO;
            weakSelf.clockBtn.selected = YES;
            weakSelf.clockBtn.titleLabel.font = UI_DJ_FONT(10.0f);
            weakSelf.clockBtn.titleLabel.text = [NSString stringWithFormat:@"%@ 秒后重新获取", @(ticket)];
            [weakSelf.clockBtn setTitle:[NSString stringWithFormat:@"%@ 秒后重新获取", @(ticket)] forState:UIControlStateSelected];
        }
        else
        {
            weakSelf.clockBtn.userInteractionEnabled = YES;
            weakSelf.clockBtn.selected = NO;
            weakSelf.clockBtn.titleLabel.font = UI_DJ_FONT(14.0f);
            [weakSelf.clockBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
    }];

    self.verifyCodeItem1 = [DJTextItem itemWithTitle:nil value:nil placeholder:@"验证码"];
    self.verifyCodeItem1.keyboardType = UIKeyboardTypeNumberPad;
    self.verifyCodeItem1.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.verifyCodeItem1.underLineDrawType = DJTableViewCell_UnderLineDrawType_SeparatorAllLeftInset;
    self.verifyCodeItem1.onChangeCharacterInRange =  ^ BOOL (DJInputItem *item, NSRange range, NSString *replacementString) {
        
        if (range.length == 1)
        {
            return YES;
        }
        if (item.value.length > VERIFICATIONCODE_LENGTH - 1)
        {
            return NO;
        }
        
        return YES;
    };
    
    UIButton *clockBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90.0f, 30.0f)];
    self.clockBtn1 = clockBtn1;
    clockBtn1.titleLabel.font = UI_DJ_FONT(14.0f);
    [clockBtn1 setTitle:@"获取验证码" forState:UIControlStateNormal];
    [clockBtn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.verifyCodeItem1.accessoryView = clockBtn1;
    [clockBtn1 addTarget:self action:@selector(getVerificationCode1:) forControlEvents:UIControlEventTouchUpInside];
    clockBtn1.exclusiveTouch = YES;
    
    clockBtn1.layer.cornerRadius = clockBtn1.height*0.5;
    clockBtn1.layer.borderWidth = 1.0f;
    clockBtn1.layer.borderColor = [[UIColor redColor] CGColor];
    clockBtn1.layer.masksToBounds = YES;
    
    clockBtn1.verifiManagerdDuration = 60.0f;
    clockBtn1.verifiManagerBlock = ^(DJVerificationCodeType type, NSInteger ticket, BOOL stop) {
        if (ticket>0)
        {
            weakSelf.clockBtn1.userInteractionEnabled = NO;
            weakSelf.clockBtn1.selected = YES;
            weakSelf.clockBtn1.titleLabel.font = UI_DJ_FONT(10.0f);
            weakSelf.clockBtn1.titleLabel.text = [NSString stringWithFormat:@"%@ 秒后重新获取", @(ticket)];
            [weakSelf.clockBtn1 setTitle:[NSString stringWithFormat:@"%@ 秒后重新获取", @(ticket)] forState:UIControlStateSelected];
        }
        else
        {
            weakSelf.clockBtn1.userInteractionEnabled = YES;
            weakSelf.clockBtn1.selected = NO;
            weakSelf.clockBtn1.titleLabel.font = UI_DJ_FONT(14.0f);
            [weakSelf.clockBtn1 setTitle:@"获取验证码" forState:UIControlStateNormal];
        }
    };
    clockBtn1.verifiManagerType = DJVerificationCodeType_Type2;

    [section addItem:self.phoneNumItem];
    [section addItem:self.verifyCodeItem];
    [section addItem:self.verifyCodeItem1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeFooter
{
    // footer
    UIView *footerBGView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 60.0f)];
    footerBGView.backgroundColor = [UIColor clearColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect btnFrame = CGRectMake(0, 0, UI_SCREEN_WIDTH/3.0f, 44.0f);
    btn.frame = btnFrame;
    btn.backgroundColor = [UIColor redColor];
    btn.titleLabel.font = UI_DJ_FONT(16.0f);
    [btn setTitle:@"下一步" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.exclusiveTouch = YES;
    [btn addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerBGView addSubview:btn];
    [btn centerInSuperView];
    
    btn.layer.cornerRadius = btn.height*0.5;
    btn.layer.masksToBounds = YES;

    self.tableView.tableFooterView = footerBGView;
}


#pragma mark -
#pragma mark VerificationCode

- (void)getVerificationCode:(UIButton *)clockBtn
{
    [self.view endEditing:YES];
    
    __weak typeof(self) weakSelf = self;
    [[DJVerifiTimeManager manager] startTimeWithType:DJVerificationCodeType_Type1 process:^(DJVerificationCodeType type, NSInteger ticket, BOOL stop) {
        if (ticket>0)
        {
            weakSelf.clockBtn.userInteractionEnabled = NO;
            weakSelf.clockBtn.selected = YES;
            weakSelf.clockBtn.titleLabel.font = UI_DJ_FONT(10.0f);
            weakSelf.clockBtn.titleLabel.text = [NSString stringWithFormat:@"%@ 秒后重新获取", @(ticket)];
            [weakSelf.clockBtn setTitle:[NSString stringWithFormat:@"%@ 秒后重新获取", @(ticket)] forState:UIControlStateSelected];
        }
        else
        {
            weakSelf.clockBtn.userInteractionEnabled = YES;
            weakSelf.clockBtn.selected = NO;
            weakSelf.clockBtn.titleLabel.font = UI_DJ_FONT(14.0f);
            //weakSelf.clockBtn.titleLabel.text = @"重新获取";
            [weakSelf.clockBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        }
    }];
}

- (void)getVerificationCode1:(UIButton *)clockBtn
{
    [self.view endEditing:YES];
    
    [self.clockBtn1 startVerifiTimeManager];
}

- (void)confirmClick:(UIButton *)btn
{
    [self.view endEditing:YES];
    
    [[DJVerifiTimeManager manager] stopAllType];
}

@end
