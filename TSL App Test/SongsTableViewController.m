//
//  SongsTableViewController.m
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SongsTableViewController.h"

@interface SongsTableViewController ()

@end

@implementation SongsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadDataSource:)
                                                 name:@"songlistSet"
                                               object:nil];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSDictionary *tracksDict = self.playListInfoDict[@"tracks"];
    
    
    SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];
    
    [sharedManager getTracksWithURL:tracksDict[@"href"]];
    
    NSLog(@"%@", tracksDict.description);
    
    NSLog(@"");
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
    
    
    
    NSDictionary *songTopDict = self.listOfSongsArray[indexPath.row];
    
    NSDictionary *songDict = songTopDict[@"track"];
    
    NSDictionary *songAlbumDict = songDict[@"album"];
    
    NSArray *songArtistsTopArray = songDict[@"artists"];
    
    NSDictionary *songArtistsDict = songArtistsTopArray[0];
    
    
    
    
    cell.songImageView.image = nil;
    
    NSArray *imageArray = songAlbumDict[@"images"];
    
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
    
    
    
    cell.songTitleLabel.text = songDict[@"name"];
    
    cell.albumTitleLabel.text = [NSString stringWithFormat:@"%@ * %@",songArtistsDict[@"name"], songAlbumDict[@"name"]];
    
    
    // Configure the cell...
    
    return cell;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];
        NSDictionary *songTopDict = self.listOfSongsArray[indexPath.row];
        
        NSDictionary *songDict = songTopDict[@"track"];
        NSNumber *positionNumb = [[NSNumber alloc]initWithLong:indexPath.row];
        
        [sharedManager deleteTrackWtih:songDict[@"uri"] andPlaylistID:self.playListInfoDict[@"id"] andPositon:positionNumb];
        
        
        
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





- (void) reloadDataSource:(NSNotification *) notification
{
    NSArray* listArray = notification.userInfo[@"list"];
    self.listOfSongsArray =  listArray.mutableCopy;
    
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toArtistDetail"])
    {
        SongDetailViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        vc.topSongDict = self.listOfSongsArray[indexPath.row];
        
        
    }
}


@end
