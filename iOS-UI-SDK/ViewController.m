//
//  ViewController.m
//  iOS-UI-SDK
//
//  Created by Eric Lambrecht on 3/9/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)presentFullPagePlayer:(id)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Player" bundle:nil];
    UIViewController *vc = [sb instantiateViewControllerWithIdentifier:@"playerViewController"];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;

    [self.navigationController pushViewController:vc animated:YES];
}

@end
