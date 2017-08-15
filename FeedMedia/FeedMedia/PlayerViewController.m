//
//  RadioViewController.m
//  FeedMedia
//
//  Created by Eric Lambrecht on 6/14/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

@import Foundation;

#import "PlayerViewController.h"
#import <FeedMedia/FeedMediaUI.h>

@interface PlayerViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) IBOutlet FMMetadataLabel *track;
@property (weak, nonatomic) IBOutlet FMMetadataLabel *artist;
@property (weak, nonatomic) IBOutlet FMMetadataLabel *album;

@property (weak, nonatomic) IBOutlet UILabel *state;

@end

static NSMutableDictionary *stations = nil;

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange:) name:FMAudioPlayerPlaybackStateDidChangeNotification object:[FMAudioPlayer sharedPlayer]];
    
    // set the lock screen up to share the player background
    // (this only appears when phone is playing music and is locked)
    // [_player setLockScreenImage:self.backgroundImage.image];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // MarqueeLabel uses Core Animation, which apparently causes problems when views
    // appear and disappear and the animation stopped by iOS does not automatically
    // restart.
    [MarqueeLabel restartLabelsOfController:self];
    [self updateStateDisplay];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"popoverSegue"]) {
        UIViewController *dest = (UIViewController *) segue.destinationViewController;
        
        dest.modalPresentationStyle = UIModalPresentationPopover;
        dest.popoverPresentationController.delegate = self;
    }
}

- (IBAction)userDidPressStop:(id)sender {
    [[FMAudioPlayer sharedPlayer] stop];
}

- (void)stateDidChange:(NSNotification *) notification {
    [self updateStateDisplay];
}

- (void) updateStateDisplay {
    _state.text = [FMAudioPlayer nameForType:[FMAudioPlayer sharedPlayer].playbackState];
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

@end
