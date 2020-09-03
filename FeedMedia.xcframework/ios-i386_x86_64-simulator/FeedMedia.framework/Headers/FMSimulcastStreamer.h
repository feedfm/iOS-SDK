//
//  Header.h
//  FeedMediaCore
//
//  Created by Arveen kumar on 8/11/20.
//  Copyright © 2020 Feed Media. All rights reserved.
//

#ifndef FMSimulcastPlayer_h
#define FMSimulcastPlayer_h


#endif /* FMSimulcastPlayer_h */

#import <Foundation/Foundation.h>
#import "FMAudioItem.h"

/**
 * Playback state of Simulcast player
 */
typedef NS_ENUM(NSInteger, FMSimulcastPlaybackState) {

    /**
     * Idle state.
     */
    SIMULCAST_STATE_IDLE,

    /**
     * Playing
     */
    SIMULCAST_STATE_PLAYING,
    /**
     * Playback has been stopped
     */
    SIMULCAST_STATE_STOPPED,
    /**
     * Player is stalled and waiting for data from the stream
     */
    SIMULCAST_STATE_STALLED,
    /**
     * Music unavailable and should not be played for this user.
     */
    SIMULCAST_STATE_MUSIC_UNAVAILABLE
    
};

/**
 * Delegate that should be implemented for simulcast streaming either in Studio or Overlay.
 * The methods update the status of the player.
 */
@protocol FMSimulcastDelegate

/**
 * State of the Player has changed
 */
-(void) stateChanged : (FMSimulcastPlaybackState) state;

/**
 * Current playing item has changed
 *  @Paramater item The next item
*/

-(void) nextItemBegan : (FMAudioItem *_Nonnull) item;

/**
 * Elapse event for updating the playback time
*/
-(void) elapse : (CMTime) elapseTime;

/**
 * Elapse event for updating the playback time
*/
-(void) onError : (NSString* _Nullable) error;



@end

/**
 * This class deals with Simulcast streaming and can be directly initialized and used independently of the FMAudioPlayer with just a token.
 */
@interface FMSimulcastStreamer : NSObject

/**
 * Current State of the Player.
 */

@property (nonatomic) FMSimulcastPlaybackState state;

/**
 * Current item that we're trying to play
 */

@property (nonatomic)  FMAudioItem * _Nullable currentItem;


/**
 * Set or retrieve the audio volume, only works with local player.
 */

@property (nonatomic) float volume;

/**
 * Initalize  the Simulcast streamer
 * @parameter token : simulcast token
 * @parameter delegate : The delegate for listening to events from simulcast player
 * @parameter isPlayer : if YES then streamer use a  player and plays the stream locally. if NO is passed the Streamer listens to the state of an in-Studiostream and fetchs metadata etc. No local playback.
 *
 */
-(id _Nonnull) initSimulcastListenerWithToken : (NSString *_Nonnull) token
                          withDelegate : (id<FMSimulcastDelegate> _Nonnull) delegate
                          playLocalStream : (BOOL) isLocal;

/**
 * Regester another delegate to listen to stream events
 */
-(void) registerDelegate: (id<FMSimulcastDelegate> _Nonnull) delegate;

/**
 * Remove a registered delegate
 */

-(void) unregisterDelegate: (id<FMSimulcastDelegate> _Nonnull) delegate;

/**
 * Begin playback
 */

- (void) play;

/**
 * Stop playback
 */

- (void) stop;

@end
