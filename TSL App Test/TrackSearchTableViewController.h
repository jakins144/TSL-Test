//
//  TrackSearchTableViewController.h
//  TSL App Test
//
//  Created by Owner on 11/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotifySingleton.h"
#import "SongTableViewCell.h"
#import "SongDetailViewController.h"

@interface TrackSearchTableViewController : UITableViewController<UISearchResultsUpdating, UISearchBarDelegate>

@property NSMutableArray *searchResults;
@property (strong, nonatomic) UISearchController *searchController;

@end
