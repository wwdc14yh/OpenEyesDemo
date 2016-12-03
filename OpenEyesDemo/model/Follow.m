//
//  Follow.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "Follow.h"


NSString *const kFollowFollowed = @"followed";
NSString *const kFollowItemType = @"itemType";
NSString *const kFollowItemId = @"itemId";


@interface Follow ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Follow

@synthesize followed = _followed;
@synthesize itemType = _itemType;
@synthesize itemId = _itemId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.followed = [[self objectOrNilForKey:kFollowFollowed fromDictionary:dict] boolValue];
            self.itemType = [self objectOrNilForKey:kFollowItemType fromDictionary:dict];
            self.itemId = [[self objectOrNilForKey:kFollowItemId fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithBool:self.followed] forKey:kFollowFollowed];
    [mutableDict setValue:self.itemType forKey:kFollowItemType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.itemId] forKey:kFollowItemId];

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

    self.followed = [aDecoder decodeBoolForKey:kFollowFollowed];
    self.itemType = [aDecoder decodeObjectForKey:kFollowItemType];
    self.itemId = [aDecoder decodeDoubleForKey:kFollowItemId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeBool:_followed forKey:kFollowFollowed];
    [aCoder encodeObject:_itemType forKey:kFollowItemType];
    [aCoder encodeDouble:_itemId forKey:kFollowItemId];
}

- (id)copyWithZone:(NSZone *)zone {
    Follow *copy = [[Follow alloc] init];
    
    
    
    if (copy) {

        copy.followed = self.followed;
        copy.itemType = [self.itemType copyWithZone:zone];
        copy.itemId = self.itemId;
    }
    
    return copy;
}


@end
