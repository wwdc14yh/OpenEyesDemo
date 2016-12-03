//
//  BottomPageView.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/12/2.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomPageView : UIView

@property (nonatomic, assign) NSInteger maxPage;
@property (nonatomic, assign) CGFloat   currPage;
@property (weak, nonatomic) IBOutlet UILabel *pageLabel;

+ (instancetype) loadView;
@end
