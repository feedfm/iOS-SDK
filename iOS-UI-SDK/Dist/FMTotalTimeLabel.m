//
//  FMTotalTimeLabel.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 3/10/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMTotalTimeLabel.h"
#import "FeedMedia/FMAudioPlayer.h"

#define kFMProgressBarUpdateTimeInterval 0.5

@interface FMTotalTimeLabel ()

#if !TARGET_INTERFACE_BUILDER
@property (strong, nonatomic) FMAudioPlayer *feedPlayer;
#endif

@end


@implementation FMTotalTimeLabel


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
    
    [self updatePlayerState];
    
#else 

    [super setText:_textForNoTime];

#endif

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
            [self resetProgress];
            
        case FMAudioPlayerPlaybackStateComplete:
            [self resetProgress];
            break;
            
        case FMAudioPlayerPlaybackStatePaused:
        case FMAudioPlayerPlaybackStateRequestingSkip:
        case FMAudioPlayerPlaybackStateReadyToPlay:
            [self updateProgress];
            break;
            
        case FMAudioPlayerPlaybackStatePlaying:
            [self updateProgress];
            break;
            
        default:
            // nada
            break;
    }
}

- (void)updateProgress {
    long duration = lroundf(_feedPlayer.currentItemDuration);
    
    if(duration > 0) {
        [super setText: [NSString stringWithFormat:@"%ld:%02ld", duration / 60, duration % 60]];
        
    }
    else {
        [super setText:@"0:00"];
    }
}

- (void)resetProgress {
    [super setText:_textForNoTime];
}

#endif

- (void) setTextForNoTime: (NSString *) text {
    _textForNoTime = text;
    [super setText:_textForNoTime];
}


@end

#undef kFMProgressBarUpdateTimeInterval


