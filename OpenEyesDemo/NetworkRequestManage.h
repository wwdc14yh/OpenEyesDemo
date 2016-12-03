//
//  NetworkRequestManage.h
//  Funny_Example
//
//  Created by 胡毅 on 16/11/23.
//  Copyright © 2016年 Hy. All rights reserved.
//
//    http://baobab.kaiyanapp.com/api/v3/tabs/selected?_s=a80176e2f85bce56e8737613ff0686fa&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=f36990f193fd8fcefb66969d2ba6043eae73bb9a&v=2.9.0&vc=1604

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "YYKit.h"

//http://baobab.kaiyanapp.com/api/v3/video/10774/detail/related?_s=f0e6ee21d170534421fee88afa003612&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=aaad82956518235e6e5a34ed0afee16c891ebc4c&v=2.9.0&vc=1604

//http://baobab.kaiyanapp.com/api/v3/video/11226/detail/related?_s=04ada0bbfd44dd2ffb79144735a66891&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=aaad82956518235e6e5a34ed0afee16c891ebc4c&v=2.9.0&vc=1604

//http://baobab.kaiyanapp.com/api/v3/discovery?_s=3008ec88188b38ee102de34e3f2c5175&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=aaad82956518235e6e5a34ed0afee16c891ebc4c&v=2.9.0&vc=1604

//http://baobab.kaiyanapp.com/api/v3/categories/detail?_s=5252788ace69af5527ed72ce3302fa39&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=aaad82956518235e6e5a34ed0afee16c891ebc4c&v=2.9.0&vc=1604

// 获取最新视频
#define mainURL @"http://baobab.kaiyanapp.com/api/v3/tabs/selected?_s=a80176e2f85bce56e8737613ff0686fa&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=f36990f193fd8fcefb66969d2ba6043eae73bb9a&v=2.9.0&vc=1604"
// 获取往期视频
#define nextPage @"http://baobab.kaiyanapp.com/api/v3/tabs/selected?pagination=1&needFilter=true&_s=5c08c97c7aed728a12c6792a7a0bbceb&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=f36990f193fd8fcefb66969d2ba6043eae73bb9a&v=2.9.0&vc=1604"
// 获取Launch载入图
#define startPage @"http://baobab.wandoujia.com/api/v1/configs?model=iPhone%206%20Plus&version=362&vc=1604&t=MjAxNjExMjYxNjUzMzMzMDQsNzQ5Ng%3D%3D&u=f36990f193fd8fcefb66969d2ba6043eae73bb9a&net=wifi&v=2.9.0&f=iphone"

// 获取作者详情页面数据_s=id
#define authorDetails @"http://baobab.kaiyanapp.com/api/v3/video/10458/detail/related?&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=aaad82956518235e6e5a34ed0afee16c891ebc4c&v=2.9.0&vc=1604"

#define findUrl @"http://baobab.kaiyanapp.com/api/v3/discovery?_s=3008ec88188b38ee102de34e3f2c5175&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=aaad82956518235e6e5a34ed0afee16c891ebc4c&v=2.9.0&vc=1604"

#define findDetailsUrl @"http://baobab.kaiyanapp.com/api/v3/categories/detail?_s=5252788ace69af5527ed72ce3302fa39&f=iphone&net=wifi&p_product=EYEPETIZER_IOS&u=aaad82956518235e6e5a34ed0afee16c891ebc4c&v=2.9.0&vc=1604"

typedef enum : NSUInteger {
    NetworkRequestMethodPOST,
    NetworkRequestMethodGET ,
} NetworkRequestMethodENUM;

typedef void (^Success)(_Nonnull id json);
typedef void (^Failure)(NSError *_Nonnull error);

@interface NetworkRequestManage : NSObject

@property (nonnull, nonatomic, strong) AFHTTPSessionManager  *requestManager;

+ (NetworkRequestManage *_Nonnull)sharedManager;

+(void)requestWithRequestMethod:(NetworkRequestMethodENUM)requestMethod
                         Params:( NSDictionary * _Nonnull )params
                           Path:(NSString * _Nonnull)path
                        Success:(_Nonnull Success)success
                        Failure:(_Nonnull Failure)failure;

@end
