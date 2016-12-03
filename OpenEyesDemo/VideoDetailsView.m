//
//  VideoDetailsView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/27.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "VideoDetailsView.h"
#import "HytextGraduallyShowAnimation.h"
#import "HyHelper.h"
#import "AuthorView.h"
#import "NSString+LabelWidthAndHeight.h"
#import "downToolsView.h"

@interface VideoDetailsView ()<UIGestureRecognizerDelegate>
{
    AuthorView *authorView;
    UIView     *maskView;
    BOOL isScroll;
    CGRect oldRect;
    CGRect newMaxRect;
    NSMutableArray *mutableStringArray;
    BOOL isRun;
}

@end

@implementation VideoDetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.layer.borderWidth   = 0.0f;
        self.layer.borderColor   = [UIColor blackColor].CGColor;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5f];
        mutableStringArray = @[].mutableCopy;
        //创建拖拽手势
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(handlePanGestures:)];
        //无论最大还是最小都只允许一个手指
        panGestureRecognizer.minimumNumberOfTouches = 1;
        panGestureRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:panGestureRecognizer];
        panGestureRecognizer.delegate = self;
        oldRect = frame;
        {
            CGRect rect = self.frame;
            _imageView = [HyHelper newObjectsClass:[UIImageView class] AtaddView:self WithTag:1000];
            _imageView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
            _imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self addSubview:_imageView];
            
            maskView = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:999];
            maskView.frame = self.bounds;
            maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
        }
        
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    if (!_data) {
        return ;
    }
    
    HytextGraduallyShowAnimation *titleText =  [HyHelper newObjectsClass:[HytextGraduallyShowAnimation class] AtaddView:self WithTag:1];
    titleText.text = self.data.data.title;
    titleText.font = [UIFont fontWithName:@"FZLTZCHJW--GB1-0" size:18];
    titleText.textColor = HyRGBColor(247, 246, 246);
    {
        CGFloat h = [titleText.text heightWithStringFont:titleText.font fixedWidth:titleText.width];
        titleText.layoutTool.groupType = ZCLayoutGroupWord;
        titleText.frame = CGRectMake(15, 20, self.width-30, h);
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineSpacing = 0;
        NSMutableAttributedString *mutableString = [[[NSAttributedString alloc] initWithString:titleText.text attributes:@{NSFontAttributeName : titleText.font, NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : titleText.textColor}] mutableCopy];
        titleText.attributedString = mutableString;
        titleText.animationDuration = 0.10f;
        titleText.animationDelay = 0.01f;
        [mutableStringArray addObject:mutableString];
    }
    
    NSString *subString = [NSString stringWithFormat:@"#%@  /  %@",_data.data.category,[HyHelper timeformatFromSeconds:_data.data.duration]];
    HytextGraduallyShowAnimation *subText =  [HyHelper newObjectsClass:[HytextGraduallyShowAnimation class] AtaddView:self WithTag:2];
    subText.text = subString;
    subText.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:12];
    subText.textColor = HyRGBColor(247, 246, 246);
    {
        CGFloat h = [subText.text heightWithStringFont:subText.font fixedWidth:subText.width];
        subText.layoutTool.groupType = ZCLayoutGroupWord;
        subText.frame = CGRectMake(15, CGRectGetMaxY(titleText.frame)+10, self.width-30, h);
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineSpacing = 0;
        NSMutableAttributedString *mutableString = [[[NSAttributedString alloc] initWithString:subText.text attributes:@{NSFontAttributeName : subText.font, NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : subText.textColor}] mutableCopy];
        subText.attributedString = mutableString;
        subText.animationDuration = 0.10f;
        subText.animationDelay = 0.01f;
        [mutableStringArray addObject:mutableString];
    }
    
    UIView *lins = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:100];
    lins.frame = CGRectMake(15, CGRectGetMaxY(subText.frame) + 20 , self.width - 15, SINGLE_LINE_WIDTH);
    lins.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
    
    if (_data.data.author) {
        if (_data.data.author.name) {
            lins.hidden = true;
            if (!authorView) {
                authorView = [AuthorView loadView];
                authorView.frame = CGRectMake(0, CGRectGetMaxY(subText.frame)+20, self.width, 60);
                [self addSubview:authorView];
            }
            authorView.authorModel = _data.data.author;
        }
    }
    
    HytextGraduallyShowAnimation *detailsText =  [HyHelper newObjectsClass:[HytextGraduallyShowAnimation class] AtaddView:self WithTag:3];
    CGFloat y = (authorView) ? CGRectGetMaxY(authorView.frame) : CGRectGetMaxY(lins.frame);
    detailsText.text = _data.data.dataDescription;
    detailsText.font = [UIFont fontWithName:@"FZLTXIHJW--GB1-0" size:12];
    detailsText.textColor = HyRGBColor(247, 246, 246);
    
    {
        //CGFloat h = [detailsText.text heightWithStringFont:detailsText.font fixedWidth:self.width-30];
        detailsText.layoutTool.groupType = ZCLayoutGroupWord;
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        style.lineSpacing = 5;
        CGFloat h = [detailsText.text heightWithStringAttribute:@{NSFontAttributeName : detailsText.font, NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : detailsText.textColor} fixedWidth:self.width-30];
        detailsText.frame = CGRectMake(15, y+20, self.width-30, h);
        
        NSMutableAttributedString *mutableString = [[[NSAttributedString alloc] initWithString:detailsText.text attributes:@{NSFontAttributeName : detailsText.font, NSParagraphStyleAttributeName : style, NSForegroundColorAttributeName : detailsText.textColor}] mutableCopy];
        detailsText.attributedString = mutableString;
        detailsText.animationDuration = 0.10f;
        detailsText.animationDelay = 0.01f;
        [mutableStringArray addObject:mutableString];
    }
    for (id str in mutableStringArray) {
        NSInteger idx = [mutableStringArray indexOfObject:str];
        [self animateLabelAppear:true AtNSMutableAttributedString:str WithTag:idx+1];
    }
//    [titleText startAppearAnimation];
//    [subText startAppearAnimation];
//    [detailsText startAppearAnimation];
    
    downToolsView *downTools = [[[NSBundle mainBundle] loadNibNamed:@"VideoDetailsView" owner:self options:nil] lastObject];
    [self addSubview:downTools];
    
    newMaxRect = (CGRect){{oldRect.origin.x,oldRect.origin.y - ((CGRectGetMaxY(detailsText.frame)+74) - CGRectGetHeight(oldRect))},{oldRect.size.width,CGRectGetMaxY(detailsText.frame)+74}};
    if (newMaxRect.size.height > oldRect.size.height) {
        downTools.frame = CGRectMake(15, CGRectGetMaxY(detailsText.frame) + 15, 375, 44);
    } else {
        downTools.frame = CGRectMake(15, self.height - 70, 375, 44);
    }
    
    downTools.replyCountLabel.text = [NSString stringWithFormat:@"%.0f",_data.data.consumption.replyCount];
    downTools.shareCountUILabel.text = [NSString stringWithFormat:@"%.0f",_data.data.consumption.shareCount];
    downTools.collectionCountLabel.text = [NSString stringWithFormat:@"%.0f",_data.data.consumption.collectionCount];
    
    UIButton *moerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    moerButton.tintColor = [UIColor whiteColor];
    [moerButton setImage:[UIImage imageNamed:@"ic_video_entry"] forState:UIControlStateNormal];
    [moerButton setFrame:CGRectMake(self.width - 41, 44, 26, 26)];
    [self addSubview:moerButton];
    moerButton.showsTouchWhenHighlighted = YES;
    [moerButton addTarget:self action:@selector(moerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:_imageView atIndex:0];
}

- (void)refreshFrame
{
    _imageView.frame = self.bounds;
    maskView.frame = self.bounds;
}

- (void) setData:(ItemList *)data
{
    _data = data;
    [self initUI];
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self refreshFrame];
}

- (void) handlePanGestures:(UIPanGestureRecognizer*)paramSender
{
    static CGFloat beginOriginY = 0.0f;
    static int  isr = 0;
    static BOOL isUpRun = false;
    //CGPoint po = [paramSender velocityInView:self];
    switch (paramSender.state)
    {
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            if (!isUpRun) {
                NSInteger index = fabs(_scrollView.contentOffset.x) / _scrollView.frame.size.width;
                if ((int)isr != -1) {
                    if (isr) {
                        [_scrollView setContentOffset:CGPointMake(MAX((index-1), 0) * _scrollView.width, 0) animated:true];
                    }else{
                        [_scrollView setContentOffset:CGPointMake(MIN((index+1), 5) * _scrollView.width, 0) animated:true];
                    }
                }
            }else{
                isUpRun = false;
            }
            
            beginOriginY = self.y;
            //scX = self.scrollView.contentOffset.x;
            CGPoint translation = [paramSender translationInView:self];
            CGFloat y = translation.y + beginOriginY;
            CGFloat pro = MAX(1-(oldRect.size.height/(CGRectGetHeight([UIScreen mainScreen].bounds)-y)), 0);
            if (pro >= 0.5f) {
                _type = VideoDetailsViewClickTypePresent;
                [self clickType];
            }
            CGFloat delay = (pro >= 0.5f)?0.2:0.0f;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                CGRect rect = newMaxRect;
                if (newMaxRect.size.height < oldRect.size.height) rect = oldRect;
                [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:1.f initialSpringVelocity:1.0f options:0 animations:^{
                    CGFloat max = MAX(CGRectGetHeight(newMaxRect), CGRectGetHeight(oldRect));
                    CGFloat min = MIN(CGRectGetHeight(newMaxRect), CGRectGetHeight(oldRect));
                    CGFloat pro = MIN((max - self.y) / (max - min), 1);
                    if (pro >= 0.5) {
                        if (newMaxRect.size.height > oldRect.size.height) {
                            self.frame = CGRectMake(oldRect.origin.x, oldRect.origin.y - (max - min), oldRect.size.width, max);
                        }else{
                            self.frame = oldRect;
                        }
                    }else{
                        self.frame = oldRect;
                    }
                } completion:^(BOOL finished) {
                    
                }];
            });
            break;
        }
        case UIGestureRecognizerStateFailed:
        {
            break;
        }
        case UIGestureRecognizerStateBegan:
        {
            beginOriginY = self.y;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint translation = [paramSender translationInView:self];
            if (-translation.y > 30) {
                CGFloat ys = translation.y + 30;
                isUpRun = true;
                CGRect selfFrame = oldRect;
                CGFloat y = ys + beginOriginY;
                CGFloat pro = oldRect.size.height/(CGRectGetHeight([UIScreen mainScreen].bounds)-y);
                if (pro <= 1.0f) {
                    //CGFloat d = 1-pro;
                    selfFrame.origin.y = y;
                    selfFrame.size.height = CGRectGetHeight([UIScreen mainScreen].bounds)-y;
                    [self setFrame:selfFrame];
                }
            }
            if (translation.x > 50) {
                isr  = true;
            } else if (-translation.x > 50) {
                isr = false;
            } else {
                isr = -1;
            }
            break;
        }
        default:
            break;
    }
}

- (void)moerButtonAction:(UIButton *)sender
{
    _type = VideoDetailsViewClickTypePresent;
    [self clickType];
}

- (void)clickType
{
    if ([_delegate respondsToSelector:@selector(videoDetailsView:videoDetailsViewClickType:)]) {
        [_delegate videoDetailsView:self videoDetailsViewClickType:_type];
    }
}

- (void) animateLabelAppear: (BOOL) appear AtNSMutableAttributedString:(NSMutableAttributedString *)mutableAttributedString WithTag:(NSInteger)tag
{
    _isShow = appear;
    HytextGraduallyShowAnimation *titleText =  [HyHelper newObjectsClass:[HytextGraduallyShowAnimation class] AtaddView:self WithTag:tag];
    titleText.animationDuration = 0.10f;
    titleText.animationDelay = 0.01f;
    if (appear) {
        titleText.text = mutableAttributedString.string;
        titleText.attributedString = mutableAttributedString;
        titleText.alpha = 1.0f;
        authorView.alpha = 1.0f;
        [titleText startAppearAnimation];
    }
    else {
        if (titleText.animatingAppear) {
            titleText.alpha = 0.0f;
            authorView.alpha = 0.0f;
            //[titleText startDisappearAnimation];
        }
    }
}

- (void)startAnimation
{
    [UIView animateWithDuration:0.2 animations:^{
        for (id str in mutableStringArray) {
            NSInteger idx = [mutableStringArray indexOfObject:str];
            [self animateLabelAppear:true AtNSMutableAttributedString:str WithTag:idx+1];
        }
    }];
}

- (void)stopAnimation
{
    [UIView animateWithDuration:0.2 animations:^{
        for (id str in mutableStringArray) {
            NSInteger idx = [mutableStringArray indexOfObject:str];
            [self animateLabelAppear:false AtNSMutableAttributedString:str WithTag:idx+1];
        }
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return true;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *result = [super hitTest:point withEvent:event];

//    if (result == self) {
//        return result;
//    }
//    return self;
    
    if (result == self ||
        [result isKindOfClass:[HytextGraduallyShowAnimation class]] ||
        [result isKindOfClass:[AuthorView class]]||
        [result isKindOfClass:[UIImageView class]]||
        result == maskView) {
        return self;
    } else {
        return result;
    }
}

@end

@implementation BlurView

- (void)initUI
{
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithFrame:self.bounds];
    [blurView setEffect:effect];
    [self addSubview:blurView];
    [self setBackgroundColor:[UIColor clearColor]];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}

@end

