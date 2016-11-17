//
//  TrackSearchTableViewController.h
//  TSL App Test
//
//  Created by Owner on 11/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotifyServiceManager.h"
#import "SongTableViewCell.h"
#import "SongDetailViewController.h"
#import "SPPlaylistTrack.h"
#import "SPTrack.h"
#import "CellConfigManager.h"
#import "ActivityIndicatorManager.h"

@interface TrackSearchTableViewController : UITableViewController<UISearchResultsUpdating, UISearchBarDelegate>

@end
