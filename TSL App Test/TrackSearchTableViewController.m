//
//  TrackSearchTableViewController.m
//  TSL App Test
//
//  Created by Owner on 11/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "TrackSearchTableViewController.h"

@interface TrackSearchTableViewController ()

@end

@implementation TrackSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadDataSource:)
                                                 name:@"searchSet"
                                               object:nil];
    
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    self.searchController.searchBar.delegate = self;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.searchResults count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 83;
}



- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];
    
    [sharedManager searchTrackWithText:searchString];
   
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}


- (void) reloadDataSource:(NSNotification *) notification
{
    self.searchResults =  notification.userInfo[@"list"];
    [self.tableView reloadData];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
//    NSDictionary *songDict = self.searchResults[indexPath.row];
    
    self.track = [SPTrack itemFromJSONDictionary:self.searchResults[indexPath.row]];
//    
//    
//    NSDictionary *songAlbumDict = songDict[@"album"];
//    
//    NSArray *songArtistsTopArray = songDict[@"artists"];
    
    NSDictionary *songArtistsDict = self.track.artists[0];
    
    
    cell.songImageView.image = nil; // or cell.poster.image = [UIImage imageNamed:@"placeholder.png"];
    
    NSArray *imageArray = self.track.album[@"images"];
    
    if ([imageArray count] > 0) {
        NSDictionary *imageDict = imageArray[0];
        NSString *imageURLString = imageDict[@"url"];
        
        NSURL *url = [NSURL URLWithString:imageURLString];
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        SongTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell)
                            updateCell.songImageView.image = image;
                    });
                }
            }
        }];
        [task resume];
    }
    else
        cell.songImageView.image = nil;
    
    cell.songTitleLabel.text = self.track.trackName;
    
    cell.albumTitleLabel.text = [NSString stringWithFormat:@"%@ * %@",songArtistsDict[@"name"], self.track.album[@"name"]];
    
    
    return cell;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toArtistDetail"])
    {
        SongDetailViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        vc.track = [SPTrack itemFromJSONDictionary:self.searchResults[indexPath.row]];
        vc.fromSearchScreen = YES;
        
    }
}

@end
