

(if you haven't already, take a look at our [welcome document](https://developer.feed.fm/docs/welcome)
that gives you an overview of the Feed.fm service and concepts)

The Feed.fm SDK centers around a singleton instance of the `FMAudioPlayer` class, which has simple
methods for selecting music stations and starting and stopping playback. The class emits events via
the `NSNotificationCenter` for easy monitoring. By default the `FMAudioPlayer` briefly displays
metadata about new songs as they start playback in the notification area of the iPhone. This
can be disabled by setting `FMAudioPlayer.disableSongStartNotifications` to false.

The feed.fm service can provide custom metadata in `FMStation` and `FMAudio` instances - see our
[metadata documentation](https://developer.feed.fm/docs/metadata) for more information.

The `*Button`, `*View`, and `*Label` classes are example UI elements that listen to `FMAudioPlayer` events
and update their state automatically. 
[Full source code](https://github.com/feedfm/iOS-SDK/tree/master/Sources) for these classes are available
on [github](https://github.com/feedfm/iOS-SDK/tree/master/Sources).

The [iOS RadioPlayer 2](https://github.com/feedfm/iOS-RadioPlayer-2) and
[iOS RadioPlayer](https://github.com/feedfm/iOS-RadioPlayer) projects on GitHub may be used as starting
points for full featured music UIs.

If you have questions or discover a bug, please contact support@feed.fm
