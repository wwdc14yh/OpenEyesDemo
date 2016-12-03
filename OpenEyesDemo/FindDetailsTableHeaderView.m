//
//  FindDetailsTableHeaderView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "FindDetailsTableHeaderView.h"


@implementation FindDetailsTableHeaderView

+ (instancetype) loadView
{
    NSArray * ar = [[NSBundle mainBundle] loadNibNamed:@"FindDetailsTableHeaderView" owner:self options:nil];
    FindDetailsTableHeaderView *headerView = [ar lastObject];
    
    CGFloat w,h;
    w = 1242;
    h = 828;
    CGFloat Vh = [UIScreen mainScreen].bounds.size.width * (h/w);
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, Vh);
    return headerView;
}

- (void)setCategoryInfo:(NSDictionary *)categoryInfo
{
    _categoryInfo = categoryInfo;
    [_imageView setImageWithURL:[NSURL URLWithString:[categoryInfo objectForKey:@"headerImage"]] options:YYWebImageOptionProgressiveBlur];
    _titleLabel.text = [categoryInfo objectForKey:@"name"];
    _subLabel.text = [categoryInfo objectForKey:@"description"];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
