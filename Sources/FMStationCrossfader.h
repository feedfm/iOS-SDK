//
//  FMStationCrossfader.h
//  FeedMedia
//
//  Created by Eric Lambrecht on 9/21/17.
//  Copyright © 2017 Feed Media. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This class keeps a list of FMStations (specified by metadata key/value pairs)
 * and time indexes. While some other media is playing (workout audio, for example),
 * this class can switch different FMStations at specified cue points.
 * If music is currently playing and the station is changed, then the music from 
 * the old station will be crossfaded with the new song in the new station.
 *
 * The general pattern here is to create an instance of this class with the
 * cue points you care about:
 *
 * FMStationCrossfader *cf = [FMSTationCrossfade stationCrossfaderWithInitialStation:@{ @"bpm": @"slow" },
 *                                               andSwitches: @[
 *                                                      5.0f, @{ @"bpm": @"medium" },
 *                                                      10.0f, @{ @"bpm": @"high" }
 *                                               ]];
 *
 * then, just before starting your external media, call connect so this class
 * updates the global music player:
 *
 * [cf connect];
 *
 * then, as your external media elapses, inform the station crossfader:
 *
 * [cf elapseToTime: _externalMediaPlayer.currentElapsedTime]
 *
 * If the user pauses playback of music then call [cf disconnect] so that music
 * stays paused until the user turns it back on again. When the user wants to
 * resume playback, call [cf reconnect].
 */

@interface FMStationCrossfader : NSObject

/**
 * Create a new FMStationCrossfader instance. The station passed in is considered the
 * initial station for playback, and the switches is an array of time offsets and station
 * specifiers that indicate when the station should change. 
 *
 * This call:
 *
 *   FMStationCrossfader *cf = [FMSTationCrossfade stationCrossfaderWithInitialStation:@{ @"bpm": @"slow" },
 *                                               andSwitches: @[ 
 *                                                      5.0f, @{ @"bpm": @"medium" },
 *                                                      10.0f, @{ @"bpm": @"high" }
 *                                               ]];
 *
 * would make the station with 'slow' bpm active from 0 seconds in to 5 seconds in, then
 * the station with 'medium' bpm active from 5 seconds to 10 seconds, then the station with
 * 'high' bpm active from 10 seconds to the end of the song.
 *
 * Setting the intial station to nil means the player starts out paused until a station switch
 * is hit.
 *
 * @param initialStationOptionKeysAndValues a set of key/value pairs that will be passed to
 *      FMAudioPlayer getStationWithOptionKey:Value: to get the intial station for playback
 * @param timeStationPairs an array that holds alternating NSFloats that specify time cue points and
 *       NSDictionarys that specify station searches suitable for FMAudioPlayer getStationWithOptionKey:Value:
 * @return a new FMStationCrossfader object
 */

+ (FMStationCrossfader *) stationCrossfaderWithInitialStation: (NSDictionary *) initialStationOptionKeysAndValues
                                                  andSwitches: (NSArray *) timeStationPairs;

/**
 * Create a new FMStationCrossfader instance with a default station. Station switches can be
 * added with the playStation:startingAtItem method.
 *
 * @param initialStationOptionKeysAndValues a set of key/value pairs that will be passed to
 *      FMAudioPlayer getStationWithOptionKey:Value: to get the intial station for playback
 * @return a new FMStationCrossfader object
 */

+ (FMStationCrossfader *) stationCrossfaderWithInitialStation: (NSDictionary *) initialStationOptionKeysAndValues;

/**
 * Specify that the station specified by optionKeysAndValues should be active starting
 * at the given time.
 *
 * Calls to this method must be made before calling 'connect'
 *
 * @param optionKeysAndValues a set of key/value pairs that will be passed to
 *      FMAudioPlayer getStationWithOptionKey:Value: to find a station
 * @param time the time at which the named station should become active.
 */

- (void) playStation: (NSDictionary *) optionKeysAndValues startingAtTime: (float) time;

/**
 * This resets the player, changes the active station to the initial station
 * and starts queueing up the first song.
 */

- (void) connect;

/**
 * If the user hits pause while music is playing, then disconnect should be called to
 * prevent this class from updating playback until the user resumes music playback.
 */

- (void) disconnect;

/**
 * If the user hits play after disconnecting, then reconnect should be called so 
 * stations are updated by this class again.
 */

- (void) reconnect;

/**
 * This call causes the active station in the shared FMAudioPlayer to be updated to match
 * the station that should be active at `time`. This method should be called at regular intervals
 * while the external media is playing.
 *
 * @param time current number of seconds elapsed in external media.
 */

- (void) elapseToTime: (float) time;

@end

