//
//  FindViewController.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "FindViewController.h"
#import "HyHelper.h"
#import "FindCollectionViewCell.h"
#import "NetworkRequestManage.h"

static NSString *FindDetailsViewController = @"FindDetailsViewController";

@interface FindViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)        NSMutableArray *  dataSource;
@property (assign, nonatomic)        NSInteger idx;
@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FindCollectionViewCell class]) bundle:nil]
      forCellWithReuseIdentifier:NSStringFromClass([FindCollectionViewCell class])];
    _dataSource = @[].mutableCopy;
    [self requestNet];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Lobster 1.4" size:25],NSFontAttributeName, nil];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)requestNet
{
    HyWeakSelf(self);
    [NetworkRequestManage requestWithRequestMethod:NetworkRequestMethodPOST Params:[NSDictionary dictionary] Path:findUrl Success:^(id  _Nonnull json) {
        
        [weakself AnalysisAtJson:json];
        
    } Failure:^(NSError * _Nonnull error) {

    }];
}

- (void)AnalysisAtJson:(id)json
{
    [_dataSource removeAllObjects];
    BaseClass *clas = [BaseClass modelObjectWithDictionary:json];
    NSMutableArray *tempArr = @[].mutableCopy;
    for (id obj in clas.itemList) {
        [tempArr addObject:obj];
    }
    
    for (id obj in tempArr) {
        ItemList *listModel = [ItemList modelObjectWithDictionary:obj];
        [_dataSource addObject:listModel];
    }
    
    [_collectionView reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.f;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemList *listModel = [_dataSource objectAtIndex:indexPath.row];
    
    return [listModel.type getCellSize];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataSource count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FindCollectionViewCell *cell = (id)[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FindCollectionViewCell class]) forIndexPath:indexPath];
    ItemList *listModel = [_dataSource objectAtIndex:indexPath.row];
    cell.list = listModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _idx = indexPath.row;
    [self performSegueWithIdentifier:FindDetailsViewController sender:self];
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    FindCollectionViewCell *cell = (id)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setIsHighlightRow:true AtIsAnimation:true];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    FindCollectionViewCell *cell = (id)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setIsHighlightRow:false AtIsAnimation:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:FindDetailsViewController]) {
        ItemList *listModel = [_dataSource objectAtIndex:_idx];
        [segue.destinationViewController setValue:@(listModel.data.dataIdentifier) forKey:@"ids"];
    }
    
}


@end
