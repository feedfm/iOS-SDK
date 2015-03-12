//
//  FMActivityIndicator.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 3/11/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMActivityIndicator.h"

@interface FMActivityIndicator ()

#if !TARGET_INTERFACE_BUILDER
@property (strong, nonatomic) FMAudioPlayer *feedPlayer;
#endif

@end


@implementation FMActivityIndicator

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    
    return self;
}

- (id) init {
    if (self = [super init]) {
        [self setup];
    }
    
    return self;
}

#if !TARGET_INTERFACE_BUILDER

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#endif

- (void) setup {
#if !TARGET_INTERFACE_BUILDER
    _feedPlayer = [FMAudioPlayer sharedPlayer];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerUpdated:) name:FMAudioPlayerPlaybackStateDidChangeNotification object:_feedPlayer];
#endif
    
    [self updatePlayerState];
    
}

- (void) playerUpdated: (NSNotification *)notification {
    [self updatePlayerState];
}

- (void) updatePlayerState {
    FMAudioPlayerPlaybackState newState;
    
#if !TARGET_INTERFACE_BUILDER
    newState = _feedPlayer.playbackState;
#else
    newState = FMAudioPlayerPlaybackStatePlaying;
#endif
    
    switch (newState) {
        case FMAudioPlayerPlaybackStateReadyToPlay:
        case FMAudioPlayerPlaybackStatePaused:
        case FMAudioPlayerPlaybackStatePlaying:
        case FMAudioPlayerPlaybackStateComplete:
            [self stopAnimating];
            break;

        case FMAudioPlayerPlaybackStateWaitingForItem:
        case FMAudioPlayerPlaybackStateStalled:
        case FMAudioPlayerPlaybackStateRequestingSkip:
            [self startAnimating];
            break;
    }
}



@end
