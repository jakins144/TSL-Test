//
//  SPSong.h
//  TSL App Test
//
//  Created by Owner on 11/16/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SPBaseItem.h"
#import "SPTrack.h"

@interface SPSong : SPBaseItem
@property (strong, nonatomic) NSString *addedAt;
@property (strong, nonatomic) NSDictionary *addedBy;
@property (strong, nonatomic) NSNumber *isLocal;
@property (strong, nonatomic) SPTrack *track;

@end
