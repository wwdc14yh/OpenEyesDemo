//
//  Provider.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "Provider.h"


NSString *const kProviderAlias = @"alias";
NSString *const kProviderIcon = @"icon";
NSString *const kProviderName = @"name";


@interface Provider ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Provider

@synthesize alias = _alias;
@synthesize icon = _icon;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.alias = [self objectOrNilForKey:kProviderAlias fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kProviderIcon fromDictionary:dict];
            self.name = [self objectOrNilForKey:kProviderName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.alias forKey:kProviderAlias];
    [mutableDict setValue:self.icon forKey:kProviderIcon];
    [mutableDict setValue:self.name forKey:kProviderName];

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

    self.alias = [aDecoder decodeObjectForKey:kProviderAlias];
    self.icon = [aDecoder decodeObjectForKey:kProviderIcon];
    self.name = [aDecoder decodeObjectForKey:kProviderName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_alias forKey:kProviderAlias];
    [aCoder encodeObject:_icon forKey:kProviderIcon];
    [aCoder encodeObject:_name forKey:kProviderName];
}

- (id)copyWithZone:(NSZone *)zone {
    Provider *copy = [[Provider alloc] init];
    
    
    
    if (copy) {

        copy.alias = [self.alias copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
