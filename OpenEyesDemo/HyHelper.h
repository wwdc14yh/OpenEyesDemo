//
//  HyHelper.h
//  OpenEyesDemo
//
//  Created by 胡毅 on 16/11/26.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIView+SetRect.h"
#import "UIImage+ImageEffects.h"
#import <YYKit.h>
#import "UIView+FontSize.h"
#define HyIMAGE(__name) [UIImage imageNamed:__name]

#define IS_IPAD     [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
#define IS_IPHONE   [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )480) < DBL_EPSILON )
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )667) < DBL_EPSILON )
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )960) < DBL_EPSILON )

#define IH_DEVICE_HEIGHT    [[UIScreen mainScreen] bounds].size.height
#define IH_DEVICE_WIDTH     [[UIScreen mainScreen] bounds].size.width

#define HyRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define HyWeakSelf(type)  __weak typeof(type) weak##type = type;
#define HyStrongSelf(type)  __strong typeof(type) type = weak##type;

#define SYSTEM_VERSION_EQUAL_TO(v)                                             \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)                                         \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)                             \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] !=       \
NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                                            \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] ==       \
NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)                                \
([[[UIDevice currentDevice] systemVersion] compare:v                         \
options:NSNumericSearch] !=       \
NSOrderedDescending)

#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@interface HyHelper : NSObject

+ (nullable NSString *)timeformatFromSeconds:(NSInteger)seconds;
+ (nullable NSString *)getTodayDate;
+ (nullable NSString *)featureWeekdayWithDate:(nullable NSString *)featureDate;
+ (nullable NSString *)timesTampConversion:(double)timesTamp AtDateFormat:(nullable NSString *)dateFormat;
+ (nullable UIView   *)getMainView;
+ (nullable UIImage  *)getLauchImage;
+ (nullable NSMutableDictionary *)decompositionUrl:(nullable NSString *)url;
+ (__kindof UIView * __nullable)newObjectsClass:(nullable Class)cla AtaddView:(nullable UIView *)superView WithTag:(NSInteger)tag;
+ (nullable UIImage *)imageWithColor:(nullable UIColor *)color size:(CGSize)size;
+ (         CGSize) getDefaultSize;
@end
