//
//  MoreInfoView.m
//  Animations
//
//  Created by YouXianMing on 15/11/24.
//  Copyright © 2015年 YouXianMing. All rights reserved.
//

#import "MoreInfoView.h"
#import "UIView+ScreensShot.h"
#import "HyHelper.h"

static int viewTag = 0x002;
@implementation MoreInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        self.layer.borderWidth   = 0.0f;
        self.layer.borderColor   = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
          
            CGPoint translation = [(UITapGestureRecognizer *)sender locationInView:self];
            NSLog(@"%@",NSStringFromCGPoint(translation));
            _type = MoreInfoViewClickTypePlayVideo;
            if (translation.x <= 70.0f &&translation.y <= 70.0f) {
                _type = MoreInfoViewClickTypeDismiss;
            }
            if ([_delegate respondsToSelector:@selector(moreInfoView:clickType:)]) {
                [_delegate moreInfoView:self clickType:_type];
            }
            
        }];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)initUI
{
    CGRect rect = self.frame;
    /*
     *     --------------     *
     *-50->|-view-width-|<-50-*
     *     --------------     *
     */
    _imageView = [HyHelper newObjectsClass:[UIImageView class] AtaddView:self WithTag:viewTag+100];
    _imageView.frame = CGRectMake(-50, 0, rect.size.width + 50 * 2, rect.size.height);
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
    if (_isBlur) return ;
    
    UIView *maskView = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:viewTag+1];
    maskView.frame = self.bounds;
    maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    
    UIImageView *playIcon = [HyHelper newObjectsClass:[UIImageView class] AtaddView:self WithTag:viewTag+2];
    playIcon.image = [UIImage imageNamed:@"Action_play_click"];
    playIcon.frame = CGRectMake(self.width/2 - 60/2, self.height/2 - 60/2, 60, 60);
    
    UIButton *dismissButton = [HyHelper newObjectsClass:[UIButton class] AtaddView:self WithTag:viewTag+3];
    [dismissButton setImage:[UIImage imageNamed:@"ic_video_dismiss"] forState:UIControlStateNormal];
    dismissButton.frame = CGRectMake(15, 30, 30, 30);
    [dismissButton addTarget:self action:@selector(dissmissSEL) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startAnimation
{
    [_imageView.layer removeAllAnimations];
    
    UIImageView *playIcon = [HyHelper newObjectsClass:[UIImageView class] AtaddView:self WithTag:viewTag+2];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(1, 1)]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(1.1, 1.1)]];
    [animation setDuration:10.0f];
    animation.fillMode = kCAFillModeForwards;
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    animation.beginTime  = CACurrentMediaTime() + 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [_imageView.layer addAnimation:animation forKey:animation.keyPath];
    
    [UIView animateWithDuration:0.2f animations:^{
        playIcon.alpha = 1.0f;
    }];
}

- (void)stopAnimation
{
    [_imageView.layer removeAllAnimations];
    
    [self.layer removeAllAnimations];
    UIImageView *playIcon = [HyHelper newObjectsClass:[UIImageView class] AtaddView:self WithTag:viewTag+2];
    //_imageView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.2 animations:^{
        playIcon.alpha = 0.0f;
        //_imageView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dissmissSEL
{
    _type = MoreInfoViewClickTypeDismiss;
    if ([_delegate respondsToSelector:@selector(moreInfoView:clickType:)]) {
        [_delegate moreInfoView:self clickType:_type];
    }
}

- (void)setIsBlur:(BOOL)isBlur
{
    _isBlur = isBlur;
    [self initUI];
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    CGRect rect = frame;
    _imageView.frame = CGRectMake(-50, 0, rect.size.width + 50 * 2, rect.size.height);
}

@end
