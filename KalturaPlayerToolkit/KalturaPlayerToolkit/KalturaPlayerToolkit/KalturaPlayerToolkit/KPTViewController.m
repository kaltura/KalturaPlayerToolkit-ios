//
//  KPTViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTViewController.h"


@interface KPTViewController () <KPControllerDelegate>
@property (nonatomic, strong) UIView *playerView;
@end


@implementation KPTViewController
@synthesize player;

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidAppear:(BOOL)animated {
    if ( self.player == nil ) {
        KPViewController.logLevel = KPLogLevelTrace;
        if (_config) {
            self.player = [[KPViewController alloc] initWithConfiguration:_config];
        } else {
            self.player = [[KPViewController alloc] initWithURL:[NSURL URLWithString:iframeUrl]];
        }
        [self presentViewController:self.player animated:YES completion:nil];
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
