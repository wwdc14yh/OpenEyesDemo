//
//  FindDetailsTableViewCell.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"
#import "FindDetailsCollectionViewFlowLayout.h"

@interface FindDetailsTableViewCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewLayoutLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewLayoutRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewLayoutBottom;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewLayoutTop;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCell;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (assign, nonatomic, readonly) BOOL isAnimations;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isHighlightRow;
@property (nonatomic, strong) ItemList *data;
@property (nonatomic, strong) id json;

- (void)setIsHighlightRow:(BOOL)isHighlightRow AtIsAnimation:(BOOL)animations;
@end
