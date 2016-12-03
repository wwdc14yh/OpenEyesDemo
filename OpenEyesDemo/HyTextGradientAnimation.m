//
//  HyTextGradientAnimation.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/27.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HyTextGradientAnimation.h"
#import "NSString+LabelWidthAndHeight.h"
#import "HyHelper.h"

@interface HyTextGradientAnimation ()
@property (nonatomic, strong) NSMutableArray *numberArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) CGSize autoSize;
@property (nonatomic, strong) CATextLayer *textLayer;
@property (nonatomic, strong) NSMutableAttributedString *attributedString;
@end

@implementation HyTextGradientAnimation

+ (instancetype)textGradientAnimationWithTextString:(NSString *)text
{
    HyTextGradientAnimation *textAnimation = [[HyTextGradientAnimation alloc] initWithTextString:text];
    return textAnimation;
}

- (instancetype)initWithTextString:(NSString *)text
{
    if (self) {
        self = [super initWithFrame:CGRectZero];
        self.text = text;
        [self initializeUI];
    }
    return self;
}

- (instancetype) init
{
    if (self) {
        self = [super initWithFrame:CGRectZero];
        [self initializeUI];
    }
    return self;
}

- (void)initializeUI
{
    _textLayer = [CATextLayer layer];
    _textLayer.truncationMode = kCATruncationMiddle;
    _font = [UIFont systemFontOfSize:17.f];
    _textColor = [UIColor blackColor];
    _autoComputeHeight = true;
    _autoSize = CGSizeZero;
    if (!_text) {
        _text = @"";
    }
    
    _textLayer.frame = self.bounds;
    _textLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:_textLayer];
    _textLayer.alignmentMode = kCAAlignmentJustified;
    _textLayer.wrapped = YES;
    
    _dataArray = @[].mutableCopy;
    _numberArray = @[].mutableCopy;
}

- (void)setText:(NSString *)text
{
    if (text) {
        _text = text;
    }
    [self compute];
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    [self compute];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self compute];
}

- (void)setAutoComputeHeight:(BOOL)autoComputeHeight
{
    _autoComputeHeight = autoComputeHeight;
    [self compute];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _textLayer.frame = self.bounds;
}

- (void)compute
{
    self.frame = CGRectMake(self.x, self.y, self.width, self.height);
    if (_autoComputeHeight) {
        CGFloat autoHeight = [_text heightWithStringFont:_font fixedWidth:self.width];
        _autoSize = CGSizeMake(self.width, autoHeight);
        self.frame = CGRectMake(self.x, self.y, self.width, autoHeight);
    }
    _attributedString = [[NSMutableAttributedString alloc] initWithString:_text];
}

- (void)startAnimations
{
   // CTFontRef font = CTFontCreateWithName(CFSTR("Helvetica"), 30, NULL);
    CFStringRef fontName = (__bridge CFStringRef)(_font.fontName);
    CGFloat fontSize = _font.pointSize;
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    _textLayer.fontSize = fontSize;
    
    
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName:(__bridge id)[UIColor clearColor].CGColor,
                              (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                                           //NSParagraphStyleAttributeName:paragraphStyle
                              };
    
    [_attributedString setAttributes:attribs range:NSMakeRange(0, _text.length)];
    _dataArray = [NSMutableArray arrayWithObjects:(__bridge id _Nonnull)(fontRef),attribs,_attributedString,_text, nil];
    _numberArray = @[].mutableCopy;
    for (int i = 0; i < _text.length; i++) {
        [_numberArray addObject:[NSNumber numberWithInt:i]];
        [self performSelector:@selector(changeToBlack) withObject:nil afterDelay:(0.1 * i)];
    }
    CFRelease(fontRef);
}

- (void)changeToBlack
{
    CTFontRef fontRef = (__bridge CTFontRef)(_dataArray[0]);
    NSMutableAttributedString *string = _dataArray[2];
    NSNumber *num = [_numberArray firstObject];
    int y = [num intValue];
    NSDictionary *attribs = _dataArray[1];
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName:(__bridge id)_textColor.CGColor,
                (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(y, 1)];
    if (_numberArray.count > 1) {
        [_numberArray removeObjectAtIndex:0];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:20];//调整行间距
    [string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(y, 1)];
    _textLayer.string = string;
}

@end
