//
//  FMSkipButton.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 3/10/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMSkipButton.h"
#import "FeedMedia/FMAudioPlayer.h"

@interface FMSkipButton ()

#if !TARGET_INTERFACE_BUILDER
@property (strong, nonatomic) FMAudioPlayer *feedPlayer;
#endif

@end

@implementation FMSkipButton

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

- (void) dealloc {
    
#if !TARGET_INTERFACE_BUILDER
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#endif
}

- (void) setup {
 
#if !TARGET_INTERFACE_BUILDER
    _feedPlayer = [FMAudioPlayer sharedPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerUpdated:) name:FMAudioPlayerPlaybackStateDidChangeNotification object:_feedPlayer];
    
    [self addTarget:self action:@selector(onSkipClick) forControlEvents:UIControlEventTouchUpInside];
;
    
    [self updatePlayerState];
    
#endif
}

#if !TARGET_INTERFACE_BUILDER

- (void) onSkipClick {
    [_feedPlayer skip];
}

- (void) playerUpdated: (NSNotification *)notification {
    [self updatePlayerState];
}

- (void) updatePlayerState {
    FMAudioPlayerPlaybackState newState = _feedPlayer.playbackState;
    
    switch (newState) {
        case FMAudioPlayerPlaybackStateRequestingSkip:
        case FMAudioPlayerPlaybackStateWaitingForItem:
        case FMAudioPlayerPlaybackStateComplete:
        case FMAudioPlayerPlaybackStateReadyToPlay:
            [self setEnabled:NO];
            break;
        case FMAudioPlayerPlaybackStatePaused:
        case FMAudioPlayerPlaybackStatePlaying:
        case FMAudioPlayerPlaybackStateStalled:
            [self setEnabled:YES];
            break;
    }
}

#endif

@end
