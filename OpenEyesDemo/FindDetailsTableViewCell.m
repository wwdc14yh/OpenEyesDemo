//
//  FindDetailsTableViewCell.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "FindDetailsTableViewCell.h"
#import "FindDetailsCollectionViewCell.h"
#import "HyHelper.h"
#import "NSString+FindCellSize.h"
#import "AuthorView.h"
#import "HyTableViewFooterViewCollectionViewCell.h"

@interface FindDetailsTableViewCell ()
@property (nonatomic, strong) FindDetailsCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) AuthorView *author;
@property (nonatomic, strong) NSString *collIds;
@end

@implementation FindDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = false;
}

- (void)setData:(id)data
{
    _data = data;
    _collectionView.hidden = ![_data.type isEqualToString:videoCollectionOfHorizontalScrollCard];
    _pageControl.hidden = ![_data.type isEqualToString:videoCollectionOfHorizontalScrollCard];
    _author.hidden = true;
    [self.contentView insertSubview:_collectionView atIndex:0];
    if (!_collectionView.hidden) {
        _collectionViewLayoutTop.constant = 0.f;
        _collectionViewLayoutBottom.constant = 37.0f;
        [self.contentView insertSubview:_collectionView atIndex:[self.contentView subviews].count];
        _collIds = NSStringFromClass([FindDetailsCollectionViewCell class]);
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FindDetailsCollectionViewCell class]) bundle:nil]
          forCellWithReuseIdentifier:NSStringFromClass([FindDetailsCollectionViewCell class])];
        CGSize cellSize = [_data.type getCellSize];
        self.flowLayout.itemSize = CGSizeMake(cellSize.width-40, cellSize.height-40);
        [_collectionView setCollectionViewLayout:_flowLayout animated:false];
        _dataSource = @[].mutableCopy;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 3, 0, 3);
        for (id obj in _data.data.itemList) {
            [_dataSource addObject:obj];
        }
        _pageControl.numberOfPages = _dataSource.count;
        [_collectionView reloadData];
    }
    if ([_data.type isEqualToString:@"videoCollectionWithBrief"]) {
         [self.contentView insertSubview:_collectionView atIndex:[self.contentView subviews].count];
        _collectionView.hidden = false;
        _collectionViewLayoutTop.constant = 60;
        _collectionViewLayoutBottom.constant = 0.0f;
        if (!_author) {
            _author = [AuthorView loadView];
            [self.contentView addSubview:_author];
        }
        _author.backgroundColor = [UIColor whiteColor];
        _author.nameLabel.textColor = [UIColor blackColor];
        _author.detailsLabel.textColor = [UIColor blackColor];
        _author.countLabel.textColor = [UIColor blackColor];
        _author.frame = CGRectMake(0, 0, self.width, 60);
        ItemList *new = [_data.data.itemList firstObject];
        _author.authorModel = new.data.author;
        _author.hidden = false;
        
        {
            _collIds = NSStringFromClass([HyTableViewFooterViewCollectionViewCell class]);
            [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HyTableViewFooterViewCollectionViewCell class]) bundle:nil]
              forCellWithReuseIdentifier:NSStringFromClass([HyTableViewFooterViewCollectionViewCell class])];
            _flowLayout = (id)[[UICollectionViewFlowLayout alloc] init];
            _flowLayout.itemSize = CGSizeMake(260, 200);
            _flowLayout.minimumLineSpacing = 5;
            _flowLayout.minimumInteritemSpacing = 5;
            _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            [_collectionView setCollectionViewLayout:_flowLayout animated:false];
            _collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        }
        
        {
            _dataSource = @[].mutableCopy;
            for (ItemList *item in _data.data.itemList) {
                [_dataSource addObject:item];
            }
            [_collectionView reloadData];
        }
    }
    
    
    [self.imageViewCell setImageURL:[NSURL URLWithString:_data.data.cover.feed]];
    _titleLabel.text = _data.data.title;
    NSString *subString = [NSString stringWithFormat:@"#%@  /  %@",_data.data.category,[HyHelper timeformatFromSeconds:_data.data.duration]];
    _subTitle.text = subString;
}

#pragma mark 懒加载flowlayout
- (FindDetailsCollectionViewFlowLayout *)flowLayout
{
    _flowLayout = [[FindDetailsCollectionViewFlowLayout alloc] init];
    //if (!_flowLayout) {
        _flowLayout.minimumLineSpacing = 3;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
   // }
    return _flowLayout;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 得到每页宽度
    CGSize cellSize = [_data.type getCellSize];
    CGSize size = CGSizeMake(cellSize.width-40, cellSize.height-40);
    CGFloat pageWidth = size.width + 3;
    // 根据当前的x坐标和页宽度计算出当前页数
    int currentPage = floor(((scrollView.contentOffset.x - 40) - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = currentPage;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_collIds forIndexPath:indexPath];
     id obj = [_dataSource objectAtIndex:indexPath.row];
    [cell setValue:obj forKey:@"list"];
    return cell;
}

- (void)setIsHighlightRow:(BOOL)isHighlightRow AtIsAnimation:(BOOL)animations
{
    if (isHighlightRow) {
        if (animations) {
            [UIView animateWithDuration:0.2 animations:^{
                _maskView.alpha = 0.0f;
            }];
        } else {
            _maskView.alpha = 0.0f;
        }
    } else {
        if (animations) {
            [UIView animateWithDuration:0.2 animations:^{
                _maskView.alpha = 1.0f;
            }];
        } else {
            _maskView.alpha = 1.0f;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
