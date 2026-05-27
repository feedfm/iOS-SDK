//
//  FeedFMError.h
//  FeedMediaCore
//
//  Created by Balazs Kiss on 2025. 03. 20..
//  Copyright © 2025. Feed Media. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, FeedFMErrorCode) {
    /** Network connection failed. Please check your internet connection and try again. */
    FeedFMErrorCodeNetworkFailure = 1001,
    /** The request was malformed or contained invalid parameters. */
    FeedFMErrorCodeInvalidRequest = 1002,
    /** Received an invalid response from the server. */
    FeedFMErrorCodeInvalidResponse = 1003,
    /** Unauthorized access. Check your credentials or authentication token. */
    FeedFMErrorCodeUnauthorized = 1004,
    /** Invalid region, service is not available in your current geographic region. */
    FeedFMErrorCodeInvalidRegion = 1005,
    /** An unexpected error occurred. */
    FeedFMErrorCodeUnexpectedError = 1006,
    /** The request timed out. Please try again. */
    FeedFMErrorCodeRequestTimeout = 1007,

    /** Failed to create the client. */
    FeedFMErrorCodeClientCreationFailed = 1101,

    /** Session is not available. Ensure that a session is created before making this request. */
    FeedFMErrorCodeSessionNotAvailable = 1201,
    /** An error occurred while sending a request to the session. */
    FeedFMErrorCodeSessionRequestError = 1202,
    /** Failed to create a session. */
    FeedFMErrorCodeSessionCreationFailed = 1203,
    /** Failed to update the session. */
    FeedFMErrorCodeSessionUpdateFailed = 1204,

    /** Skipping is not allowed for simulcast stations. */
    FeedFMErrorCodeSkipNotAllowedForSimulcast = 1301,
    /** Skip operation is already in progress. */
    FeedFMErrorCodeSkipAlreadyInProgress = 1302,
    /** No active station to like. */
    FeedFMErrorCodeLikeNoActiveStation = 1303,
    /** No active item to like. */
    FeedFMErrorCodeLikeNoActiveItem = 1304,
    /** Like operation is not allowed. */
    FeedFMErrorCodeLikeNotAllowed = 1305,
    /** No active station to dislike. */
    FeedFMErrorCodeDislikeNoActiveStation = 1306,
    /** No active item to dislike. */
    FeedFMErrorCodeDislikeNoActiveItem = 1307,
    /** Dislike operation is not allowed. */
    FeedFMErrorCodeDislikeNotAllowed = 1308,
    /** No active station to unlike. */
    FeedFMErrorCodeUnlikeNoActiveStation = 1309,
    /** No active item to unlike. */
    FeedFMErrorCodeUnlikeNoActiveItem = 1310,
    /** Unlike operation is not allowed. */
    FeedFMErrorCodeUnlikeNotAllowed = 1311,

    /** Audio player is not initialized. */
    FeedFMErrorCodePlayerNotInitialized = 1401,
    /** Playback is unavailable. */
    FeedFMErrorCodePlayerPlaybackUnavailable = 1402,
    /** No audio items are available to load. */
    FeedFMErrorCodePlayerNoItemsToLoad = 1403,
    /** Could not load the requested item. */
    FeedFMErrorCodePlayerCouldNotLoadItem = 1404,
    /** Unable to retrieve more music for the current station/birate/codec configuration. */
    FeedFMErrorCodePlayerNoMoreMusic = 1405,
    /** Could not set the requested station. */
    FeedFMErrorCodePlayerCouldNotSetStation = 1406,
    /** Preparing the player timed out. */
    FeedFMErrorCodePlayerPrepareTimeout = 1407,

    /** An unknown error occurred. Please try again or contact support if the issue continues. */
    FeedFMErrorCodeUnknown = 9999
};

/**
 * FeedFMError is a custom error class for handling errors in the FeedFM SDK.
 * It provides a way to create and manage errors with specific codes and descriptions.
 * This class is used internally by the SDK to report errors to the client application.
 */
@interface FeedFMError : NSError

/**
 * Creates a new FeedFMError instance with the specified error code.
 * 
 * @param code The error code.
 */
+ (instancetype)errorWithCode:(FeedFMErrorCode)code;

/**
 * Creates a new FeedFMError instance with the specified error code and underlying error.
 * 
 * @param code The error code.
 * @param underlyingError The underlying error that caused this error, if any.
 */
+ (instancetype)errorWithCode:(FeedFMErrorCode)code underlyingError:(NSError * _Nullable)underlyingError;

/**
 * Returns a string description for the specified error code.
 * 
 * @param code The error code.
 */
+ (NSString *)descriptionForCode:(FeedFMErrorCode)code;

@end

NS_ASSUME_NONNULL_END
