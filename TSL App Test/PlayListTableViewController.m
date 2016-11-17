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

//@property (strong,nonatomic) SPPlaylist *playlist;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (strong,nonatomic) CellConfigManager * cellConfig;
@property (strong,nonatomic) ActivityIndicatorManager *indicator;

- (IBAction)createPlaylistAction:(id)sender;
@end

@implementation PlayListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.indicator  = [[ActivityIndicatorManager alloc]initWithView:self.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadDataSource:)
                                                 name:@"playlistSet"
                                               object:nil];
    
    //self.playlist = [[SPPlaylist alloc]init];
    self.cellConfig =[[CellConfigManager alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    SpotifyServiceManager *sharedManager = [SpotifyServiceManager sharedManager];
    [self.indicator startAnimating];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self.cellConfig configPlayListCellWithCell:cell andPlayListDict:self.playListsArray[indexPath.row] andTableView:tableView andIndexPath:indexPath];

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
        
        vc.playlist =[SPPlaylist itemFromJSONDictionary:self.playListsArray[indexPath.row]];

    }

}

#pragma mark - IBActions

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
        
        SpotifyServiceManager *sharedManager = [SpotifyServiceManager sharedManager];
        [self.indicator startAnimating];
        [sharedManager createPlaylistWithName:playlistTitleField.text];
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - assisting custom methods

- (void) reloadDataSource:(NSNotification *) notification
{
    self.playListsArray =  notification.userInfo[@"list"];
    [self.indicator stopAnimating];
    [self.tableView reloadData];
}
@end
