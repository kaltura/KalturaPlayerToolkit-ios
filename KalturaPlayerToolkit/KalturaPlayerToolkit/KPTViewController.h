//
//  KPTViewController.h
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KalPlayerSDK/KalPlayerViewController.h>

@interface KPTViewController : UIViewController <KalPlayerViewControllerDelegate> {
    NSString *iframeUrl;
}

@property (retain, nonatomic) KalPlayerViewController *player;

- (void)setIframeUrl:(NSString*)url;

@end
