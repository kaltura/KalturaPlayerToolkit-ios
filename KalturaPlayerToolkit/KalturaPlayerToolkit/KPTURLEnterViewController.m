//
//  KPTURLEnterViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 8/10/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTURLEnterViewController.h"
#import "KPTViewController.h"
#import "KPTAppDelegate.h"

/// Sotres the urlScheme value
static NSURL *urlScheme;

@interface KPTURLEnterViewController() {
    KPPlayerConfig *config;
    BOOL isVisible;
}

@end

@implementation KPTURLEnterViewController

- (id)initWithNibName: (NSString *)nibNameOrNil bundle: (NSBundle *)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    
    if ( self ) {
        // Custom initialization
    }
    
    return self;
}

+(NSDictionary*)parseQueryString:(NSURL*)url {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    for (NSString *pair in [url.query componentsSeparatedByString:@"&"]) {
        NSArray* keyValue = [pair componentsSeparatedByString:@"="];
        NSString *key = keyValue.firstObject;
        NSString *value = keyValue.lastObject;
        
        value = [value stringByReplacingOccurrencesOfString:@"+" withString:@" "];
        value = [value stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        dict[key] = value;
    }
    
    return dict;
}


#pragma mark URLScheme
+ (void)setURLScheme:(NSURL *)url {
    @synchronized(self) {
        NSDictionary* parameters = [self parseQueryString:url];
        NSString* embedFrameURL = parameters[@"embedFrameURL"];
        if (embedFrameURL) {
            urlScheme = [NSURL URLWithString:embedFrameURL];
        }
    }
}

+ (NSURL *)URLScheme {
    @synchronized(self) {
        return urlScheme;
    }
}



- (void)viewDidLoad {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setNeedsStatusBarAppearanceUpdate];
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appDidBecomeActive:)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
    // Deeplink when app is closed  
    isVisible = YES;
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    KPLogDebug(@"did become active notification");

    if (!isVisible) {
        return;
    }
    
    // Checks if received url scheme
    if (!self.class.URLScheme) {
        return;
    }
    // Deep Link
    if (!self.childViewControllers.count) {
        [self performSegueWithIdentifier:@"showPlayer" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender {
    if ( [segue.identifier isEqualToString: @"showPlayer"] ) {
        if (self.class.URLScheme) {
            config = [KPPlayerConfig configWithEmbedFrameURL:[((KPTAppDelegate *)[UIApplication sharedApplication].delegate).iframeUrl absoluteString]];
        }
        [(KPTViewController *)[segue destinationViewController] setConfig: config];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    isVisible = YES;
    [super viewDidDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    isVisible = NO;
    [super viewDidDisappear:animated];
}
- (BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)enterClicked: (id)sender {
    KPLogTrace(@"Enter");
    config = [[KPPlayerConfig alloc] initWithDomain:@"http://cdnapi.kaltura.com/"
                                           uiConfID:@"32855491"
                                          partnerId:@"1424501"];
    config.entryId = @"1_jqlytpfw";
    [config addConfigKey:@"chromecast.plugin" withValue:@"true"];
    [self performSegueWithIdentifier: @"showPlayer" sender: self];
    KPLogTrace(@"Exit");
}

- (IBAction)hereClicked:(id)sender {
    KPLogTrace(@"Enter");
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://player.kaltura.com/docs/NativeCallout"]];
    KPLogTrace(@"Exit");
}

@end
