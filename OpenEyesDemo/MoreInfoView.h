//
//  MoreInfoView.h
//  Animations
//
//  Created by YouXianMing on 15/11/24.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    MoreInfoViewClickTypeDismiss,
    MoreInfoViewClickTypePlayVideo,
    MoreInfoViewClickTypeOther,
} MoreInfoViewClickType;
@class MoreInfoView;
@protocol MoreInfoViewDelegate <NSObject>
@optional
- (void)moreInfoView:(MoreInfoView *)moreInfoView clickType:(MoreInfoViewClickType)type;
@end

@interface MoreInfoView : UIView

@property (nonatomic, assign) BOOL isBlur;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign, readonly) MoreInfoViewClickType type;
@property (nonatomic, weak)   id<MoreInfoViewDelegate> delegate;

- (void)startAnimation;
- (void)stopAnimation;
@end
