//
//  FeedMediaCore.h
//  FeedMediaCore
//
//  Created by Eric Lambrecht on 9/6/17.
//  Copyright © 2017 Feed Media. All rights reserved.
//

#define FEED_MEDIA_CLIENT_VERSION @"5.1.4"

// All public headers

#import <FeedMedia/FMSimulcastStreamer.h>
#import <FeedMedia/FMAudioItem.h>
#import <FeedMedia/FMAudioPlayer.h>
#import <FeedMedia/FMLockScreenDelegate.h>
#import <FeedMedia/FMError.h>
#import <FeedMedia/FMLog.h>
#import <FeedMedia/FMStation.h>
#import <FeedMedia/FMStationArray.h>

#if TARGET_OS_TV || TARGET_OS_MACCATALYST
#else
#import "CWStatusBarNotification.h"
#endif
