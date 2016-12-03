//
//  HytextGraduallyShowAnimation.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/28.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HytextGraduallyShowAnimation.h"

@implementation HytextGraduallyShowAnimation

- (instancetype) init
{
    if (self = [super init]) {
        self.onlyDrawDirtyArea = NO;
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.onlyDrawDirtyArea = NO;
    }
    return self;
}

- (void) appearStateDrawingForRect: (CGRect) rect textBlock: (ZCTextBlock *) textBlock
{
    CGFloat alpha = [ZCEasingUtil easeInWithStartValue:0 endValue:1 time:textBlock.progress];
    if (alpha < 0.01) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMidX(textBlock.charRect), CGRectGetMidY(textBlock.charRect));
    UIColor *color = [textBlock.derivedTextColor colorWithAlphaComponent:alpha];
    CGRect rotatedRect = CGRectMake(-textBlock.charRect.size.width / 2, - textBlock.charRect.size.height / 2, textBlock.charRect.size.width, textBlock.charRect.size.height);
    textBlock.textColor = color;
    [textBlock.derivedAttributedString drawInRect:rotatedRect];
    CGContextRestoreGState(context);
}

@end
