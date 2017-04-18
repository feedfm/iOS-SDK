//
//  LockScreenDelegate.h
//  FeedMedia
//
//  Created by Eric Lambrecht on 4/18/17.
//  Copyright © 2017 Feed Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FeedMedia/FeedMedia.h>

@interface LockScreenDelegate : NSObject <FMLockScreenDelegate>


- (void) updateLockScreenInfo: (NSDictionary *) info
                dislikeActive: (BOOL) dislikeActive
                   likeActive: (BOOL) likeActive
             nextTrackEnabled: (BOOL) nextTrackEnabled;

@end
