//
//  ChoosePlaylistViewController.h
//  TSL App Test
//
//  Created by Owner on 11/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "PlayListTableViewController.h"
#import "SpotifyServiceManager.h"
#import "AppDelegate.h"
#import "ActivityIndicatorManager.h"

@interface ChoosePlaylistViewController : PlayListTableViewController

@property (strong, nonatomic) NSString* trackURI;

@end
