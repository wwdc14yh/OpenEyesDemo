//
//  NetworkRequestManage.m
//  Funny_Example
//
//  Created by 胡毅 on 16/11/23.
//  Copyright © 2016年 Hy. All rights reserved.
//

#import "NetworkRequestManage.h"

static NetworkRequestManage *_sharedNetworkRequestManage = nil;

@implementation NetworkRequestManage

+ (NetworkRequestManage *)sharedManager {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _sharedNetworkRequestManage = [[self alloc] init];
    });
    return _sharedNetworkRequestManage;
}

- (instancetype) init
{
    if (!self) {
        self = [super init];
    }
    if (!self.requestManager) {
        self.requestManager = [[AFHTTPSessionManager alloc] init];
    }
    return self;
}

//基本请求
+(void)requestWithRequestMethod:(NetworkRequestMethodENUM)requestMethod Params:(NSDictionary *)params Path:(NSString *)path Success:(Success)success Failure:(Failure)failure
{
    
    NSString *baseURL = mainURL;
    if (path != nil) {
        if (path.length != 0) {
            baseURL = path;
        }
    }
    NSLog(@"发送请求:%@\n",baseURL);
    NSLog(@"发送参数:%@\n",params);
    
    
    if (requestMethod == NetworkRequestMethodGET) {
        [_sharedNetworkRequestManage.requestManager GET:baseURL parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_sharedNetworkRequestManage processJson:responseObject AtSuccessBlock:success AtFailureBlock:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    } else {
        [_sharedNetworkRequestManage.requestManager POST:baseURL parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [_sharedNetworkRequestManage processJson:responseObject AtSuccessBlock:success AtFailureBlock:failure];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            failure(error);
        }];
    }
}

- (void)processJson:(id)json AtSuccessBlock:(Success)success AtFailureBlock:(Failure)failure
{
    if (json) {
        if ([json isKindOfClass:[NSDictionary class]]||
            [json isKindOfClass:[NSArray class]]) {
            success(json);
        } else {
            failure([NSError errorWithDomain:@"服务器错误" code:-1 userInfo:nil]);
        }
    } else {
        failure([NSError errorWithDomain:@"服务器错误" code:-1 userInfo:nil]);
    }
}

@end
