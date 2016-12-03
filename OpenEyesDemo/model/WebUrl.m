//
//  WebUrl.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "WebUrl.h"


NSString *const kWebUrlRaw = @"raw";
NSString *const kWebUrlForWeibo = @"forWeibo";


@interface WebUrl ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WebUrl

@synthesize raw = _raw;
@synthesize forWeibo = _forWeibo;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.raw = [self objectOrNilForKey:kWebUrlRaw fromDictionary:dict];
            self.forWeibo = [self objectOrNilForKey:kWebUrlForWeibo fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.raw forKey:kWebUrlRaw];
    [mutableDict setValue:self.forWeibo forKey:kWebUrlForWeibo];

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

    self.raw = [aDecoder decodeObjectForKey:kWebUrlRaw];
    self.forWeibo = [aDecoder decodeObjectForKey:kWebUrlForWeibo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_raw forKey:kWebUrlRaw];
    [aCoder encodeObject:_forWeibo forKey:kWebUrlForWeibo];
}

- (id)copyWithZone:(NSZone *)zone {
    WebUrl *copy = [[WebUrl alloc] init];
    
    
    
    if (copy) {

        copy.raw = [self.raw copyWithZone:zone];
        copy.forWeibo = [self.forWeibo copyWithZone:zone];
    }
    
    return copy;
}


@end
