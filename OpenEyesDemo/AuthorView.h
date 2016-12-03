//
//  AuthorView.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/28.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HyHelper.h"
#import "DataModels.h"
#import "YYKit.h"
#import "NSString+LabelWidthAndHeight.h"
@interface AuthorView : UIView

@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countLayoutX;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, strong) Author *authorModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *linsHLayout;

+ (instancetype) loadView;

@end
