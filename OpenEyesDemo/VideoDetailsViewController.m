//
//  VideoDetailsViewController.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/27.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "VideoDetailsViewController.h"
#import "HyInteractiveTransition.h"
#import "VideoDetailsView.h"
#import "ScrollComputingValue.h"
#import "Math.h"
#import "MoreInfoView.h"
#import "HyHelper.h"
#import "YYKit.h"
#import "FXBlurView.h"
#import "HyImages.h"
#import "BottomPageView.h"

static int type    = 0;
static int viewTag = 0x11;
@interface VideoDetailsViewController ()<UIViewControllerTransitioningDelegate, UIScrollViewDelegate, MoreInfoViewDelegate, VideoDetailsViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) HyInteractiveTransition *transitionManage;
@property (nonatomic, strong) NSArray              *picturesArray;
@property (nonatomic, strong) NSMutableArray       *computingValuesArray;
@property (nonatomic, strong) Math                 *onceLinearEquation;
@property (nonatomic, strong) NSMutableArray       *videoDetailsObjs;
@property (nonatomic, strong) dispatch_queue_t mainQueue;
@property (nonatomic, strong) BottomPageView *bottomView;
@end

@implementation VideoDetailsViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if (self) {
        self = [super initWithCoder:aDecoder];
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _transitionManage = [[HyInteractiveTransition alloc] init];
        _transitionManage.transitionStyleType = HyTransitionStyleTypeVideoDetails;
        //设置屏幕的转向为竖屏
        [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
        //刷新
        [UIViewController attemptRotationToDeviceOrientation];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)setResources:(id)resources
{
    _resources = resources;
    _transitionManage.resources = _resources;
}

- (void)setStartFrame:(CGRect)startFrame
{
    _startFrame = startFrame;
    _transitionManage.startFrame = _startFrame;
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

static NSMutableArray *blurImages = nil;
static BOOL isRun = false;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    _mainQueue = dispatch_get_main_queue();
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        blurImages = @[].mutableCopy;
        NSMutableArray *tempArr = @[].mutableCopy;
        for (ItemList *listData in _list.itemList) {
            if ([listData.type isEqualToString:@"video"]) {
                [tempArr addObject:listData];
            }
        }
        isRun = false;
        for (ItemList *listData in tempArr) {
            NSInteger idx = [tempArr indexOfObject:listData];
            
            UIImage *cachedImage = [[YYImageCache sharedCache] getImageForKey:listData.data.cover.feed];
            __block UIImage *blur = nil;
            if (cachedImage) {
                blur =  [cachedImage applyExtraLightEffect];//[cachedImage blurredImageWithRadius:100 iterations:2.0f tintColor:[UIColor clearColor]];
                NSData *data = UIImageJPEGRepresentation(blur, 1);
                HyImages *hyImage = [[HyImages alloc] initWithData:data];
                hyImage.index = idx;
                [blurImages addObject:hyImage];
            }else{
                UIImageView *show = nil;
                [show setImageWithURL:[NSURL URLWithString:listData.data.cover.feed] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity];
                [show setImageWithURL:[NSURL URLWithString:listData.data.cover.feed] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                    blur =  [image applyExtraLightEffect];//[image blurredImageWithRadius:100 iterations:2.0f tintColor:[UIColor clearColor]];
                    NSData *data = UIImageJPEGRepresentation(blur, 1);
                    HyImages *hyImage = [[HyImages alloc] initWithData:data];
                    hyImage.index = idx;
                    [blurImages addObject:hyImage];
                    if (isRun) return ;
                    if (blurImages.count == tempArr.count) {
                        [self com];
                    }
                }];
            }
            NSLog(@"正在模糊第%zd个图片",idx);
        }
        if (isRun) return ;
        if (blurImages.count == tempArr.count) {
            [self com];
        }
    });
}

- (void)com
{
    isRun = true;
    dispatch_async(_mainQueue, ^{
        NSLog(@"根据更新UI界面");
        for (HyImages *image in blurImages) {
            VideoDetailsView *detailsView = [_videoDetailsObjs objectAtIndex:image.index];
            detailsView.imageView.image = image;
        }
        isRun = false;
        blurImages = nil;
    });
    NSLog(@"ヾ(｡｀Д´｡)");
}

- (void)setup
{
    MATHPoint pointA;
    MATHPoint pointB;
    // Init pictures data.
    
    NSMutableArray *tempArr = @[].mutableCopy;
    for (ItemList *listData in _list.itemList) {
        if ([listData.type isEqualToString:@"video"]) {
            [tempArr addObject:listData];
        }
    }
    
    _videoDetailsObjs = @[].mutableCopy;
    _picturesArray = tempArr;
    self.computingValuesArray = [NSMutableArray array];
    // Type.
    if (type % 4 == 0) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.view.width, 270 - 80);
        
    } else if (type % 4 == 1) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.view.width, 270 - 20);
        
    } else if (type % 4 == 2) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.view.width, 270 + 20);
        
    } else if (type % 4 == 3) {
        
        pointA = MATHPointMake(0, -50);
        pointB = MATHPointMake(self.view.width, 270 + 80);
    }
    
    self.onceLinearEquation = [Math mathOnceLinearEquationWithPointA:pointA PointB:pointB];
    
    type++;
    
    
    // Init scrollView.
    CGFloat height = self.view.height;
    CGFloat width  = self.view.width;
    
    _scrollView.pagingEnabled                  = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.bounces                        = YES;
    _scrollView.contentSize                    = CGSizeMake(self.picturesArray.count * width, height);
    
    for (ItemList *listData in self.picturesArray) {
        NSInteger i = [self.picturesArray indexOfObject:listData];
        
        MoreInfoView *show   = [[MoreInfoView alloc] initWithFrame:CGRectMake(i * width, 0, width, (height/2) + 40)];
        show.isBlur = false;
        show.delegate = self;
        //__block MoreInfoView *blurImage = [[MoreInfoView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(show.frame), width, height - show.height)];
        VideoDetailsView *detailsView = [[VideoDetailsView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(show.frame), width, (self.view.height - show.height))];
        detailsView.delegate = self;
        detailsView.scrollView = _scrollView;
        [_videoDetailsObjs addObject:detailsView];
            [show.imageView setImageWithURL:[NSURL URLWithString:listData.data.cover.feed] options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity];
        detailsView.tag = (viewTag + i)+200;
        detailsView.data = listData;
        [detailsView stopAnimation];
        [self.view addSubview:detailsView];
        if (i == 0) {
            
            detailsView.alpha      = 1.f;
            
        } else {
            
            detailsView.alpha      = 0.f;
        }
        show.tag             = viewTag + i;
        [_scrollView addSubview:show];
        
        detailsView.tag      = (viewTag + i)+100;
        
        // Setup ScrollComputingValues.
        ScrollComputingValue *value = [ScrollComputingValue new];
        value.startValue            = -Width + i * Width;
        value.midValue              = 0      + i * Width;
        value.endValue              = +Width + i * Width;
        [value makeTheSetupEffective];
        [self.computingValuesArray addObject:value];
    }
    
    id objs = [_list.itemList objectAtIndex:_indexPath.row];
    NSInteger idx = [_picturesArray indexOfObject:objs];
    MoreInfoView *show = [_scrollView viewWithTag:viewTag + idx];
    __block VideoDetailsView *detailsView = [_videoDetailsObjs objectAtIndex:idx];
    [detailsView startAnimation];
    
    ItemList *listData = [_picturesArray objectAtIndex:idx];
    [show.imageView setImageWithURL:[NSURL URLWithString:listData.data.cover.feed] placeholder:nil options:YYWebImageOptionProgressiveBlur | YYWebImageOptionShowNetworkActivity completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        UIImage *blur = [image applyExtraLightEffect];//[image blurredImageWithRadius:100 iterations:2.0f tintColor:[UIColor clearColor]];
        detailsView.imageView.image = blur;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [show startAnimation];
    });
    [_scrollView setContentOffset:CGPointMake(idx * width, 0) animated:false];
    
    _bottomView = [BottomPageView loadView];
    _bottomView.frame = CGRectMake(0, self.view.height - 30, 0, 30);
    _bottomView.maxPage = _picturesArray.count;
    _bottomView.currPage = _scrollView.contentOffset.x / _scrollView.contentSize.width;
    [self.view addSubview:_bottomView];
}
static NSInteger oldIndex = 0;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        if ([object isKindOfClass:[UIScrollView class]]) {
           // CGPoint offset = ((UIScrollView*)object).contentOffset;
            NSInteger index = fabs(_scrollView.contentOffset.x) / _scrollView.frame.size.width;
            _bottomView.currPage = _scrollView.contentOffset.x / _scrollView.contentSize.width;
            if (oldIndex != index) {
                VideoDetailsView *detailsView = [_videoDetailsObjs objectAtIndex:index];
                [detailsView startAnimation];
                
                VideoDetailsView *olddetailsView = [_videoDetailsObjs objectAtIndex:oldIndex];
                [olddetailsView stopAnimation];
            }
            
            oldIndex = index;
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat X = scrollView.contentOffset.x;
    for (int i = 0; i < self.picturesArray.count; i++) {
        
        ScrollComputingValue *value     = _computingValuesArray[i];
        MoreInfoView *show = [scrollView viewWithTag:viewTag + i];
        VideoDetailsView *detailsView = [_videoDetailsObjs objectAtIndex:i];
        show.imageView.x   = _onceLinearEquation.k * (X - i * self.view.width) + _onceLinearEquation.b;
        
        value.inputValue     = X;
        detailsView.alpha    = value.outputValue;
    }
}

- (void)videoDetailsView:(nonnull VideoDetailsView *)videoDetaolsView videoDetailsViewClickType:(VideoDetailsViewClickType)type
{
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AuthorVideoSetViewController"];
    [vc setValue:[NSValue valueWithCGRect:videoDetaolsView.frame] forKey:@"startFrame"];
    [vc setValue:videoDetaolsView.imageView.image forKey:@"resources"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [vc setValue:[NSValue valueWithCGRect:videoDetaolsView.frame] forKey:@"startFrame"];
    });
    [self presentViewController:vc animated:true completion:nil];
}

- (void)moreInfoView:(MoreInfoView *)moreInfoView clickType:(MoreInfoViewClickType)type
{
    if (type == MoreInfoViewClickTypeDismiss) {
        [self dismissViewControllerAnimated:true completion:nil];
    }else if (type == MoreInfoViewClickTypePlayVideo) {
        NSInteger index = fabs(_scrollView.contentOffset.x) / _scrollView.frame.size.width;
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"PlayVideoViewController"];
        [vc setValue:_picturesArray forKey:@"list"];
        [vc setValue:@(index) forKey:@"idx"];
        //[vc setValue:[NSURL URLWithString:@"http://baobab.kaiyanapp.com/api/v1/playUrl?vid=10516&editionType=high"] forKey:@"videoURL"];
        [self presentViewController:vc animated:true completion:nil];
    }
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    NSInteger index = fabs(_scrollView.contentOffset.x) / _scrollView.frame.size.width;
    id obj = [_picturesArray objectAtIndex:index];
    NSInteger idx = [_list.itemList indexOfObject:obj];
    
    if ([_delegate respondsToSelector:@selector(videoDetailsViewController:updateIndexPath:)]) {
        [_delegate videoDetailsViewController:self updateIndexPath:[NSIndexPath indexPathForRow:idx inSection:_indexPath.section]];
    }
    CGRect rectInTableView = [_tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:_indexPath.section]];
    CGRect rect = [_tableView convertRect:rectInTableView toView:[_tableView superview]];
    MoreInfoView *show = [_scrollView viewWithTag:viewTag + index];
    _transitionManage.startFrame = rect;
    _transitionManage.resources = show.imageView.image;
    [super dismissViewControllerAnimated:flag completion:completion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)dealloc
{
    _picturesArray = nil;
    _computingValuesArray = nil;
    _onceLinearEquation = nil;
    _videoDetailsObjs = nil;
    _mainQueue = nil;
    _scrollView = nil;
    _transitionManage = nil;
    _list = nil;
    _indexPath = nil;
    _delegate = nil;
    _bottomView = nil;
    [self.view removeAllSubviews];
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
