//
//  StationBackgroundState.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 6/16/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "StationBackgroundState.h"

@implementation StationBackgroundState

- (id) initWithStationName: (NSString *) stationName backgroundFilenameFormat: (NSString *) format lockScreenFilename: (NSString *) lockscreen {
    if (self = [super init]) {
        _stationName = stationName;
        _nextRotationDate = nil;
        _secondsRemainingForRotation = 0;
        _imageFilenameFormat = format;
        _currentImageOffset = 0;
        _lockScreenFilename = lockscreen;
    }

    return self;
}


@end
