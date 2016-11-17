//
//  TrackSearchTableViewController.m
//  TSL App Test
//
//  Created by Owner on 11/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "TrackSearchTableViewController.h"

@interface TrackSearchTableViewController ()

@property NSMutableArray *searchResults;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong,nonatomic) CellConfigManager * cellConfig;
@property (strong,nonatomic) ActivityIndicatorManager *indicator;
@property (strong, nonatomic) SPTrack *track;

@end

@implementation TrackSearchTableViewController

- (void)viewDidLoad {
    
    self.indicator  = [[ActivityIndicatorManager alloc]initWithView:self.view];
    
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
    
    self.cellConfig =[[CellConfigManager alloc]init];
  
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self.cellConfig configSongCellForSearchResultsWithCell:cell andTrackDict:self.searchResults[indexPath.row] andTableView:tableView andIndexPath:indexPath];
    
    return cell;
}

#pragma mark UISearch related methods

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    SpotifyServiceManager *sharedManager = [SpotifyServiceManager sharedManager];
    
    [self.indicator startAnimating];
    [sharedManager searchTrackWithText:searchString];
   
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchController];
}

#pragma mark - assisting custom methods

- (void) reloadDataSource:(NSNotification *) notification
{
    [self.indicator stopAnimating];
    self.searchResults =  notification.userInfo[@"list"];
    [self.tableView reloadData];
    
}

#pragma mark - Navigation

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
