
/*!
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included
 in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 * @File:       YDSlider
 * @Abstract:   为Slider添加middleTrack，用于实现音乐或视频播放的buffered进度
 * @History:
 
 -2013-10-20 创建 by xuwf
 */

#import "YDSlider.h"
#import <objc/message.h>

#define POINT_OFFSET    (2)

#pragma mark - UIImage (YDSlider)

@interface UIImage (YDSlider)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
@end

@implementation UIImage (YDSlider)
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,
                                   color.CGColor);
    CGContextFillRect(context, rect);
    
    img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}
@end

#pragma mark - YDSlider
    
@interface YDSlider () {
    UISlider*       _slider;
    UIProgressView* _progressView;
    BOOL            _loaded;
    
    id              _target;
    SEL             _action;
    
}
@end

@implementation YDSlider

- (void)loadSubView {
    if (_loaded) return;
    _loaded = YES;
    
    self.backgroundColor = [UIColor clearColor];
    
    _slider = [[UISlider alloc] initWithFrame:self.bounds];
    _slider.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self addSubview:_slider];
    
    CGRect rect = _slider.bounds;
    
    rect.origin.x += POINT_OFFSET;
    rect.size.width -= POINT_OFFSET*2;
    _progressView = [[UIProgressView alloc] initWithFrame:rect];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _progressView.center = _slider.center;
    _progressView.userInteractionEnabled = NO;
    
    [_slider addSubview:_progressView];
    [_slider sendSubviewToBack:_progressView];
    
    _progressView.progressTintColor = [UIColor darkGrayColor];
    _progressView.trackTintColor = [UIColor lightGrayColor];
    _slider.maximumTrackTintColor = [UIColor clearColor];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadSubView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadSubView];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [self loadSubView];
    
    _target = target;
    _action = action;
    [_slider addTarget:self action:@selector(onSliderValueChanged:) forControlEvents:controlEvents];
}

- (void)onSliderValueChanged:(UISlider* )slider {
    objc_msgSend(_target, _action, self);
    //objc_msgSend(_target, _action);
}

/* setting & getting */
- (CGFloat)value {
    return _slider.value;
}

- (void)setValue:(CGFloat)value {
    _slider.value = value;
}

- (CGFloat)middleValue {
    return _progressView.progress;
}

- (void)setMiddleValue:(CGFloat)middleValue {
    _progressView.progress = middleValue;
}

- (UIColor* )thumbTintColor {
    return _slider.thumbTintColor;
}

- (void)setThumbTintColor:(UIColor *)thumbTintColor {
    [_slider setThumbTintColor:thumbTintColor];
}

- (UIColor* )minimumTrackTintColor {
    return _slider.minimumTrackTintColor;
}

- (void)setMinimumTrackTintColor:(UIColor *)minimumTrackTintColor {
    [_slider setMinimumTrackTintColor:minimumTrackTintColor];
}

- (UIColor* )middleTrackTintColor {
    return _progressView.progressTintColor;
}

- (void)setMiddleTrackTintColor:(UIColor *)middleTrackTintColor {
    _progressView.progressTintColor = middleTrackTintColor;
}

- (UIColor* )maximumTrackTintColor {
    return _progressView.trackTintColor;
}

- (void)setMaximumTrackTintColor:(UIColor *)maximumTrackTintColor {
    _progressView.trackTintColor = maximumTrackTintColor;
}

- (UIImage* )thumbImage {
    return _slider.currentThumbImage;
}

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state {
    [_slider setThumbImage:image forState:state];
}

- (UIImage* )minimumTrackImage {
    return _slider.currentMinimumTrackImage;
}

- (void)setMinimumTrackImage:(UIImage *)minimumTrackImage {
    [_slider setMinimumTrackImage:minimumTrackImage forState:UIControlStateNormal];
}

- (UIImage* )middleTrackImage {
    return _progressView.progressImage;
}

- (void)setMiddleTrackImage:(UIImage *)middleTrackImage {
    _progressView.progressImage = middleTrackImage;
}

- (UIImage* )maximumTrackImage {
    return _progressView.trackImage;
}

- (void)setMaximumTrackImage:(UIImage *)maximumTrackImage {
    [_slider setMaximumTrackImage:[UIImage imageWithColor:[UIColor clearColor] size:maximumTrackImage.size] forState:UIControlStateNormal];
    _progressView.trackImage = maximumTrackImage;
}

@end

