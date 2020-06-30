//
//  FMAsset.h
//  sdktest
//
//  Created by James Anthony on 4/26/13.
//  Copyright (c) 2013 Feed Media, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "FMAudioItem.h"

@interface FMAsset : NSObject

/**
 The item to be loaded (set during initialization)
 */
@property (readonly) FMAudioItem *audioItem;

/**
 Available after `-loadPlayerItem` is completed successfully
 */
@property (readonly) AVPlayerItem *playerItem;

/**
 The error, if any, that occurred during loading
 */
@property (readonly) NSError *loadError;

+ (FMAsset *)assetWithAudioItem:(FMAudioItem *)item;
- (id)initWithAudioItem:(FMAudioItem *)item;

/**
 Completion blocks are guaranteed to be called on the main queue.
 If the load is canceled, neither block will be called.
 If set after the load has completed, the respective block will be executed in the next iteration of the run-loop.
 */
- (void)setCompletionBlockWithSuccess:(void (^)(FMAsset *asset, AVPlayerItem *playerItem))success
                              failure:(void (^)(FMAsset *asset, NSError *error))failure;

/**
 Loads the player item asynchronously
 */
- (void)loadPlayerItem;

/**
 Loading will be halted in its current state and any existing or future completion blocks will be ignored.
 */
- (void)cancel;

@end
