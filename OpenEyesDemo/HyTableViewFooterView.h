//
//  HyTableViewFooterView.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/26.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HyTableViewFooterView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *outImageViwe;
@property (weak, nonatomic) IBOutlet UIImageView *inImageView;
+ (instancetype) loadView;
@end
