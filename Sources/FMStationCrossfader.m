//
//  FMStationCrossfader.m
//  FeedMedia
//
//  Created by Eric Lambrecht on 9/21/17.
//  Copyright © 2017 Feed Media. All rights reserved.
//

#import "FMStationCrossfader.h"
#import "FeedMedia.h"

@interface FMStationAndTime : NSObject

@property (nonatomic) float time;
@property (nonatomic, strong) FMStation *station;

+ (FMStationAndTime *) station: (FMStation *) station time: (float) time;

@end

@implementation FMStationAndTime

+ (FMStationAndTime *) station: (FMStation *) station time: (float) time {
    FMStationAndTime *st = [[FMStationAndTime alloc] init];
    
    st.time = time;
    st.station = station;
    
    return st;
}

@end



@implementation FMStationCrossfader {
    
    NSMutableArray *_timesAndStations;
    FMAudioPlayer *_player;
    BOOL _connected;
    
}

- (id) init {
    if (self = [super init]) {
        _timesAndStations = [NSMutableArray array];
        _player = [FMAudioPlayer sharedPlayer];
        _connected = NO;
    }
    
    return self;
}

+ (FMStationCrossfader *) stationCrossfaderWithInitialStation:(NSDictionary *)initialStationOptionKeysAndValues {
    FMStationCrossfader *sc = [[FMStationCrossfader alloc] init];
    
    [sc appendStation: initialStationOptionKeysAndValues startingAtTime: 0.0f];

    return sc;
}

+ (FMStationCrossfader *) stationCrossfaderWithInitialStation: (NSDictionary *) initialStationOptionKeysAndValues
                                                  andSwitches: (NSArray *) timeStationPairs {
    FMStationCrossfader *sc = [FMStationCrossfader stationCrossfaderWithInitialStation:initialStationOptionKeysAndValues];

    if ((timeStationPairs.count % 2) != 0) {
        NSLog(@"**WARNING** switches provided to FMStationCrossfader should come in pairs, but we found %lu items", (unsigned long)timeStationPairs.count);
    }

    // convert the input values into an array of FMStationAndTime objects, sorted by
    // increasing time value
    for (int i = 0; i < timeStationPairs.count; i += 2) {
        NSNumber *timeObject = (NSNumber *) timeStationPairs[i];
        NSDictionary *optionKeysAndValues = (NSDictionary *) timeStationPairs[i+1];
        
        [sc appendStation: optionKeysAndValues startingAtTime: [timeObject floatValue]];
    }
    
    return sc;
}

- (void) appendStation: (NSDictionary *) optionKeysAndValues startingAtTime: (float) time {
    if (_connected) {
        NSLog(@"**WARNING** cannot append switches to crossfader once begin has been called");
        return;
    }
    
    if (optionKeysAndValues == nil) {
        if (time != 0.0) {
            NSLog(@"**WARNING** only the initial station may be nil. Unable to add to station crossfader at time index %f.", time);

        } else {
            [_timesAndStations addObject:[FMStationAndTime station:nil time:time]];
        }

        return;
    }
    
    FMStation *station = [_player getStationWithOptions: optionKeysAndValues];
    
    if (station != nil) {
        FMLogDebug(@"adding station %@ at time %f", station.name, time);
        [_timesAndStations addObject:[FMStationAndTime station:station time: time]];
        
    } else {
        NSLog(@"**WARNING** unable to find station with attributes %@ for time index %f", optionKeysAndValues, time);
    }
}

- (void) connect {
    if (_connected) {
        return;
    }
    
    if (_timesAndStations.count == 0) {
        NSLog(@"*WARNING** station crossfader begin called, but no stations provided");
        return;
    }

    // make sure all the switches are ordered properly
    NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"time" ascending:YES];
    [_timesAndStations sortUsingDescriptors:@[ sd ]];
    
    // find the initial station
    FMStation *initialStation = nil;
    for (FMStationAndTime *st in _timesAndStations) {
        if (st.station != nil) {
            initialStation = st.station;
            break;
        }
    }

    if (initialStation == nil) {
        // no station specified anywhere.. so just reset the player
        [_player stop];

    } else if ([initialStation isEqual:_player.activeStation]) {
        // already in the station - make sure we're paused
        [_player pause];
        
    } else {
        // tune to the initial station
        [_player stop];
        _player.activeStation = initialStation;
        
    }

    _connected = YES;
}

- (void) disconnect {
    _connected = NO;
}

- (void) reconnect {
    _connected = YES;
}

- (void) elapseToTime: (float) time {
    if (!_connected || (_timesAndStations.count == 0)) {
        return;
    }
    
    FMStation *station = ((FMStationAndTime *) _timesAndStations[0]).station;
    
    for (FMStationAndTime *st in _timesAndStations) {
        if (time < st.time) {
            break;
        }
        
        station = st.station;
    }
    
    if (station == nil) {
        if ((_player.playbackState != FMAudioPlayerPlaybackStatePaused) ||
            (_player.playbackState != FMAudioPlayerPlaybackStateReadyToPlay)) {
            [_player pause];
        }

    } else {
        if (![_player.activeStation isEqual:station]) {
            [_player setActiveStation:station withCrossfade:YES];
        }
        
        if (_player.playbackState != FMAudioPlayerPlaybackStatePlaying) {
            [_player play];
        }
    }
}

@end
