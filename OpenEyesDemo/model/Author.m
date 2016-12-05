//
//  Author.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "Author.h"
#import "Follow.h"


NSString *const kAuthorFollow = @"follow";
NSString *const kAuthorVideoNum = @"videoNum";
NSString *const kAuthorLatestReleaseTime = @"latestReleaseTime";
NSString *const kAuthorId = @"id";
NSString *const kAuthorAdTrack = @"adTrack";
NSString *const kAuthorLink = @"link";
NSString *const kAuthorDescription = @"description";
NSString *const kAuthorIcon = @"icon";
NSString *const kAuthorName = @"name";


@interface Author ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Author

@synthesize follow = _follow;
@synthesize videoNum = _videoNum;
@synthesize latestReleaseTime = _latestReleaseTime;
@synthesize authorIdentifier = _authorIdentifier;
@synthesize adTrack = _adTrack;
@synthesize link = _link;
@synthesize authorDescription = _authorDescription;
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
            self.follow = [Follow modelObjectWithDictionary:[dict objectForKey:kAuthorFollow]];
            self.videoNum = [[self objectOrNilForKey:kAuthorVideoNum fromDictionary:dict] doubleValue];
            self.latestReleaseTime = [[self objectOrNilForKey:kAuthorLatestReleaseTime fromDictionary:dict] doubleValue];
            self.authorIdentifier = [[self objectOrNilForKey:kAuthorId fromDictionary:dict] doubleValue];
            self.adTrack = [self objectOrNilForKey:kAuthorAdTrack fromDictionary:dict];
            self.link = [self objectOrNilForKey:kAuthorLink fromDictionary:dict];
            self.authorDescription = [self objectOrNilForKey:kAuthorDescription fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kAuthorIcon fromDictionary:dict];
            self.name = [self objectOrNilForKey:kAuthorName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.follow dictionaryRepresentation] forKey:kAuthorFollow];
    [mutableDict setValue:[NSNumber numberWithDouble:self.videoNum] forKey:kAuthorVideoNum];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latestReleaseTime] forKey:kAuthorLatestReleaseTime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.authorIdentifier] forKey:kAuthorId];
    [mutableDict setValue:self.adTrack forKey:kAuthorAdTrack];
    [mutableDict setValue:self.link forKey:kAuthorLink];
    [mutableDict setValue:self.authorDescription forKey:kAuthorDescription];
    [mutableDict setValue:self.icon forKey:kAuthorIcon];
    [mutableDict setValue:self.name forKey:kAuthorName];

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

    self.follow = [aDecoder decodeObjectForKey:kAuthorFollow];
    self.videoNum = [aDecoder decodeDoubleForKey:kAuthorVideoNum];
    self.latestReleaseTime = [aDecoder decodeDoubleForKey:kAuthorLatestReleaseTime];
    self.authorIdentifier = [aDecoder decodeDoubleForKey:kAuthorId];
    self.adTrack = [aDecoder decodeObjectForKey:kAuthorAdTrack];
    self.link = [aDecoder decodeObjectForKey:kAuthorLink];
    self.authorDescription = [aDecoder decodeObjectForKey:kAuthorDescription];
    self.icon = [aDecoder decodeObjectForKey:kAuthorIcon];
    self.name = [aDecoder decodeObjectForKey:kAuthorName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_follow forKey:kAuthorFollow];
    [aCoder encodeDouble:_videoNum forKey:kAuthorVideoNum];
    [aCoder encodeDouble:_latestReleaseTime forKey:kAuthorLatestReleaseTime];
    [aCoder encodeDouble:_authorIdentifier forKey:kAuthorId];
    [aCoder encodeObject:_adTrack forKey:kAuthorAdTrack];
    [aCoder encodeObject:_link forKey:kAuthorLink];
    [aCoder encodeObject:_authorDescription forKey:kAuthorDescription];
    [aCoder encodeObject:_icon forKey:kAuthorIcon];
    [aCoder encodeObject:_name forKey:kAuthorName];
}

- (id)copyWithZone:(NSZone *)zone {
    Author *copy = [[Author alloc] init];
    
    
    
    if (copy) {

        copy.follow = [self.follow copyWithZone:zone];
        copy.videoNum = self.videoNum;
        copy.latestReleaseTime = self.latestReleaseTime;
        copy.authorIdentifier = self.authorIdentifier;
        //copy.adTrack = [self.adTrack copyWithZone:zone];
        copy.link = [self.link copyWithZone:zone];
        copy.authorDescription = [self.authorDescription copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
