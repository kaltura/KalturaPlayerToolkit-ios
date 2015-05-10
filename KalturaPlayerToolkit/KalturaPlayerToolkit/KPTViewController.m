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
        dispatch_async(dispatch_get_main_queue(), ^{
            self.player = [[KPViewController alloc] initWithURL:[NSURL URLWithString:iframeUrl]];
//            self.player.configuration.enableHover = YES;
            self.player.configuration.advertiserID = @"test";
            self.player.configuration.enableOmniture = YES;
//            self.player.configuration.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscape;
//            [self performSelector:@selector(seek) withObject:nil afterDelay:12];
            
            
            self.player.currentPlaybackTime = 25;
            [self presentViewController:self.player animated:YES completion:nil];
        });
    }
}
             
- (void)seek {
    NSLog(@"%f", self.player.currentPlaybackTime);
    self.player.currentPlaybackTime = 25;
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
