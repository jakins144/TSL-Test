//
//  SPBaseItem.m
//  TSL App Test
//
//  Created by Owner on 11/15/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SPBaseItem.h"

@implementation SPBaseItem

+ (instancetype)itemFromJSONDictionary:(NSDictionary *)data {
    
    //NSDictionary *dict = [self dictionaryWithoutNulls:data];
    
    NSError *error = nil;
    id item = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:data error:&error];
    
    return item;
}


+ (NSDictionary *)dictionaryWithoutNulls:(NSDictionary *)data {
    
    NSMutableDictionary *mData = data.mutableCopy;
    
    for (NSString *key in data.allKeys) {
        id item = data[key];
        
        if ([item isEqual:[NSNull null]] == NO) {
            [mData setValue:item forKey:key];
        }
    }
    
    return mData;
}


+ (NSArray *)itemsFromJSONDictionary:(NSArray *)data {
    
    NSError *error = nil;
    NSArray *items = [MTLJSONAdapter modelsOfClass:self.class fromJSONArray:data error:&error];
    
    return items;
}


+ (NSValueTransformer *)defaultDateJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    } reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        NSDate *date = value;
        return @(date.timeIntervalSince1970);
    }];
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return nil; //child will implement
}


@end
