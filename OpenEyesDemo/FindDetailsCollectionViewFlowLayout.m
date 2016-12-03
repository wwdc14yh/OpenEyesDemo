//
//  FindDetailsCollectionViewFlowLayout.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "FindDetailsCollectionViewFlowLayout.h"

@implementation FindDetailsCollectionViewFlowLayout

// 该方法可写可不写，主要是让滚动的item根据距离中心的值，确定哪个必须展示在中心，不会像普通的那样滚动到哪里就停到哪里
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // ProposeContentOffset是本来应该停下的位子
    // 1. 先给一个字段存储最小的偏移量 那么默认就是无限大
    CGFloat minOffset = CGFLOAT_MAX;
    // 2. 获取到可见区域的centerX
    CGFloat horizontalCenter = proposedContentOffset.x + self.collectionView.bounds.size.width / 2;
    // 3. 拿到可见区域的rect
    CGRect visibleRec = CGRectMake(proposedContentOffset.x, 0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    // 4. 获取到所有可见区域内的item数组
    NSArray *visibleAttributes = [super layoutAttributesForElementsInRect:visibleRec];
    
    // 遍历数组，找到距离中心最近偏移量是多少
    for (UICollectionViewLayoutAttributes *atts in visibleAttributes)
    {
        // 可见区域内每个item对应的中心X坐标
        CGFloat itemCenterX = atts.center.x;
        // 比较是否有更小的，有的话赋值给minOffset
        if (fabs(itemCenterX - horizontalCenter) <= fabs(minOffset)) {
            minOffset = itemCenterX - horizontalCenter;
        }
        
    }
    // 这里需要注意的是  上面获取到的minOffset有可能是负数，那么代表左边的item还没到中心，如果确定这种情况下左边的item是距离最近的，那么需要左边的item居中，意思就是collectionView的偏移量需要比原本更小才是，例如原先是1000的偏移，但是需要展示前一个item，所以需要1000减去某个偏移量，因此不需要更改偏移的正负
    
    // 但是当propose小于0的时候或者大于contentSize（除掉左侧和右侧偏移以及单个cell宽度）  、
    // 防止当第一个或者最后一个的时候不会有居中（偏移量超过了本身的宽度），直接卡在推荐的停留位置
    CGFloat centerOffsetX = proposedContentOffset.x + minOffset;
    if (centerOffsetX < 0) {
        centerOffsetX = 0;
    }
    
    if (centerOffsetX > self.collectionView.contentSize.width -(self.sectionInset.left + self.sectionInset.right + self.itemSize.width)) {
        centerOffsetX = floor(centerOffsetX);
    }
    return CGPointMake(centerOffsetX, proposedContentOffset.y);
}

@end
