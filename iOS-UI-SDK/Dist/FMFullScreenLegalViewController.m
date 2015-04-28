//
//  FMFullScreenLegalViewController.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 4/26/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "FMFullScreenLegalViewController.h"

@interface FMFullScreenLegalViewController ()

@end

@implementation FMFullScreenLegalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)close:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:true completion:nil];
}

@end
