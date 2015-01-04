//
//  KPTViewController.h
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KALTURAPlayerSDK/KPViewController.h>

@interface KPTViewController : UIViewController {
    NSString *iframeUrl;
}

@property (retain, nonatomic) KPViewController *player;

- (void)setIframeUrl:(NSString *)url;

@end
