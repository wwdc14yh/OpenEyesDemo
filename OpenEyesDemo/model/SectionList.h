//
//  SectionList.h
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"


@interface SectionList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) Header *header;
@property (nonatomic, strong) id footer;
@property (nonatomic, assign) double sectionListIdentifier;
@property (nonatomic, assign) double count;
@property (nonatomic, strong) id adTrack;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *itemList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
