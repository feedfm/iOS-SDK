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

@property (strong, nonatomic) FMAudioPlayer *feedPlayer;

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

- (void) setup {
 
#if !TARGET_INTERFACE_BUILDER
    _feedPlayer = [FMAudioPlayer sharedPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerUpdated:) name:FMAudioPlayerPlaybackStateDidChangeNotification object:_feedPlayer];
    
    [self addTarget:self action:@selector(onSkipClick) forControlEvents:UIControlEventTouchUpInside];
;
#endif
    
    [self updatePlayerState];
}

- (void) onSkipClick {
    [_feedPlayer skip];
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



@end
