//
//  FMMetadataLabel.m
//  iOS-UI-SDK
//
//  This label sets its 'text' property to match its 'format' propery, but with
//  the following strings replaced to reflect the currently playing song:
//
//   %ARTIST - the name of the current artist
//   %TRACK  - the name of the current track
//   %ALBUM  - the name of the current album
//
//  If no song is playing, then the text is set to the empty string.
//
//  Created by Eric Lambrecht on 4/27/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMMetadataLabel.h"
#import "FeedMedia/FMAudioPlayer.h"

@interface FMMetadataLabel ()

#if !TARGET_INTERFACE_BUILDER
@property (strong, nonatomic) FMAudioPlayer *feedPlayer;
#endif

@end

@implementation FMMetadataLabel


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
    
    super.text = @"metadata placeholder";
    
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
    
    if (!current || !_format || (_format.length == 0)) {
        super.text = @"";
        return;
    }
    
    // swap %ARTIST with artist name, %TRACK with track name, %ALBUM with album name
    NSMutableString *string = [NSMutableString stringWithString:_format];
    
    [string replaceOccurrencesOfString:@"%ARTIST" withString:current.artist options:NSLiteralSearch range:NSMakeRange(0, [string length])];

    [string replaceOccurrencesOfString:@"%TRACK" withString:current.name options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    
    [string replaceOccurrencesOfString:@"%ALBUM" withString:current.album options:NSLiteralSearch range:NSMakeRange(0, [string length])];
    
    super.text = string;
}

#endif



@end
