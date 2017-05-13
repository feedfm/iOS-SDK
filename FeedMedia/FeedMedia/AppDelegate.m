//
//  FMAppDelegate.m
//  FeedMedia
//
//  Created by Eric Lambrecht on 02/01/2016.
//  Copyright (c) 2016 Eric Lambrecht. All rights reserved.
//

#import "AppDelegate.h"

#import <FeedMedia/FeedMedia.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    FMLogSetLevel(FMLogLevelDebug);
    
    [FMAudioPlayer setClientToken:@"0248084d48fedad705477a42f6dd5238001507db" secret:@"6a7c7b1f40026be479b920e6ec7079eeddf6ef1b"];
    
    [[FMAudioPlayer sharedPlayer] whenAvailable:^{
        FMAudioPlayer *player = [FMAudioPlayer sharedPlayer];
        
        player.secondsOfCrossfade = 6;
        [player prepareToPlay];

    } notAvailable:^{
        // nada
    }];

    // Override point for customization after application launch.
    return YES;
}

@end
