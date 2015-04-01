//
//  KPTViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTViewController.h"


@interface KPTViewController ()

@property (nonatomic, strong) KPPlayerConfig *requestConfig;
@property (nonatomic, strong) UIView *playerView;
@end


@implementation KPTViewController
@synthesize player;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidAppear:(BOOL)animated {
    if ( self.player == nil ) {
        KPViewController.logLevel = KPLogLevelAll;
//        self.player = [[KPViewController alloc] initWithFrame: playerFrame forView: self.view];
//        
//        [self.player setNativeFullscreen];
//        //self.player
//        //self.player.datasource = self;
//        //[self.player load];
//        [self.player setWebViewURL:iframeUrl];
        
    }
}


- (void)setIframeUrl: (NSString*)url {
    KPLogTrace(@"Enter");
    
    iframeUrl = url;
    KPLogTrace(@"Exit");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
