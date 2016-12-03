//
//  HyTableViewCellFooterView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/26.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HyTableViewCellFooterView.h"

@interface HyTableViewCellFooterView ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HyTableViewCellFooterView

+ (instancetype) loadView
{
    NSArray * ar = [[NSBundle mainBundle] loadNibNamed:@"HyTableViewCellFooterView" owner:self options:nil];
    return [ar firstObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _dataSource = @[].mutableCopy;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HyTableViewFooterViewCollectionViewCell class]) bundle:nil]
      forCellWithReuseIdentifier:NSStringFromClass([HyTableViewFooterViewCollectionViewCell class])];
    [_collectionView setCollectionViewLayout:self.flowLayout animated:true];
    _collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    _collectionView.showsHorizontalScrollIndicator = false;
}

#pragma mark 懒加载flowlayout
- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //_flowLayout.itemSize = CGSizeMake(260, 200);
        _flowLayout.minimumLineSpacing = 5;
        _flowLayout.minimumInteritemSpacing = 2;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}

- (void)setData:(ItemList *)data
{
    _data = data;
    [_imageView setImageWithURL:[NSURL URLWithString:_data.data.header.cover] placeholder:nil options:YYWebImageOptionShowNetworkActivity|YYWebImageOptionProgressiveBlur completion:nil];
    [_dataSource removeAllObjects];
    for (id obj in _data.data.itemList) {
        [_dataSource addObject:obj];
    }
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5.f;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemList *listModel = [_dataSource objectAtIndex:indexPath.row];
    if (!listModel.data.title) {
        return CGSizeMake(150, 200);
    }
    return CGSizeMake(260, 200);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HyTableViewFooterViewCollectionViewCell *cell = (id)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HyTableViewFooterViewCollectionViewCell class]) forIndexPath:indexPath];
    id obj = [_dataSource objectAtIndex:indexPath.row];
    cell.list = obj;
    return cell;
}

- (void)setH:(CGFloat)h
{
    _h = h;
    _imageViewHeightLayout.constant = _h;
}

@end
