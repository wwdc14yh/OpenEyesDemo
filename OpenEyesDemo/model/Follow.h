//
//  Follow.h
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Follow : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) BOOL followed;
@property (nonatomic, strong) NSString *itemType;
@property (nonatomic, assign) double itemId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
