//
//  SectionList.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "SectionList.h"
#import "ItemList.h"


NSString *const kSectionListHeader = @"header";
NSString *const kSectionListFooter = @"footer";
NSString *const kSectionListId = @"id";
NSString *const kSectionListCount = @"count";
NSString *const kSectionListAdTrack = @"adTrack";
NSString *const kSectionListType = @"type";
NSString *const kSectionListItemList = @"itemList";


@interface SectionList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation SectionList

@synthesize header = _header;
@synthesize footer = _footer;
@synthesize sectionListIdentifier = _sectionListIdentifier;
@synthesize count = _count;
@synthesize adTrack = _adTrack;
@synthesize type = _type;
@synthesize itemList = _itemList;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.header = [self objectOrNilForKey:kSectionListHeader fromDictionary:dict];
            self.footer = [self objectOrNilForKey:kSectionListFooter fromDictionary:dict];
            self.sectionListIdentifier = [[self objectOrNilForKey:kSectionListId fromDictionary:dict] doubleValue];
            self.count = [[self objectOrNilForKey:kSectionListCount fromDictionary:dict] doubleValue];
            self.adTrack = [self objectOrNilForKey:kSectionListAdTrack fromDictionary:dict];
            self.type = [self objectOrNilForKey:kSectionListType fromDictionary:dict];
    NSObject *receivedItemList = [dict objectForKey:kSectionListItemList];
    NSMutableArray *parsedItemList = [NSMutableArray array];
    
    if ([receivedItemList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedItemList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedItemList addObject:[ItemList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedItemList isKindOfClass:[NSDictionary class]]) {
       [parsedItemList addObject:[ItemList modelObjectWithDictionary:(NSDictionary *)receivedItemList]];
    }

    self.itemList = [NSArray arrayWithArray:parsedItemList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.header forKey:kSectionListHeader];
    [mutableDict setValue:self.footer forKey:kSectionListFooter];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sectionListIdentifier] forKey:kSectionListId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kSectionListCount];
    [mutableDict setValue:self.adTrack forKey:kSectionListAdTrack];
    [mutableDict setValue:self.type forKey:kSectionListType];
    NSMutableArray *tempArrayForItemList = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.itemList) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForItemList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForItemList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItemList] forKey:kSectionListItemList];

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

    self.header = [aDecoder decodeObjectForKey:kSectionListHeader];
    self.footer = [aDecoder decodeObjectForKey:kSectionListFooter];
    self.sectionListIdentifier = [aDecoder decodeDoubleForKey:kSectionListId];
    self.count = [aDecoder decodeDoubleForKey:kSectionListCount];
    self.adTrack = [aDecoder decodeObjectForKey:kSectionListAdTrack];
    self.type = [aDecoder decodeObjectForKey:kSectionListType];
    self.itemList = [aDecoder decodeObjectForKey:kSectionListItemList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_header forKey:kSectionListHeader];
    [aCoder encodeObject:_footer forKey:kSectionListFooter];
    [aCoder encodeDouble:_sectionListIdentifier forKey:kSectionListId];
    [aCoder encodeDouble:_count forKey:kSectionListCount];
    [aCoder encodeObject:_adTrack forKey:kSectionListAdTrack];
    [aCoder encodeObject:_type forKey:kSectionListType];
    [aCoder encodeObject:_itemList forKey:kSectionListItemList];
}

- (id)copyWithZone:(NSZone *)zone {
    SectionList *copy = [[SectionList alloc] init];
    
    
    
    if (copy) {

        copy.header = [self.header copyWithZone:zone];
        copy.footer = [self.footer copyWithZone:zone];
        copy.sectionListIdentifier = self.sectionListIdentifier;
        copy.count = self.count;
        copy.adTrack = [self.adTrack copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.itemList = [self.itemList copyWithZone:zone];
    }
    
    return copy;
}


@end
