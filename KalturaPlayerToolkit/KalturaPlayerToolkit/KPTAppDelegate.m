//
//  KPTAppDelegate.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTAppDelegate.h"
#import "KPTURLEnterViewController.h"
#import <KALTURAPlayerSDKFW/KALTURAPlayerSDKFW.h>

@implementation KPTAppDelegate

static NSURL *urlScheme;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[[Foo alloc] init] bar];
    
    // Override point for customization after application launch.
    return YES;
}

// iOS8
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {   
    self.URLScheme = url;
    KPTURLEnterViewController.URLScheme = url;

    return YES;
}

// iOS7
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    KPTURLEnterViewController.URLScheme = url;
    return YES;
}

// iOS9
- (BOOL)application:(UIApplication *)application continueUserActivity:(nonnull NSUserActivity *)userActivity restorationHandler:(nonnull void (^)(NSArray * _Nullable))restorationHandler {
    self.iframeUrl = userActivity.webpageURL;
    self.URLScheme = userActivity.webpageURL;
    return YES;
}

- (void)setURLScheme:(NSURL *)url {
    @synchronized(self) {
        NSDictionary* parameters = [self parseQueryString:url];
        NSString* embedFrameURL = parameters[@"embedFrameURL"];
        if (embedFrameURL) {
            self.iframeUrl = [NSURL URLWithString:embedFrameURL];
        }
    }
}

- (NSDictionary*)parseQueryString:(NSURL*)url {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSString *pair in [url.query componentsSeparatedByString:@"&"]) {
        NSArray* keyValue = [pair componentsSeparatedByString:@"="];
        NSString *key = keyValue.firstObject;
        NSString *value = keyValue.lastObject;
        
        value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        dict[key] = value;
    }
    
    return dict;
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error NS_AVAILABLE_IOS(8_0) {
    
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
