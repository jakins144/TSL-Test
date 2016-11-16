//
//  SPPlaylist.h
//  TSL App Test
//
//  Created by Owner on 11/15/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SPBaseItem.h"

@interface SPPlaylist : SPBaseItem

@property (strong, nonatomic) NSString *playlistID;
@property (strong, nonatomic) NSNumber *plublic;
@property (strong, nonatomic) NSString *snapshotID;

@property (strong, nonatomic) NSDictionary *tracks;
@property (strong, nonatomic) NSString *uri;
@property (strong, nonatomic) NSString *href;
@property (strong, nonatomic) NSDictionary *owner;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *collaborative;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSDictionary *externalURLS;
@property (strong, nonatomic) NSString *name;

@end
