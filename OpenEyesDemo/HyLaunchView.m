//
//  HyLaunchView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/26.
//  Copyright © 2016年 Hy. All rights reserved.
//
#import "NetworkRequestManage.h"
#import "HyLaunchView.h"
#import "HyHelper.h"
#import "YYWebImageManager.h"
#define ScreenWidth CGRectGetWidth(self.frame)
#define ScreenHeight CGRectGetHeight(self.frame)


@implementation HyLaunchView

+ (instancetype)loadShowView
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *fullPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"launchImage.png"]];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    UIWindow *window = (id)[HyHelper getMainView];
    NSArray * ar = [[NSBundle mainBundle] loadNibNamed:@"HyLaunchView" owner:self options:nil];
    id obj = [ar firstObject];
    ((UIView *)obj).frame = window.bounds;
    ((UIView *)obj).autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [window.rootViewController.view addSubview:obj];
    if (savedImage) {
        ((HyLaunchView *)obj).imageView.image = savedImage;
    }
    [((HyLaunchView *)obj) startAnimations];
    return obj;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    return self;
}

- (void)startAnimations
{
    UIImage *lauchImage = [HyHelper getLauchImage];
    self.maskView.image = lauchImage;
    [self requestNet];
    self.backgroundColor = [UIColor clearColor];
    _imageView.transform = CGAffineTransformMakeScale(1, 1);
    [UIView animateWithDuration:1.0 animations:^{
        _maskView.alpha = 0.0f;
    }];
    
    [UIView animateWithDuration:4 delay:0.4 options:0 animations:^{
        _imageView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    } completion:nil];
    [UIView animateWithDuration:1 delay:4 options:0 animations:^{
        _imageView.alpha = 0.0f;
        _t1.alpha = 0.0f;
        _t2.alpha = 0.0f;
        _t3.alpha = 0.0f;
        _t4.alpha = 0.0f;
        _iconImage.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)requestNet
{
    typeof(self) __weak weakSelf = self;
    [NetworkRequestManage requestWithRequestMethod:NetworkRequestMethodGET Params:[NSDictionary dictionary] Path:startPage Success:^(id  _Nonnull json) {
       
        [weakSelf AnalysisAtJson:json];
        
    } Failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)AnalysisAtJson:(id)json
{
    NSDictionary *startPageAd = [json objectForKey:@"startPage"];
    [self downloadLaumchImageAtUrl:[startPageAd objectForKey:@"imageUrl"]];
}

- (void)downloadLaumchImageAtUrl:(NSString *)url
{
    typeof(self) __weak weakSelf = self;
    YYWebImageManager *__block downloadImageManager = [YYWebImageManager sharedManager];
    [downloadImageManager requestImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionShowNetworkActivity progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        [weakSelf sevaImage:image];
        downloadImageManager = nil;
    }];
}

- (void)sevaImage:(UIImage *)image
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"launchImage.png"]];   // 保存文件的名称
    [UIImagePNGRepresentation(image)writeToFile:filePath    atomically:YES];
}

- (void)dealloc
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
