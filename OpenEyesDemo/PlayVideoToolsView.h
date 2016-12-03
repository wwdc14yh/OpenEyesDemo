//
//  PlayVideoToolsView.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/30.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HySlideView.h"
#import "HyHelper.h"
#import "LxVolumeManager.h"
@class PlayVideoToolsView;

typedef enum : NSUInteger {
    PlayVideoToolsViewClickTypeDismiss,
    PlayVideoToolsViewClickTypeAction_VolumePlus,
    PlayVideoToolsViewClickTypeAction_VolumeMinus,
    PlayVideoToolsViewClickTypePlay,
    PlayVideoToolsViewClickTypePause,
} PlayVideoToolsViewClickType;

@protocol PlayVideoToolsViewDelegate <NSObject>
@optional
- (void)playVideoToolsView:(PlayVideoToolsView *)toolsView clickType:(PlayVideoToolsViewClickType)type;

@end

@interface PlayVideoToolsView : UIView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet HySlideView *progressSlider;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) id<PlayVideoToolsViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *frontOrRearImageView;
@property (weak, nonatomic) IBOutlet UILabel *fastLable;
@property (assign, nonatomic ,readonly)        PlayVideoToolsViewClickType type;
+ (instancetype) loadView;

- (void)showToolsView;

- (void)disappearToolsView;

- (void)setVolumeValue:(float)value;

@end
