//
//  TabBarView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "TabBarView.h"
#import "HyHelper.h"

static NSInteger viewTag = 0x002;
@interface TabBarView ()

@property (nonatomic, strong) UIVisualEffectView *blurView;

@end

@implementation TabBarView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self initUI];
    return self;
}

- (void)initUI
{
    self.backgroundColor = [UIColor clearColor];
    //UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    //_blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    //_blurView.frame = self.bounds;
    //[self addSubview:_blurView];
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self reloadUI];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self reloadUI];
}

- (void)reloadUI
{
    for (UIViewController *vc in _viewControllers) {
        NSInteger idx = [_viewControllers indexOfObject:vc];
        CGFloat w = [UIScreen mainScreen].bounds.size.width / _viewControllers.count;
        CGFloat h = 45;
        
        UIView *superView = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:(idx + viewTag)*100];
        [superView setFrame:CGRectMake(idx * w, 0, w, self.height)];
        
        UIImageView *imageView = [HyHelper newObjectsClass:[UIImageView class] AtaddView:superView WithTag:idx+1000];
        imageView.frame = CGRectMake(superView.width/2 - h/2, superView.height/2 - h/2, h, h);

        UIButton *button = [HyHelper newObjectsClass:[UIButton class] AtaddView:superView WithTag:idx + 400];
        [button setFrame:CGRectMake(0, 0, w, self.height)];

    }
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    for (UIViewController *vc in viewControllers) {
        NSInteger idx = [viewControllers indexOfObject:vc];
        CGFloat w = [UIScreen mainScreen].bounds.size.width / viewControllers.count;
        CGFloat h = 45;
        
        UIView *superView = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:(idx + viewTag)*100];
        [superView setFrame:CGRectMake(idx * w, 0, w, self.height)];
        [superView setBackgroundColor:[UIColor clearColor]];
        
        UIImageView *imageView = [HyHelper newObjectsClass:[UIImageView class] AtaddView:superView WithTag:idx+1000];
        imageView.frame = CGRectMake(superView.width/2 - h/2, superView.height/2 - h/2, h, h);
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = vc.tabBarItem.image;
        if (idx == 0) {
            imageView.image = vc.tabBarItem.selectedImage;
        }
        
        UIButton *button = [HyHelper newObjectsClass:[UIButton class] AtaddView:superView WithTag:idx + 400];
        [button setFrame:CGRectMake(0, 0, w, self.height)];
        [button addTarget:self action:@selector(selectViewController:) forControlEvents:UIControlEventTouchUpInside];
        button.tintColor = [UIColor clearColor];
    }
}

- (void)selectViewController:(UIButton *)sender
{
    for (UIViewController *vc in _viewControllers) {
        NSInteger idx = [_viewControllers indexOfObject:vc];
        UIView *superView = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:(idx + viewTag)*100];
        UIImageView *imageView = [HyHelper newObjectsClass:[UIImageView class] AtaddView:superView WithTag:idx+1000];
        UIButton *button = [HyHelper newObjectsClass:[UIButton class] AtaddView:superView WithTag:idx + 400];
        
        button.selected = true;
        imageView.image = vc.tabBarItem.image;
    }
    UIViewController *vc = [_viewControllers objectAtIndex:sender.tag-400];
    UIView *superView = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:((sender.tag - 400) + viewTag)*100];
    UIImageView *imageView = [HyHelper newObjectsClass:[UIImageView class] AtaddView:superView WithTag:(sender.tag - 400)+1000];
    if (sender.selected) {
        imageView.image = vc.tabBarItem.selectedImage;
    }else {
        imageView.image = vc.tabBarItem.image;
    }
    sender.selected = !sender.selected;
    
    self.tabbarController.selectedIndex = sender.tag - 400;
}

@end
