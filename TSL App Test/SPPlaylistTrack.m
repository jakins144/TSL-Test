//
//  SPSong.m
//  TSL App Test
//
//  Created by Owner on 11/16/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SPPlaylistTrack.h"

@implementation SPPlaylistTrack

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"addedAt"          : @"added_at",
             @"addedBy"          : @"added_by",
             @"isLocal"          : @"is_local",
             @"track"            : @"track"
             };
}


+(NSValueTransformer*)promotionMessageJSONTransformer {
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:SPTrack.class];
}



@end
