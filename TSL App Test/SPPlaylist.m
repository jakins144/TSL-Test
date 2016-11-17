//
//  SPPlaylist.m
//  TSL App Test
//
//  Created by Owner on 11/15/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SPPlaylist.h"

@implementation SPPlaylist




+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
             @"playlistID"          : @"id",
             @"public"              : @"public",
             @"snapshotID"          : @"snapshot_id",
             @"tracks"              : @"tracks",
             @"uri"                 : @"uri",
             @"href"                : @"href",
             @"owner"               : @"owner",
             @"type"                : @"type",
             @"collaborative"       : @"collaborative",
             @"images"              : @"images",
             @"externalURLS"        : @"external_urls",
             @"name"                : @"name"
             
             };
}



@end
