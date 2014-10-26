//
//  KPTViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTViewController.h"

@interface KPTViewController ()


@end

@implementation KPTViewController

@synthesize player;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    [[NSNotificationCenter defaultCenter] addObserver: self
//                                             selector: @selector(toggleFullscreen:)
//                                                 name: @"toggleFullscreenNotification"
//                                               object: nil];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidAppear:(BOOL)animated {
    if ( self.player == nil ) {
        CGRect playerFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.player = [[KPViewController alloc] initWithFrame: playerFrame forView: self.view];
        [self.player setNativeFullscreen];
        [self.player setWebViewURL: iframeUrl];
    }
}

- (void)setIframeUrl: (NSString*)url {
    NSLog(@"setIframeUrl Enter");
    
    iframeUrl = url;
    
    NSLog(@"setIframeUrl Exit");
}

-(NSURL *)getInitialKIframeUrl {
    return [NSURL URLWithString: [iframeUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
}

- (void)toggleFullscreen: (NSNotification *)note {
    NSLog(@"toggleFullscreen Enter");
    
    NSDictionary *theData = [note userInfo];
    if (theData != nil) {
        NSNumber *n = [theData objectForKey: @"isFullScreen"];
        BOOL isFullScreen = [n boolValue];
        
        if ( isFullScreen ) {
            [[[UIApplication sharedApplication] delegate].window addSubview: self.player.view];
        }
        else if( !isFullScreen ) {
            [self.view addSubview: self.player.view];
        }
    }
    
    NSLog(@"toggleFullscreen Exit");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
