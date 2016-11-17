//
//  ChoosePlaylistViewController.m
//  TSL App Test
//
//  Created by Owner on 11/11/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "ChoosePlaylistViewController.h"

@interface ChoosePlaylistViewController ()

//@property (strong,nonatomic) ActivityIndicatorManager *indicator;

@end

@implementation ChoosePlaylistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   //  self.indicator  = [[ActivityIndicatorManager alloc]initWithView:self.view];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissChoice:)
                                                 name:@"songAdded"
                                               object:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    SpotifySingleton *sharedManager = [SpotifySingleton sharedManager];
    
    NSDictionary* playListInfoDict = self.playListsArray[indexPath.row];
    
    
    NSLog(@"");
    
    [sharedManager addToPlayListWithTrackURI:self.trackURI andPlaylistID:playListInfoDict[@"id"]];
    
}

- (void) dismissChoice:(NSNotification *) notification
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


@end
