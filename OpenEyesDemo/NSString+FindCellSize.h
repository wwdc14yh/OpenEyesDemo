//
//  NSString+FindCellSize.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <Foundation/Foundation.h>

static  NSString  * _Nonnull horizontalScrollCard = @"horizontalScrollCard";
static  NSString  * _Nonnull rectangleCard        = @"rectangleCard";
static  NSString  * _Nonnull squareCard           = @"squareCard";

static  NSString  * _Nonnull videoCollectionOfHorizontalScrollCard = @"videoCollectionOfHorizontalScrollCard";
static  NSString  * _Nonnull horizontalScrollCardSection           = @"horizontalScrollCardSection";
static  NSString  * _Nonnull videoListSection                      = @"videoListSection";
static  NSString  * _Nonnull authorSection                         = @"authorSection";


@interface NSString (FindCellSize)

- (CGSize)getCellSize;

@end
