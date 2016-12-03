//
//  Label.m
//
//  Created by 毅 胡 on 16/12/2
//  Copyright (c) 2016 暂无. All rights reserved.
//

#import "Label.h"


NSString *const kLabelDetail = @"detail";
NSString *const kLabelCard = @"card";
NSString *const kLabelText = @"text";


@interface Label ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Label

@synthesize detail = _detail;
@synthesize card = _card;
@synthesize text = _text;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.detail = [self objectOrNilForKey:kLabelDetail fromDictionary:dict];
            self.card = [self objectOrNilForKey:kLabelCard fromDictionary:dict];
            self.text = [self objectOrNilForKey:kLabelText fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.detail forKey:kLabelDetail];
    [mutableDict setValue:self.card forKey:kLabelCard];
    [mutableDict setValue:self.text forKey:kLabelText];

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

    self.detail = [aDecoder decodeObjectForKey:kLabelDetail];
    self.card = [aDecoder decodeObjectForKey:kLabelCard];
    self.text = [aDecoder decodeObjectForKey:kLabelText];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_detail forKey:kLabelDetail];
    [aCoder encodeObject:_card forKey:kLabelCard];
    [aCoder encodeObject:_text forKey:kLabelText];
}

- (id)copyWithZone:(NSZone *)zone {
    Label *copy = [[Label alloc] init];
    
    
    
    if (copy) {

        copy.detail = [self.detail copyWithZone:zone];
        copy.card = [self.card copyWithZone:zone];
        copy.text = [self.text copyWithZone:zone];
    }
    
    return copy;
}


@end
