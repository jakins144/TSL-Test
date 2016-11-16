//
//  SPBaseItem.h
//  TSL App Test
//
//  Created by Owner on 11/15/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface SPBaseItem : MTLModel <MTLJSONSerializing>
+ (instancetype)itemFromJSONDictionary:(NSDictionary *)data;
+ (NSArray *)itemsFromJSONDictionary:(NSArray *)data;
+ (NSValueTransformer *)defaultDateJSONTransformer;

@end
