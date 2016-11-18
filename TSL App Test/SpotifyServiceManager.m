//
//  SpotifySingleton.m
//  TSL App Test
//
//  Created by Owner on 11/9/16.
//  Copyright © 2016 Josh Akins. All rights reserved.
//

#import "SpotifyServiceManager.h"

@interface SpotifyServiceManager ()
@property (strong,nonatomic) AFHTTPSessionManager *AFHTTPManager;
@property (strong,nonatomic) AFURLSessionManager *AFURLManager;
@end

@implementation SpotifyServiceManager

+ (id)sharedManager {
    static SpotifyServiceManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
        
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        self.AFHTTPManager = [AFHTTPSessionManager manager];
        self.AFURLManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return self;
}

#pragma mark - spotify network methods

-(void)requestTokenWithDict:(NSMutableDictionary*)codeDict
{
    NSString *codeForToken = [codeDict objectForKey:@"code"];
    NSString *urlString = [NSString stringWithFormat:@"%@api/token?grant_type=authorization_code&code=%@&client_id=%@&client_secret=%@&redirect_uri=tsl-app-test://", spotifyAccountsBaseURL, codeForToken, clientID, clientSecret];
    
    [self.AFHTTPManager POST:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        self.accessToken = responseObject[@"access_token"];
        self.refreshToken = responseObject[@"refresh_token"];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"TokensSet"
         object:self];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)requestRefreshTokenAndGetPlaylist
{
    NSString *urlString = [NSString stringWithFormat:@"%@api/token?grant_type=refresh_token&refresh_token=%@&client_id=%@&client_secret=%@&redirect_uri=tsl-app-test://", spotifyAccountsBaseURL, self.refreshToken, clientID, clientSecret];
    
    [self.AFHTTPManager POST:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        self.accessToken = responseObject[@"access_token"];
        
        [self retrievePlayLists];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)requestAuthorization
{
    NSString *urlString = [NSString stringWithFormat:@"%@authorize?client_id=%@&response_type=code&scope=playlist-modify-public playlist-read-private playlist-read-collaborative playlist-modify-private&redirect_uri=tsl-app-test://", spotifyAccountsBaseURL, clientID];
    
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *result = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url = [NSURL URLWithString: result];
    
    [[UIApplication sharedApplication] openURL:(NSURL*)url options:[[NSDictionary alloc]init] completionHandler:nil];
}

-(void)setupUserIDForPlaylists
{
    NSString *urlString = [NSString stringWithFormat:@"%@v1/me?access_token=%@", spotifyBaseURL, self.accessToken];
    
    [self.AFHTTPManager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        self.userID = responseObject[@"id"];
        
        [self retrievePlayLists];
        
        NSLog(@"JSON: %@", responseObject);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

-(void)retrievePlayLists
{
    if (!self.userID) {
        [self setupUserIDForPlaylists];
    }
    else{
        
        NSString *urlString = [NSString stringWithFormat:@"%@v1/users/%@/playlists?access_token=%@", spotifyBaseURL, self.userID , self.accessToken];
        
        [self.AFHTTPManager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            
            NSMutableArray *playlistArray = responseObject[@"items"];
            
            NSDictionary* userInfo =  @{@"list": playlistArray};
            
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"playlistSet"
             object:self userInfo:userInfo];
            
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
        
    }
}

-(void)searchTrackWithText:(NSString*)searchText
{
    searchText = [searchText stringByReplacingOccurrencesOfString:@" " withString: @"+"];
    searchText = [searchText stringByReplacingOccurrencesOfString:@"\"" withString: @"\%22"];
    NSString *urlString = [NSString stringWithFormat:@"%@v1/search/?q=%@&type=track&access_token=%@", spotifyBaseURL, searchText , self.accessToken];
    
    [self.AFHTTPManager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSDictionary *searchlistDict = responseObject[@"tracks"];
        
        NSArray *searchlistArray = searchlistDict[@"items"];
        
        NSDictionary* userInfo =  @{@"list": searchlistArray};
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"searchSet"
         object:self userInfo:userInfo];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"searchSet"
         object:self userInfo:nil];
    }];
    
}

-(void)getTracksWithURL:(NSString*)stringURL
{
    NSString *urlString = [NSString stringWithFormat:@"%@?access_token=%@", stringURL, self.accessToken];
    
    [self.AFHTTPManager GET:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        NSMutableArray *songlistArray = responseObject[@"items"];
        
        NSDictionary* userInfo =  @{@"list": songlistArray};
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"songlistSet"
         object:self userInfo:userInfo];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"songlistSet"
         object:self userInfo:nil];
    }];
}


-(void)addToPlayListWithTrackURI:(NSString*)stringURI andPlaylistID:(NSString*)playListID
{
    NSString *urlString = [NSString stringWithFormat:@"%@v1/users/%@/playlists/%@/tracks?uris=%@&access_token=%@", spotifyBaseURL, self.userID, playListID, stringURI, self.accessToken];
    
    [self.AFHTTPManager POST:urlString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        
        self.accessToken = responseObject[@"access_token"];
        
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"songAdded"
         object:self];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"songAdded"
         object:self];
    }];
}

-(void)createPlaylistWithName:(NSString*)playlistName
{
    NSString *urlString = [NSString stringWithFormat:@"%@v1/users/%@/playlists?access_token=%@", spotifyBaseURL, self.userID, self.accessToken];
    
    NSDictionary *body = @{@"name": playlistName};
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[self.AFURLManager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            [self requestRefreshTokenAndGetPlaylist];
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
    
}

-(void)createPlaylistWithName:(NSString*)playlistName andAddSong:(NSString*)trackURI
{
    NSString *urlString = [NSString stringWithFormat:@"%@v1/users/%@/playlists?access_token=%@", spotifyBaseURL, self.userID, self.accessToken];
    
    NSDictionary *body = @{@"name": playlistName};
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[self.AFURLManager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            
            NSDictionary *playListDict = responseObject;
            
            [self addToPlayListWithTrackURI:trackURI andPlaylistID:playListDict[@"id"]];
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
    
}

-(void)deleteTrackWtih:(NSString*)trackURI andPlaylistID:(NSString*)playListID andPositon:(NSNumber*)positionNumber
{
    NSString *urlString = [NSString stringWithFormat:@"%@v1/users/%@/playlists/%@/tracks?access_token=%@", spotifyBaseURL, self.userID, playListID, self.accessToken];
    
    NSDictionary *body = @{@"tracks": @[@{@"uri": trackURI, @"positions":@[positionNumber]}]};
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"DELETE" URLString:urlString parameters:nil error:nil];
    
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[self.AFURLManager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"Reply JSON: %@", responseObject);
            
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                //blah blah
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
        }
    }] resume];
    
}

@end
