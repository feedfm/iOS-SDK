//
//  FMFullScreenPlayerViewController.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 4/25/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMFullScreenPlayerViewController.h"

@interface FMFullScreenPlayerViewController ()

@property IBOutlet UIView *playerContainer;

@end

@implementation FMFullScreenPlayerViewController

- (IBAction)showPoweredByFeed:(id)sender {
    UINib *uiNib = [UINib nibWithNibName:@"FMFullScreenLegalViewController" bundle:nil];
    
    UIViewController *vc = [uiNib instantiateWithOwner:nil options:nil][0];
    
    [self presentViewController:vc animated:true completion:nil];
}


- (IBAction)close:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:true completion:nil];
}


@end
