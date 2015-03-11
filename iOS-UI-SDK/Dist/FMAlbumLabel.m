//
//  FMAlbumLabel.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 3/10/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMAlbumLabel.h"
#import "FeedMedia/FMAudioPlayer.h"

@interface FMAlbumLabel ()

#if !TARGET_INTERFACE_BUILDER
@property (strong, nonatomic) FMAudioPlayer *feedPlayer;
#endif

@end

@implementation FMAlbumLabel

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
    self.feedPlayer = [FMAudioPlayer sharedPlayer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(songUpdated:) name:FMAudioPlayerCurrentItemDidChangeNotification object:self.feedPlayer];
    
    [self updateText];
#else 
    
    super.text = @"album placeholder";
    
#endif
}

- (void) setText:(NSString *)text {
    // nada
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
        super.text = current.album;
    } else {
        super.text = @"";
    }
    
}

#endif

@end
