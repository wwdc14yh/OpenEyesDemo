//
//  FindDetailsCollectionViewCell.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "FindDetailsCollectionViewCell.h"
#import "HyHelper.h"

@implementation FindDetailsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupdateUI];
    // Initialization code
}

- (void)setList:(id)list
{
    _list = list ;
    [_imageView setImageURL:[NSURL URLWithString:_list.data.cover.feed]];
    
    _titleLabel.text = _list.data.title;
    NSString *subString = [NSString stringWithFormat:@"#%@  /  %@",_list.data.category,[HyHelper timeformatFromSeconds:_list.data.duration]];
    _subLabel.text = subString;
}

- (void)setupdateUI
{
    CGSize newSize = CGSizeMake(self.width ,self.height);
    _imageView.frame = CGRectMake(0, 0, newSize.width, newSize.height - (40+15));
    
    _titleLabel.frame = CGRectMake(8, CGRectGetMaxY(_imageView.frame)+15, self.width-16, 20);
    _subLabel.frame = CGRectMake(8, CGRectGetMaxY(_titleLabel.frame), self.width-16, 20);
}

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    [self setupdateUI];
}

@end
