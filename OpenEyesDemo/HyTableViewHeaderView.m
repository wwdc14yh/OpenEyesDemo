//
//  HyTableViewHeaderView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/25.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HyTableViewHeaderView.h"
#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)

@interface HyTableViewHeaderView () <UIScrollViewDelegate>
@property (nonatomic, weak)    UITableView *tableView;
@property (weak, nonatomic)  UIScrollView  *scrollView;
@property (nonatomic, copy, nonnull) StartRefreshBlock block;
@end

@implementation HyTableViewHeaderView

+ (_Nonnull instancetype)loadSetupForCustomSubView:(id _Nonnull)subView
                              AtHeaderViewWithSize:(CGSize)size
{
    HyTableViewHeaderView *headerView = [[HyTableViewHeaderView alloc] initWithFrame:(CGRect){CGPointZero,size}];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [headerView initialSetupForCustomSubView:subView];
        [headerView layoutHeaderViewForScrollViewOffset:CGPointZero];
        headerView.tableView = (id)headerView.superview;
    });
    return headerView;
}

+ (_Nonnull instancetype)loadTableViewHeaderViewWithSize:(CGSize)size
{
    HyTableViewHeaderView *headerView = [[HyTableViewHeaderView alloc] initWithFrame:(CGRect){CGPointZero,size}];
    HyContentView *content = [HyContentView loadView];
    content.frame = (CGRect){CGPointZero,headerView.frame.size};
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        headerView.tableView = (id)headerView.superview;
        [headerView initialSetupForCustomSubView:content];
    });
    return headerView;
}

- (void)initialSetupForCustomSubView:(HyContentView *)subView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView = scrollView;
    self.subView = subView;
    //self.subView.frame = self.frame;
    subView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [self.scrollView addSubview:subView];
    [self addSubview:self.scrollView];
}

- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset
{
    CGFloat delta = 0.0f;
    CGRect rect = kDefaultHeaderFrame;
    delta = fabs(MIN(0.0f, offset.y));
    rect.size.height += delta;
    rect.origin.y = offset.y;
    self.scrollView.frame = rect;
    CGFloat pro = offset.y/(CGRectGetHeight(self.frame));//MAX(offset.y/(CGRectGetHeight(self.frame)), 0);
    if ([self.delegate respondsToSelector:@selector(hyTableViewHeaderView:SlidingProgressFloat:)]) {
        [self.delegate hyTableViewHeaderView:self SlidingProgressFloat:pro];
    }
    self.clipsToBounds = offset.y > 0;
    
    if (-pro > 0.3) {
        if (!self.isRefresh) {
            [self startRefresh];
            _refreshDirectionType = HyPullDownRefreshType;
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(hyTableViewHeaderView:PullDownProgressFloat:)]) {
            [self.delegate hyTableViewHeaderView:self PullDownProgressFloat:(-pro * 3.4)];
        }
    }
    CGFloat pullUpFloat = offset.y / (_tableView.contentSize.height - _tableView.frame.size.height);
    if (pullUpFloat >= 0.9f) {
        _refreshDirectionType = HyPullUpRefreshType;
        [self startRefresh];
    }
}

- (void)startRefresh
{
    if (!_isDrag) {
        if (!self.isRefresh) {
            _isRefresh = true;
            if ([self.delegate respondsToSelector:@selector(hyTableViewHeaderViewStartRefresh: AtRefreshDirectionType:)]) {
                [self.delegate hyTableViewHeaderViewStartRefresh:self AtRefreshDirectionType:_refreshDirectionType];
            }
            if (_block) {
                _block(self ,_refreshDirectionType);
            }
        }   
    }
}

- (void)stopRefresh
{
    _isRefresh = false;
}

- (void)startRefreshBlock:(StartRefreshBlock)block
{
    _block = block;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
