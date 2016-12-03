//
//  HySlideView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/30.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HySlideView.h"
#import "HyHelper.h"

#define thumbImageViewH self.height
#define progressH 5.0f

@interface HySlideView ()
@property (nonatomic, copy  ) HySlideViewBlock block;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, assign) BOOL isPan;
@end

@implementation HySlideView

+ (instancetype)rangeValueViewWithFrame:(CGRect)frame
                                   name:(NSString *)name
                               minValue:(CGFloat)minValue
                               maxValue:(CGFloat)maxValue
                           defaultValue:(CGFloat)defaultValue
{
    return nil;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    [self commonInit];
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self commonInit];
    return self;
}

- (instancetype) init
{
    self = [super init];
    [self commonInit];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadUI];
    });
}

- (void)commonInit
{
    _bufferValue    = 0.0f;
    _minValue       = 0.0f;
    _maxValue       = 0.0f;
    _currentValue   = 0.0f;
    _defaultValue   = 0.0f;
    UIView      *backgroundView =       [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:4];
    UIView      *bufferProgressView   = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:3];
    UIView      *progressView   =       [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:2];
    UIImageView *thumbImageView =       [HyHelper newObjectsClass:[UIImageView class] AtaddView:self WithTag:1];
    
    thumbImageView.image = HyIMAGE(@"ic_slider_thumb");
    thumbImageView.layer.masksToBounds = YES;
    thumbImageView.frame = CGRectMake(0, 0, thumbImageViewH, thumbImageViewH);
    thumbImageView.userInteractionEnabled = true;
    
    backgroundView.frame = CGRectMake(thumbImageViewH/4, self.height/2 - progressH/2, self.width - thumbImageViewH/2, progressH);
    backgroundView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.5f];
    
    bufferProgressView.backgroundColor  =[UIColor colorWithWhite:0.7 alpha:0.5];
    bufferProgressView.frame = CGRectMake(thumbImageViewH/4, self.height/2 - progressH/2, 0, progressH);
    
    progressView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    if (_pan) return;
    _pan = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        _isPan = true;
        CGPoint location = [_pan locationInView:self];
        if (_pan.state == UIGestureRecognizerStateCancelled) {
            
            _isPan = false;
            
        } else if (_pan.state == UIGestureRecognizerStateBegan) {
        
            if (location.x >= 0 && (location.x + thumbImageViewH/2) <= self.width) {
                thumbImageView.x = (location.x - (thumbImageViewH/2));
                progressView.width = location.x;
                //progressView.frame = CGRectMake(0, self.height/2 - progressH/2, location.x, progressH);
            }
            
        } else if (_pan.state == UIGestureRecognizerStateChanged) {
            //NSLog(@"%@",NSStringFromCGPoint(location));
            if (location.x >= 0 && (location.x + thumbImageViewH/2) <= self.width) {
                thumbImageView.x = (location.x - (thumbImageViewH/2));
                progressView.width = location.x;
                //progressView.frame = CGRectMake(0, self.height/2 - progressH/2, location.x, progressH);
            }
        }else if (_pan.state == UIGestureRecognizerStateEnded) {
            _currentValue = (progressView.width/backgroundView.width) * _maxValue;
            _isPan = false;
        }
        _currentValue = (progressView.width/backgroundView.width) * _maxValue;
        _block(self,_pan.state);
    }];
    [thumbImageView addGestureRecognizer:_pan];
}

- (void) reloadUI
{
    UIView      *backgroundView =       [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:4];
    backgroundView.frame = CGRectMake(thumbImageViewH/4, self.height/2 - progressH/2, self.width - thumbImageViewH/2, progressH);
}

- (void)setBufferValue:(CGFloat)bufferValue
{
    _bufferValue = bufferValue;
    {
        UIView      *bufferProgressView   = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:3];
        //UIView      *progressView   =       [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:2];
        CGFloat rate = _bufferValue/_maxValue;
        if (isnan(rate)) {
            rate = 0.0f;
        }
        bufferProgressView.width = self.width * rate;
    }
}

- (void)setCurrentValue:(CGFloat)currentValue
{
    if (currentValue <= _maxValue) {
        _currentValue = currentValue;
    }else{
        _currentValue = _maxValue;
    }
    if (currentValue >= _minValue) {
        _currentValue = currentValue;
    }else{
        _currentValue = _minValue;
    }
    [self compute];
}

- (void)compute
{
    if (_isPan) return;
    {
        UIView      *progressView   =       [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:2];
        UIImageView *thumbImageView =       [HyHelper newObjectsClass:[UIImageView class] AtaddView:self WithTag:1];
        CGFloat rate = _currentValue/_maxValue;
        if (isnan(rate)) {
            rate = 0.0f;
        }
        thumbImageView.x = self.width * rate - (thumbImageView.width/2);
        progressView.width = self.width * rate;
        //progressView.frame = CGRectMake(0, self.height/2 - progressH/2, self.width * rate, progressH);
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self reloadUI];
}

- (void)dragSliderCompleteWithBlock:(HySlideViewBlock)block
{
    _block = block;
}

@end
