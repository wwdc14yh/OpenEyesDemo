//
//  OpenEyesViewController.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "OpenEyesViewController.h"
#import "HyHelper.h"
#import "TabBarView.h"
#import "HyLaunchView.h"
@interface OpenEyesViewController ()

@end

@implementation OpenEyesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (iPhone6_6s || iPhone6_6sPlus) {
        NSLog(@"%.2f",[UIScreen mainScreen].scale);
        [UIView setFontScale:[UIScreen mainScreen].scale / 3];
    }else{
        [UIView setFontScale:[UIScreen mainScreen].scale / 2];
    }
    TabBarView *bar = [[TabBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.tabBar.height)];
    [self.tabBar addSubview:bar];
    bar.viewControllers = self.viewControllers;
    bar.tabbarController = self;
    [HyLaunchView loadShowView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
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
