//
//  PlayInfo.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "PlayInfo.h"


NSString *const kPlayInfoWidth = @"width";
NSString *const kPlayInfoHeight = @"height";
NSString *const kPlayInfoName = @"name";
NSString *const kPlayInfoType = @"type";
NSString *const kPlayInfoUrl = @"url";


@interface PlayInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation PlayInfo

@synthesize width = _width;
@synthesize height = _height;
@synthesize name = _name;
@synthesize type = _type;
@synthesize url = _url;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.width = [[self objectOrNilForKey:kPlayInfoWidth fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kPlayInfoHeight fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kPlayInfoName fromDictionary:dict];
            self.type = [self objectOrNilForKey:kPlayInfoType fromDictionary:dict];
            self.url = [self objectOrNilForKey:kPlayInfoUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kPlayInfoWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kPlayInfoHeight];
    [mutableDict setValue:self.name forKey:kPlayInfoName];
    [mutableDict setValue:self.type forKey:kPlayInfoType];
    [mutableDict setValue:self.url forKey:kPlayInfoUrl];

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

    self.width = [aDecoder decodeDoubleForKey:kPlayInfoWidth];
    self.height = [aDecoder decodeDoubleForKey:kPlayInfoHeight];
    self.name = [aDecoder decodeObjectForKey:kPlayInfoName];
    self.type = [aDecoder decodeObjectForKey:kPlayInfoType];
    self.url = [aDecoder decodeObjectForKey:kPlayInfoUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_width forKey:kPlayInfoWidth];
    [aCoder encodeDouble:_height forKey:kPlayInfoHeight];
    [aCoder encodeObject:_name forKey:kPlayInfoName];
    [aCoder encodeObject:_type forKey:kPlayInfoType];
    [aCoder encodeObject:_url forKey:kPlayInfoUrl];
}

- (id)copyWithZone:(NSZone *)zone {
    PlayInfo *copy = [[PlayInfo alloc] init];
    
    
    
    if (copy) {

        copy.width = self.width;
        copy.height = self.height;
        copy.name = [self.name copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
    }
    
    return copy;
}


@end
