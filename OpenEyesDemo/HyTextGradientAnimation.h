//
//  HyTextGradientAnimation.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/27.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface HyTextGradientAnimation : UIView

@property (nonnull, nonatomic, copy)   NSString *text;

@property (nullable, nonatomic, weak)  UIFont   *font;

@property (nonnull, nonatomic, strong) UIColor  *textColor;

@property (nonatomic, assign)          BOOL     autoComputeHeight;


+ (nonnull instancetype)textGradientAnimationWithTextString:( NSString * __nonnull)text;

- (nonnull instancetype)initWithTextString:(NSString * __nonnull)text;

- (void)startAnimations;

@end
