//
//  HomeViewController.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/25.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HomeViewController.h"
#import "HyTableViewHeaderView.h"
#import "HyTableViewFooterView.h"
#import "HyContentView.h"
#import "HomeTableViewCell.h"
#import "NetworkRequestManage.h"
#import "DataModels.h"
#import "HyTableViewCellFooterView.h"
#import "HyLaunchView.h"
#define ScreenWidth CGRectGetWidth(self.view.frame)

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, HyTableViewHeaderViewDelegate>
@property (assign, nonatomic) BOOL isStatusDrak;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *effectTopLayout;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *effectView;
@property (nonatomic, strong) BaseClass *baseClass;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) BOOL isJump;
@property (nonatomic, strong) NSMutableArray *footerViews;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (iPhone6_6s || iPhone6_6sPlus) {
        NSLog(@"%.2f",[UIScreen mainScreen].scale);
        [UIView setFontScale:[UIScreen mainScreen].scale / 3];
    }else{
        [UIView setFontScale:[UIScreen mainScreen].scale / 2];
    }
    CGSize newSize = [HyHelper getDefaultSize];
    CGFloat rowH = newSize.height;
    _tableView.tableHeaderView = [HyTableViewHeaderView loadTableViewHeaderViewWithSize:CGSizeMake(CGRectGetWidth(self.view.frame), rowH)];
    ((HyTableViewHeaderView *)_tableView.tableHeaderView).delegate = self;
   
    HyWeakSelf(self);
    [((HyTableViewHeaderView *)_tableView.tableHeaderView) startRefreshBlock:^(HyTableViewHeaderView * _Nonnull headerView ,HyRefreshDirectionType type) {
        if (type == HyPullDownRefreshType) {
            [weakself refreshIs:true];
            [weakself requestNet];
        } else {
            [weakself nextPagesAtRequestNet];
        }
    }];
    _tableView.rowHeight = rowH;
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:0 context:nil];
    
    _dataSource = @[].mutableCopy;
    _footerViews = @[].mutableCopy;
    [self requestNet];
    
    _tableView.tableFooterView = [HyTableViewFooterView loadView];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _tableView.contentInset = UIEdgeInsetsMake(0, 0, -_tableView.tableFooterView.height, 0);
    [[UIDevice currentDevice] setValue:@(UIDeviceOrientationPortrait) forKey:@"orientation"];
    //刷新
    [UIViewController attemptRotationToDeviceOrientation];
}

- (void)refreshIs:(BOOL)is
{
    typeof(HyContentView *) __weak weakContentView =(HyContentView *)((HyTableViewHeaderView *)_tableView.tableHeaderView).subView;
    if (is) {
        [UIView animateWithDuration:0.2 animations:^{
            weakContentView.titleLabel.alpha = 0;
            weakContentView.activityIndicatorView.alpha = 1;
            [weakContentView.activityIndicatorView startAnimating];
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            weakContentView.titleLabel.alpha = 1;
            weakContentView.activityIndicatorView.alpha = 0;
            [weakContentView.activityIndicatorView stopAnimating];
        } completion:^(BOOL finished) {
            [((HyTableViewHeaderView *)_tableView.tableHeaderView) stopRefresh];
        }];
        weakContentView.date = _baseClass.date;
    }
}

#pragma mark 刷新请求数据
- (void)requestNet
{
    HyWeakSelf(self);
    [NetworkRequestManage requestWithRequestMethod:NetworkRequestMethodPOST Params:[NSDictionary dictionary] Path:@"" Success:^(id  _Nonnull json) {
        
        [weakself AnalysisAtJson:json];
        [weakself refreshIs:false];
        
    } Failure:^(NSError * _Nonnull error) {
        [weakself refreshIs:false];
    }];
}

#pragma mark 加载更多数据
- (void)nextPagesAtRequestNet
{
    HyWeakSelf(self);
    if (!_baseClass) {
        NSLog(@"请刷新界面");
        return ;
    }
    NSLog(@"%@",NSStringFromUIEdgeInsets(_tableView.contentInset));
    NSDictionary *dic = [HyHelper decompositionUrl:_baseClass.nextPageUrl];
    [NetworkRequestManage requestWithRequestMethod:NetworkRequestMethodPOST Params:@{@"date":[dic objectForKey:@"date"]} Path:nextPage Success:^(id  _Nonnull json)
    {

        [((HyTableViewHeaderView *)_tableView.tableHeaderView) stopRefresh];
        [weakself addModelsAtmodels:json];
        
    } Failure:^(NSError * _Nonnull error) {
        [((HyTableViewHeaderView *)_tableView.tableHeaderView) stopRefresh];
    }];
}

- (void)addModelsAtmodels:(id)json
{
    id obj = [[BaseClass alloc] initWithDictionary:json];
    [_dataSource addObject:obj];
    NSInteger section = [_dataSource indexOfObject:obj];
    [_tableView insertSection:section withRowAnimation:UITableViewRowAnimationFade];
    //[_tableView reloadData];
    _baseClass = obj;
    for (id obj in _dataSource) {
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:[_dataSource indexOfObject:obj]];
        [_footerViews addObject:set];
    }
}

- (void)AnalysisAtJson:(id)json
{
    [_dataSource removeAllObjects];
    [_footerViews removeAllObjects];
    id obj = [[BaseClass alloc] initWithDictionary:json];
    [_dataSource addObject:obj];
    [_tableView reloadData];
    _baseClass = obj;
    for (id obj in _dataSource) {
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:[_dataSource indexOfObject:obj]];
        [_footerViews addObject:set];
    }
}

- (void)statusDrak
{
    _isStatusDrak = true;
    [UIView animateWithDuration:0.1 animations:^{
        [_effectTopLayout setConstant:-20.f];
        [self.view layoutIfNeeded];
        //_effectView.alpha = 0.f;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }];
}

- (void)statusLight
{
    _isStatusDrak = false;
    [UIView animateWithDuration:0.1 animations:^{
        
        [_effectTopLayout setConstant:0.f];
        [self.view layoutIfNeeded];
        //_effectView.alpha = 1.0f;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }];
}

- (void)hyTableViewHeaderView:(HyTableViewHeaderView *)headerView SlidingProgressFloat:(CGFloat)progress
{
    ((HyContentView *)headerView.subView).maskView.hidden = !headerView.clipsToBounds;
    ((HyContentView *)headerView.subView).maskView.alpha = MAX(progress/1.2f, 0.0f);
    CGFloat al = 1-(-progress / 0.3);
    ((HyContentView *)headerView.subView).titleLabel.alpha = al;
    if (al >= 0) {
        ((HyContentView *)headerView.subView).activityIndicatorView.alpha = 0;
        [((HyContentView *)headerView.subView).activityIndicatorView stopAnimating];
    } else {
        ((HyContentView *)headerView.subView).activityIndicatorView.alpha = 1;
        [((HyContentView *)headerView.subView).activityIndicatorView startAnimating];
    }
    if (progress>=0.9f) {
        if (_isStatusDrak) {
            [self statusLight];
        }
    } else {
        if (!_isStatusDrak) {
            [self statusDrak];
        }
    }
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSource count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    BaseClass *clas = [_dataSource objectAtIndex:section];
    SectionList *list = [clas.sectionList objectAtIndex:0];
    return [list.itemList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeTableViewCell class]) forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setIsHighlightRow:false AtIsAnimation:false];
    BaseClass *baseClas = [_dataSource objectAtIndex:indexPath.section];
    SectionList *list = [baseClas.sectionList objectAtIndex:0];
    cell.data = [list.itemList objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseClass *baseClas = [_dataSource objectAtIndex:indexPath.section];
    SectionList *list = [baseClas.sectionList objectAtIndex:0];
    ItemList *data = [list.itemList objectAtIndex:indexPath.row];
    return data.data.title ? tableView.rowHeight : 50.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat h = tableView.rowHeight + 220;
    return h;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    id obj = [_footerViews objectAtIndex:section];
    if (section < _footerViews.count) {
        if ([obj isKindOfClass:[UIView class]]) {
            return obj;
        }
    }
    HyTableViewCellFooterView *footerView = [HyTableViewCellFooterView loadView];
    footerView.h = _tableView.rowHeight;
    BaseClass *clas = [_dataSource objectAtIndex:section];
    SectionList *list = [clas.sectionList lastObject];
    footerView.data = [list.itemList firstObject];
    [_footerViews insertObject:footerView atIndex:section];
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = (id)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell.titleLabel.text || cell.titleLabel.text.length == 0) return ;
    [self statusDrak];
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    {
        UIImageView *maseView = [[UIImageView alloc] initWithImage:cell.imageViewCell.image];
        maseView.frame = rect;
        maseView.layer.masksToBounds = true;
        maseView.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:maseView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [maseView removeFromSuperview];
        });
    }
    BaseClass *clas = [_dataSource objectAtIndex:indexPath.section];
    SectionList *list = [clas.sectionList objectAtIndex:0];
    
    UIViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoDetailsViewController"];
    [vc setValue:cell.imageViewCell.image forKey:@"resources"];
    [vc setValue:[NSValue valueWithCGRect:rect] forKey:@"startFrame"];
    [vc setValue:list forKey:@"list"];
    [vc setValue:indexPath forKey:@"indexPath"];
    [vc setValue:tableView forKey:@"tableView"];
    [vc setValue:self forKey:@"delegate"];
    [self presentViewController:vc animated:true completion:nil];
}


- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setIsHighlightRow:true AtIsAnimation:true];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setIsHighlightRow:false AtIsAnimation:true];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_tableView.tableHeaderView setValue:@(true) forKey:@"isDrag"];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    [_tableView.tableHeaderView setValue:@(false) forKey:@"isDrag"];
}

#pragma mark VideoDetailsViewControllerDelegate
- (void)videoDetailsViewController:(UIViewController *)videoDetailsViewController updateIndexPath:(NSIndexPath *)indexPath
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self statusLight];
    });
    NSArray *indexPaths = [_tableView indexPathsForVisibleRows];
    BOOL rolling = true;
    for (NSIndexPath *path in indexPaths) {
        if (path.section == indexPath.section && path.row == indexPath.row) {
            rolling = false;
        }
    }
    if (rolling) {
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark KVO
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        if ([object isKindOfClass:[UITableView class]]) {
            [((HyTableViewHeaderView *)_tableView.tableHeaderView) layoutHeaderViewForScrollViewOffset:((UITableView*)object).contentOffset];
        }
    }
}

@end
