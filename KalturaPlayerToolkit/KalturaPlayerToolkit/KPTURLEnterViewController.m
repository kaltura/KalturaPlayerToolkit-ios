//
//  KPTURLEnterViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 8/10/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTURLEnterViewController.h"
#import "KPTViewController.h"

/// Sotres the urlScheme value
static NSURL *urlScheme;

@interface KPTURLEnterViewController() {
    KPPlayerConfig *config;
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


#pragma mark URLScheme
+ (void)setURLScheme:(NSURL *)url {
    @synchronized(self) {
        NSArray *components = [url.absoluteString componentsSeparatedByString:@":="];
        if (components.count == 2) {
            urlScheme = [NSURL URLWithString:components.lastObject];
        } else {
            urlScheme = nil;
        }
    }
}

+ (NSURL *)URLScheme {
    @synchronized(self) {
        return urlScheme;
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(appDidBecomeActive:)
                                                 name: UIApplicationDidBecomeActiveNotification
                                               object: nil];
}

//- (void) playWithUrl:(NSString *)url {
//    iframeUrl = url;
//    [self performSegueWithIdentifier: @"showPlayer" sender: self];
//}

- (void)appDidBecomeActive: (NSNotification *)notification {
    KPLogDebug(@"did become active notification");

    // Checks if received url scheme
    if (!self.class.URLScheme) {
        return;
    }
    if (!self.childViewControllers.count) {
        [self performSegueWithIdentifier: @"showPlayer" sender: self];
    }
    
//    [self dismissViewControllerAnimated: NO completion: nil];
//    self.class.URLScheme = nil;
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
            [(KPTViewController *)segue.destinationViewController setIframeUrl: self.class.URLScheme.absoluteString];
        } else {
            [(KPTViewController *)segue.destinationViewController setConfig: config];
        }
        
        
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)enterClicked: (id)sender {
    KPLogTrace(@"Enter");
//    [self playWithUrl: @"http://10.0.21.18/html5.kaltura/mwEmbed/mwEmbedFrame.php?&wid=_1091&uiconf_id=15094011&cache_st=1418629658&entry_id=0_czq4o7u6&flashvars%5BForceFlashOnDesktopSafari%5D=true&flashvars%5BnativeCallout%5D=%7B%22plugin%22%3Atrue%7D&playerId=kaltura_player_1418629658&forceMobileHTML5=true&urid=2.31.rc8&flashvars%5Bchromecast.plugin%5D=true"];
    config = [[KPPlayerConfig alloc] initWithDomain:@"http://10.0.20.198/html5.kaltura/mwEmbed/mwEmbedFrame.php"
                                           uiConfID:@"26698911"
                                           playerID:@"kaltura_player_1418629658"];
    config.wid = @"_1831271";
    config.cacheSt = @"1427884676";
    config.entryId = @"1_m1m2cnoz";
    config.urid = @"2.33.rc24";
    config.cacheSize = 0.5;
    [self performSegueWithIdentifier: @"showPlayer" sender: self];
    KPLogTrace(@"Exit");
}

- (IBAction)hereClicked:(id)sender {
    KPLogTrace(@"Enter");
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://player.kaltura.com/docs/NativeCallout"]];
    KPLogTrace(@"Exit");
}

@end
