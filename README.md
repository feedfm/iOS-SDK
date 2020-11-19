# FeedMedia

## Introduction

[Feed.fm](https://feed.fm/) is a service that allows you to add popular
music to your mobile app. The SDK hosted in this repository provides
you with simple UI components that you can adapt or use directly in your
app.

## Installation

You don't need to download this repository - you can use CocoaPods to add this to your app.

### CocoaPod

FeedMedia is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FeedMedia"
```

### Carthage

Carthage is no longer updated because it does not support XCFrameworks just yet, but you can still get the last published version via Carthage by adding the following to your CartFile:

```ruby
github "feedfm/iOS-SDK"
```

.. and then integrate into your app the usual Carthage way. 

### Swift Package Manager

From Xcode 12, you can use [Swift Package Manager](https://swift.org/package-manager/) to add Feed Media to your project.

0. Select File > Swift Packages > Add Package Dependency. Enter `https://github.com/feedfm/iOS-SDK` in the "Choose Package Repository" dialog.
0. In the next page, specify the version resolving rule as "Up to Next Major" with "4.4.13" as its earliest version.
0. After Xcode checking out the source and resolving the version, you can choose the "FeedMedia" library and add it to your app target.

### No package manager? No problem!

If you aren't using CocoaPods or Carthage but want to integrate this
library in your application, do the following:

- Clone this repository and drag FeedMedia.xcframeworks folder into frameworks and libraries section of your project. That's it!
- Optionally you could also add dSYMs files manually.

## Getting started

The SDK centers around a singleton instance of this `FMAudioPlayer` class, which has simple methods to control music playback (play, pause, skip). The FMAudioPlayer holds a list of FMStation objects (stationList), one of which is always considered the active station (activeStation). Once music playback has begun, there is a current song (currentSong).

Typical initialization and setup is as follows:

As early as you can in your app’s lifecycle (preferably in your AppDelegate or initial ViewController) call
```Objective-C
[FMAudioPlayer setclientToken:@"demo" secret:@"demo"]
```
to asynchronously contact the feed.fm servers, validate that the client is in a location that can legally play music, and then retrieve a list of available music stations.

There are a number of sample credentials you can use to assist in testing your app out. Use one of the following strings for your token and secret to get the desired behavior:

`‘demo’ - 3 simple stations with no skip limits`

`‘badgeo’ - feed.fm will treat this client as if it were accessing from outside the US`

`‘counting’ - a station that just plays really short audio clips of a voice saying the numbers 0 through 9`

To receive notice that music is available or not available, use the whenAvailable:notAvailable: method call, which is guaranteed to call only one of its arguments as soon as music is deemed available or not:

```Objective-C
FMAudioPlayer *player = [FMAudioPlayer sharedPlayer];

[player whenAvailable:^{
  NSLog(@"music is available!");
  // .. do something, now that you know music is available

  // set player settings
  player.crossfadeInEnabled = true;
  player.secondsOfCrossfade = 4;
  [player play];

 } notAvailable: ^{
    NSLog(@"music is not available!");
    // .. do something, like leave music button hidden

 }];
 // Set Notifications for ex to listen for player events
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange:) name:FMAudioPlayerPlaybackStateDidChangeNotification object:[FMAudioPlayer sharedPlayer]];
```


## Tell me more!
Find Appledocs for SDK at [demo.Feed.fm](http://demo.feed.fm/sdk/docs/ios/latest/html/index.html)

Creating a custom music station requires you to create an account on
[Feed.fm](https://feed.fm), but you can try out our sample app here
with the included demo credentials. You can also check out our fully
pre-built music players
[RadioPlayer](https://github.com/feedfm/iOS-RadioPlayer) and
[Radioplayer 2](https://github.com/feedfm/iOS-RadioPlayer-2),
located on GitHub, that use this library.

## Bugs!

If you find a bug, please send an email to support@feed.fm with a description
and any information you have to help us reproduce it.

## Authors

[Eric Lambrecht](eric@feed.fm), [Arveen Kumar](arveen@feed.fm)


## License

FeedMedia is available under the MIT license. See the LICENSE.md file for more info.
