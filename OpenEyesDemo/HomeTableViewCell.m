//
//  HomeTableViewCell.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/25.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "YYKit.h"
#import "HyHelper.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(ItemList *)data
{
    if (IS_IPHONE_5) {
        _titleLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:14];
        _subTitle.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:10];
    }
    _maskView.hidden = false;
    _data = data;
    _titleLabel.text = _data.data.title;
    NSString *subString = [NSString stringWithFormat:@"#%@  /  %@",_data.data.category,[HyHelper timeformatFromSeconds:_data.data.duration]];
    _subTitle.text = subString;

    [_imageViewCell setImageWithURL:[NSURL URLWithString:_data.data.cover.feed] placeholder:nil options:YYWebImageOptionShowNetworkActivity|YYWebImageOptionProgressiveBlur completion:nil];
    _textLabels.hidden = (_data.data.title);
    _textLabels.text = _data.data.text;
    if (!_data.data.cover.feed) {
        [_imageViewCell setImageWithURL:[NSURL URLWithString:_data.data.image] placeholder:nil options:YYWebImageOptionShowNetworkActivity|YYWebImageOptionProgressiveBlur completion:nil];
        _maskView.hidden = true;
    }
    
}

- (void)setIsHighlightRow:(BOOL)isHighlightRow AtIsAnimation:(BOOL)animations
{
    _isHighlightRow = isHighlightRow;
    if (isHighlightRow) {
        if (animations) {
            _isAnimations = true;
            [UIView animateWithDuration:0.2 animations:^{
                _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
                _titleLabel.alpha = 0.0f;
                _subTitle.alpha = 0.0f;
            } completion:^(BOOL finished) {
                _isAnimations = !finished;
            }];
        } else {
            _isAnimations = animations;
            _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        }
    } else {
        _isAnimations = true;
        if (animations) {
            [UIView animateWithDuration:0.2 animations:^{
                _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
                _titleLabel.alpha = 1.0f;
                _subTitle.alpha = 1.0f;
            } completion:^(BOOL finished) {
                _isAnimations = !finished;
            }];
        } else {
            _isAnimations = animations;
            _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3f];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
