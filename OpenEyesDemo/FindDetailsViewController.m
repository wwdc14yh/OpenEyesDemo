//
//  FindDetailsViewController.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "FindDetailsViewController.h"
#import "HyHelper.h"
#import "DataModels.h"
#import "NetworkRequestManage.h"
#import "NSString+FindCellSize.h"
#import "FindDetailsTableViewCell.h"
#import "HyTableViewHeaderView.h"
#import "FindDetailsTableHeaderView.h"

@interface FindDetailsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, weak)   FindDetailsTableHeaderView *headerView;
@property (nonatomic, strong) id json;
@end

@implementation FindDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = @[].mutableCopy;
    [self requestNet];

    [self.navigationController.navigationBar setHidden:true];
    _tableView.contentInset = UIEdgeInsetsZero;
    
    FindDetailsTableHeaderView *headerView = [FindDetailsTableHeaderView loadView];
    _headerView = headerView;
    _tableView.tableHeaderView = [HyTableViewHeaderView loadSetupForCustomSubView:headerView AtHeaderViewWithSize:headerView.size];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)requestNet
{
    HyWeakSelf(self);
    
    [NetworkRequestManage requestWithRequestMethod:NetworkRequestMethodPOST Params:@{@"id":@(_ids)} Path:findDetailsUrl Success:^(id  _Nonnull json) {
        
        [weakself AnalysisAtJson:json];
        
    } Failure:^(NSError * _Nonnull error) {
        NSLog(@"error_%@",error);
    }];
}

- (void)AnalysisAtJson:(id)json
{
    [_dataSource removeAllObjects];

    [_headerView setValue:[json objectForKey:@"categoryInfo"] forKey:@"categoryInfo"];
    _json = json;
    BaseClass *clas = [BaseClass modelObjectWithDictionary:json];
    for (id obj in clas.sectionList) {
        [_dataSource addObject:obj];
    }
    [_tableView reloadData];
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    [((HyTableViewHeaderView *)_tableView.tableHeaderView) layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionList *list = [_dataSource objectAtIndex:section];
    return list.itemList.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60.f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    SectionList *list = [_dataSource objectAtIndex:section];
    CGFloat h = 8.0f;
    if (list.footer) {
        NSDictionary *dic = [list.footer objectForKey:@"data"];
        NSString *text = [dic objectForKey:@"text"];
        if (text) {
            h = 68.f;
        }
    }else {
        h = 0.0f;
    }
    return h;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionList *list = [_dataSource objectAtIndex:indexPath.section];
    return [list.type getCellSize].height;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    UIView *lins = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    lins.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
    [view addSubview:lins];
    
    SectionList *list = [_dataSource objectAtIndex:section];
    if (list.footer) {
        NSDictionary *dic = [list.footer objectForKey:@"data"];
        NSString *text = [dic objectForKey:@"text"];
        if (text) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            [button setTintColor:[UIColor clearColor]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setFrame:CGRectMake(0, 0, self.view.width, 60.0f)];
            button.titleLabel.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:14];
            [button setTitle:text forState:UIControlStateNormal];
            lins.frame = CGRectMake(0, CGRectGetMaxY(button.frame), lins.width, lins.height);
            [view addSubview:button];
        }
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    SectionList *list = [_dataSource objectAtIndex:section];
    if (!list.header) {
        ItemList *item = [list.itemList firstObject];
        label.text = item.data.header.title;
    }else{
        label.text = [[list.header valueForKey:@"data"] objectForKey:@"text"];
    }
    label.textAlignment = 1;
    label.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:14];
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindDetailsTableViewCell" forIndexPath:indexPath];
    SectionList *list = [_dataSource objectAtIndex:indexPath.section];
    id obj = [list.itemList objectAtIndex:indexPath.row];
    cell.data = obj;
    cell.json = _json;
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindDetailsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setIsHighlightRow:true AtIsAnimation:true];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    FindDetailsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setIsHighlightRow:false AtIsAnimation:true];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
