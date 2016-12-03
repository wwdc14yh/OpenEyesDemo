//
//  HyInteractiveTransition.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/26.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+ScreensShot.h"
typedef NS_ENUM(NSUInteger, HyPresentOneTransitionType) {
    HyPresentOneTransitionTypePresent = 0,//管理present动画
    HyPresentOneTransitionTypeDismiss//管理dismiss动画
};

typedef NS_ENUM(NSUInteger, HyTransitionStyleType) {
    HyTransitionStyleTypeVideoDetails = 0,
    HyTransitionStyleTypeAuthorVideoSet ,
    HyTransitionStyleTypePlayVideo
};

@interface HyInteractiveTransition : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic, assign) HyPresentOneTransitionType type;
@property (nonatomic, assign) HyTransitionStyleType transitionStyleType;
@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, strong) id     resources;
+ (instancetype)transitionWithTransitionType:(HyPresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(HyPresentOneTransitionType)type;
@end
