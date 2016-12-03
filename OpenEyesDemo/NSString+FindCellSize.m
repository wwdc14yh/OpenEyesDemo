//
//  NSString+FindCellSize.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSString+FindCellSize.h"
#import "HyHelper.h"


@implementation NSString (FindCellSize)

- (CGSize)getCellSize
{
    CGSize size = CGSizeZero;
    if ([self isEqualToString:horizontalScrollCard]) {
        size = [HyHelper getDefaultSize];
    } else if ([self isEqualToString:rectangleCard]) {
        CGFloat iW,iH;
        iW = 1242.f;
        iH = 618.f;
        CGFloat sX = iH/iW;
        CGFloat h = [UIScreen mainScreen].bounds.size.width *sX;
        size = CGSizeMake([UIScreen mainScreen].bounds.size.width ,h);
    } else if ([self isEqualToString:squareCard])    {
        size = CGSizeMake(([UIScreen mainScreen].bounds.size.width/2)-1, ([UIScreen mainScreen].bounds.size.width/2));
    } else if ([self isEqualToString:horizontalScrollCardSection] ||
               [self isEqualToString:videoCollectionOfHorizontalScrollCard]) {
        CGSize defaulstSize = [HyHelper getDefaultSize];
        size = CGSizeMake(defaulstSize.width, defaulstSize.height+57+15);
    } else if ([self isEqualToString:videoListSection]) {
        size = [HyHelper getDefaultSize];
    } else if ([self isEqualToString:authorSection]) {
        size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 270);
    }
    return size;
}
@end
