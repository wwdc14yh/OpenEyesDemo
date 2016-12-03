//
//  HyTableViewFooterViewCollectionViewCell.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/26.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYKit.h"
#import "DataModels.h"
#import "HyHelper.h"

@interface HyTableViewFooterViewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (nonatomic, strong) ItemList *list;
@end
