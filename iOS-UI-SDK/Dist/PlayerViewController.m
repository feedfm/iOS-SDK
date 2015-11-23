//
//  RadioViewController.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 6/14/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

@import Foundation;

#import "PlayerViewController.h"
#import "FeedMedia/FMAudioPlayer.h"
#import "FMMetadataLabel.h"
#import "StationBackgroundState.h"

@interface PlayerViewController () <UIPopoverPresentationControllerDelegate>

@property (weak, nonatomic) FMAudioPlayer *player;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;

@property (weak, nonatomic) IBOutlet UILabel *pressPlay;

@property (weak, nonatomic) IBOutlet FMMetadataLabel *track;
@property (weak, nonatomic) IBOutlet FMMetadataLabel *artist;
@property (weak, nonatomic) IBOutlet FMMetadataLabel *album;

@end

static NSMutableDictionary *stations = nil;

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // set the lock screen up to share the player background
    // (this only appears when phone is playing music and is locked)
    [_player setLockScreenImage:self.backgroundImage.image];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // MarqueeLabel uses Core Animation, which apparently causes problems when views
    // appear and disappear and the animation stopped by iOS does not automatically
    // restart.
    [MarqueeLabel restartLabelsOfController:self];
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
