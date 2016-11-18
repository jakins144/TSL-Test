//
//  SPTrack.h
//  TSL App Test
//
//  Created by Owner on 11/16/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SPBaseItem.h"

@interface SPTrack : SPBaseItem
@property (strong, nonatomic) NSString *trackID;
@property (strong, nonatomic) NSString *trackName;
@property (strong, nonatomic) NSDictionary *album;
@property (strong, nonatomic) NSNumber *discNumber;
@property (strong, nonatomic) NSNumber *trackNumber;
@property (strong, nonatomic) NSArray *artists;
@property (strong, nonatomic) NSString *href;
@property (strong, nonatomic) NSString *uri;
@property (strong, nonatomic) NSNumber *popularity;
@property (strong, nonatomic) NSArray *availableMarkets;
@property (strong, nonatomic) NSString *previewURL;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSNumber *isExplicit;
@property (strong, nonatomic) NSDictionary *externalURLS;
@property (strong, nonatomic) NSDictionary *externalIDS;
@end
