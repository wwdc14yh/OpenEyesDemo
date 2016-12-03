//
//  Data.m
//
//  Created by 毅 胡 on 16/12/3
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "Data.h"
#import "Author.h"
#import "Label.h"
#import "Cover.h"
#import "Provider.h"
#import "PlayInfo.h"
#import "Consumption.h"
#import "Tags.h"
#import "WebUrl.h"
#import "ItemList.h"
#import "Header.h"


NSString *const kDataAuthor = @"author";
NSString *const kDataAdTrack = @"adTrack";
NSString *const kDataId = @"id";
NSString *const kDataCategory = @"category";
NSString *const kDataPlayUrl = @"playUrl";
NSString *const kDataText = @"text";
NSString *const kDataLabel = @"label";
NSString *const kDataWebAdTrack = @"webAdTrack";
NSString *const kDataDuration = @"duration";
NSString *const kDataDescription = @"description";
NSString *const kDataPlayed = @"played";
NSString *const kDataType = @"type";
NSString *const kDataCampaign = @"campaign";
NSString *const kDataReleaseTime = @"releaseTime";
NSString *const kDataCover = @"cover";
NSString *const kDataImage = @"image";
NSString *const kDataDataType = @"dataType";
NSString *const kDataWaterMarks = @"waterMarks";
NSString *const kDataProvider = @"provider";
NSString *const kDataHeight = @"height";
NSString *const kDataFavoriteAdTrack = @"favoriteAdTrack";
NSString *const kDataPlayInfo = @"playInfo";
NSString *const kDataDate = @"date";
NSString *const kDataCount = @"count";
NSString *const kDataConsumption = @"consumption";
NSString *const kDataTags = @"tags";
NSString *const kDataShareAdTrack = @"shareAdTrack";
NSString *const kDataCollected = @"collected";
NSString *const kDataActionUrl = @"actionUrl";
NSString *const kDataIdx = @"idx";
NSString *const kDataPromotion = @"promotion";
NSString *const kDataWebUrl = @"webUrl";
NSString *const kDataItemList = @"itemList";
NSString *const kDataHeader = @"header";
NSString *const kDataTitle = @"title";
NSString *const kDataFont = @"font";


@interface Data ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Data

@synthesize author = _author;
@synthesize adTrack = _adTrack;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize category = _category;
@synthesize playUrl = _playUrl;
@synthesize text = _text;
@synthesize label = _label;
@synthesize webAdTrack = _webAdTrack;
@synthesize duration = _duration;
@synthesize dataDescription = _dataDescription;
@synthesize played = _played;
@synthesize type = _type;
@synthesize campaign = _campaign;
@synthesize releaseTime = _releaseTime;
@synthesize cover = _cover;
@synthesize image = _image;
@synthesize dataType = _dataType;
@synthesize waterMarks = _waterMarks;
@synthesize provider = _provider;
@synthesize height = _height;
@synthesize favoriteAdTrack = _favoriteAdTrack;
@synthesize playInfo = _playInfo;
@synthesize date = _date;
@synthesize count = _count;
@synthesize consumption = _consumption;
@synthesize tags = _tags;
@synthesize shareAdTrack = _shareAdTrack;
@synthesize collected = _collected;
@synthesize actionUrl = _actionUrl;
@synthesize idx = _idx;
@synthesize promotion = _promotion;
@synthesize webUrl = _webUrl;
@synthesize itemList = _itemList;
@synthesize header = _header;
@synthesize title = _title;
@synthesize font = _font;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.author = [Author modelObjectWithDictionary:[dict objectForKey:kDataAuthor]];
            self.adTrack = [self objectOrNilForKey:kDataAdTrack fromDictionary:dict];
            self.dataIdentifier = [[self objectOrNilForKey:kDataId fromDictionary:dict] doubleValue];
            self.category = [self objectOrNilForKey:kDataCategory fromDictionary:dict];
            self.playUrl = [self objectOrNilForKey:kDataPlayUrl fromDictionary:dict];
            self.text = [self objectOrNilForKey:kDataText fromDictionary:dict];
            self.label = [Label modelObjectWithDictionary:[dict objectForKey:kDataLabel]];
            self.webAdTrack = [self objectOrNilForKey:kDataWebAdTrack fromDictionary:dict];
            self.duration = [[self objectOrNilForKey:kDataDuration fromDictionary:dict] doubleValue];
            self.dataDescription = [self objectOrNilForKey:kDataDescription fromDictionary:dict];
            self.played = [[self objectOrNilForKey:kDataPlayed fromDictionary:dict] boolValue];
            self.type = [self objectOrNilForKey:kDataType fromDictionary:dict];
            self.campaign = [self objectOrNilForKey:kDataCampaign fromDictionary:dict];
            self.releaseTime = [[self objectOrNilForKey:kDataReleaseTime fromDictionary:dict] doubleValue];
            self.cover = [Cover modelObjectWithDictionary:[dict objectForKey:kDataCover]];
            self.image = [self objectOrNilForKey:kDataImage fromDictionary:dict];
            self.dataType = [self objectOrNilForKey:kDataDataType fromDictionary:dict];
            self.waterMarks = [self objectOrNilForKey:kDataWaterMarks fromDictionary:dict];
            self.provider = [Provider modelObjectWithDictionary:[dict objectForKey:kDataProvider]];
            self.height = [[self objectOrNilForKey:kDataHeight fromDictionary:dict] doubleValue];
            self.favoriteAdTrack = [self objectOrNilForKey:kDataFavoriteAdTrack fromDictionary:dict];
    NSObject *receivedPlayInfo = [dict objectForKey:kDataPlayInfo];
    NSMutableArray *parsedPlayInfo = [NSMutableArray array];
    
    if ([receivedPlayInfo isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPlayInfo) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPlayInfo addObject:[PlayInfo modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPlayInfo isKindOfClass:[NSDictionary class]]) {
       [parsedPlayInfo addObject:[PlayInfo modelObjectWithDictionary:(NSDictionary *)receivedPlayInfo]];
    }

    self.playInfo = [NSArray arrayWithArray:parsedPlayInfo];
            self.date = [[self objectOrNilForKey:kDataDate fromDictionary:dict] doubleValue];
            self.count = [[self objectOrNilForKey:kDataCount fromDictionary:dict] doubleValue];
            self.consumption = [Consumption modelObjectWithDictionary:[dict objectForKey:kDataConsumption]];
    NSObject *receivedTags = [dict objectForKey:kDataTags];
    NSMutableArray *parsedTags = [NSMutableArray array];
    
    if ([receivedTags isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTags) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTags addObject:[Tags modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTags isKindOfClass:[NSDictionary class]]) {
       [parsedTags addObject:[Tags modelObjectWithDictionary:(NSDictionary *)receivedTags]];
    }

    self.tags = [NSArray arrayWithArray:parsedTags];
            self.shareAdTrack = [self objectOrNilForKey:kDataShareAdTrack fromDictionary:dict];
            self.collected = [[self objectOrNilForKey:kDataCollected fromDictionary:dict] boolValue];
            self.actionUrl = [self objectOrNilForKey:kDataActionUrl fromDictionary:dict];
            self.idx = [[self objectOrNilForKey:kDataIdx fromDictionary:dict] doubleValue];
            self.promotion = [self objectOrNilForKey:kDataPromotion fromDictionary:dict];
            self.webUrl = [WebUrl modelObjectWithDictionary:[dict objectForKey:kDataWebUrl]];
    NSObject *receivedItemList = [dict objectForKey:kDataItemList];
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
            self.header = [Header modelObjectWithDictionary:[dict objectForKey:kDataHeader]];
            self.title = [self objectOrNilForKey:kDataTitle fromDictionary:dict];
            self.font = [self objectOrNilForKey:kDataFont fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.author dictionaryRepresentation] forKey:kDataAuthor];
    [mutableDict setValue:self.adTrack forKey:kDataAdTrack];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kDataId];
    [mutableDict setValue:self.category forKey:kDataCategory];
    [mutableDict setValue:self.playUrl forKey:kDataPlayUrl];
    [mutableDict setValue:self.text forKey:kDataText];
    [mutableDict setValue:[self.label dictionaryRepresentation] forKey:kDataLabel];
    [mutableDict setValue:self.webAdTrack forKey:kDataWebAdTrack];
    [mutableDict setValue:[NSNumber numberWithDouble:self.duration] forKey:kDataDuration];
    [mutableDict setValue:self.dataDescription forKey:kDataDescription];
    [mutableDict setValue:[NSNumber numberWithBool:self.played] forKey:kDataPlayed];
    [mutableDict setValue:self.type forKey:kDataType];
    [mutableDict setValue:self.campaign forKey:kDataCampaign];
    [mutableDict setValue:[NSNumber numberWithDouble:self.releaseTime] forKey:kDataReleaseTime];
    [mutableDict setValue:[self.cover dictionaryRepresentation] forKey:kDataCover];
    [mutableDict setValue:self.image forKey:kDataImage];
    [mutableDict setValue:self.dataType forKey:kDataDataType];
    [mutableDict setValue:self.waterMarks forKey:kDataWaterMarks];
    [mutableDict setValue:[self.provider dictionaryRepresentation] forKey:kDataProvider];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kDataHeight];
    [mutableDict setValue:self.favoriteAdTrack forKey:kDataFavoriteAdTrack];
    NSMutableArray *tempArrayForPlayInfo = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.playInfo) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPlayInfo addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPlayInfo addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPlayInfo] forKey:kDataPlayInfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.date] forKey:kDataDate];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kDataCount];
    [mutableDict setValue:[self.consumption dictionaryRepresentation] forKey:kDataConsumption];
    NSMutableArray *tempArrayForTags = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.tags) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kDataTags];
    [mutableDict setValue:self.shareAdTrack forKey:kDataShareAdTrack];
    [mutableDict setValue:[NSNumber numberWithBool:self.collected] forKey:kDataCollected];
    [mutableDict setValue:self.actionUrl forKey:kDataActionUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.idx] forKey:kDataIdx];
    [mutableDict setValue:self.promotion forKey:kDataPromotion];
    [mutableDict setValue:[self.webUrl dictionaryRepresentation] forKey:kDataWebUrl];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForItemList] forKey:kDataItemList];
    [mutableDict setValue:[self.header dictionaryRepresentation] forKey:kDataHeader];
    [mutableDict setValue:self.title forKey:kDataTitle];
    [mutableDict setValue:self.font forKey:kDataFont];

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

    self.author = [aDecoder decodeObjectForKey:kDataAuthor];
    self.adTrack = [aDecoder decodeObjectForKey:kDataAdTrack];
    self.dataIdentifier = [aDecoder decodeDoubleForKey:kDataId];
    self.category = [aDecoder decodeObjectForKey:kDataCategory];
    self.playUrl = [aDecoder decodeObjectForKey:kDataPlayUrl];
    self.text = [aDecoder decodeObjectForKey:kDataText];
    self.label = [aDecoder decodeObjectForKey:kDataLabel];
    self.webAdTrack = [aDecoder decodeObjectForKey:kDataWebAdTrack];
    self.duration = [aDecoder decodeDoubleForKey:kDataDuration];
    self.dataDescription = [aDecoder decodeObjectForKey:kDataDescription];
    self.played = [aDecoder decodeBoolForKey:kDataPlayed];
    self.type = [aDecoder decodeObjectForKey:kDataType];
    self.campaign = [aDecoder decodeObjectForKey:kDataCampaign];
    self.releaseTime = [aDecoder decodeDoubleForKey:kDataReleaseTime];
    self.cover = [aDecoder decodeObjectForKey:kDataCover];
    self.image = [aDecoder decodeObjectForKey:kDataImage];
    self.dataType = [aDecoder decodeObjectForKey:kDataDataType];
    self.waterMarks = [aDecoder decodeObjectForKey:kDataWaterMarks];
    self.provider = [aDecoder decodeObjectForKey:kDataProvider];
    self.height = [aDecoder decodeDoubleForKey:kDataHeight];
    self.favoriteAdTrack = [aDecoder decodeObjectForKey:kDataFavoriteAdTrack];
    self.playInfo = [aDecoder decodeObjectForKey:kDataPlayInfo];
    self.date = [aDecoder decodeDoubleForKey:kDataDate];
    self.count = [aDecoder decodeDoubleForKey:kDataCount];
    self.consumption = [aDecoder decodeObjectForKey:kDataConsumption];
    self.tags = [aDecoder decodeObjectForKey:kDataTags];
    self.shareAdTrack = [aDecoder decodeObjectForKey:kDataShareAdTrack];
    self.collected = [aDecoder decodeBoolForKey:kDataCollected];
    self.actionUrl = [aDecoder decodeObjectForKey:kDataActionUrl];
    self.idx = [aDecoder decodeDoubleForKey:kDataIdx];
    self.promotion = [aDecoder decodeObjectForKey:kDataPromotion];
    self.webUrl = [aDecoder decodeObjectForKey:kDataWebUrl];
    self.itemList = [aDecoder decodeObjectForKey:kDataItemList];
    self.header = [aDecoder decodeObjectForKey:kDataHeader];
    self.title = [aDecoder decodeObjectForKey:kDataTitle];
    self.font = [aDecoder decodeObjectForKey:kDataFont];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_author forKey:kDataAuthor];
    [aCoder encodeObject:_adTrack forKey:kDataAdTrack];
    [aCoder encodeDouble:_dataIdentifier forKey:kDataId];
    [aCoder encodeObject:_category forKey:kDataCategory];
    [aCoder encodeObject:_playUrl forKey:kDataPlayUrl];
    [aCoder encodeObject:_text forKey:kDataText];
    [aCoder encodeObject:_label forKey:kDataLabel];
    [aCoder encodeObject:_webAdTrack forKey:kDataWebAdTrack];
    [aCoder encodeDouble:_duration forKey:kDataDuration];
    [aCoder encodeObject:_dataDescription forKey:kDataDescription];
    [aCoder encodeBool:_played forKey:kDataPlayed];
    [aCoder encodeObject:_type forKey:kDataType];
    [aCoder encodeObject:_campaign forKey:kDataCampaign];
    [aCoder encodeDouble:_releaseTime forKey:kDataReleaseTime];
    [aCoder encodeObject:_cover forKey:kDataCover];
    [aCoder encodeObject:_image forKey:kDataImage];
    [aCoder encodeObject:_dataType forKey:kDataDataType];
    [aCoder encodeObject:_waterMarks forKey:kDataWaterMarks];
    [aCoder encodeObject:_provider forKey:kDataProvider];
    [aCoder encodeDouble:_height forKey:kDataHeight];
    [aCoder encodeObject:_favoriteAdTrack forKey:kDataFavoriteAdTrack];
    [aCoder encodeObject:_playInfo forKey:kDataPlayInfo];
    [aCoder encodeDouble:_date forKey:kDataDate];
    [aCoder encodeDouble:_count forKey:kDataCount];
    [aCoder encodeObject:_consumption forKey:kDataConsumption];
    [aCoder encodeObject:_tags forKey:kDataTags];
    [aCoder encodeObject:_shareAdTrack forKey:kDataShareAdTrack];
    [aCoder encodeBool:_collected forKey:kDataCollected];
    [aCoder encodeObject:_actionUrl forKey:kDataActionUrl];
    [aCoder encodeDouble:_idx forKey:kDataIdx];
    [aCoder encodeObject:_promotion forKey:kDataPromotion];
    [aCoder encodeObject:_webUrl forKey:kDataWebUrl];
    [aCoder encodeObject:_itemList forKey:kDataItemList];
    [aCoder encodeObject:_header forKey:kDataHeader];
    [aCoder encodeObject:_title forKey:kDataTitle];
    [aCoder encodeObject:_font forKey:kDataFont];
}

- (id)copyWithZone:(NSZone *)zone {
    Data *copy = [[Data alloc] init];
    
    
    
    if (copy) {

        copy.author = [self.author copyWithZone:zone];
        //copy.adTrack = [self.adTrack copyWithZone:zone];
        copy.dataIdentifier = self.dataIdentifier;
        copy.category = [self.category copyWithZone:zone];
        copy.playUrl = [self.playUrl copyWithZone:zone];
        copy.text = [self.text copyWithZone:zone];
        copy.label = [self.label copyWithZone:zone];
        copy.webAdTrack = [self.webAdTrack copyWithZone:zone];
        copy.duration = self.duration;
        copy.dataDescription = [self.dataDescription copyWithZone:zone];
        copy.played = self.played;
        copy.type = [self.type copyWithZone:zone];
        //copy.campaign = [self.campaign copyWithZone:zone];
        copy.releaseTime = self.releaseTime;
        copy.cover = [self.cover copyWithZone:zone];
        copy.image = [self.image copyWithZone:zone];
        copy.dataType = [self.dataType copyWithZone:zone];
        //copy.waterMarks = [self.waterMarks copyWithZone:zone];
        copy.provider = [self.provider copyWithZone:zone];
        copy.height = self.height;
        copy.favoriteAdTrack = [self.favoriteAdTrack copyWithZone:zone];
        copy.playInfo = [self.playInfo copyWithZone:zone];
        copy.date = self.date;
        copy.count = self.count;
        copy.consumption = [self.consumption copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        //copy.shareAdTrack = [self.shareAdTrack copyWithZone:zone];
        copy.collected = self.collected;
        copy.actionUrl = [self.actionUrl copyWithZone:zone];
        copy.idx = self.idx;
        //copy.promotion = [self.promotion copyWithZone:zone];
        copy.webUrl = [self.webUrl copyWithZone:zone];
        copy.itemList = [self.itemList copyWithZone:zone];
        copy.header = [self.header copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.font = [self.font copyWithZone:zone];
    }
    
    return copy;
}


@end
