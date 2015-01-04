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
    NSString *iframeUrl;
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

- (void) playWithUrl:(NSString *)url {
    iframeUrl = url;
    [self performSegueWithIdentifier: @"showPlayer" sender: self];
}

- (void)appDidBecomeActive: (NSNotification *)notification {
    KPLogDebug(@"did become active notification");

    // Checks if received url scheme
    if (!self.class.URLScheme) {
        return;
    }
    
    [self dismissViewControllerAnimated: NO completion: nil];
    [self playWithUrl: self.class.URLScheme.absoluteString];
    self.class.URLScheme = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue: (UIStoryboardSegue *)segue sender: (id)sender {
    if ( [segue.identifier isEqualToString: @"showPlayer"] ) {
        if ( ![segue.destinationViewController isKindOfClass: [KPTViewController class]] ) {
            return;
        }
        
        [(KPTViewController *)segue.destinationViewController setIframeUrl: [iframeUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)enterClicked: (id)sender {
    KPLogTrace(@"Enter");
    [self playWithUrl: @"http://50.19.86.65/kgit/tags/v2.25.rc4/mwEmbedFrame.php?&wid=_243342&uiconf_id=13306622&entry_id=0_uka1msg4&flashvars[vast]={\"numPreroll\":\"1\",\"prerollInterval\":\"1\",\"prerollStartWith\":\"1\",\"prerollUrl\":\"http://projects.kaltura.com/MichalR/vast3_demo.xml\",\"overlayStartAt\":\"20\",\"overlayInterval\":\"300\",\"overlayUrl\":\"http://projects.kaltura.com/MichalR/vast_overlay.xml\",\"numPostroll\":\"1\",\"preSequence\":\"1\",\"postSequence\":\"1\",\"timeout\":\"4\"}&flashvars[adsOnReplay]=true&flashvars[nativeCallout]={\"plugin\":true}&playerId=myVideoTarget&forceMobileHTML5=true&urid=2.25.rc4__57a0ab85&flashvars[chromecast.plugin]=true"];
    KPLogTrace(@"Exit");
}

- (IBAction)hereClicked:(id)sender {
    KPLogTrace(@"Enter");
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://player.kaltura.com/docs/NativeCallout"]];
    KPLogTrace(@"Exit");
}

@end
