//
//  HyTableViewHeaderView.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/25.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HyContentView.h"
@class HyTableViewHeaderView;
typedef NS_OPTIONS(NSUInteger, HyRefreshDirectionType) {
    HyPullDownRefreshType = 1 << 0,
    HyPullUpRefreshType = 1 << 1,
};
typedef void(^StartRefreshBlock)(HyTableViewHeaderView *_Nonnull, HyRefreshDirectionType type);
@protocol HyTableViewHeaderViewDelegate <NSObject>
@optional

- (void)hyTableViewHeaderViewStartRefresh:(HyTableViewHeaderView *_Nonnull)contentView
                   AtRefreshDirectionType:(HyRefreshDirectionType)type;

- (void)hyTableViewHeaderView:(HyTableViewHeaderView *_Nonnull)headerView
        PullDownProgressFloat:(CGFloat)progressFloat;

- (void)hyTableViewHeaderView:(HyTableViewHeaderView *_Nonnull)headerView
         SlidingProgressFloat:(CGFloat)progress;

@end

@interface HyTableViewHeaderView : UIView


@property (nonatomic, weak, nullable) id<HyTableViewHeaderViewDelegate> delegate;
@property (nonatomic, assign, readonly) HyRefreshDirectionType refreshDirectionType;
@property (nonatomic, assign, readonly) BOOL isRefresh;
@property (nonatomic, assign) BOOL isDrag;
@property (weak, nonatomic, nullable) id subView;

+ (_Nonnull instancetype)loadSetupForCustomSubView:(id _Nonnull)subView
                              AtHeaderViewWithSize:(CGSize)size;

+ (_Nonnull instancetype)loadTableViewHeaderViewWithSize:(CGSize)size;

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;
- (void)stopRefresh;
- (void)startRefreshBlock:(StartRefreshBlock _Nonnull)block;
@end
