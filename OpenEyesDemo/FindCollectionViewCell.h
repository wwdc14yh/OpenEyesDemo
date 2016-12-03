//
//  FindCollectionViewCell.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYBannerView.h"
#import "HyHelper.h"
#import "DataModels.h"
#import "NSString+FindCellSize.h"

@interface FindCollectionViewCell : UICollectionViewCell <ZYBannerViewDelegate,ZYBannerViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet ZYBannerView *bannerView;
@property (strong, nonatomic)        ItemList *list;

- (void)setIsHighlightRow:(BOOL)isHighlightRow AtIsAnimation:(BOOL)animations;
@end
