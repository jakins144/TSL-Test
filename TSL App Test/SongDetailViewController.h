//
//  ArtistDetailViewController.h
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosePlaylistViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SPTrack.h"

@interface SongDetailViewController : UIViewController

@property (strong, nonatomic) SPTrack *track;

@property BOOL fromSearchScreen;

@end
