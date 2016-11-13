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

@interface SongsTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableDictionary *playListInfoDict;

@property (strong, nonatomic) NSMutableArray *listOfSongsArray;


@property (strong, nonatomic) NSMutableArray *imageCache;



@end
