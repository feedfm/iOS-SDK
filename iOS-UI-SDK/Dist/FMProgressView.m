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
@property float actualProgress;
#endif

@end

@implementation FMProgressView

#if !TARGET_INTERFACE_BUILDER

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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) setup {
    _feedPlayer = [FMAudioPlayer sharedPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerUpdated:) name:FMAudioPlayerPlaybackStateDidChangeNotification object:_feedPlayer];
    
    [self updatePlayerState];
}

- (void) setProgress: (float) progress {
    // ignore passed in values, and just use what we've calculated
    [super setProgress:_actualProgress];
}

- (void) setProgress:(float)progress animated:(BOOL)animated {
    // ignore passed in values, and just use what we've calculated
    [super setProgress:_actualProgress animated:animated];
}

- (void) playerUpdated: (NSNotification *) notification {
    [self updatePlayerState];
}

- (void) updatePlayerState {
    FMAudioPlayerPlaybackState newState = _feedPlayer.playbackState;
    
    switch (newState) {
        case FMAudioPlayerPlaybackStateWaitingForItem:
        case FMAudioPlayerPlaybackStateReadyToPlay:
            [self updateProgress];
            [self cancelProgressTimer];
            break;
            
        case FMAudioPlayerPlaybackStateComplete:
        case FMAudioPlayerPlaybackStatePaused:
            [self updateProgress];
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
    [self updateProgress];
}


- (void)cancelProgressTimer {
    [_progressTimer invalidate];
    _progressTimer = nil;
}

- (void)updateProgress {
    NSTimeInterval duration = _feedPlayer.currentItemDuration;
    if(duration > 0) {
        _actualProgress = _feedPlayer.currentPlaybackTime / duration;
        [super setProgress:_actualProgress animated:false];
    }
    else {
        _actualProgress = 0.0;
        [super setProgress:_actualProgress animated:false];
    }
}

- (void)resetProgress {
    _actualProgress = 0.0;
    [super setProgress: _actualProgress animated:false];
}

#endif



@end

#undef kFMProgressBarUpdateTimeInterval

