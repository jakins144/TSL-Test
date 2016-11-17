//
//  PlayListTableViewController.h
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotifyServiceManager.h"
#import "PlayListTableViewCell.h"
#import "SPPlaylist.h"
#import "CellConfigManager.h"
#import "ActivityIndicatorManager.h"

@interface PlayListTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray * playListsArray;

@end
