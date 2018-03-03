# FeedMedia

## Introduction

[Feed.fm](https://feed.fm/) is a service that allows you to add popular
music to your mobile app. The SDK hosted in this repository provides
you with simple UI components that you can adapt or use directly in your
app.

## Installation

You don't need to download this repository - you can use CocoaPods or
Carthage to add this to your app.

### CocoaPod

FeedMedia is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FeedMedia"
```

If you want to try out a sample app before installing, run

```bash
pod try FeedMedia
```

### Carthage

You can add this library via Carthage by adding the following to your CartFile:

```ruby
binary "https://demo.feed.fm/sdk/FeedMediaCore.framework.json"
```

.. and then integrate into your app the usual Carthage way.

### No package manager? No problem!

If you aren't using CocoaPods or Carthage but want to integrate this library in your
application, we suggest you clone this repository into a subdirectory
of your project and include all files in `Core/*` and `Sources/*`.

## Tell me more!

Creating a custom music station requires you to create an account on
[Feed.fm](https://feed.fm), but you can try out our sample app here
with the included demo credentials. You can also check out our fully
pre-built music players 
[here](https://github.com/feedfm/iOS-RadioPlayer) and 
[here](https://github.com/feedfm/iOS-RadioPlayer-2),
located on GitHub, that use this library.

## Author

Eric Lambrecht, eric@feed.fm

## License

FeedMedia is available under the MIT license. See the LICENSE.md file for more info.
