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

#define kAEOStationName @"American Eagle Radio"
#define kAERIEStationName @"Aerie Radio"

#define kStationRotationIntervalInSeconds 60
#define kMinimumStationRotationTimeInSeconds 2

@interface RadioViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) FMAudioPlayer *player;
@property (strong, nonatomic) StationBackgroundState *visibleStationBackground;
@property (strong, nonatomic) NSTimer *stationBackgroundTimer;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UILabel *pressPlay;

@property (weak, nonatomic) IBOutlet UIButton *aeoStationButton;
@property (weak, nonatomic) IBOutlet UIButton *aerieStationButton;

@property (weak, nonatomic) IBOutlet FMMetadataLabel *track;
@property (weak, nonatomic) IBOutlet FMMetadataLabel *artist;
@property (weak, nonatomic) IBOutlet FMMetadataLabel *album;

@end

static bool playbackBegun = false;
static NSMutableDictionary *stations = nil;

@implementation RadioViewController


- (void)viewDidLoad {
    NSLog(@"view did load!");
    
    [super viewDidLoad];

    _player = [FMAudioPlayer sharedPlayer];
    _visibleStationBackground = nil;
    _stationBackgroundTimer = nil;
    
    if (stations == nil) {
        stations = [[NSMutableDictionary alloc] init];
        
        StationBackgroundState *sbs = [[StationBackgroundState alloc] init];
        sbs.secondsRemainingForRotation = 0;
        sbs.imageFilenameFormat = @"AEO-Background-%d";
        sbs.currentImageOffset = 0;
        sbs.lockScreenFilename = @"AEO-Lockscreen";
        [stations setObject:sbs forKey:kAEOStationName];

        sbs = [[StationBackgroundState alloc] init];
        sbs.secondsRemainingForRotation = 0;
        sbs.imageFilenameFormat = @"AERIE-Background-%d";
        sbs.currentImageOffset = 0;
        sbs.lockScreenFilename = @"AERIE-Lockscreen";
        [stations setObject:sbs forKey:kAERIEStationName];
    }
    
    [self matchLockScreenWithStationNamed:_player.activeStation.name];
    [self selectActiveStation:_player.activeStation.name];

    [self updateSongDisplay];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(onActiveStationChanged:) name:FMAudioPlayerActiveStationDidChangeNotification object:_player];
    [nc addObserver:self selector:@selector(onPlaybackStateChange:) name:FMAudioPlayerPlaybackStateDidChangeNotification object:_player];
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

- (void) selectActiveStation:(NSString *)name {
    UIFont *gothamMedium = [UIFont fontWithName:@"Gotham-Medium" size:17.0];
    UIFont *gothamBook = [UIFont fontWithName:@"Gotham-Book" size:17.0];
    
    if ([name isEqualToString:kAERIEStationName]) {
        _aeoStationButton.selected = NO;
        _aeoStationButton.backgroundColor = [UIColor whiteColor];
        _aeoStationButton.titleLabel.font = gothamMedium;
        
        _aerieStationButton.selected = YES;
        _aerieStationButton.backgroundColor = [UIColor blackColor];
        _aerieStationButton.titleLabel.font = gothamBook;
        
    } else { // if ([station.name isEqualToString:kAEOStationName])
        _aeoStationButton.selected = YES;
        _aeoStationButton.backgroundColor = [UIColor blackColor];
        _aeoStationButton.titleLabel.font = gothamBook;
        
        _aerieStationButton.selected = NO;
        _aerieStationButton.backgroundColor = [UIColor whiteColor];
        _aerieStationButton.titleLabel.font = gothamMedium;
    }
}

- (IBAction) onTouchAEO: (id) view {
    if (![_player.activeStation.name isEqualToString:kAEOStationName]) {
        [_player setActiveStationByName:kAEOStationName];
        [_player play];
    };
}

- (IBAction) onTouchAERIE: (id) view {
    if (![_player.activeStation.name isEqualToString:kAERIEStationName]) {
        [_player setActiveStationByName:kAERIEStationName];
        [_player play];
    }
}


- (void) updateSongDisplay {
    if (playbackBegun) {
        [self displaySongData];
    }
}

- (void)onPlaybackStateChange:(NSNotification *)notification {
    // as soon as something happens, kick off metadata display
    if (!playbackBegun) {
        playbackBegun = true;
        [self displaySongData];
    }
}

- (void) displaySongData {
    _pressPlay.hidden = YES;
    _track.hidden = NO;
    _artist.hidden = NO;
    _album.hidden = NO;
}


- (IBAction)closePlayer:(id)sender {
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
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
