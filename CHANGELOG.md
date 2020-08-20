- v4.4.3-beta6
 - Move to XCFrameworks
 - Add support for Mac Catalyst.
 - Add in Studio simulcast support.

- v4.4.2
 - Add disableAVAudioSession option to player.
 
- v4.4.1
 - Fix a bug with Airplay
 
- v4.4.0
 - Added autoNetworkRetryEnabled option to FMAudioPlayer. FMAudioPlayer will now by default keep retrying to play music in events of network failure. 
 - A callback to onUnavailable is no longer final. The player may call onAvailable at a later stage if the first failure was due to network issues. 

- v4.3.11
 -  bitcode enable on tvOS static lib

- v4.3.10
 - Fix for song start notifications on iOS 13 and notch
 
- v4.3.9
 - Added setBaseUrl api and more remote debugging capabilities. 
 - the default AVAudioSession options set in 4.3.7 disabled the 'now playing'
   controls. This release reverts back to the pre-4.3.7 settings.

- v4.3.8
 - Fix bug that caused crash in getClientId()
 
- v4.3.7
 - Default crossfade is now 5 seconds
 - Ensure call to UIApplicationState occurs in main thread
 - New setAVAudioSessionCategory:mode:options method to let clients
   assign AVAudioSession values different from our defaults.
 - Expose submitLogsForRemoteDebuggingWithLabel: method on FMAudioPlayer

- v4.3.7-beta2
 - Expose submitLogsForRemoteDebuggingWithLabel: method on FMAudioPlayer

- v4.3.7-beta1
 - Ensure call to UIApplicationState occurs in main thread
 - New setAVAudioSessionCategory:mode:options method to let clients
   assign AVAudioSession values different from our defaults.

- v4.3.6
 - Changes in how crossfading works and priority of remote crossfading.

- v4.3.5
 - Support for remote crossfade values.
 - Prevent throwing a nil value in NSDictionary (fix thanks to https://github.com/lucasnewman)

- v4.3.3
 - Update to fix small no of crashes caused by deprication of NSFileHandle methods's on iOS13
 
- v4.3.2
 - Assertion typo

- v4.3.1
 - Bug fix to reduce the no of songs skipped due to networking error. 

- v4.3.0
 - Stop call ends the active AVAudioSession and disables lockscreen controls. 
 - Setting doesHandleRemoteCommands to NO in FMAudioplayer will now prevent 
   all initialization and interaction with remote controls even if no lock
   screen delegate is set. Make sure to _not_ enable background audio
   capabilities if you set doesHandleRemoteCommands to NO.
 
- v4.2.9
 - Support for iOS13, upgrade the SDK version ASAP to 4.2.9 to avoid app crashes on iOS13

- v4.2.8
 - Added support for seeking
 - fixed bug caused due to calling play pause multiple times

- v4.2.7
  - Fix bad reference when reporting offline playback problem
  - Expose methods to retrieve client id for external storage

- v4.2.4 - v4.2.6
  - updates to internal build/deploy scripts
  - Carthage project fix
  
- v4.2.3
  - Added new parameters lastPlayStart and lastUpdated to FMStation

- v4.2.2 
  - Fixed a crash in crossfader.
  - Fixed a bug which would cause a few songs to not crossfade properly. 

- v4.2.1
  - Fixed VICache crash bug 
  - *bugfix* - client id was not being persisted between application runs, since 4.2.0

- v4.2.0
  - This is the first non-beta release of our SDK with offline playback support. See
    our [offline documentation](https://developer.feed.fm/docs/offline) for details
    on how this works.
  - We are deprecating the methods in `FMAudioPlayer` that let you search for stations
    (`getStationWithOptions`, `getStationWithOptionKey:Value:`, e.t.c.), and instead
    we've created a new subclass of NSArray 
    ([FMStationAray](http://feed.fm/sdk/docs/ios/latest/html/Classes/FMStationArray.html))
    that has methods to let you search for stations based on their metadata. The `FMAudioPlayer`
    properties `stationList`, `localOfflineStationList`, and `remoteOfflineStationList`
    implement that class.
  - whenAvailable:notAvailable: was holding on to its callbacks too long.

- v4.2.0-beta5
  - remove 'download completed' callback and just use 'progress' callback

- v4.2.0-beta4
  - damn FMStation reference bug wasn't fully solved

- v4.2.0-beta3
  - fix to deal with overlapping content in offline stations
  - FMAudioItems that have started playback should always have FMStation reference
  - ensure offline play queue holds dulicate FMAudioItem references

- v4.2.0-beta2
  - fix to activeStation not returning correct value
  - clarify how local and remote stations are related
  - methods to map local -> remote stations and vice versa
  - only allow download & sync of remote offline stations
  - delete local stations no longer appearing in remote station list

- v4.2.0-beta
  - support for offline station loading and playback
  - some documentation cleanup
  - FMAudioPlayer playHistory is now mutable!
  - new FMStationArray class holds methods for searching for stations based on 'option' metadata
  - more internal tests to validate things working properly
  - prepareStation calls handled automatically
 
- v4.1.5
  - Fix for 10.2 interruption bug.
  - Better handling of internal assertions
  - Debugging added for internal WaitingForItem bug

- v4.1.3
  - Fix for interaction between station crossfade and start trim
  
- v4.1.1
  - NSString category was causing issues with static archive
  
- v4.1.0
  - new prepareStations and prepareStations: methods to improve time to first audio

- v4.0.27
  - No, really add support for tvOS!

- v4.0.26
  - Add support for tvOS!

- v4.0.25
  - Add support for simulcast stations
  - follow-up calls to setClientToken:Secret: will reset the
    FMAudioPlayer's availability so future whenAvailable:notAvailable 
    calls will work again.

- v4.0.24
  - Tweak AVPlayers so that AirPlay doesn't cause them to fight for
    control.
  - Better handle and log when a song doesn't play to completion, for
    whatever reason.

- v4.0.23
  - Station crossfade wasn't taking into account volume normalization

- v4.0.22
  - Fix for crash when user hits skip after pausing during station crossfade

- v4.0.21
  - Core library apparently wasn't properly copied to public repro.

- v4.0.20
  - Volume normalization support for songs. You might notice max volume is a little
    lower than before - this allows us to raise the volume of quiet songs. If the
    volume won't get as high as you want, we can add a boost via server side options.
  - Fix for crash that occurs when you are crossfading between two songs and hit
    'skip'
  - Extra logic to detect when ramp up/down overlap

- v4.0.19
  - properly handle when a song notifies us that it is complete even though
    we've already paused it
  - more logging to narrow down avplayer death issue

- v4.0.18
  - validate crossfade and fade in/out times before passing off to AVMixing params
  - force song loading to be done serially to escape thread race conditions
  - improve crash reporting

- v4.0.17
  - prevent crash when fading-out song crosses fade out boundary multiple times
  - fix 'dislike' being recorded as a 'like'

- v4.0.16
  - update to FMStationCrossfader to handle volume adjustments

- v4.0.15
  - new getStationWithOptions: and getAllStationsWithOptions: calls to search
    for stations based on metadata
  - bugfix to apply volume change when crossfading is not turned on
  - handle race condition when av player item prep is cancelled
  - first revision of FMStationCrossfader to assist with cue-based station
    switching

- v4.0.14
  - re-enable bitcode generation for static libFeedMediaCore.a library

- v4.0.13
  - add new FMPlayer getStationWithOptionKey:Value: to search for a station with
    a given option key/value.
  - fixed internal compilation warning

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


