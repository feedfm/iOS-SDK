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
    FeedFMErrorCodeNetworkFailure = 1001,
    FeedFMErrorCodeInvalidRequest = 1002,
    FeedFMErrorCodeInvalidResponse = 1003,
    FeedFMErrorCodeUnauthorized = 1004,
    FeedFMErrorCodeInvalidRegion = 1005,
    FeedFMErrorCodeUnexpectedError = 1006,

    FeedFMErrorCodeClientCreationFailed = 1101,

    FeedFMErrorCodeSessionNotAvailable = 1201,
    FeedFMErrorCodeSessionRequestError = 1202,
    FeedFMErrorCodeSessionCreationFailed = 1203,
    FeedFMErrorCodeSessionUpdateFailed = 1204,

    FeedFMErrorCodeSkipNotAllowedForSimulcast = 1301,
    FeedFMErrorCodeSkipAlreadyInProgress = 1302,
    FeedFMErrorCodeLikeNoActiveStation = 1303,
    FeedFMErrorCodeLikeNoActiveItem = 1304,
    FeedFMErrorCodeLikeNotAllowed = 1305,
    FeedFMErrorCodeDislikeNoActiveStation = 1306,
    FeedFMErrorCodeDislikeNoActiveItem = 1307,
    FeedFMErrorCodeDislikeNotAllowed = 1308,
    FeedFMErrorCodeUnlikeNoActiveStation = 1309,
    FeedFMErrorCodeUnlikeNoActiveItem = 1310,
    FeedFMErrorCodeUnlikeNotAllowed = 1311,

    FeedFMErrorCodePlayerNotInitialized = 1401,
    FeedFMErrorCodePlayerPlaybackUnavailable = 1402,
    FeedFMErrorCodePlayerNoItemsToLoad = 1403,
    FeedFMErrorCodePlayerCouldNotLoadItem = 1404,
    FeedFMErrorCodePlayerNoMoreMusic = 1405,

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
