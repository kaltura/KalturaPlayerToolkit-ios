//
//  KPTViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTViewController.h"
#import "KPTURLEnterViewController.h"
#import "KPTAppDelegate.h"


@interface KPTViewController (){
    BOOL firstChnage;
    id appDelegate;
}
@property (weak, nonatomic) IBOutlet UIView *pv;
@property (nonatomic, strong) UIView *playerView;
@end


@implementation KPTViewController

- (void)viewDidLoad {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    firstChnage = NO;
    appDelegate = (KPTAppDelegate *)[UIApplication sharedApplication].delegate;
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(changeMedia:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Show View" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidBecomeActive:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [self createPlayer];
    [super viewDidAppear:animated];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)createPlayer {
    if ( self.player == nil ) {
        KPViewController.logLevel = KPLogLevelTrace;
        
        if (_config) {
            self.player = [[KPViewController alloc] initWithConfiguration:_config];
        } else {
            self.player = [[KPViewController alloc] initWithURL:[NSURL URLWithString:iframeUrl]];
        }
        
        self.player.delegate = self;
        [self presentViewController:self.player animated:YES completion:nil];
        [KPViewController setLogLevel:KPLogLevelError];
    }
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    NSString *newIframeUrl = [((KPTAppDelegate *)[UIApplication sharedApplication].delegate).iframeUrl absoluteString];
    
    if(newIframeUrl != nil &&
       ![newIframeUrl isEqualToString:iframeUrl]){
        [self setIframeUrl:newIframeUrl];
        [self.player dismissViewControllerAnimated:YES completion:nil];
        self.config = nil;
        [self.player removePlayer];
        self.player = nil;
        [self createPlayer];
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
