# TSL-Test
iOS app based on the TSL Spotify assignment.

# About Project 

This app allows a user to login to Spotify. After a user is logged in, the app will display a list of playlists from the user's Spotify account. From here a user can create a new playlist, search for tracks to add to a new or existing playlist, see details about the track, delete a track from one of their playlists and listen to a preview of the track. This app does not use the official Spotify iOS SDK but uses purely the Spotify Web API. AFNetworking is used to make network calls to the Web API, Mantle is used for JSON serialization into model classes, and YYWebImage is used to asynchronously download and load images. 

## Getting Started

Checkout or download the project. To compile TSL App Test you must run the command "pod install" from the terminal in the project directory in order to install the dependencies for AFNetworking, Mantle, and YYWebImage via Cocoapods. Then open the project in Xcode with the .xcworkspace file.
