//
//  HyPlayVideoLayer.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/30.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HyPlayVideoLayer.h"

@implementation HyPlayVideoLayer


/*
 普通的播放器 不能安置播放器
 不重写 layerClass 方法 默认返回是 CALayer
 UIView 接受手势
 CALayer 不能接受手势
 CALayer是UIView底层 界面绘制 UIView是CALayer的容器
 
 CALayer 不能安置播放器
 AVPlayerLayer 才能安置播放器
 */
// 自定义带播放器的UIView 必须重写该方法

+(Class)layerClass
{
    return [AVPlayerLayer class];
}

// 安置播放器于Layer上必须重写player的 getter setter方法
- (void)setPlayer:(AVPlayer *)player
{
    AVPlayerLayer * layer = (AVPlayerLayer *)self.layer;
    [layer setPlayer:player];
}

- (AVPlayer *)player
{
    AVPlayerLayer * layer = (AVPlayerLayer *)self.layer;
    return layer.player;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
