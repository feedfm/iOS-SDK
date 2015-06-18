//
//  StationBackgroundState.h
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 6/16/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StationBackgroundState : NSObject

@property (strong, nonatomic) NSString *stationName;
@property (strong, nonatomic) NSDate *nextRotationDate;
@property NSTimeInterval secondsRemainingForRotation;
@property (strong, nonatomic) NSString *imageFilenameFormat;
@property int currentImageOffset;
@property (strong, nonatomic) NSString *lockScreenFilename;

- (id) initWithStationName: (NSString *) stationName backgroundFilenameFormat: (NSString *) format lockScreenFilename: (NSString *) lockscreen;

@end
