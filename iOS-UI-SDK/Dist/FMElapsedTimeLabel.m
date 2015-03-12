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
    
    [self updateProgress:nil];
#endif
    
    [super setText:_textForNoTime];
}

- (void) setText: (NSString *)text {
    // ignore
}

#if !TARGET_INTERFACE_BUILDER

- (void) playerUpdated: (NSNotification *) notification {
    [self updatePlayerState];
}

- (void) updatePlayerState {
    FMAudioPlayerPlaybackState newState = _feedPlayer.playbackState;
    
    switch (newState) {
        case FMAudioPlayerPlaybackStateWaitingForItem:
            [self emptyProgress];
            
        case FMAudioPlayerPlaybackStateComplete:
            [self cancelProgressTimer];
            [self emptyProgress];
            break;
            
        case FMAudioPlayerPlaybackStatePaused:
        case FMAudioPlayerPlaybackStateReadyToPlay:
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
    [self updateProgress:nil];
}

- (void)updateProgress:(NSTimer *)timer {
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

- (void) emptyProgress {
    [super setText:_textForNoTime];
}

- (void)cancelProgressTimer {
    [_progressTimer invalidate];
    _progressTimer = nil;
}

#endif


- (void) setTextForNoTime: (NSString *) text {
    _textForNoTime = text;
    [super setText:_textForNoTime];
}


@end

#undef kFMProgressBarUpdateTimeInterval

