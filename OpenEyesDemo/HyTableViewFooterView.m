//
//  HyTableViewFooterView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/26.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HyTableViewFooterView.h"

@implementation HyTableViewFooterView

+ (instancetype) loadView
{
    NSArray * ar = [[NSBundle mainBundle] loadNibNamed:@"HyTableViewFooterView" owner:self options:nil];
    HyTableViewFooterView *footerView = [ar lastObject];
    [footerView startAnimation];
    footerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 68);
    return [ar lastObject];
}

- (void)startAnimation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [_inImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

@end
