//
//  FMPlayPauseButton.m
//  UITests
//
//  Created by Eric Lambrecht on 3/6/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FeedMedia/FMAudioPlayer.h"
#import "FMPlayPauseButton.h"

@interface FMPlayPauseButton ()

#if !TARGET_INTERFACE_BUILDER
@property (strong, nonatomic) FMAudioPlayer *feedPlayer;
#endif

@end

@implementation FMPlayPauseButton

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
    
    [self addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
#endif
    
    [self updatePlayerState];
}

#if !TARGET_INTERFACE_BUILDER

- (void) onClick {
    if ((_feedPlayer.playbackState == FMAudioPlayerPlaybackStatePaused) ||
        (_feedPlayer.playbackState == FMAudioPlayerPlaybackStateReadyToPlay) ||
        (_feedPlayer.playbackState == FMAudioPlayerPlaybackStateComplete)) {
        [_feedPlayer play];
    } else {
        [_feedPlayer pause];
    }
}

- (void) playerUpdated: (NSNotification *)notification {
    [self updatePlayerState];
}

#endif

- (void) updatePlayerState {
    FMAudioPlayerPlaybackState newState;

#if !TARGET_INTERFACE_BUILDER
    newState = _feedPlayer.playbackState;
#else
    newState = FMAudioPlayerPlaybackStateReadyToPlay;
#endif
    
    // selected = YES = show the pause button
    // selected = NO = show the play button
    
    switch (newState) {
        case FMAudioPlayerPlaybackStateWaitingForItem:
            [self setSelected:YES];
            if (_hideWhenStalled) {
                [self setHidden:YES];
            }
            break;
        case FMAudioPlayerPlaybackStateReadyToPlay:
        case FMAudioPlayerPlaybackStatePaused:
            [self setSelected:NO];
            if (_hideWhenStalled) {
                [self setHidden:NO];
            }
            break;
        case FMAudioPlayerPlaybackStatePlaying:
            [self setSelected:YES];
            if (_hideWhenStalled) {
                [self setHidden:NO];
            }
            break;
        case FMAudioPlayerPlaybackStateStalled:
            [self setSelected:YES];
            if (_hideWhenStalled) {
                [self setHidden:YES];
            }
            break;
        case FMAudioPlayerPlaybackStateRequestingSkip:
            [self setSelected:YES];
            if (_hideWhenStalled) {
                [self setHidden:YES];
            }
            break;
        case FMAudioPlayerPlaybackStateComplete:
            [self setSelected:NO];
            if (_hideWhenStalled) {
                [self setHidden:NO];
            }
            break;
    }
}

@end
