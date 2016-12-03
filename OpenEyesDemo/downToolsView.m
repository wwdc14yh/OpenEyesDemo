//
//  downToolsView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/28.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "downToolsView.h"

@implementation downToolsView

- (IBAction)collectionCountButton:(id)sender {
    
    _collectionCountButtonHighlight.showsTouchWhenHighlighted = YES;
    _collectionCountButtonHighlight.highlighted = true;
}

- (IBAction)shareCountButton:(id)sender {
    
    _shareCountButtonHighlight.showsTouchWhenHighlighted = YES;
    _shareCountButtonHighlight.highlighted = true;
}

- (IBAction)replyCountButton:(id)sender {
    
    _replyCountButtonHighlight.showsTouchWhenHighlighted = YES;
    _replyCountButtonHighlight.highlighted = true;
}

@end
