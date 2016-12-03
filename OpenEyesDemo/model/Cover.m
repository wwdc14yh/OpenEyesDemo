//
//  Cover.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "Cover.h"


NSString *const kCoverBlurred = @"blurred";
NSString *const kCoverSharing = @"sharing";
NSString *const kCoverDetail = @"detail";
NSString *const kCoverFeed = @"feed";


@interface Cover ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Cover

@synthesize blurred = _blurred;
@synthesize sharing = _sharing;
@synthesize detail = _detail;
@synthesize feed = _feed;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.blurred = [self objectOrNilForKey:kCoverBlurred fromDictionary:dict];
            self.sharing = [self objectOrNilForKey:kCoverSharing fromDictionary:dict];
            self.detail = [self objectOrNilForKey:kCoverDetail fromDictionary:dict];
            self.feed = [self objectOrNilForKey:kCoverFeed fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.blurred forKey:kCoverBlurred];
    [mutableDict setValue:self.sharing forKey:kCoverSharing];
    [mutableDict setValue:self.detail forKey:kCoverDetail];
    [mutableDict setValue:self.feed forKey:kCoverFeed];

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

    self.blurred = [aDecoder decodeObjectForKey:kCoverBlurred];
    self.sharing = [aDecoder decodeObjectForKey:kCoverSharing];
    self.detail = [aDecoder decodeObjectForKey:kCoverDetail];
    self.feed = [aDecoder decodeObjectForKey:kCoverFeed];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_blurred forKey:kCoverBlurred];
    [aCoder encodeObject:_sharing forKey:kCoverSharing];
    [aCoder encodeObject:_detail forKey:kCoverDetail];
    [aCoder encodeObject:_feed forKey:kCoverFeed];
}

- (id)copyWithZone:(NSZone *)zone {
    Cover *copy = [[Cover alloc] init];
    
    
    
    if (copy) {

        copy.blurred = [self.blurred copyWithZone:zone];
        //copy.sharing = [self.sharing copyWithZone:zone];
        copy.detail = [self.detail copyWithZone:zone];
        copy.feed = [self.feed copyWithZone:zone];
    }
    
    return copy;
}


@end
