//
//  CellConfigManager.m
//  TSL App Test
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "CellConfigManager.h"
@interface CellConfigManager()
@property (strong,nonatomic) SPPlaylist *playlist;
@property (strong, nonatomic) SPPlaylistTrack *song;
@property (strong, nonatomic) SPTrack *track;
@end

@implementation CellConfigManager

-(void)configPlayListCellWithCell:(PlayListTableViewCell*)cell andPlayListDict:(NSDictionary*)playListDict andTableView:(UITableView*)theTableView andIndexPath:(NSIndexPath*)theIndexPath
{
 
    self.playlist = [SPPlaylist itemFromJSONDictionary:playListDict];
    
    cell.playListTitleLabel.text = self.playlist.name;
    
    cell.playListImageView.image = nil;
    
    NSArray *imageArray = self.playlist.images;
    
    if ([imageArray count] > 0) {
        NSDictionary *imageDict = imageArray[0];
        NSString *imageURLString = imageDict[@"url"];
        
        NSURL *url = [NSURL URLWithString:imageURLString];
        
        [cell.playListImageView yy_setImageWithURL:url options: YYWebImageOptionSetImageWithFadeAnimation];
        

    }
    else
    cell.playListImageView.image = nil;
    
    NSDictionary *tracksDict = self.playlist.tracks;
    NSNumber* tracksTotal = tracksDict[@"total"];
    
    cell.songAmountLabel.text = [NSString stringWithFormat:@"%ld Songs", (long)[tracksTotal integerValue]];
}

-(void)configSongCellWithCell:(SongTableViewCell*)cell andSongDict:(NSDictionary*)songDict andTableView:(UITableView*)theTableView andIndexPath:(NSIndexPath*)theIndexPath
{
    self.song = [SPPlaylistTrack itemFromJSONDictionary:songDict];
    
    NSLog(@"%@", self.song.description);
    
    //  self.track = self.song.track;
    //NSDictionary *songDict = songTopDict[@"track"];
    
    // NSDictionary *songAlbumDict = songDict[@"album"];
    
    // NSArray *songArtistsTopArray = self.song.track.artists;
    
    NSDictionary *songArtistsDict = self.song.track.artists[0];
    
    cell.songImageView.image = nil;
    
    NSArray *imageArray = self.song.track.album[@"images"];
    
    if ([imageArray count] > 0) {
        NSDictionary *imageDict = imageArray[0];
        NSString *imageURLString = imageDict[@"url"];
        
        NSURL *url = [NSURL URLWithString:imageURLString];
        
        [cell.songImageView yy_setImageWithURL:url options: YYWebImageOptionSetImageWithFadeAnimation];

    }
    else
    cell.songImageView.image = nil;
    
    cell.songTitleLabel.text = self.song.track.trackName;
    
    cell.albumTitleLabel.text = [NSString stringWithFormat:@"%@ * %@",songArtistsDict[@"name"], self.song.track.album[@"name"]];
}

-(void)configSongCellForSearchResultsWithCell:(SongTableViewCell*)cell andTrackDict:(NSDictionary*)trackDict andTableView:(UITableView*)theTableView andIndexPath:(NSIndexPath*)theIndexPath
{
    
    self.track = [SPTrack itemFromJSONDictionary:trackDict];

    NSDictionary *songArtistsDict = self.track.artists[0];
    
    cell.songImageView.image = nil; // or cell.poster.image = [UIImage imageNamed:@"placeholder.png"];
    
    NSArray *imageArray = self.track.album[@"images"];
    
    if ([imageArray count] > 0) {
        NSDictionary *imageDict = imageArray[0];
        NSString *imageURLString = imageDict[@"url"];
        
        NSURL *url = [NSURL URLWithString:imageURLString];
        
        [cell.songImageView yy_setImageWithURL:url options: YYWebImageOptionSetImageWithFadeAnimation];

    }
    else
    cell.songImageView.image = nil;
    
    cell.songTitleLabel.text = self.track.trackName;
    
    cell.albumTitleLabel.text = [NSString stringWithFormat:@"%@ * %@",songArtistsDict[@"name"], self.track.album[@"name"]];
}

@end
