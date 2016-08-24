//
//  FMTotalTimeLabel.h
//  iOS-UI-SDK
//
//  This class extends UILabel to automatically set its
//  text to be the total duration of the currently playing
//  song, or the value of the textForNoTime property. The
//  setText: call is stubbed out so that the text cannot be
//  changed by the client.
//
//  Created by Eric Lambrecht on 3/10/15.
//  Copyright (c) 2015 Feed Media. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 
 This label automatically sets its `text` value to represent the
 total playback time of the current song. If the `textForNoTime`
 property is set, then `text` is set to that value when there is
 no currently playing or paused song.
 
 */

//NOT_IB_DESIGNABLE
@interface FMTotalTimeLabel : UILabel

/**
 
 If set, this label will set its `text` property to this value
 when no song is playing or paused.
 
 */

@property (strong, nonatomic) IBInspectable NSString *textForNoTime;

@end
