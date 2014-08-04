//
//  KPTViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTViewController.h"
#import "KPTAppDelegate.h"

@interface KPTViewController () {
    KalPlayerViewController *player;
}

@end

@implementation KPTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
	// Do any additional setup after loading the view, typically from a nib.
    
    player = [[KalPlayerViewController alloc] initWithFrame: CGRectMake(0, 0, 320, 480) forView: self.view];
    [player setDelegate: self];
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    NSLog(@"did become active notification");
    KPTAppDelegate *delegate = (KPTAppDelegate *)[UIApplication sharedApplication].delegate;
    [player setWebViewURL: delegate.urlSchemeIframeUrlParam];
    
//    if (delegate.urlSchemeParameters) {
//        // Came  from url.
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome from url!" message:[NSString stringWithFormat:@"Hello, %@. How is it in %@?", [delegate.urlSchemeParameters objectForKey:@"name"], [delegate.urlSchemeParameters objectForKey:@"city"]] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//        [alert show];
//        delegate.urlSchemeParameters = nil;
//    }
}

-(NSURL *)getInitialKIframeUrl {
    NSString *iframeURL = @"http://localhost/html5.kaltura/mwEmbed/mwEmbedFrame.php/p/243342/uiconf_id/12905712/entry_id/0_uka1msg4?wid=_243342&iframeembed=true&entry_id=0_s26q4ryp";
    
    return [NSURL URLWithString:[iframeURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
