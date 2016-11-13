//
//  ArtistDetailViewController.m
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SongDetailViewController.h"

@interface SongDetailViewController ()

@end

@implementation SongDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ;
    

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissChoice:)
                                                 name:@"songAdded"
                                               object:nil];
    if (self.topSongDict) {
        NSDictionary *songDict = nil;
        if (self.fromSearchScreen) {
            songDict = self.topSongDict;
        }
        else
            songDict = self.topSongDict[@"track"];
        
        self.trackURI = songDict[@"uri"];
        
        self.previewURL = songDict[@"preview_url"];
       
        NSDictionary *songAlbumDict = songDict[@"album"];

        
        
        NSArray *songArtistsTopArray = songDict[@"artists"];
        
        NSDictionary *songArtistsDict = songArtistsTopArray[0];
        
        
        NSArray *imageArray = songAlbumDict[@"images"];
        
        if (imageArray.count > 0) {
            NSDictionary *imageDict = imageArray[0];
            NSString *imageURLString = imageDict[@"url"];
            
            NSLog(@"image url: %@",imageURLString);
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]];
            self.songDetailImageView.image = [UIImage imageWithData:imageData];
        }
        
        self.trackNameLabel.text = songDict[@"name"];
        self.artistNameLabel.text = songArtistsDict[@"name"];
        
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toChoose"])
    {
        ChoosePlaylistViewController *vc = [segue destinationViewController];
        
        
        vc.trackURI = self.trackURI;
        
        
    }
}

- (void) dismissChoice:(NSNotification *) notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)closeButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)previewButtonAction:(id)sender {
    if ( ![self.previewURL isEqual:[NSNull null]]) {
        [self playAudioFromURL:self.previewURL];
    }
    
}

- (IBAction)addToPlayListAction:(id)sender {
    
    NSDictionary *songDict = nil;
    if (self.fromSearchScreen) {
        songDict = self.topSongDict;
    }
    else
        songDict = self.topSongDict[@"track"];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Create Playlist"
                                                                              message: @"Input the Playlist title"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"new play list title here";
        textField.textColor = [UIColor blueColor];
        textField.text = songDict[@"name"];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];

    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * playlistTitleField = textfields[0];
        
        SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];
        
        [sharedManager createPlaylistWithName:playlistTitleField.text andAddSong:self.trackURI];
        
        
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


-(void)playAudioFromURL:(NSString*)songURL
{
    NSString* resourcePath = songURL; //your url
    NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
    NSError *error;
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:_objectData error:&error];
    self.audioPlayer.numberOfLoops = 0;
    self.audioPlayer.volume = 1.0f;
    [self.audioPlayer prepareToPlay];
    
    if (self.audioPlayer == nil)
        NSLog(@"%@", [error description]);
    else
        [self.audioPlayer play];
    
}
@end
