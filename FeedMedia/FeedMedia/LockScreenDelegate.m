//
//  LockScreenDelegate.m
//  FeedMedia
//
//  Created by Eric Lambrecht on 4/18/17.
//  Copyright © 2017 Feed Media. All rights reserved.
//

#import "LockScreenDelegate.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation LockScreenDelegate

- (void) updateLockScreenInfo: (NSDictionary *) info
                dislikeActive: (BOOL) dislikeActive
                   likeActive: (BOOL) likeActive
             nextTrackEnabled: (BOOL) nextTrackEnabled {
    
    NSLog(@"updating lock screen info!");
    
    NSMutableDictionary *md = [info mutableCopy];
    NSString *title = [md objectForKey:MPMediaItemPropertyTitle];
    
    if (title) {
        [md setObject:[NSString stringWithFormat:@"<<%@>>", title] forKey:MPMediaItemPropertyTitle];
    }
    
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = md;
    
    MPRemoteCommandCenter *rcc = [MPRemoteCommandCenter sharedCommandCenter];
    
    MPRemoteCommand *nextTrackCommand = [rcc nextTrackCommand];
    [nextTrackCommand setEnabled: nextTrackEnabled];
    
    MPFeedbackCommand *dislikeCommand = [rcc dislikeCommand];
    [dislikeCommand setEnabled:YES];
    [dislikeCommand setActive:dislikeActive];
    
    MPFeedbackCommand *likeCommand = [rcc likeCommand];
    [likeCommand setEnabled:YES];
    [likeCommand setActive:likeActive];
    
}

@end
