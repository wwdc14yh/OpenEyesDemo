//
//  Consumption.h
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Consumption : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double replyCount;
@property (nonatomic, assign) double shareCount;
@property (nonatomic, assign) double collectionCount;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
