//
//  FindDetailsTableHeaderView.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HyHelper.h"
@interface FindDetailsTableHeaderView : UIView

@property (nonatomic, strong) NSDictionary *categoryInfo;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

+ (instancetype) loadView;
@end
