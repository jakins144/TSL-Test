//
//  ChoosePlaylistViewController.m
//  TSL App Test
//
//  Created by Owner on 11/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "ChoosePlaylistViewController.h"

@interface ChoosePlaylistViewController ()

@end

@implementation ChoosePlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissChoice:)
                                                 name:@"songAdded"
                                               object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    SpotifyServiceManager *sharedManager = [SpotifyServiceManager sharedManager];
    
    NSDictionary* playListInfoDict = self.playListsArray[indexPath.row];
    
    NSLog(@"");
    
    [sharedManager addToPlayListWithTrackURI:self.trackURI andPlaylistID:playListInfoDict[@"id"]];
    
}

#pragma mark - assisting custom methods

- (void) dismissChoice:(NSNotification *) notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
