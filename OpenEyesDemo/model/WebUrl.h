//
//  WebUrl.h
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface WebUrl : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *raw;
@property (nonatomic, strong) NSString *forWeibo;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
