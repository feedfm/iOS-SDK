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
 * and time indexes. While some other
 * media is playing (workout audio, for example), this class can associate
 * an FMStation with the current time index in the other media. When this class
 * is told of the current time index in the other media, it will map that
 * time index to an FMStation and then make sure that is the active station
 * in the FMAudioPlayer. If music is currently playing and the station is
 * changed, then the music from the old station will be crossfaded with the
 * new song in the new station.
 */


@interface FMStationCrossfader : NSObject

/**
 * Create a new FMStationCrossfader instance. The station passed in is considered the
 * initial station for playback, and the switches is an array of time offsets and station
 * specifiers that indicate when the station should change. So this call:
 *
 * FMStationCrossfader *cf = [FMSTationCrossfade stationCrossfaderWithStation:@{ @"id": @"ABC123" },
 *                                               andSwitches: @[ 
 *                                                      5.0f, @{ @"id": @"DEF456" },
 *                                                      10.0f, @{ @"id": @"GHI789" }
 *                                               ]];
 *
 * would make the station with id ABC123 active from 0 seconds in to 5 seconds in, then
 * the station with id DEF456 active from 5 seconds to 10 seconds, then the station with
 * id GHI789 active from 10 seconds to the end of the song.
 *
 * Setting the intial station to nil means the player starts out paused until a station switch
 * is hit.
 */

+ (FMStationCrossfader *) stationCrossfaderWithInitialStation: (NSDictionary *) initialStationOptionKeysAndValues
                                                  andSwitches: (NSArray *) timeStationPairs;


- (void) appendStation: (NSDictionary *) optionKeysAndValues startingAtTime: (float) time;

/**
 * This resets the player, changes it to the first station that will play,
 * and starts queueing up the first song.
 */

- (void) connect;

/**
 * If the user hits pause while music is playing, then disconnect should be called to
 * prevent music from being started again.
 */

- (void) disconnect;

/**
 * If the user hits play again, then reconnect should be called so stations are updated
 * per the crossfade rules.
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
