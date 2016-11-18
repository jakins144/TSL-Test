//
//  ArtistDetailViewController.m
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SongDetailViewController.h"

@interface SongDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *addToNewPlayListButton;
@property (weak, nonatomic) IBOutlet UIButton *addToExistingPlaylistButton;
@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *songDetailImageView;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (IBAction)previewButtonAction:(id)sender;
- (IBAction)closeButtonAction:(id)sender;
- (IBAction)addToPlayListAction:(id)sender;

@end

@implementation SongDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.track) {

        NSDictionary *songArtistsDict = self.track.artists[0];
        
        NSArray *imageArray = self.track.album[@"images"];
        
        if (imageArray.count > 0) {
            NSDictionary *imageDict = imageArray[0];
            NSString *imageURLString = imageDict[@"url"];
            
            NSLog(@"image url: %@",imageURLString);
            
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLString]];
            self.songDetailImageView.image = [UIImage imageWithData:imageData];
        }
        
        self.trackNameLabel.text = self.track.trackName;
        self.artistNameLabel.text = songArtistsDict[@"name"];
    
        
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissChoice:)
                                                 name:@"songAdded"
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
        
        vc.trackURI = self.track.uri;
    
    }
}


#pragma mark - IBActions

- (IBAction)closeButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)previewButtonAction:(id)sender {
    if ( ![self.track.previewURL isEqual:[NSNull null]]) {
        [self playAudioFromURL:self.track.previewURL];
    }
    
}

- (IBAction)addToPlayListAction:(id)sender {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Create Playlist"
                                                                              message: @"Input the Playlist title"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"new play list title here";
        textField.textColor = [UIColor blueColor];
        textField.text = self.track.trackName;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];

    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * playlistTitleField = textfields[0];
        
        SpotifyServiceManager *sharedManager = [SpotifyServiceManager sharedManager];
        
        [sharedManager createPlaylistWithName:playlistTitleField.text andAddSong:self.track.uri];
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - assisting custom methods

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

- (void) dismissChoice:(NSNotification *) notification
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
