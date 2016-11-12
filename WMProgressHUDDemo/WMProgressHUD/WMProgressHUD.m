//
//  WMProgressHUD.m
//  WMProgressHUDDemo
//
//  Created by Winson Cheung on 2016/11/11.
//  Copyright © 2016年 Winson Cheung. All rights reserved.
//

#import "WMProgressHUD.h"


@interface WMProgressHUD()

@property (nonatomic,strong) MBProgressHUD  *hud;

@end


@implementation WMProgressHUD

// 全局变量
static id _instance = nil;

/*=============================== 单例方法 ==========================*/ 
+(instancetype)shareInstance{
    return [[self alloc] init];
}
////alloc会调用allocWithZone:
+(instancetype)allocWithZone:(struct _NSZone *)zone{
    //只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}
//初始化方法
- (instancetype)init{
    // 只进行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super init];
    });
    return _instance;
}
//copy在底层 会调用copyWithZone:
- (id)copyWithZone:(NSZone *)zone{
    return  _instance;
}
+ (id)copyWithZone:(struct _NSZone *)zone{
    return  _instance;
}
+ (id)mutableCopyWithZone:(struct _NSZone *)zone{
    return _instance;
}
- (id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}
/*===================================================================*/

// 实现方法

+ (void)showIn:(UIView *)view text:(NSString *)text detail:(NSString *)detail custom:(UIView *)custom HUDModel:(WMProgressHUDMode)model position:(WMProgressHUDPosition)position animated:(BOOL)animation {

    // 如果 当前有hud显示 则让其消失
    if ([WMProgressHUD shareInstance].hud != nil) {
        [[WMProgressHUD shareInstance].hud hideAnimated:YES];
        [WMProgressHUD shareInstance].hud = nil;
    }
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    // 创建MBProgressHUD
    [WMProgressHUD shareInstance].hud = [MBProgressHUD showHUDAddedTo:view animated:animation];


    /*===================  设置hud的样式 ==========================================================*/
    // hud 显示动画样式
    [WMProgressHUD shareInstance].hud.animationType = MBProgressHUDAnimationFade;
    // hud 背景色
    [WMProgressHUD shareInstance].hud.bezelView.color = [UIColor blackColor];
    // hud 指示器的颜色(菊花, 圆圈)
    [WMProgressHUD shareInstance].hud.contentColor = [UIColor whiteColor];
    // hud 内部视图到边框的间距
     [WMProgressHUD shareInstance].hud.margin = 15;
    // 允许隐藏后 移除
    [WMProgressHUD shareInstance].hud.removeFromSuperViewOnHide = YES;
    // label的font
    // [WMProgressHUD shareInstance].hud.label.font = [UIFont systemFontOfSize:14.f];
    // ....
    /*============================================================================================*/


    if (text != nil) {
        [WMProgressHUD shareInstance].hud.label.text = text;
    }
    if (detail != nil) {
        [WMProgressHUD shareInstance].hud.detailsLabel.text = detail;
    }
    if (custom != nil) {
        [WMProgressHUD shareInstance].hud.customView = custom;
    }
    // hud 显示 模式
    MBProgressHUDMode mbModel;
    switch (model) {
        case WMProgressHUDModeIndeterminate:
        {
            mbModel = MBProgressHUDModeIndeterminate;
            break;
        }
        case WMProgressHUDModeDeterminate:
        {
            mbModel = MBProgressHUDModeDeterminate;
            break;
        }
        case WMProgressHUDModeDeterminateHorizontalBar:
        {
            mbModel = MBProgressHUDModeDeterminateHorizontalBar;
            break;
        }
        case WMProgressHUDModeAnnularDeterminate:
        {
            mbModel = MBProgressHUDModeAnnularDeterminate;
            break;
        }
        case WMProgressHUDModeCustomView:
        {
            mbModel = MBProgressHUDModeCustomView;
            break;
        }
        case WMProgressHUDModeText:
        {
            mbModel = MBProgressHUDModeText;
            break;
        }
        default:
        {
            mbModel = MBProgressHUDModeIndeterminate;
            break;
        }
    }
    [WMProgressHUD shareInstance].hud.mode = mbModel;

    // hud 显示位置
    CGPoint hud_offset = CGPointZero;
    switch (position) {
        case WMProgressHUDPositionUp:
        {
            hud_offset = CGPointMake(0.f, -MBProgressMaxOffset);
            break;
        }
        case WMProgressHUDPositionCenter:
        {
            hud_offset = CGPointZero;
            break;
        }
        case WMProgressHUDPositionBottom:
        {
            hud_offset = CGPointMake(0.f, MBProgressMaxOffset);
            break;
        }
        default:
        {
            hud_offset = CGPointZero;
            break;
        }
    }
    if (mbModel == MBProgressHUDModeText) {
        [WMProgressHUD shareInstance].hud.offset = hud_offset;
    }
}

+ (void) setupProgress:(CGFloat)progress {

    [[WMProgressHUD shareInstance].hud setProgress:progress];
}

// Indeterminate mode
+ (void)showIn:(UIView *)view animated:(BOOL)animation {

    // defalut is WMProgressHUDModeIndeterminate
    [self showIn:view text:nil detail:nil custom:nil HUDModel:WMProgressHUDModeIndeterminate position:WMProgressHUDPositionCenter animated:animation];
}

// With label
+ (void)showIn:(UIView *)view text:(NSString *)text animated:(BOOL)animation {

    [self showIn:view text:text detail:nil custom:nil HUDModel:WMProgressHUDModeIndeterminate position:WMProgressHUDPositionCenter animated:animation];
}

// With details label
+ (void)showIn:(UIView *)view text:(NSString *)text detail:(NSString *)detail animated:(BOOL)animation {

    [self showIn:view text:text detail:detail custom:nil HUDModel:WMProgressHUDModeIndeterminate position:WMProgressHUDPositionCenter animated:animation];
}

// Determinate mode
+ (void)showIn:(UIView *)view text:(NSString *)text HUDModel:(WMProgressHUDMode)model animated:(BOOL)animation {

    [self showIn:view text:text detail:nil custom:nil HUDModel:model position:WMProgressHUDPositionCenter animated:animation];
}

// text only
+ (void)showIn:(UIView *)view text:(NSString *)text position:(WMProgressHUDPosition)position {
    [self showIn:view text:text detail:nil custom:nil HUDModel:WMProgressHUDModeText position:position animated:YES];
}

// default position is center
+ (void)showIn:(UIView *)view text:(NSString *)text {
    [self showIn:view text:text detail:nil custom:nil HUDModel:WMProgressHUDModeText position:WMProgressHUDPositionCenter animated:YES];
}

// custom view
+ (void) showIn:(UIView *)view custom:(UIView *)custom text:(NSString *)text animated:(BOOL)animation {
    [self showIn:view text:text detail:nil custom:custom HUDModel:WMProgressHUDModeCustomView position:WMProgressHUDPositionCenter animated:animation];
}

+ (void)showIn:(UIView *)view animaitions:(NSArray *)animations text:(NSString *)text {

    NSMutableArray *imageArray = [@[] mutableCopy];
    for (NSString *imageName in animations) {
        UIImage *image = [UIImage imageNamed:imageName];
        [imageArray addObject:image];
    }
    UIImageView *imageView = [UIImageView new];
    imageView.animationImages = imageArray;
    imageView.animationRepeatCount = 0;
    imageView.animationDuration = (imageArray.count + 1) * 0.06f;
    [imageView startAnimating];

    [self showIn:view custom:imageView text:text animated:YES];
}



/*================================================================================*/

// dismiss
+ (void) dismissAnimated:(BOOL)animation {

    if ([WMProgressHUD shareInstance].hud != nil) {
        [[WMProgressHUD shareInstance].hud hideAnimated:animation];
    }
}

// dismiss after seconds
+ (void) dismissAnimated:(BOOL)animation after:(NSTimeInterval)seconds {

    if ([WMProgressHUD shareInstance].hud != nil) {
        [[WMProgressHUD shareInstance].hud hideAnimated:animation afterDelay:seconds];
    }
}

// dismissing with completed block
+ (void) dismissAnimated:(BOOL)animation completedBlock:(WMProgressHUDCompletionBlock)completion {

    if ([WMProgressHUD shareInstance].hud != nil) {
        [[WMProgressHUD shareInstance].hud hideAnimated:animation];
        [WMProgressHUD shareInstance].hud.completionBlock = completion;
    }
}

@end
