//
//  Data.h
//
//  Created by 毅 胡 on 16/12/3
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Author, Label, Cover, Provider, Consumption, WebUrl, Header;

@interface Data : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) Author *author;
@property (nonatomic, assign) id adTrack;
@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *playUrl;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) Label *label;
@property (nonatomic, strong) id webAdTrack;
@property (nonatomic, assign) double duration;
@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, assign) BOOL played;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) id campaign;
@property (nonatomic, assign) double releaseTime;
@property (nonatomic, strong) Cover *cover;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *dataType;
@property (nonatomic, assign) id waterMarks;
@property (nonatomic, strong) Provider *provider;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) id favoriteAdTrack;
@property (nonatomic, strong) NSArray *playInfo;
@property (nonatomic, assign) double date;
@property (nonatomic, assign) double count;
@property (nonatomic, strong) Consumption *consumption;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, assign) id shareAdTrack;
@property (nonatomic, assign) BOOL collected;
@property (nonatomic, strong) NSString *actionUrl;
@property (nonatomic, assign) double idx;
@property (nonatomic, assign) id promotion;
@property (nonatomic, strong) WebUrl *webUrl;
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) Header *header;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *font;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
