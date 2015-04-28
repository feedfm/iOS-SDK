//
//  FMProgressView.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 3/10/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMProgressView.h"
#import "FeedMedia/FMAudioPlayer.h"

#define kFMProgressBarUpdateTimeInterval 0.5

@interface FMProgressView () {
    NSTimer *_progressTimer;
}

#if !TARGET_INTERFACE_BUILDER
@property (strong, nonatomic) FMAudioPlayer *feedPlayer;
#endif

@end

@implementation FMProgressView

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
    
    [self updatePlayerState];

#else
    [self resetProgress];

#endif
}

#if !TARGET_INTERFACE_BUILDER

- (void) playerUpdated: (NSNotification *) notification {
    [self updatePlayerState];
}

- (void) updatePlayerState {
    FMAudioPlayerPlaybackState newState = _feedPlayer.playbackState;
    
    switch (newState) {
        case FMAudioPlayerPlaybackStateWaitingForItem:
        case FMAudioPlayerPlaybackStateReadyToPlay:
            [self resetProgress];
            [self cancelProgressTimer];
            break;
            
        case FMAudioPlayerPlaybackStateComplete:
        case FMAudioPlayerPlaybackStatePaused:
            [self updateProgress:nil];
            [self cancelProgressTimer];
            break;
            
        case FMAudioPlayerPlaybackStatePlaying:
            [self startProgressTimer];
            break;
            
        default:
            // nada
            break;
    }
}

- (void)startProgressTimer {
    [_progressTimer invalidate];
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:kFMProgressBarUpdateTimeInterval
                                                      target:self
                                                    selector:@selector(updateProgress:)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)updateProgress:(NSTimer *)timer {
    NSTimeInterval duration = _feedPlayer.currentItemDuration;
    if(duration > 0) {
        [super setProgress:(_feedPlayer.currentPlaybackTime / duration)
                                   animated: false];
    }
    else {
        [super setProgress: 0.0 animated:false];
    }
}

- (void)cancelProgressTimer {
    [_progressTimer invalidate];
    _progressTimer = nil;
}

#endif

- (void)resetProgress {
    [super setProgress: 0.0 animated:false];
}


@end

#undef kFMProgressBarUpdateTimeInterval

