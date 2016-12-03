//
//  BaseClass.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "BaseClass.h"
#import "SectionList.h"


NSString *const kBaseClassItemList = @"itemList";
NSString *const kBaseClassDialog = @"dialog";
NSString *const kBaseClassCount = @"count";
NSString *const kBaseClassDate = @"date";
NSString *const kBaseClassSectionList = @"sectionList";
NSString *const kBaseClassNextPublishTime = @"nextPublishTime";
NSString *const kBaseClassNextPageUrl = @"nextPageUrl";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize itemList = _itemList;
@synthesize dialog = _dialog;
@synthesize count = _count;
@synthesize date = _date;
@synthesize sectionList = _sectionList;
@synthesize nextPublishTime = _nextPublishTime;
@synthesize nextPageUrl = _nextPageUrl;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.itemList = [self objectOrNilForKey:kBaseClassItemList fromDictionary:dict];
            self.dialog = [self objectOrNilForKey:kBaseClassDialog fromDictionary:dict];
            self.count = [[self objectOrNilForKey:kBaseClassCount fromDictionary:dict] doubleValue];
            self.date = [[self objectOrNilForKey:kBaseClassDate fromDictionary:dict] doubleValue];
    NSObject *receivedSectionList = [dict objectForKey:kBaseClassSectionList];
    NSMutableArray *parsedSectionList = [NSMutableArray array];
    
    if ([receivedSectionList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedSectionList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedSectionList addObject:[SectionList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedSectionList isKindOfClass:[NSDictionary class]]) {
       [parsedSectionList addObject:[SectionList modelObjectWithDictionary:(NSDictionary *)receivedSectionList]];
    }

    self.sectionList = [NSArray arrayWithArray:parsedSectionList];
            self.nextPublishTime = [[self objectOrNilForKey:kBaseClassNextPublishTime fromDictionary:dict] doubleValue];
            self.nextPageUrl = [self objectOrNilForKey:kBaseClassNextPageUrl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.itemList forKey:kBaseClassItemList];
    [mutableDict setValue:self.dialog forKey:kBaseClassDialog];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kBaseClassCount];
    [mutableDict setValue:[NSNumber numberWithDouble:self.date] forKey:kBaseClassDate];
    NSMutableArray *tempArrayForSectionList = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.sectionList) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSectionList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSectionList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSectionList] forKey:kBaseClassSectionList];
    [mutableDict setValue:[NSNumber numberWithDouble:self.nextPublishTime] forKey:kBaseClassNextPublishTime];
    [mutableDict setValue:self.nextPageUrl forKey:kBaseClassNextPageUrl];

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

    self.itemList = [aDecoder decodeObjectForKey:kBaseClassItemList];
    self.dialog = [aDecoder decodeObjectForKey:kBaseClassDialog];
    self.count = [aDecoder decodeDoubleForKey:kBaseClassCount];
    self.date = [aDecoder decodeDoubleForKey:kBaseClassDate];
    self.sectionList = [aDecoder decodeObjectForKey:kBaseClassSectionList];
    self.nextPublishTime = [aDecoder decodeDoubleForKey:kBaseClassNextPublishTime];
    self.nextPageUrl = [aDecoder decodeObjectForKey:kBaseClassNextPageUrl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_itemList forKey:kBaseClassItemList];
    [aCoder encodeObject:_dialog forKey:kBaseClassDialog];
    [aCoder encodeDouble:_count forKey:kBaseClassCount];
    [aCoder encodeDouble:_date forKey:kBaseClassDate];
    [aCoder encodeObject:_sectionList forKey:kBaseClassSectionList];
    [aCoder encodeDouble:_nextPublishTime forKey:kBaseClassNextPublishTime];
    [aCoder encodeObject:_nextPageUrl forKey:kBaseClassNextPageUrl];
}

- (id)copyWithZone:(NSZone *)zone {
    BaseClass *copy = [[BaseClass alloc] init];
    
    
    
    if (copy) {

        copy.itemList = [self.itemList copyWithZone:zone];
        //copy.dialog = [self.dialog copyWithZone:zone];
        copy.count = self.count;
        copy.date = self.date;
        copy.sectionList = [self.sectionList copyWithZone:zone];
        copy.nextPublishTime = self.nextPublishTime;
        copy.nextPageUrl = [self.nextPageUrl copyWithZone:zone];
    }
    
    return copy;
}


@end
