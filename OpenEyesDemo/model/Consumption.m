//
//  Consumption.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "Consumption.h"


NSString *const kConsumptionReplyCount = @"replyCount";
NSString *const kConsumptionShareCount = @"shareCount";
NSString *const kConsumptionCollectionCount = @"collectionCount";


@interface Consumption ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Consumption

@synthesize replyCount = _replyCount;
@synthesize shareCount = _shareCount;
@synthesize collectionCount = _collectionCount;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.replyCount = [[self objectOrNilForKey:kConsumptionReplyCount fromDictionary:dict] doubleValue];
            self.shareCount = [[self objectOrNilForKey:kConsumptionShareCount fromDictionary:dict] doubleValue];
            self.collectionCount = [[self objectOrNilForKey:kConsumptionCollectionCount fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.replyCount] forKey:kConsumptionReplyCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.shareCount] forKey:kConsumptionShareCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.collectionCount] forKey:kConsumptionCollectionCount];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.replyCount = [aDecoder decodeDoubleForKey:kConsumptionReplyCount];
    self.shareCount = [aDecoder decodeDoubleForKey:kConsumptionShareCount];
    self.collectionCount = [aDecoder decodeDoubleForKey:kConsumptionCollectionCount];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_replyCount forKey:kConsumptionReplyCount];
    [aCoder encodeDouble:_shareCount forKey:kConsumptionShareCount];
    [aCoder encodeDouble:_collectionCount forKey:kConsumptionCollectionCount];
}

- (id)copyWithZone:(NSZone *)zone {
    Consumption *copy = [[Consumption alloc] init];
    
    
    
    if (copy) {

        copy.replyCount = self.replyCount;
        copy.shareCount = self.shareCount;
        copy.collectionCount = self.collectionCount;
    }
    
    return copy;
}


@end
