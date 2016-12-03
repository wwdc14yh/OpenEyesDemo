//
//  VideoDetailsViewController.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/27.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"

@class VideoDetailsViewController;
@protocol VideoDetailsViewControllerDelegate <NSObject>
@optional
- (void)videoDetailsViewController:(VideoDetailsViewController *)videoDetailsViewController updateIndexPath:(NSIndexPath *)indexPath;

@end

@interface VideoDetailsViewController : UIViewController
@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, strong) id     resources;
@property (nonatomic, strong) SectionList *list;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak)   UITableView *tableView;
@property (nonatomic, weak)   id<VideoDetailsViewControllerDelegate> delegate;
@end
