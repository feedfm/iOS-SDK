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
SIMULCAST_STATE_MUSIC_UNAVAILABLE
    
};

@protocol FMSimulcastDelegate

-(void) stateChanged : (FMSimulcastPlaybackState) state;

-(void) nextItemBegan : (FMAudioItem *_Nonnull) item;

-(void) elapse : (NSTimeInterval) elapseTime;

@end


@interface FMSimulcastStreamer : NSObject



@property (nonatomic) FMSimulcastPlaybackState streamState;

/**
 * Current item that we're trying to play
 */

@property (nonatomic, readonly)  FMAudioItem * _Nullable currentItem;


-(id _Nonnull ) initWithSimulcastToken : (NSString *_Nonnull) token
                          withDelegate : (id<FMSimulcastDelegate> _Nonnull) delegate;

-(void) registerStreamDelegate: (id<FMSimulcastDelegate> _Nonnull) delegate;

-(void) unregisterStreamDelegate: (id<FMSimulcastDelegate> _Nonnull) delegate;

@end
