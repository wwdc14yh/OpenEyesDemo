//
//  PlayVideoViewController.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/29.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "PlayVideoViewController.h"
#import <MDVRLibrary.h>
#import <VIMVideoPlayer.h>
#import <VIMVideoPlayerView.h>
#import "PlayVideoToolsView.h"
#import "HyPlayVideoLayer.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define misuseArea 30
@interface PlayVideoViewController ()<VIMVideoPlayerDelegate, PlayVideoToolsViewDelegate, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate>
{
    AVPlayerItem *playerItem;
}
@property (nonatomic, strong) VIMVideoPlayer *player;
@property (weak, nonatomic) IBOutlet VIMVideoPlayerView *playerView;
@property (nonatomic, strong) MDVRLibrary* vrLibrary;
@property (nonatomic, strong) MDVRConfiguration* config;
@property (nonatomic, strong) PlayVideoToolsView *tools;
@property (nonatomic, assign) BOOL isScrubbing;
@property (weak, nonatomic) IBOutlet HyPlayVideoLayer *playView;
@property (assign, nonatomic) BOOL isShowTools;
@end

@implementation PlayVideoViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if (self) {
        self = [super initWithCoder:aDecoder];
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _transitionManage = [[HyInteractiveTransition alloc] init];
        _transitionManage.transitionStyleType = HyTransitionStyleTypePlayVideo;
    }
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    //这里我们初始化presentType
    _transitionManage.type = HyPresentOneTransitionTypePresent;
    return _transitionManage;
}
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    //这里我们初始化dismissType
    _transitionManage.type = HyPresentOneTransitionTypeDismiss;
    return _transitionManage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _isScrubbing = false;
    self.player = [[VIMVideoPlayer alloc] init];
    
    ItemList *list = [_list objectAtIndex:_idx];
    
    
    playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:[[list.data.playInfo lastObject] valueForKey:@"url"]]];
    [self.player setPlayerItem:playerItem];
    _player.delegate = self;
    [self.playerView setVideoFillMode:AVLayerVideoGravityResizeAspectFill];
    /////////////////////////////////////////////////////// MDVRLibrary
    self.playView.hidden = (list.data.label);
    if (list.data.label) {
        
        if (list.data.label.text.length != 0) {
            //dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _config = [MDVRLibrary createConfig];
                
                [_config asVideo:playerItem];
                [_config setContainer:self view:self.view];
                
                // optional
                [_config projectionMode:MDModeProjectionPlaneFull];
                [_config displayMode:MDModeDisplayNormal];
                [_config interactiveMode:MDModeInteractiveTouch];
                [_config pinchEnabled:true];
                
                self.vrLibrary = [_config build];
            //});
        }
    }
    
    if (!_config) {
        _playView.hidden = false;
        _playView.Player = self.player.player;
    }
    /////////////////////////////////////////////////////// MDVRLibrary
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {

                _isShowTools = !_isShowTools;
                if (_isShowTools) {
                    NSLog(@"显示");
                    [_tools showToolsView];
                }else{
                    NSLog(@"消失");
                    [_tools disappearToolsView];
                }
    }];
    tap.delegate = self;
    [[list.data.label.text isEqualToString:@"360°全景"]?self.view : self.playView addGestureRecognizer:tap];
    static CGFloat fl = 0.0f;
    static CGFloat lin = 0.0f;
    static CGFloat pro = 0.0f;
    static CGFloat i1 = 0.0f;
    static BOOL isfastForward = false;
    HyWeakSelf(self);
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        
        UIPanGestureRecognizer *pans = sender;
        CGPoint translation = [pans translationInView:self.view];
        CGPoint location = [pans locationInView:self.view];
        
        Float64 durationInSeconds = CMTimeGetSeconds(weakself.player.player.currentItem.duration);
        
        if (pans.state == UIGestureRecognizerStateCancelled) {
            
            
        } else if (pans.state == UIGestureRecognizerStateBegan) {
            lin = [[UIScreen mainScreen] brightness];
            fl = LxVolumeManager.currentVolume;
            pro = weakself.tools.progressSlider.currentValue/_tools.progressSlider.maxValue;
        } else if (pans.state == UIGestureRecognizerStateChanged) {
            
            
            CGFloat half = location.x/weakself.view.width;
            if (translation.x > misuseArea) {
                weakself.isScrubbing = true;
                isfastForward = true;
                CGFloat x = translation.x - misuseArea;
                [weakself.player startScrubbing];
                //NSLog(@"x:%.2f",x);
                //if (x > 0) {
                    //快进
                    CGFloat f = x/(weakself.view.width/2);
                    CGFloat fastFront = pro + f;
                    float ti = durationInSeconds *fastFront;
                    [weakself.player scrub:ti];
                    weakself.tools.progressSlider.currentValue = fastFront;
                    Float64 time = durationInSeconds * weakself.tools.progressSlider.currentValue;
                    NSString *currentTime = [self timeformatFromSeconds:time];
                    _tools.currentTimeLabel.text = currentTime;
                    NSString *zo = [self timeformatFromSeconds:durationInSeconds];
                    _tools.fastLable.text = [NSString stringWithFormat:@"%@/%@",currentTime,zo];
                    if (i1 < x) {
                        _tools.frontOrRearImageView.image = HyIMAGE(@"guide_arrow_right");
                    } else {
                        _tools.frontOrRearImageView.image = HyIMAGE(@"guide_arrow_left");
                    }
                    i1 = x;
                   // return ;
                //}
            }
            if (-translation.x > misuseArea) {
                weakself.isScrubbing = true;
                isfastForward = true;
                CGFloat x = translation.x + misuseArea;
                [weakself.player startScrubbing];
                //if (x < 0) {
                    //快退
                    CGFloat f = -x/(weakself.view.width/2);
                    CGFloat fastRear = pro - f;
                    float ti = durationInSeconds *fastRear;
                    [weakself.player scrub:ti];
                    weakself.tools.progressSlider.currentValue = fastRear;
                    Float64 time = durationInSeconds * weakself.tools.progressSlider.currentValue;
                    NSString *currentTime = [self timeformatFromSeconds:time];
                    _tools.currentTimeLabel.text = currentTime;
                    NSString *zo = [self timeformatFromSeconds:durationInSeconds];
                    _tools.fastLable.text = [NSString stringWithFormat:@"%@/%@",currentTime,zo];
                    if (i1 < x) {
                        _tools.frontOrRearImageView.image = HyIMAGE(@"guide_arrow_right");
                    } else {
                        _tools.frontOrRearImageView.image = HyIMAGE(@"guide_arrow_left");
                    }
                    i1 = x;
                  //  return ;
                //}
            }
            
            if (_isScrubbing) return ;
            if ((1-half) < 0.3f) {
                //亮度调节
                if (translation.y < 0) {
                    //亮
                    CGFloat f = -translation.y/100;
                    CGFloat plus = lin  + f;
                    [[UIScreen mainScreen] setBrightness: plus];
                } else {
                    //暗
                    CGFloat f =  translation.y/100;
                    CGFloat minus = lin - f;
                    [[UIScreen mainScreen] setBrightness: minus];
                }
                return ;
                
            }
            if (half < 0.3f) {
                // 音量调节
                if (translation.y < 0) {
                    //大
                    CGFloat f = -translation.y/100;
                    CGFloat plus = fl  + f;
                    [LxVolumeManager setVolume:plus];
                } else {
                    //小
                    CGFloat f =  translation.y/100;
                    CGFloat minus = fl - f;
                    [LxVolumeManager setVolume:minus];
                }
                return ;
            }
            
        }else if (pans.state == UIGestureRecognizerStateEnded) {
            
            if (isfastForward) {
                isfastForward = false;
                [weakself.player stopScrubbing];
                weakself.isScrubbing = false;
            }
            
        }
        
    }];
    [[list.data.label.text isEqualToString:@"360°全景"]?nil : self.playView addGestureRecognizer:pan];
    
    [[UIApplication sharedApplication] setStatusBarHidden:true withAnimation:UIStatusBarAnimationSlide];
    
    _tools = [PlayVideoToolsView loadView];
    _tools.frame = self.view.bounds;
    _tools.progressSlider.maxValue = 1.0f;
    _tools.progressSlider.minValue = 0.f;
    _tools.delegate = self;
    _tools.titleLabel.text = list.data.title;
    [self.view addSubview:_tools];
    
    [_tools.progressSlider dragSliderCompleteWithBlock:^(HySlideView *slideView ,UIGestureRecognizerState state) {

        Float64 durationInSeconds = CMTimeGetSeconds(weakself.player.player.currentItem.duration);
        Float64 time = durationInSeconds * slideView.currentValue;
        NSString *currentTime = [self timeformatFromSeconds:time];
        _tools.currentTimeLabel.text = currentTime;
        NSLog(@"%.2f",time);
        if (state == UIGestureRecognizerStateEnded) {
            [weakself.player stopScrubbing];
            [weakself.player seekToTime:time];
            weakself.isScrubbing = false;
        } else if (state == UIGestureRecognizerStateBegan) {
            [weakself.player startScrubbing];
            weakself.isScrubbing = true;
            
        } else if (state == UIGestureRecognizerStateChanged) {
            [weakself.player scrub:time];
        }
        
    }];
}

- (void)deviceOrientationDidChange
{
    NSLog(@"NAV deviceOrientationDidChange:%ld",(long)[UIDevice currentDevice].orientation);
    if([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait];
        //[self orientationChange:NO];
        //注意： UIDeviceOrientationLandscapeLeft 与 UIInterfaceOrientationLandscapeRight
    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
        [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
        [self orientationChange:YES];
    }
}

- (void)orientationChange:(BOOL)landscapeRight
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    if (landscapeRight) {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.view.bounds = CGRectMake(0, 0, width, height);
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            self.view.transform = CGAffineTransformMakeRotation(0);
            self.view.bounds = CGRectMake(0, 0, width, height);
        }];
    }
}

- (void)interfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector             = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val                  = orientation;
        // 从2开始是因为0 1 两个参数已经被selector和target占用
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationLandscapeRight) forKey:@"orientation"];
//    [UIViewController attemptRotationToDeviceOrientation];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationDidChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    [self interfaceOrientation:UIInterfaceOrientationLandscapeRight];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //设置屏幕的转向为竖屏
//    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
//    //刷新
//    [UIViewController attemptRotationToDeviceOrientation];
    [self interfaceOrientation:UIInterfaceOrientationPortrait];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [super dismissViewControllerAnimated:flag completion:completion];
    [[UIApplication sharedApplication] setStatusBarHidden:false withAnimation:UIStatusBarAnimationSlide];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.player pause];
        self.player = nil;
        _config = nil;
        self.vrLibrary = nil;
        _tools = nil;
        playerItem = nil;
        _playView = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    });
}

- (void)videoPlayerIsReadyToPlayVideo:(VIMVideoPlayer *)videoPlayer
{
    [self.vrLibrary switchInteractiveMode:MDModeInteractiveMotionWithTouch];
    [self.player play];
    [_tools disappearToolsView];
}

- (void)videoPlayerDidReachEnd:(VIMVideoPlayer *)videoPlayer
{
    
}
- (void)videoPlayer:(VIMVideoPlayer *)videoPlayer timeDidChange:(CMTime)cmTime
{
    if (_isScrubbing) return;
    Float64 durationInSeconds = CMTimeGetSeconds(videoPlayer.player.currentItem.duration);
    Float64 timeInSeconds = CMTimeGetSeconds(cmTime);
    //_tools.progressSlider.defaultValue =
    if (isnan(durationInSeconds)) {
        durationInSeconds = 0.0f;
    }
    NSString *totalTime = [self timeformatFromSeconds:durationInSeconds];
    NSString *currentTime = [self timeformatFromSeconds:timeInSeconds];
    _tools.progressSlider.currentValue = timeInSeconds/durationInSeconds;
    _tools.totalTimeLabel.text = totalTime;
    _tools.currentTimeLabel.text = currentTime;
}

- (void)videoPlayer:(VIMVideoPlayer *)videoPlayer loadedTimeRangeDidChange:(float)duration
{
    Float64 durationInSeconds = CMTimeGetSeconds(videoPlayer.player.currentItem.duration);
    _tools.progressSlider.bufferValue = duration/durationInSeconds;
}

- (void)videoPlayerPlaybackBufferEmpty:(VIMVideoPlayer *)videoPlayer
{
    
}

- (void)videoPlayerPlaybackLikelyToKeepUp:(VIMVideoPlayer *)videoPlayer
{

}

- (void)videoPlayer:(VIMVideoPlayer *)videoPlayer didFailWithError:(NSError *)error
{

}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (NSString *)timeformatFromSeconds:(NSInteger)seconds
{
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    return format_time;
}

- (void)playVideoToolsView:(PlayVideoToolsView *)toolsView clickType:(PlayVideoToolsViewClickType)type
{
    if (type == PlayVideoToolsViewClickTypeDismiss) {
        [self dismissViewControllerAnimated:true completion:nil];
    }else if (type == PlayVideoToolsViewClickTypePause) {
        [self.player pause];
    }else if (type == PlayVideoToolsViewClickTypePlay) {
        [self.player play];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

- (void)dealloc
{

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
