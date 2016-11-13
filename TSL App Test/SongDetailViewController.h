//
//  ArtistDetailViewController.h
//  TSL App Test
//
//  Created by Owner on 11/10/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosePlaylistViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface SongDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *addToNewPlayListButton;
@property (weak, nonatomic) IBOutlet UIButton *addToExistingPlaylistButton;


@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *artistNameLabel;

@property (strong, nonatomic) NSDictionary *topSongDict;

@property (weak, nonatomic) IBOutlet UIImageView *songDetailImageView;

@property (weak, nonatomic) IBOutlet UIButton *addToPlayList;

@property (strong, nonatomic) NSString* trackURI;

@property (strong, nonatomic) NSString* previewURL;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (IBAction)previewButtonAction:(id)sender;
- (IBAction)closeButtonAction:(id)sender;

- (IBAction)addToPlayListAction:(id)sender;

@property BOOL fromSearchScreen;

@end
