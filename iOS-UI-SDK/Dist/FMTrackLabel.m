//
//  FMTrackLabel.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 3/10/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMTrackLabel.h"
#import "FeedMedia/FMAudioPlayer.h"

@interface FMTrackLabel ()

#if !TARGET_INTERFACE_BUILDER
@property (strong, nonatomic) FMAudioPlayer *feedPlayer;
#endif

@end

@implementation FMTrackLabel

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
    
#if !TARGET_INTERFACE_BUILDER
    [self updateText];
#endif
    
    return self;
}

- (void) setup {
#if !TARGET_INTERFACE_BUILDER
    self.feedPlayer = [FMAudioPlayer sharedPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(songUpdated:) name:FMAudioPlayerCurrentItemDidChangeNotification object:self.feedPlayer];
    
    [self updateText];
#endif
}

#if !TARGET_INTERFACE_BUILDER

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) songUpdated: (NSNotification *) notification {
    [self updateText];
}

- (void) updateText {
    FMAudioItem *current = [_feedPlayer currentItem];
    
    if (current) {
        self.text = current.name;
    } else {
        self.text = @"";
    }
    
}

#endif

@end
