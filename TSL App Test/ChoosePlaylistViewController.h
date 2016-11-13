//
//  ChoosePlaylistViewController.h
//  TSL App Test
//
//  Created by Owner on 11/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "PlayListTableViewController.h"
#import "SpotifySingleton.h"
#import "AppDelegate.h"

@interface ChoosePlaylistViewController : PlayListTableViewController

@property (strong, nonatomic) NSString* trackURI;

@end
