//
//  Tags.h
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Tags : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double tagsIdentifier;
@property (nonatomic, strong) NSString *actionUrl;
@property (nonatomic, assign) id adTrack;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
