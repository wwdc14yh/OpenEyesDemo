//
//  Header.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "Header.h"
#import "Follow.h"


NSString *const kHeaderFollow = @"follow";
NSString *const kHeaderId = @"id";
NSString *const kHeaderActionUrl = @"actionUrl";
NSString *const kHeaderTitle = @"title";
NSString *const kHeaderLabel = @"label";
NSString *const kHeaderDescription = @"description";
NSString *const kHeaderCover = @"cover";
NSString *const kHeaderFont = @"font";
NSString *const kHeaderIcon = @"icon";


@interface Header ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Header

@synthesize follow = _follow;
@synthesize headerIdentifier = _headerIdentifier;
@synthesize actionUrl = _actionUrl;
@synthesize title = _title;
@synthesize label = _label;
@synthesize headerDescription = _headerDescription;
@synthesize cover = _cover;
@synthesize font = _font;
@synthesize icon = _icon;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.follow = [Follow modelObjectWithDictionary:[dict objectForKey:kHeaderFollow]];
            self.headerIdentifier = [[self objectOrNilForKey:kHeaderId fromDictionary:dict] doubleValue];
            self.actionUrl = [self objectOrNilForKey:kHeaderActionUrl fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHeaderTitle fromDictionary:dict];
            self.label = [self objectOrNilForKey:kHeaderLabel fromDictionary:dict];
            self.headerDescription = [self objectOrNilForKey:kHeaderDescription fromDictionary:dict];
            self.cover = [self objectOrNilForKey:kHeaderCover fromDictionary:dict];
            self.font = [self objectOrNilForKey:kHeaderFont fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kHeaderIcon fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.follow dictionaryRepresentation] forKey:kHeaderFollow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.headerIdentifier] forKey:kHeaderId];
    [mutableDict setValue:self.actionUrl forKey:kHeaderActionUrl];
    [mutableDict setValue:self.title forKey:kHeaderTitle];
    [mutableDict setValue:self.label forKey:kHeaderLabel];
    [mutableDict setValue:self.headerDescription forKey:kHeaderDescription];
    [mutableDict setValue:self.cover forKey:kHeaderCover];
    [mutableDict setValue:self.font forKey:kHeaderFont];
    [mutableDict setValue:self.icon forKey:kHeaderIcon];

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

    self.follow = [aDecoder decodeObjectForKey:kHeaderFollow];
    self.headerIdentifier = [aDecoder decodeDoubleForKey:kHeaderId];
    self.actionUrl = [aDecoder decodeObjectForKey:kHeaderActionUrl];
    self.title = [aDecoder decodeObjectForKey:kHeaderTitle];
    self.label = [aDecoder decodeObjectForKey:kHeaderLabel];
    self.headerDescription = [aDecoder decodeObjectForKey:kHeaderDescription];
    self.cover = [aDecoder decodeObjectForKey:kHeaderCover];
    self.font = [aDecoder decodeObjectForKey:kHeaderFont];
    self.icon = [aDecoder decodeObjectForKey:kHeaderIcon];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_follow forKey:kHeaderFollow];
    [aCoder encodeDouble:_headerIdentifier forKey:kHeaderId];
    [aCoder encodeObject:_actionUrl forKey:kHeaderActionUrl];
    [aCoder encodeObject:_title forKey:kHeaderTitle];
    [aCoder encodeObject:_label forKey:kHeaderLabel];
    [aCoder encodeObject:_headerDescription forKey:kHeaderDescription];
    [aCoder encodeObject:_cover forKey:kHeaderCover];
    [aCoder encodeObject:_font forKey:kHeaderFont];
    [aCoder encodeObject:_icon forKey:kHeaderIcon];
}

- (id)copyWithZone:(NSZone *)zone {
    Header *copy = [[Header alloc] init];
    
    
    
    if (copy) {

        copy.follow = [self.follow copyWithZone:zone];
        copy.headerIdentifier = self.headerIdentifier;
        copy.actionUrl = [self.actionUrl copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        //copy.label = [self.label copyWithZone:zone];
        copy.headerDescription = [self.headerDescription copyWithZone:zone];
        copy.cover = [self.cover copyWithZone:zone];
        copy.font = [self.font copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
    }
    
    return copy;
}


@end
