//
//  PlayListTableViewController.m
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "PlayListTableViewController.h"
#import "SongsTableViewController.h"

@interface PlayListTableViewController ()

@end

@implementation PlayListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadDataSource:)
                                                 name:@"playlistSet"
                                               object:nil];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];
    
    [sharedManager requestRefreshTokenAndGetPlaylist];
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
    
    return [self.playListsArray count];
}


- (void) reloadDataSource:(NSNotification *) notification
{
    self.playListsArray =  notification.userInfo[@"list"];
    
    [self.tableView reloadData];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary *playListDict = self.playListsArray[indexPath.row];
    
    cell.playListTitleLabel.text = playListDict[@"name"];
    
    
    cell.playListImageView.image = nil;
    NSArray *imageArray = playListDict[@"images"];
    
    
    if ([imageArray count] > 0) {
        NSDictionary *imageDict = imageArray[0];
        NSString *imageURLString = imageDict[@"url"];
        
        NSURL *url = [NSURL URLWithString:imageURLString];
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        PlayListTableViewCell *updateCell = (id)[tableView cellForRowAtIndexPath:indexPath];
                        if (updateCell)
                            updateCell.playListImageView.image = image;
                    });
                }
            }
        }];
        [task resume];
    }
    else
        cell.playListImageView.image = nil;
    
    
    NSDictionary *tracksDict = playListDict[@"tracks"];
    NSNumber* tracksTotal = tracksDict[@"total"];
    
    
    
    cell.songAmountLabel.text = [NSString stringWithFormat:@"%ld Songs", (long)[tracksTotal integerValue]];
    
    // Configure the cell...
    
    return cell;
}







#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"toSongList"])
    {
        SongsTableViewController *vc = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        vc.playListInfoDict = self.playListsArray[indexPath.row];
        
        
    }
    
    // vc.playListInfoDict =
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}




- (IBAction)createPlaylistAction:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Create Playlist"
                                                                              message: @"Input the Playlist title"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"new play list title here";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * playlistTitleField = textfields[0];
        
        SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];
        
        [sharedManager createPlaylistWithName:playlistTitleField.text];
        
        
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
