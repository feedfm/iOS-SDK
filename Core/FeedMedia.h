//
//  FeedMedia.h
//
//  Created by Eric Lambrecht on 2/2/16.
//
//  Variant of the FeedMedia.h umbrella file that includes
//  all the core functions plus the UI components.
//

#ifndef FeedMedia_h
#define FeedMedia_h

#include "FeedMediaVersion.h"
#include "FeedMediaCore.h"

#ifdef FEED_MEDIA_INCLUDE_UI

#include "FMActivityIndicator.h"
#include "FMDislikeButton.h"
#include "FMElapsedTimeLabel.h"
#include "FMLikeButton.h"
#include "FMMetadataLabel.h"
#include "FMPlayPauseButton.h"
#include "FMProgressView.h"
#include "FMRemainingTimeLabel.h"
#include "FMShareButton.h"
#include "FMSkipButton.h"
#include "FMSkipWarningView.h"
#include "FMStationButton.h"
#include "FMTotalTimeLabel.h"

#endif /* FEED_MEDIA_INCLUDE_UI */

#endif /* FeedMedia_h */
