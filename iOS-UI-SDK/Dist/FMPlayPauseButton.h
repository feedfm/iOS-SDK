//
//  FMPlayPauseButton.h
//  UITests
//
//  Created by Eric Lambrecht on 3/6/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface FMPlayPauseButton : UIView

@property (weak, nonatomic) IBInspectable UIImage *playImage;
@property (weak, nonatomic) IBInspectable UIImage *pauseImage;

@property (weak, nonatomic) IBInspectable NSString *playTitle;
@property (weak, nonatomic) IBInspectable NSString *pauseTitle;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable BOOL previewPlayButton;
#endif

- (void) stylePlayButton:(UIButton *)button withImage:(UIImage *) image andTitle:(NSString *) title;
- (void) stylePauseButton:(UIButton *)button withImage:(UIImage *) image andTitle:(NSString *) title;
- (void) styleSpinner:(UIActivityIndicatorView *) spinner;

@end
