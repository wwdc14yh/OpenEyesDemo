//
//  HySlideView.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/30.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HySlideView;
typedef void(^HySlideViewBlock)(HySlideView * ,UIGestureRecognizerState state);

@interface HySlideView : UIView

/**
 *  一些值的设置
 */
@property (nonatomic)           CGFloat    bufferValue;
@property (nonatomic)           CGFloat    minValue;
@property (nonatomic)           CGFloat    maxValue;
@property (nonatomic)           CGFloat    currentValue;
@property (nonatomic)           CGFloat    defaultValue;

/**
 *  便利构造器创建出视图
 *
 *  @param frame        控件的尺寸
 *  @param name         控件名字
 *  @param minValue     最小值
 *  @param maxValue     最大值
 *  @param defaultValue 默认值
 *
 *  @return 视图对象
 */
+ (instancetype)rangeValueViewWithFrame:(CGRect)frame
                                   name:(NSString *)name
                               minValue:(CGFloat)minValue
                               maxValue:(CGFloat)maxValue
                           defaultValue:(CGFloat)defaultValue;

- (void)dragSliderCompleteWithBlock:(HySlideViewBlock)block;

@end
