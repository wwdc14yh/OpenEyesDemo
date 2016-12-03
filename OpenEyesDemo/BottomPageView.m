//
//  BottomPageView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "BottomPageView.h"
#import "HyHelper.h"
@implementation BottomPageView

+ (instancetype) loadView
{
    NSArray * ar = [[NSBundle mainBundle] loadNibNamed:@"BottomPageView" owner:self options:nil];
    return [ar lastObject];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    _currPage = 0.0f;
    _maxPage = 0.0f;
}

- (void)setMaxPage:(NSInteger)maxPage
{
    _maxPage = maxPage;
    self.frame = CGRectMake(self.x, self.y, [UIScreen mainScreen].bounds.size.width/maxPage, self.height);
    _pageLabel.text = [NSString stringWithFormat:@"%.0f - %zd",fabs(_currPage * _maxPage)+1,_maxPage];
}

- (void)setCurrPage:(CGFloat)currPage
{
    _currPage = currPage;
    self.x = [UIScreen mainScreen].bounds.size.width * currPage;
    _pageLabel.text = [NSString stringWithFormat:@"%.0f - %zd",fabs(_currPage * _maxPage)+1,_maxPage];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
