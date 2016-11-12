//
//  WMProgressHUD.h
//  WMProgressHUDDemo
//
//  Created by Winson Cheung on 2016/11/11.
//  Copyright © 2016年 Winson Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, WMProgressHUDMode) {
    /// UIActivityIndicatorView.
    WMProgressHUDModeIndeterminate,
    /// A round, pie-chart like, progress view.
    WMProgressHUDModeDeterminate,
    /// Horizontal progress bar.
    WMProgressHUDModeDeterminateHorizontalBar,
    /// Ring-shaped progress view.
    WMProgressHUDModeAnnularDeterminate,
    /// Shows a custom view.
    WMProgressHUDModeCustomView,
    /// Shows only labels.
    WMProgressHUDModeText
};

typedef NS_ENUM(NSInteger, WMProgressHUDPosition) {
    // up
    WMProgressHUDPositionUp,
    // center;
    WMProgressHUDPositionCenter,
    // Bottom;
    WMProgressHUDPositionBottom
};

typedef void (^WMProgressHUDCompletionBlock)();

@interface WMProgressHUD : NSObject



// Singleton
+ (instancetype) shareInstance;

// set progress
+ (void) setupProgress:(CGFloat)progress;

// Indeterminate mode
+ (void) showIn:(UIView *)view animated:(BOOL)animation;

// With label
+ (void) showIn:(UIView *)view text:(NSString *)text animated:(BOOL)animation;

// With details label
+ (void) showIn:(UIView *)view text:(NSString *)text detail:(NSString *)detail animated:(BOOL)animation;

// Determinate mode
+ (void) showIn:(UIView *)view text:(NSString *)text HUDModel:(WMProgressHUDMode)model animated:(BOOL)animation;

// text only
+ (void) showIn:(UIView *)view text:(NSString *)text position:(WMProgressHUDPosition)position;

// default position is center
+ (void) showIn:(UIView *)view text:(NSString *)text;

// custom view
+ (void) showIn:(UIView *)view custom:(UIView *)custom text:(NSString *)text animated:(BOOL)animation;

// custom animation
+ (void)showIn:(UIView *)view animaitions:(NSArray *)animations text:(NSString *)text;

// dismiss
+ (void) dismissAnimated:(BOOL)animation;

// dismiss after seconds
+ (void) dismissAnimated:(BOOL)animation after:(NSTimeInterval)seconds;

// dismissing with completed block
+ (void) dismissAnimated:(BOOL)animation completedBlock:(WMProgressHUDCompletionBlock)completion;

@end
