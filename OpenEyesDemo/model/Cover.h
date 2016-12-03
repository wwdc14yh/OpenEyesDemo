//
//  Cover.h
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Cover : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *blurred;
@property (nonatomic, assign) id sharing;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *feed;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
