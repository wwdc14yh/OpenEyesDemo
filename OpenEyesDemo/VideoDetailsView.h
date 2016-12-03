//
//  VideoDetailsView.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/27.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"
typedef enum : NSUInteger {
    VideoDetailsViewClickTypePresent,
} VideoDetailsViewClickType;

@class VideoDetailsView;
@protocol VideoDetailsViewDelegate <NSObject>
@optional
- (void)videoDetailsView:(nonnull VideoDetailsView *)videoDetaolsView videoDetailsViewClickType:(VideoDetailsViewClickType)type;

@end

@interface VideoDetailsView : UIView

@property (nullable,nonatomic, weak)   ItemList           *data;
@property (nonnull, nonatomic, strong) UIImageView        *imageView;
@property (nonatomic, assign, readonly)          VideoDetailsViewClickType type;
@property (nullable ,nonatomic ,weak)  id<VideoDetailsViewDelegate> delegate;
@property (nullable,nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) BOOL isShow;

- (void)startAnimation;
- (void)stopAnimation;
@end

@interface BlurView : UIView
- (void)initUI;
@end
