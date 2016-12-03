//
//  PlayVideoViewController.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/29.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"
#import "HyHelper.h"
#import "HyInteractiveTransition.h"
@interface PlayVideoViewController : UIViewController

@property (nonatomic, assign) BOOL isSpecialVideo;
@property (strong, nonatomic) NSURL *videoURL;

@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) NSInteger idx;

@property (nonatomic, strong) HyInteractiveTransition *transitionManage;

@end
