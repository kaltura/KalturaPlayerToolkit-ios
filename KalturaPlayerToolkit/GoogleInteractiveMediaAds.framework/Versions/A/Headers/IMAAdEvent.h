/*! \file IMAAdEvent.h
 *  GoogleIMA3
 *
 *  Copyright (c) 2013 Google Inc. All rights reserved.
 *
 *  Defines a data object used to convey information during ad playback.
 *  This object is sent to the IMAAdsManager delegate.
 */

#import <Foundation/Foundation.h>

#import "IMAAd.h"

#pragma mark IMAAdEventType

/// Different event types sent by the IMAAdsManager to its delegate.
typedef enum {
  /// Ad break ready.
  kIMAAdEvent_AD_BREAK_READY,
  /// All ads managed by the ads manager have completed.
  kIMAAdEvent_ALL_ADS_COMPLETED,
  /// Ad clicked.
  kIMAAdEvent_CLICKED,
  /// Single ad has finished.
  kIMAAdEvent_COMPLETE,
  /// First quartile of a linear ad was reached.
  kIMAAdEvent_FIRST_QUARTILE,
  /// An ad was loaded.
  kIMAAdEvent_LOADED,
  /// Midpoint of a linear ad was reached.
  kIMAAdEvent_MIDPOINT,
  /// Ad paused.
  kIMAAdEvent_PAUSE,
  /// Ad resumed.
  kIMAAdEvent_RESUME,
  /// Ad has skipped.
  kIMAAdEvent_SKIPPED,
  /// Ad has started.
  kIMAAdEvent_STARTED,
  /// Ad tapped.
  kIMAAdEvent_TAPPED,
  /// Third quartile of a linear ad was reached.
  kIMAAdEvent_THIRD_QUARTILE
} IMAAdEventType;

#pragma mark - Ad Data Keys

/// The key for the time in seconds when the AD_BREAK_READY event fired.
static NSString *const kIMAAdBreakTime = @"kIMAAdBreakTime";

#pragma mark - IMAAdEvent

/// Simple data class used to transport ad playback information.
@interface IMAAdEvent : NSObject

/// Type of the event.
@property(nonatomic, readonly) IMAAdEventType type;

/// The current ad that is playing or just played. Can be nil.
@property(nonatomic, strong, readonly) IMAAd *ad;

/// Extra data about the ad. Can be nil.
@property(nonatomic, copy, readonly) NSDictionary *adData;

- (instancetype)init NS_UNAVAILABLE;

@end
