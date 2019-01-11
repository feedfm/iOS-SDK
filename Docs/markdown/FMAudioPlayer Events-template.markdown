
The FMAudioPlayer class emits a number of events via NSNotificationCenter
to inform clients about what the player is doing. This document
lists those constants (defined in [FMaudioPlayer.h](https://github.com/feedfm/iOS-SDK/blob/master/Core/FMAudioPlayer.h#L28)).

## **FMAudioPlayerPlaybackStateDidChangeNotification**

  The FMAudioPlayer have changed it's playbackState property value.n
  The first time this event is emitted, the state
  of the player will be one of FMAudioPlayerPlabackStateUnavailable,
  FMAudioPlayerPlaybackStateReadyToPlay, or FMAudioPlayerPlaybackStateOfflineOnly.

## **FMAudioPlayerCurrentItemDidBeginPlaybackNotification**

  The FMAudioPlayer has started playback of a new song. This is only triggered
  once for any song (and not, for instance, after resuming playback from a pause).

## **FMAudioPlayerActiveStationDidChangeNotification**

The activeStation property of the FMAudioPlayer has just changed.

## **FMAudioPlayerSkipStatusNotification**

The canSkip property of the FMAudioPlayer has just changed.

## **FMAudioPlayerSkipFailedNotification**

A request to skip the current song has been denied by the feed.fm servers. Users
may skip up to 6 songs per hour per station. The FMAudioPlayer canSkip property
is a best guess as to whether the user may skip the current song - but the player
doesn't ultimately know until it asks the feed.fm servers for permission to
skip the current song.

## **FMAudioPlayerLikeStatusChangeNotification**

As the player advances from one song to the next, this notification announces when
the `like` status of the new song is different from the `like` status
of the previous song.

## **FMAudioPlayerTimeElapseNotification**

After every half second of music playback, this notification is triggered.

## **FMAudioPlayerPreCachingCompleted**

Upon initialization, the FMAudioPlayer tries to pre-load some data to speed up
song starts. This notification is triggered when that pre-loading has completed.

## **FMAudioPlayerNewClientIdAvailable**

This notification is triggered when the FMAudioPlayer has successfully generated a new unique
client id after a call to FMAudioPlayer createNewClientId

## **FMAudioPlayerStationDownloadProgress**

This notification is emitted during offline station downloading. This is the same event
passed to the delegate in FMAudioPlayer downloadAndSyncStation:withDelegate: . The userInfo
object contains NSNumber values for the keys `TotalDownloads`, `FailedDownloads`, and
`DownloadsPending`. For full documentation on offline station downloading and playback, see
[Offline Music Playback](https://developer.feed.fm/docs/offline).

