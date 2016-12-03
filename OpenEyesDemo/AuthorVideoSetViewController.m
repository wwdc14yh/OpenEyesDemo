//
//  AuthorVideoSetViewController.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/28.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "AuthorVideoSetViewController.h"

@interface AuthorVideoSetViewController ()<UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation AuthorVideoSetViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    if (self) {
        self = [super initWithCoder:aDecoder];
        self.transitioningDelegate = self;
        self.modalPresentationStyle = UIModalPresentationCustom;
        _transitionManage = [[HyInteractiveTransition alloc] init];
        _transitionManage.transitionStyleType = HyTransitionStyleTypeAuthorVideoSet;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView.image = _resources;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
    // Do any additional setup after loading the view.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
