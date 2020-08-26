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


typedef NS_ENUM(NSInteger, FMSimulcastPlaybackState) {

SIMULCAST_STATE_IDLE,

SIMULCAST_STATE_PLAYING,

SIMULCAST_STATE_STOPPED,

SIMULCAST_STATE_STALLED,

SIMULCAST_STATE_WAITING_FOR_ITEM,

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
*/

-(void) nextItemBegan : (FMAudioItem *_Nonnull) item;

/**
 * Elapse event for updating the playback time
*/
-(void) elapse : (CMTime) elapseTime;


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
 * Listens to the state of an in-Studio stream and fetch metadata etc. No local playback.
 */
-(id _Nonnull ) initSimulcastListenerWithToken : (NSString *_Nonnull) token
                          withDelegate : (id<FMSimulcastDelegate> _Nonnull) delegate;

/**
 * Generates a player using the token and plays the stream locally.
 */
-(id _Nonnull) initSimulcastPlayerWithToken: (NSString* _Nonnull) simulcastToken withDelegate:(id<FMSimulcastDelegate> _Nonnull)delegate ;

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
