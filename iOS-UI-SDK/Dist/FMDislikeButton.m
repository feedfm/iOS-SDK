//
//  FMDislikeButton.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 3/10/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMDislikeButton.h"
#import "FeedMedia/FMAudioPlayer.h"

@interface FMDislikeButton ()

@property (strong, nonatomic) FMAudioPlayer *feedPlayer;

@end

@implementation FMDislikeButton

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerUpdated:) name:FMAudioPlayerLikeStatusChangeNotification object:_feedPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerUpdated:) name:FMAudioPlayerCurrentItemDidChangeNotification object:self.feedPlayer];
    
    [self addTarget:self action:@selector(onDislikeClick) forControlEvents:UIControlEventTouchUpInside];
    ;
#endif
    
    [self updatePlayerState];
}

#if !TARGET_INTERFACE_BUILDER
- (void) onDislikeClick {
    BOOL disliked = _feedPlayer.currentItem.disliked;
    
    if (disliked) {
        [_feedPlayer unlike];
    } else {
        [_feedPlayer dislike];
    }
    
    [self updatePlayerState];
}
#endif

- (void) playerUpdated: (NSNotification *)notification {
    [self updatePlayerState];
}

- (void) updatePlayerState {
    FMAudioPlayerPlaybackState newState;
    BOOL disliked;
    
#if !TARGET_INTERFACE_BUILDER
    newState = _feedPlayer.playbackState;
    disliked = _feedPlayer.currentItem.disliked;
#else
    newState = FMAudioPlayerPlaybackStatePlaying;
    disliked = NO;
#endif
    
    switch (newState) {
        case FMAudioPlayerPlaybackStatePaused:
        case FMAudioPlayerPlaybackStatePlaying:
            self.enabled = YES;
            self.selected = disliked;
            break;
        case FMAudioPlayerPlaybackStateStalled:
        case FMAudioPlayerPlaybackStateRequestingSkip:
            break;
        case FMAudioPlayerPlaybackStateReadyToPlay:
        case FMAudioPlayerPlaybackStateWaitingForItem:
        case FMAudioPlayerPlaybackStateComplete:
            self.enabled = NO;
            self.selected = NO;
    }
}

@end
