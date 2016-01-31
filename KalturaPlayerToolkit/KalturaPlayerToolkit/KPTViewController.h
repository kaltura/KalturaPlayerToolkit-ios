//
//  KPTViewController.h
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KALTURAPlayerSDK/KPViewController.h>

@interface KPTViewController : UIViewController <KPViewControllerDelegate> {
    NSString *iframeUrl;
}

@property (strong, nonatomic) KPViewController *player;
@property (nonatomic, strong) KPPlayerConfig *config;

- (void)setIframeUrl:(NSString*)url;

@end
