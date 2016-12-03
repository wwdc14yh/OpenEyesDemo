//
//  downToolsView.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/28.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface downToolsView : UIView

@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *shareCountUILabel;
@property (weak, nonatomic) IBOutlet UIButton *collectionCountButton;
@property (weak, nonatomic) IBOutlet UIButton *shareCountButton;
@property (weak, nonatomic) IBOutlet UIButton *replyCountButton;

@property (weak, nonatomic) IBOutlet UIButton *collectionCountButtonHighlight;
@property (weak, nonatomic) IBOutlet UIButton *shareCountButtonHighlight;
@property (weak, nonatomic) IBOutlet UIButton *replyCountButtonHighlight;

@end
