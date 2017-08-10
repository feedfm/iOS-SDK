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
    
    [FMAudioPlayer setClientToken:@"ondemand" secret:@"ondemand"];

    FMAudioPlayer *player = [FMAudioPlayer sharedPlayer];
    [player whenAvailable:^{
        
        player.secondsOfCrossfade = 6;
        [player prepareToPlay];

    } notAvailable:^{
        // nada
    }];

    // Override point for customization after application launch.
    return YES;
}

@end
