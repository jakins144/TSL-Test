//
//  CellConfigManager.h
//  TSL App Test
//
//  Created by Owner on 11/17/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayListTableViewCell.h"
#import "SongTableViewCell.h"
#import "SPPlaylist.h"
#import "SPPlaylistTrack.h"
#import "SPTrack.h"
#import  <YYWebImage/YYWebImage.h>


@interface CellConfigManager : NSObject


-(void)configPlayListCellWithCell:(PlayListTableViewCell*)cell andPlayListDict:(NSDictionary*)playListDict andTableView:(UITableView*)theTableView andIndexPath:(NSIndexPath*)theIndexPath;

-(void)configSongCellWithCell:(SongTableViewCell*)cell andSongDict:(NSDictionary*)songDict andTableView:(UITableView*)theTableView andIndexPath:(NSIndexPath*)theIndexPath;

-(void)configSongCellForSearchResultsWithCell:(SongTableViewCell*)cell andTrackDict:(NSDictionary*)trackDict andTableView:(UITableView*)theTableView andIndexPath:(NSIndexPath*)theIndexPath;

@end
