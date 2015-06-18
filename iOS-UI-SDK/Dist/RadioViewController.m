//
//  RadioViewController.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 6/14/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

@import Foundation;

#import "RadioViewController.h"
#import "FeedMedia/FMAudioPlayer.h"
#import "FMMetadataLabel.h"
#import "StationBackgroundState.h"

#define kStationOneName @"Station One"
#define kStationTwoName @"Station Two"

#define kStationRotationIntervalInSeconds 60
#define kMinimumStationRotationTimeInSeconds 2

@interface RadioViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) FMAudioPlayer *player;
@property (strong, nonatomic) StationBackgroundState *visibleStationBackground;
@property (strong, nonatomic) NSTimer *stationBackgroundTimer;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UILabel *pressPlay;

@property (weak, nonatomic) IBOutlet UISegmentedControl *stationsControl;

@property (weak, nonatomic) IBOutlet FMMetadataLabel *track;
@property (weak, nonatomic) IBOutlet FMMetadataLabel *artist;
@property (weak, nonatomic) IBOutlet FMMetadataLabel *album;

@end

static NSMutableDictionary *stations = nil;

@implementation RadioViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    _player = [FMAudioPlayer sharedPlayer];
    _visibleStationBackground = nil;
    _stationBackgroundTimer = nil;
    
    if (stations == nil) {
        stations = [[NSMutableDictionary alloc] init];
        
        StationBackgroundState *sbs;
        sbs = [[StationBackgroundState alloc] initWithStationName:@"Station One" backgroundFilenameFormat:@"Station-One-Background-%d" lockScreenFilename:@"Station-One-Lockscreen"];
        [stations setObject:sbs forKey:sbs.stationName];

        sbs = [[StationBackgroundState alloc] initWithStationName:@"Station Two" backgroundFilenameFormat:@"Station-Two-Background-%d" lockScreenFilename:@"Station-Two-Lockscreen"];
        [stations setObject:sbs forKey:sbs.stationName];
    }
    
    [self matchLockScreenWithStationNamed:_player.activeStation.name];
    [self selectActiveStation:_player.activeStation.name];
    [self selectActiveStationControl:_player.activeStation.name];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(onActiveStationChanged:) name:FMAudioPlayerActiveStationDidChangeNotification object:_player];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Background images rotation handling

/* Kill off the timer that is rotating the station's background image.
   Keep track of how many seconds were left on the timer.
 */

- (void) disableVisibleStationBackgroundTimer {
    // if there is an existing timer:
    if (_stationBackgroundTimer != nil) {
        // cancel it
        [_stationBackgroundTimer invalidate];
        _stationBackgroundTimer = nil;
    }
    
    if ((_visibleStationBackground != nil) && (_visibleStationBackground.nextRotationDate != nil)) {
        // keep track of how much time was left
        NSTimeInterval remainingTime = [_visibleStationBackground.nextRotationDate timeIntervalSinceDate:[NSDate date]];
        _visibleStationBackground.secondsRemainingForRotation = (remainingTime < kMinimumStationRotationTimeInSeconds) ? kMinimumStationRotationTimeInSeconds : remainingTime;
        
        _visibleStationBackground = nil;
    }
   
    _visibleStationBackground = nil;
}

/* Change the background image to reflect the given station. Restart
   the timer to automatically rotate the image periodically.
 */

- (void) updateVisibleStationBackground:(NSString *)stationName {
    [self disableVisibleStationBackgroundTimer];
    
    // pick out the new visible station
    _visibleStationBackground = [stations objectForKey:stationName];
    
    if (_visibleStationBackground == nil) {
        NSLog(@"Trying to switch to unknown station: %@", stationName);
        return;
    }
    
    [self assignVisibleStationBackgroundAndRestartTimer];
}

/* Set the current station background image to the value provided, then start
   a timer to have the image automatically advanced after some period of time
 */

- (void) assignVisibleStationBackgroundAndRestartTimer {
    if (_visibleStationBackground.secondsRemainingForRotation <= 0) {
        _visibleStationBackground.secondsRemainingForRotation = kStationRotationIntervalInSeconds;
    }
    
    _visibleStationBackground.nextRotationDate = [NSDate dateWithTimeIntervalSinceNow:_visibleStationBackground.secondsRemainingForRotation];

    NSString *filename = [NSString stringWithFormat:_visibleStationBackground.imageFilenameFormat, _visibleStationBackground.currentImageOffset];
    UIImage *bg = [UIImage imageNamed:filename];
    
    if (bg == nil) {
        _visibleStationBackground.currentImageOffset = 0;
        filename = [NSString stringWithFormat:_visibleStationBackground.imageFilenameFormat, _visibleStationBackground.currentImageOffset];
        
        bg = [UIImage imageNamed:filename];
        if (bg == nil) {
            NSLog(@"Trying to display station background, but there is no image with name %@", filename);
            return;
        }
    }

    _backgroundImage.image = bg;
    
    // create a timer so we update this in the future
    _stationBackgroundTimer = [NSTimer scheduledTimerWithTimeInterval:_visibleStationBackground.secondsRemainingForRotation target:self selector:@selector(onStationBackgroundTimeEvent:) userInfo:nil repeats:NO];
}

- (void) onStationBackgroundTimeEvent: (NSTimer *) timer {
    // time to rotate shit!
    if (_visibleStationBackground == nil) {
        NSLog(@"Trying to rotate background, but there is no active station background!?");
        return;
    }
    
    // cancel the timer that spawned this
    _stationBackgroundTimer = nil;
    
    // reset timing
    _visibleStationBackground.secondsRemainingForRotation = 0;
    
    // advance to next image
    _visibleStationBackground.currentImageOffset++;
    
    [self assignVisibleStationBackgroundAndRestartTimer];
}

- (void) onActiveStationChanged:(NSNotification *)notification {
    [self updateVisibleStationBackground:_player.activeStation.name];
    [self matchLockScreenWithStationNamed:_player.activeStation.name];
    [self selectActiveStation:_player.activeStation.name];
}

- (void) matchLockScreenWithStationNamed: (NSString *)stationName {
    StationBackgroundState *sbs = [stations objectForKey:stationName];
    
    if (sbs == nil) {
        NSLog(@"Unable to find lock screen details for station with name %@", stationName);
        return;
    }

    UIImage *image = [UIImage imageNamed:sbs.lockScreenFilename];
    
    if (image == nil) {
        NSLog(@"Unable to find lock screen image with filename '%@'", sbs.lockScreenFilename);
        return;
    }
    
    [_player setLockScreenImage: image];
}

- (IBAction) stationChanged: (id) sender {
    NSString *stationName = [_stationsControl titleForSegmentAtIndex:_stationsControl.selectedSegmentIndex];
    
    if (stationName == nil) {
        NSLog(@"No station selected - whaaa?");
        return;
    }
    
    [self selectActiveStation:stationName];
}

- (void) selectActiveStationControl: (NSString *)stationName {
    for (int i = 0; i < _stationsControl.numberOfSegments; i++) {
        if ([stationName isEqualToString:[_stationsControl titleForSegmentAtIndex:i]]) {
            _stationsControl.selectedSegmentIndex = i;
            return;
        }
    }
    
    NSLog(@"Unable to find segment with active station name!");
}

- (void) selectActiveStation: (NSString *)stationName {
    StationBackgroundState *sbs = [stations objectForKey:stationName];
    if (sbs == nil) {
        NSLog(@"Trying to select station we don't know about: %@", stationName);
        return;
    }
    
    [_player setActiveStationByName:stationName];
    [_player play];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self updateVisibleStationBackground:_player.activeStation.name];

    [MarqueeLabel controllerViewWillAppear:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [MarqueeLabel controllerViewDidAppear:self];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self disableVisibleStationBackgroundTimer];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"popoverSegue"]) {
        UIViewController *dest = (UIViewController *) segue.destinationViewController;
        
        dest.modalPresentationStyle = UIModalPresentationPopover;
        dest.popoverPresentationController.delegate = self;
    }
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
