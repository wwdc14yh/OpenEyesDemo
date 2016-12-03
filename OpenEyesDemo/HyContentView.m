//
//  HyContentView.m
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/25.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "HyContentView.h"
#import "HyHelper.h"

@implementation HyContentView

+ (instancetype) loadView
{
    NSArray * ar = [[NSBundle mainBundle] loadNibNamed:@"HyContentView" owner:self options:nil];
    return [ar lastObject];
}

- (void)setDate:(double)date
{
    _date = date;
    NSString *time = [HyHelper timesTampConversion:_date AtDateFormat:@"yyyy-MM-dd"];
    NSString *weakEnglish = [HyHelper featureWeekdayWithDate:time];
    NSString *days = [time substringFromIndex:8];
    NSString *info = [NSString stringWithFormat:@"- %@, Nov. %@ -",weakEnglish,days];
    _titleLabel.text = info;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
