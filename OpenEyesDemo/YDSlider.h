
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
                支持 UIControlEventValueChanged 事件
 * @History:
 
 -2013-10-20 创建 by xuwf
 */

#import <UIKit/UIKit.h>

@interface YDSlider : UIControl
@property (nonatomic, assign) CGFloat value;        /* From 0 to 1 */
@property (nonatomic, assign) CGFloat middleValue;  /* From 0 to 1 */

@property (nonatomic, strong) UIColor* thumbTintColor;
@property (nonatomic, strong) UIColor* minimumTrackTintColor;
@property (nonatomic, strong) UIColor* middleTrackTintColor;
@property (nonatomic, strong) UIColor* maximumTrackTintColor;

@property (nonatomic, readonly) UIImage* thumbImage;
@property (nonatomic, strong) UIImage* minimumTrackImage;
@property (nonatomic, strong) UIImage* middleTrackImage;
@property (nonatomic, strong) UIImage* maximumTrackImage;

- (void)setThumbImage:(UIImage *)image forState:(UIControlState)state;
@end


