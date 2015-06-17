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
    UINib *uiNib = [UINib nibWithNibName:@"Player" bundle:nil];
    
    UIViewController *playerVC = [uiNib instantiateWithOwner:nil options:nil][0];
    
    [self presentViewController:playerVC animated:true completion:nil];
}

@end
