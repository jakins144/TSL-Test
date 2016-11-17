//
//  SongsTableViewController.m
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SongsTableViewController.h"

@interface SongsTableViewController ()

@property (strong, nonatomic) SPPlaylistTrack *song;

@property (strong,nonatomic) CellConfigManager * cellConfig;
@property (strong,nonatomic) ActivityIndicatorManager *indicator;

@end

@implementation SongsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indicator  = [[ActivityIndicatorManager alloc]initWithView:self.view];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadDataSource:)
                                                 name:@"songlistSet"
                                               object:nil];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.cellConfig =[[CellConfigManager alloc]init];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSDictionary *tracksDict = self.playlist.tracks;
    
    [self.indicator startAnimating];
    SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];
    
    [sharedManager getTracksWithURL:tracksDict[@"href"]];

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
    
    return [self.listOfSongsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self.cellConfig configSongCellWithCell:cell andSongDict:self.listOfSongsArray[indexPath.row] andTableView:tableView andIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];

        self.song = [SPPlaylistTrack itemFromJSONDictionary:self.listOfSongsArray[indexPath.row]];

        NSNumber *positionNumb = [[NSNumber alloc]initWithLong:indexPath.row];
        
        [sharedManager deleteTrackWtih:self.song.track.uri andPlaylistID:self.playlist.playlistID andPositon:positionNumb];
        
        [self.listOfSongsArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]                         withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing)
    {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - assisting custom methods

- (void) reloadDataSource:(NSNotification *) notification
{
    NSArray* listArray = notification.userInfo[@"list"];
    self.listOfSongsArray =  listArray.mutableCopy;
    [self.indicator stopAnimating];
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toArtistDetail"])
    {
        SongDetailViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        self.song = [SPPlaylistTrack itemFromJSONDictionary:self.listOfSongsArray[indexPath.row]];
        
        vc.track = self.song.track;
        
        
    }
}

@end
