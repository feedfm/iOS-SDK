//
//  FMPlayer.h
//  FeedMediaCore
//
//  Created by Arveen kumar on 17/05/2023.
//  Copyright © 2023 Feed Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


NS_ASSUME_NONNULL_BEGIN

/**
 *  Feed class is a simplified way to use our SDK, it does not replace any functionality of the SDK but is rather a layer on top to simplify integration.
 *
 *  This method associates the feed audio player with an avplayer. The feed SDK watches the associated AVPlayer and automatically finds and plays the correct station and pauses and unpause the playback etc. For more info please check out our welcome docs on business portal.
 */

@interface  Feed : NSObject

/**
 *  Initalize the feed player with a given avplayer. The AVplayer must already have a current item, as the URL of the current item will be used to lookup related FeedFM program.
 *   @param token FeedFM token
 *   @param secret FeedFM token
 *   @param avplayer The AVPlayer responsible for playback of the associated video.
 */
+ (void)initWithToken:(nonnull NSString *)token secret:(nonnull NSString *)secret withPlayer:(nonnull AVPlayer *) avplayer;

/**
 *  Initalize the feed player with a given avplayer and the URL or uri that will be used to lookup related FeedFM program.
 *   @param token FeedFM token
 *   @param secret FeedFM token
 *   @param uri ID or URL associated with a FeedFM program
 *   @param avplayer The AVplayer responsible for playback of the associated video.
 */


+ (void)initWithToken:(nonnull NSString *)token secret:(nonnull NSString *)secret withURI:(NSString*) uri withPlayer:(nonnull AVPlayer *) avplayer;

@end

NS_ASSUME_NONNULL_END
