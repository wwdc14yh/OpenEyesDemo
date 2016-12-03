//
//  FindCollectionViewCell.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "FindCollectionViewCell.h"

@implementation FindCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bannerView.delegate = self;
    _bannerView.dataSource = self;
    _bannerView.autoScroll = true;
    _bannerView.scrollInterval = 2.f;
}

- (void)setList:(ItemList *)list
{
    _list = list;
    _titlelabel.hidden = false;
    _bannerView.hidden = true;
    _titlelabel.text = list.data.title;
    [_imageView setImageWithURL:[NSURL URLWithString:list.data.image] options:YYWebImageOptionProgressiveBlur];
    if ([list.type isEqualToString:horizontalScrollCard]) {
        [_bannerView reloadData];
        _bannerView.hidden = false;
    } else if ([self.list.type isEqualToString:rectangleCard] || !self.list.data.title || self.list.data.title.length == 0){
        _titlelabel.hidden = true;
    }
}

- (NSInteger)numberOfItemsInBanner:(ZYBannerView *)banner
{
    return _list.data.itemList.count;
}

- (UIView *)banner:(ZYBannerView *)banner viewForItemAtIndex:(NSInteger)index
{
    ItemList *data = [_list.data.itemList objectAtIndex:index];
    // 取出数据
    NSString *imageName = data.data.image;
    
    // 创建将要显示控件
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setImageWithURL:[NSURL URLWithString:imageName] options:YYWebImageOptionProgressiveBlur];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    return imageView;
}

- (void)setIsHighlightRow:(BOOL)isHighlightRow AtIsAnimation:(BOOL)animations
{
    if (isHighlightRow) {
        if (animations) {
            [UIView animateWithDuration:0.2 animations:^{
                _titlelabel.alpha = 0.0f;
            }];
        } else {
            _titlelabel.alpha = 0.0f;
        }
    } else {
        if (animations) {
            [UIView animateWithDuration:0.2 animations:^{
                _titlelabel.alpha = 1.0f;
            }];
        } else {
            _titlelabel.alpha = 1.0f;
        }
    }
}

@end
