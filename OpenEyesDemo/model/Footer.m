//
//  Footer.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "Footer.h"
#import "Data.h"


NSString *const kFooterType = @"type";
NSString *const kFooterData = @"data";


@interface Footer ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Footer

@synthesize type = _type;
@synthesize data = _data;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.type = [self objectOrNilForKey:kFooterType fromDictionary:dict];
            self.data = [Data modelObjectWithDictionary:[dict objectForKey:kFooterData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kFooterType];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kFooterData];

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

    self.type = [aDecoder decodeObjectForKey:kFooterType];
    self.data = [aDecoder decodeObjectForKey:kFooterData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_type forKey:kFooterType];
    [aCoder encodeObject:_data forKey:kFooterData];
}

- (id)copyWithZone:(NSZone *)zone {
    Footer *copy = [[Footer alloc] init];
    
    
    
    if (copy) {

        copy.type = [self.type copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
