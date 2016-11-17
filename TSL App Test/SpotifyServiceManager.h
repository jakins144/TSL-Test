//
//  SpotifySingleton.h
//  TSL App Test
//
//  Created by Owner on 11/9/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Constants.h"

@interface SpotifyServiceManager : NSObject
+ (id)sharedManager;

@property (strong,nonatomic) NSString *accessToken;
@property (strong,nonatomic) NSString *refreshToken;
@property (strong,nonatomic) NSString *userID;

-(void)requestAuthorization;
-(void)requestRefreshTokenAndGetPlaylist;
-(void)requestTokenWithDict:(NSMutableDictionary*)codeDict;
-(void)retrievePlayLists;
-(void)setupUserIDForPlaylists;
-(void)getTracksWithURL:(NSString*)stringURL;
-(void)searchTrackWithText:(NSString*)searchText;
-(void)addToPlayListWithTrackURI:(NSString*)stringURI andPlaylistID:(NSString*)playListID;
-(void)createPlaylistWithName:(NSString*)playlistName;
-(void)createPlaylistWithName:(NSString*)playlistName andAddSong:(NSString*)trackURI;
-(void)deleteTrackWtih:(NSString*)trackURI andPlaylistID:(NSString*)playListID andPositon:(NSNumber*)positionNumber;
@end
