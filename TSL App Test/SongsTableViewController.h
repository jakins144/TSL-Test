//
//  SongsTableViewController.h
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotifySingleton.h"
#import "SongTableViewCell.h"
#import "SongDetailViewController.h"
#import "SPPlaylistTrack.h"
#import "SPTrack.h"
#import "SPPlaylist.h"
#import "CellConfigManager.h"

@interface SongsTableViewController : UITableViewController


@property (strong, nonatomic) SPPlaylist *playlist;

@property (strong, nonatomic) NSMutableArray *listOfSongsArray;




@end
