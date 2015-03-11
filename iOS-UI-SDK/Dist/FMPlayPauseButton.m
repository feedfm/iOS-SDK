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

@property (strong, nonatomic) UIButton *playButton;
@property (strong, nonatomic) UIButton *pauseButton;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;

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


- (void) setBackgroundColor: (UIColor *) color {
    super.backgroundColor = [UIColor clearColor];
}

- (void) setup {
#if !TARGET_INTERFACE_BUILDER
    _feedPlayer = [FMAudioPlayer sharedPlayer];
#endif
    
    self.backgroundColor = [UIColor clearColor];
    self.playTitle = @"play";
    self.pauseTitle = @"pause";

#if TARGET_INTERFACE_BUILDER
    self.previewPlayButton = YES;
#endif

    _playButton = [[UIButton alloc] init];
    _playButton.frame = self.bounds;
    _playButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self stylePlayButton:_playButton withImage:_playImage andTitle:_playTitle];
    [self addSubview:_playButton];
    
    _pauseButton = [[UIButton alloc] init];
    _pauseButton.frame = self.bounds;
    _pauseButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self stylePauseButton:_pauseButton withImage:_pauseImage andTitle:_pauseTitle];
    [self addSubview:_pauseButton];
    
    _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    _spinner.frame = self.bounds;
    _spinner.hidesWhenStopped = YES;
    [self styleSpinner:_spinner];
    [_spinner stopAnimating];
    [self addSubview:_spinner];
    
#if !TARGET_INTERFACE_BUILDER
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerUpdated:) name:FMAudioPlayerPlaybackStateDidChangeNotification object:_feedPlayer];
    
    [_playButton addTarget:self action:@selector(onPlayClick) forControlEvents:UIControlEventTouchUpInside];
    [_pauseButton addTarget:self action:@selector(onPauseClick) forControlEvents:UIControlEventTouchUpInside];
#endif
    
    [self updatePlayerState];
    
}

#if !TARGET_INTERFACE_BUILDER

- (void) onPlayClick {
    [_feedPlayer play];
}

- (void) onPauseClick {
    [_feedPlayer pause];
}

#endif

- (void) setPlayTitle:(NSString *)playTitle {
    _playTitle = playTitle;
    
    [self stylePlayButton:_playButton withImage:_playImage andTitle:_playTitle];
}

- (void) setPlayImage:(UIImage *)image {
    _playImage = image;
    
    [self stylePlayButton:_playButton withImage:_playImage andTitle:_playTitle];
}

- (void) setPauseTitle:(NSString *)pauseTitle {
    _pauseTitle  = pauseTitle;
    
    [self stylePauseButton:_pauseButton withImage:_pauseImage andTitle:_pauseTitle];
}

- (void) setPauseImage:(UIImage *)image {
    _pauseImage = image;
    
    [self stylePauseButton:_pauseButton withImage:_pauseImage andTitle:_pauseTitle];
}

#if TARGET_INTERFACE_BUILDER
- (void) setPreviewPlayButton: (BOOL)yesOrNo {
    _previewPlayButton = yesOrNo;
    
    [self updatePlayerState];
}
#endif

- (void) stylePlayButton:(UIButton *)button withImage:(UIImage *) image andTitle:(NSString *) title {
    [self styleButton:button withImage:image andTitle:title];
}

- (void) stylePauseButton:(UIButton *)button withImage:(UIImage *) image andTitle:(NSString *) title {
    [self styleButton:button withImage:image andTitle:title];
}

- (void) styleButton:(UIButton *)button withImage:(UIImage *) image andTitle:(NSString *) title {
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];

    button.backgroundColor = [UIColor clearColor];
}

- (void) styleSpinner:(UIActivityIndicatorView *) spinner {
    
}

- (void) playerUpdated: (NSNotification *)notification {
    [self updatePlayerState];
}

- (void) updatePlayerState {
    FMAudioPlayerPlaybackState newState;

#if !TARGET_INTERFACE_BUILDER
    newState = _feedPlayer.playbackState;
#else
    newState = self.previewPlayButton ? FMAudioPlayerPlaybackStateReadyToPlay : FMAudioPlayerPlaybackStatePlaying;
#endif
    
    switch (newState) {
        case FMAudioPlayerPlaybackStateWaitingForItem:
            _playButton.hidden = YES;
            _pauseButton.hidden = YES;
            [_spinner startAnimating];
            break;
        case FMAudioPlayerPlaybackStateReadyToPlay:
        case FMAudioPlayerPlaybackStatePaused:
            [_spinner stopAnimating];
            _playButton.hidden = NO;
            _pauseButton.hidden = YES;
            break;
        case FMAudioPlayerPlaybackStatePlaying:
            [_spinner stopAnimating];
            _playButton.hidden = YES;
            _pauseButton.hidden = NO;
            break;
        case FMAudioPlayerPlaybackStateStalled:
            _playButton.hidden = YES;
            _pauseButton.hidden = YES;
            [_spinner startAnimating];
            break;
        case FMAudioPlayerPlaybackStateRequestingSkip:
            _playButton.hidden = YES;
            _pauseButton.hidden = YES;
            [_spinner startAnimating];
            break;
        case FMAudioPlayerPlaybackStateComplete:
            [_spinner stopAnimating];
            _playButton.hidden = NO;
            _pauseButton.hidden = YES;
            break;
    }
}

@end
