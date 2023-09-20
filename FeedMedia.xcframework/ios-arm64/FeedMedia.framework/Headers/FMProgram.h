//
//  NSObject+FMProgram.h
//  FeedMediaCore
//
//  Created by Arveen kumar on 25/05/2023.
//  Copyright © 2023 Feed Media. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <FeedMedia/FMStationCrossfader.h>

/**
 * Program class with cuepoints
 */

@interface FMProgram : NSObject

@property (readonly) NSArray *cuepoints;


- (id) initwithJSON:(id) cuepoints;


@end

