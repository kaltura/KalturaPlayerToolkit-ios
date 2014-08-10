//
//  KPTViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTViewController.h"
#import "KPTAppDelegate.h"

@interface KPTViewController ()


@end

@implementation KPTViewController

@synthesize player;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(toggleFullscreen:)
                                                 name:@"toggleFullscreenNotification"
                                               object:nil];
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.player == nil) {
        self.player = [[KalPlayerViewController alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) forView: self.view];
        [self.player setNativeFullscreen];
        [self.player setDelegate: self];
    }
}

- (void)setUrl:(NSString*)str {
    url = str;
}

-(NSURL *)getInitialKIframeUrl {
//    http://cdnapi.kaltura.com/html5/html5lib/v2.15/mwEmbedFrame.php?wid=_243342&uiconf_id=23389712&entry_id=0_uka1msg4
    return [NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

- (void)toggleFullscreen:(NSNotification *)note {
    NSLog(@"toggleFullscreen Enter");
    
    NSDictionary *theData = [note userInfo];
    if (theData != nil) {
        NSNumber *n = [theData objectForKey:@"isFullScreen"];
        BOOL isFullScreen = [n boolValue];
        
        if ( isFullScreen ) {
            [[[UIApplication sharedApplication] delegate].window addSubview:player.view];
        }
        else if( !isFullScreen ){
            [self.view addSubview:player.view];
        }
    }
    
    NSLog(@"toggleFullscreen Exit");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
