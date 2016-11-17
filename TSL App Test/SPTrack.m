//
//  SPTrack.m
//  TSL App Test
//
//  Created by Owner on 11/16/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SPTrack.h"

@implementation SPTrack

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
             @"trackID"                 : @"id",
             @"trackName"               : @"name",
             @"album"                   : @"album",
             @"discNumber"              : @"disc_number",
             @"trackNumber"             : @"track_number",
             @"artists"                 : @"artists",
             @"href"                    : @"href",
             @"uri"                     : @"uri",
             @"popularity"              : @"popularity",
             @"previewURL"            : @"preview_url",
             @"availableMarkets"        : @"available_markets",
             @"type"                    : @"type",
             @"isExplicit"              : @"explicit",
             @"externalURLS"            : @"external_urls",
             @"externalIDS"             : @"external_ids"
             };
}

@end
