//
//  PlayListTableViewController.h
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpotifySingleton.h"
#import "PlayListTableViewCell.h"

@interface PlayListTableViewController : UITableViewController

@property (strong,nonatomic) NSMutableArray * playListsArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
- (IBAction)createPlaylistAction:(id)sender;

@end
