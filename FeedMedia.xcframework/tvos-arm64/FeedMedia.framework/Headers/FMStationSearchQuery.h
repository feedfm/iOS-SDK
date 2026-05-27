//
//  FMStationSearchQuery.h
//  FeedMediaCore
//
//  Copyright (c) 2025 Feed Media, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Station search type enum for use with FMStationSearchQuery.
 *
 * In Swift, use the typed enum values (e.g. `.radio`).
 * In Objective-C, use `FMStationSearchTypeRadio`, etc.
 */
typedef NS_ENUM(NSInteger, FMStationSearchType) {
    /** Radio station type - standard streaming radio station */
    FMStationSearchTypeRadio,
    /** First play station type - plays through a station from the beginning */
    FMStationSearchTypeFirstPlay,
    /** Replay station type - replays content from a station */
    FMStationSearchTypeReplay
};

/**
 * Represents a search query for finding a music station.
 *
 * This class encapsulates the criteria used to search for a station that matches
 * specific requirements. Multiple FMStationSearchQuery objects can be provided to
 * `searchForAndSetActiveStation:` and they will be executed in sequence until a
 * matching station is found.
 *
 * Example usage (Objective-C):
 * @code
 * FMStationSearchQuery *query = [FMStationSearchQuery radioWithAdvance:0
 *                                                              filter:@{ @"name": @"Global Radio" }];
 * @endcode
 *
 * Example usage (Swift):
 * @code
 * let query = FMStationSearchQuery.radio(withAdvance: 0, filter: ["name": "Global Radio"])
 * @endcode
 */
@interface FMStationSearchQuery : NSObject

/**
 * The type of station to search for as a string ("radio", "first_play", "replay").
 *
 * This is nil when no specific type is required (i.e. any station type may match).
 */
@property (nonatomic, strong, nullable, readonly) NSString *type;

/**
 * The number of seconds into the station where playback should begin.
 *
 * Only applies to first_play and replay stations. Ignored for radio stations.
 * For example, to start 5 minutes into a first play station, set this to 300.
 */
@property (nonatomic, readonly) NSTimeInterval advance;

/**
 * A MongoDB-style filter object for matching station attributes.
 *
 * This is a dictionary containing logical tests against station attributes.
 * Examples:
 * - Equality: @{ @"name": @"foo bar" }
 * - Substring: @{ @"name": @"*bar" } (ends with "bar")
 * - $in operator: @{ @"name": @{ @"$in": @[@"foo", @"bar"] } }
 * - $ne operator: @{ @"name": @{ @"$ne": @"global" } }
 * - $exists operator: @{ @"genre": @{ @"$exists": @YES } }
 *
 * If nil, no attribute filtering is applied.
 */
@property (nonatomic, strong, nullable, readonly) NSDictionary<NSString *, id> *filter;

#pragma mark - Typed Initializers

/**
 * Initializes a station search query with an explicit type enum.
 *
 * @param type The station type enum value
 * @param advance The number of seconds into the station where playback should begin
 * @param filter A MongoDB-style filter dictionary, or nil for no filtering
 * @return A new FMStationSearchQuery instance
 */
- (instancetype)initWithType:(FMStationSearchType)type
                     advance:(NSTimeInterval)advance
                      filter:(NSDictionary<NSString *, id> *_Nullable)filter;

#pragma mark - Untyped Initializer

/**
 * Initializes a station search query without specifying a type (any type may match).
 *
 * @param advance The number of seconds into the station where playback should begin
 * @param filter A MongoDB-style filter dictionary, or nil for no filtering
 * @return A new FMStationSearchQuery instance
 */
- (instancetype)initWithAdvance:(NSTimeInterval)advance
                         filter:(NSDictionary<NSString *, id> *_Nullable)filter;

#pragma mark - Typed Convenience Constructors

/**
 * Creates a radio station search query.
 *
 * @param advance The number of seconds into the station where playback should begin (ignored for radio stations)
 * @param filter A MongoDB-style filter dictionary, or nil for no filtering
 * @return A new FMStationSearchQuery instance with type set to radio
 */
+ (instancetype)radioWithAdvance:(NSTimeInterval)advance
                          filter:(NSDictionary<NSString *, id> *_Nullable)filter;

/**
 * Creates a first play station search query.
 *
 * @param advance The number of seconds into the station where playback should begin
 * @param filter A MongoDB-style filter dictionary, or nil for no filtering
 * @return A new FMStationSearchQuery instance with type set to first_play
 */
+ (instancetype)firstPlayWithAdvance:(NSTimeInterval)advance
                              filter:(NSDictionary<NSString *, id> *_Nullable)filter;

/**
 * Creates a replay station search query.
 *
 * @param advance The number of seconds into the station where playback should begin
 * @param filter A MongoDB-style filter dictionary, or nil for no filtering
 * @return A new FMStationSearchQuery instance with type set to replay
 */
+ (instancetype)replayWithAdvance:(NSTimeInterval)advance
                           filter:(NSDictionary<NSString *, id> *_Nullable)filter;

#pragma mark - Serialization

/**
 * Converts this query to a dictionary suitable for JSON encoding in API requests.
 *
 * Only non-nil/non-default properties are included in the returned dictionary.
 * The offset is always included.
 *
 * @return A dictionary representation of this query
 */
- (NSDictionary *)toDictionary;

@end

NS_ASSUME_NONNULL_END
