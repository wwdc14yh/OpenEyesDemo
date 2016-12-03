//
//  AuthorView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/28.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "AuthorView.h"

@implementation AuthorView

+ (instancetype) loadView
{
    NSArray * ar = [[NSBundle mainBundle] loadNibNamed:@"AuthorView" owner:self options:nil];
    return [ar lastObject];
}


- (void) setAuthorModel:(Author *)authorModel
{
    _authorModel = authorModel;
    _nameLabel.text = _authorModel.name;
    _detailsLabel.text = _authorModel.authorDescription;
    [_avatarImageView setImageWithURL:[NSURL URLWithString:_authorModel.icon] options:YYWebImageOptionProgressiveBlur];
    _avatarImageView.layer.cornerRadius = _avatarImageView.width/2;
    _avatarImageView.layer.masksToBounds = YES;
    
    CGFloat w = [_nameLabel.text widthWithStringFont:_nameLabel.font];
    _countLayoutX.constant = 35+w;
    _countLabel.text = [NSString stringWithFormat:@"%.0f个视频",_authorModel.videoNum];
    
    UIView *lins = [HyHelper newObjectsClass:[UIView class] AtaddView:self WithTag:100];
    lins.frame = CGRectMake(15, self.height - SINGLE_LINE_WIDTH, self.width - 15, SINGLE_LINE_WIDTH);
    lins.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.5];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
