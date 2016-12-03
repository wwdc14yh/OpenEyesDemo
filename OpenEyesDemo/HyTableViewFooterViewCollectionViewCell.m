//
//  HyTableViewFooterViewCollectionViewCell.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/26.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HyTableViewFooterViewCollectionViewCell.h"

@implementation HyTableViewFooterViewCollectionViewCell

-(void)setListModel:(ItemList *)listModel
{

//    if (!_list.data.title) {
//        
//        
//    }
}

- (void) setList:(ItemList *)list
{
    _list = list;
    _titleLabel.text = _list.data.title;
    NSString *subString = [NSString stringWithFormat:@"#%@  /  %@",_list.data.category,[HyHelper timeformatFromSeconds:_list.data.duration]];
    _subLabel.text = subString;
    [_imageView setImageWithURL:[NSURL URLWithString:_list.data.cover.feed] placeholder:nil options:YYWebImageOptionShowNetworkActivity|YYWebImageOptionProgressiveBlur completion:nil];
    _moreButton.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.8].CGColor;
    _moreButton.hidden = (_list.data.title);
    _titleLabel.hidden = !_list.data.title;
    _subLabel.hidden = !_list.data.title;
    _imageView.hidden = !_list.data.title;
}

@end
