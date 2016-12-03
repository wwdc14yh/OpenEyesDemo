//
//  BaseClass.h
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, assign) id dialog;
@property (nonatomic, assign) double count;
@property (nonatomic, assign) double date;
@property (nonatomic, strong) NSArray *sectionList;
@property (nonatomic, assign) double nextPublishTime;
@property (nonatomic, strong) NSString *nextPageUrl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
