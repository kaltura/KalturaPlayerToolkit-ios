//
//  IMAAdDisplayContainer.h
//  GoogleIMA3
//
//  Copyright (c) 2014 Google Inc. All rights reserved.
//
//  Declares the IMAAdDisplayContainer interface that manages the views,
//  ad slots, and displays used for ad playback.

#import <UIKit/UIKit.h>

/// The IMAAdDisplayContainer is responsible for managing the ad container view
/// and companion ad slots used for ad playback.
@interface IMAAdDisplayContainer : NSObject

/// View containing the video display and ad related UI.
@property(nonatomic, strong, readonly) UIView *adContainer;

/// List of companion ad slots. Can be nil or empty.
@property(nonatomic, copy, readonly) NSArray *companionSlots;

/// Initializes with the |adContainer| and |companionSlots| to use for ad
/// playback. |companionSlots| is an array of IMACompanionAdSlots.
- (instancetype)initWithAdContainer:(UIView *)adContainer
                     companionSlots:(NSArray *)companionSlots NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

@end
