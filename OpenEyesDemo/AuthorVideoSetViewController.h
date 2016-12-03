//
//  AuthorVideoSetViewController.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/28.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkRequestManage.h"
#import "HyInteractiveTransition.h"
#import "HyHelper.h"
#import "YYKit.h"
@interface AuthorVideoSetViewController : UIViewController
@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, strong) id     resources;
@property (nonatomic, strong) HyInteractiveTransition *transitionManage;
@end
