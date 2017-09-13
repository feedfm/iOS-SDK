
- v4.0.12
  - refactor layout of repository to properly support Carthage

- v4.0.11
  - remove support for pre-7.1 command center notifications
  - remove excessive remote command center registrations
  - update like/dislike status of different FMAudioItem instance with same audio item id
  - core library assertions updated to add more descriptive content to assist
    with crash debugging.

- v4.0.10
  - AVPlayerItem.playbackBufferEmpty is turning out to be unreliable, so
    stop using it.

- v4.0.9
  - properly mark FMStationButton as deprecated
  - FMAudioPlayer wasn't properly proxying volume of player
  - re-implemented 'isPreparedtoPlay', while also deprecating it
  - update stop() method to property reset player state
  - expose static method to map FMAudioPlayerPlaybackState to NSString

- v4.0.8
  - Add support for on-demand stations that provide list of FMAudioItems in FMStation
  - Add support for like/dislike/unlike of FMAudioItems not associated with a play
  - Add support for requesting playback of specific audio item.
  - Updated FMPlayPauseButton so it can attach to specific audio item.

- v4.0.7
  - we really support iOS 8.0+

- v4.0.6
  - emergency fix for last emergency fix - crash due to 'prepared' state not being
    re-initialized
  - add handling for AVAudioRouteChange and pause things when headphones are
    unplugged.

- v4.0.5
  - emergency fix for crash bug: AVPlayerItems are marked as 'ready' multiple times

- v4.0.4
  - fix core library bugs where song metadata was not being parsed correctly,
    and song trimming wasn't enabled.
  - deprecate FMStationButton and push its functionality into FMPlayPauseButton

- v4.0.3
  - iOS 9 support, and update to stop using deprecated functions in iOS 10.
  - fix bug where media center 'rate' wasn't properly set.
  - remove unused code that referenced MPMediaCenter and triggers app store
    privacy flags.
  - expose CWStatusBarNotification object for easier styling and management.

- v4.0.2
  - fix FMDislikeButton to update state when new FMAudioFile is assigned.
  - disable user interaction with equalizer

- v4.0.1
  - add new 'station' property to FMAudioFiles

- v4.0.0
  - notification bar now displays next song by default (was just a placeholder
    in beta2). This makes use of https://github.com/cezarywojcik/CWStatusBarNotification
    by Cezary Wojcik.
  - FMLikeButton and FMDislikeButton can be attached to a specific FMAudioItem
  - FMAudioPlayer now exports playHistory
  - FMAudioItem now exports metadata NSDictionary
  - FMPlayPauseButton can now switch to specific station when user hits play
    from idle or completed state

= v4.0.0-beta2
  - fix bug when setActiveStation repeatedly called with same station
  - fix FMStationButton to watch for state change, not song start change
  - add FMEqualizer for snazzy UI animation
  - update to newer MarqueeLabel version
  - allow FMPlayPauseButton to first tune to specific station when
    transitioning from idle (ready to play or playback complete) to playing
    state.
  - BREAKING CHANGE FROM 3.x: the player will now display a transient notification
    in the notification area of the screen when a new song starts unless
    disableSongStartNotifications has been set to YES in the FMAudioPlayer.

= v4.0.0-beta1
  - new methods and properties in FMAudioPlayer to support
    crossfading between songs (secondsOfCrossfade, crossfadeInEnabled,
    and setActiveStationByName:withCrossfade), with a
    rewrite of internal logic to support this.
  - server can now specify that the start and end audio for
    songs can be trimmed in order to skip slow intros or exits.
  - two new player states: FMAudioPlayerPlaybackStateUninitialized
    (which is the default state of the player) and 
    FMAudioPlayerPlaybackStateUnavailable (when the server has announced
    that this client cannot play any music [typically due to geo
    restrictions]).
  - FMAudioPlayerCurrentItemDidChangeNotification removed and replaced
    with the more-accurately named 
    FMAudioPlayerCurrentItemDidBeginPlaybackNotification.
  - new FMAudioPlayerMusicQueuedNotification notification announces when
    the player has audio data sitting in buffer and ready for immediate
    playback.
  - FMAudioPlayerNotAvailableNotification removed - instead watch for the 
    FMAudioPlayerPlaybackStateUnavailable state.
  - FMAudioPlayerStationListAvailableNotification removed.

= v3.0.7
  - add 'FMLockScreenDelegate' protocol to allow clients to customize
    lock screen management.

= v3.0.6
  - add 'doesHandleRemoteCommands' option to allow disabling of
    MPRemoteCommandCenter commands

= v3.0.5
  - Delay registering with the remote command center until 'play' is
    called.

= v3.0.4
  - When resuming app that has 'stop()'ed music, don't begin playback
    automatically.

= v3.0.3
  - Take 2 for the NSDateFormatter race condition

= v3.0.2
  - private library now with bitcode!

= v3.0.1
  - Report music invalidation reason back to server
  - New logic to deal with placement changes in the middle of a session
  - Add bugfix for possible NSDateFormatter race condition

= v3.0.0
  - Merge FeedMediaUI and FeedMedia pods into single FeedMedia pod

= v1.0.0
  - Split out ObjC and Swift subspecs. Use proper versioning. Technically
    the API hasn`t changed at all from v0.1.10

= v0.1.10
  - update to newer FeedMedia pod that improves Authorization fix

= v0.1.9
  - update to newer FeedMedia pod that fixes missing Authorization problem

= v0.1.8
  - yet another update to latest FeedMedia pod

= v0.1.7
  - update to latest FeedMedia pod, again again

= v0.1.6
  - update to latest FeedMedia pod, again

= v0.1.5
  - update to latest FeedMedia pod

= v0.1.4
  - added deploy scripts to automate/validate releases

= v0.1.3

  - added CHANGELOG
  - removed MarqueeLabel code and pointed to MarqueeLabel cocoapoa


