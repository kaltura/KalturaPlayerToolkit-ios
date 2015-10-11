//
//  KPTAppDelegate.h
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, strong) NSDictionary *urlSchemeParameters;
@property (nonatomic, strong) NSString *urlSchemeIframeUrlParam;

@end
