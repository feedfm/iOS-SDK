//
//  FMElapsedTimeLabel.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 3/10/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMElapsedTimeLabel.h"
#import "FeedMedia/FMAudioPlayer.h"

#define kFMProgressBarUpdateTimeInterval 0.5

@interface FMElapsedTimeLabel () {
    NSTimer *_progressTimer;
}

#if !TARGET_INTERFACE_BUILDER
@property (strong, nonatomic) FMAudioPlayer *feedPlayer;
#endif

@end


@implementation FMElapsedTimeLabel

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

- (void) setup {
    _feedPlayer = [FMAudioPlayer sharedPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPlayerUpdated:) name:FMAudioPlayerPlaybackStateDidChangeNotification object:_feedPlayer];
    
    [self updatePlayerState];
}

- (void) onPlayerUpdated: (NSNotification *) notification {
    [self updatePlayerState];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self cancelProgressTimer];
}

- (void) setText:(NSString *)text {
    // ignore whatever is passed in during runtime
    [self updateProgress];
}

- (void) updatePlayerState {
    FMAudioPlayerPlaybackState newState = _feedPlayer.playbackState;
    
    switch (newState) {
        case FMAudioPlayerPlaybackStateWaitingForItem:
        case FMAudioPlayerPlaybackStateComplete:
        case FMAudioPlayerPlaybackStateReadyToPlay:
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
                                                    selector:@selector(onProgressTimerUpdate:)
                                                    userInfo:nil
                                                     repeats:YES];
    [self updateProgress];
}

- (void)onProgressTimerUpdate:(NSTimer *)timer {
    [self updateProgress];
}


- (void)cancelProgressTimer {
    [_progressTimer invalidate];
    _progressTimer = nil;
}


- (void)updateProgress {
    NSTimeInterval duration = _feedPlayer.currentItemDuration;
    if(duration > 0) {
        long currentTime = lroundf(self.feedPlayer.currentPlaybackTime);
        
        [super setText: [NSString stringWithFormat:@"%ld:%02ld", currentTime / 60, currentTime % 60]];
        if (currentTime < 0) {
            [super setText:@"0:00"];
        }
        
    }
    else {
        [super setText:_textForNoTime];
    }
}

- (void) setTextForNoTime: (NSString *) textForNoTime {
    _textForNoTime = textForNoTime;
    
    [self updatePlayerState];
}

#endif



@end

#undef kFMProgressBarUpdateTimeInterval

