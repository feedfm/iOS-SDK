

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


