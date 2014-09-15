//
//  KPTURLEnterViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 8/10/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTURLEnterViewController.h"
#import "KPTAppDelegate.h"
#import "KPTViewController.h"

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
    NSLog(@"did become active notification");
    
    KPTAppDelegate *delegate = (KPTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (delegate.urlSchemeIframeUrlParam == nil) {
        return;
    }
    
    [self dismissViewControllerAnimated: NO completion: nil];
    [self playWithUrl: delegate.urlSchemeIframeUrlParam];
    delegate.urlSchemeIframeUrlParam = nil;
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
        
        [(KPTViewController *)segue.destinationViewController setIframeUrl: iframeUrl];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)enterClicked: (id)sender {
    NSLog(@"enterClicked Enter");
    
    [self playWithUrl: @"http://kgit.html5video.org/tags/playerToolkit-v2.19.1/mwEmbedFrame.php/wid/_243342/uiconf_id/21099702/entry_id/0_c0r624gh/?&flashvars%5BconfFilePath%5D=%7BlibPath%7D%2Fmodules%2FKalturaSupport%2Ftests%2FconfFiles%2FjsonConfig.json&flashvars%5BKaltura.UseAppleAdaptive%5D=false&flashvars%5Bks%5D=MjYyNjQ4NTY1MzQxODMxNTM0ODhiYjNkZjk4YTg2ZDYzODU2M2NlM3wyNDMzNDI7MjQzMzQyOzE0MTA4MTEzNjY7MDsxNDEwNzI0OTY2LjI2NzU7MDt2aWV3Oiosd2lkZ2V0OjE7Ow%3D%3D&flashvars%5Bchromecast.plugin%5D=true"];
    
    NSLog(@"enterClicked Exit");
}

- (IBAction)hereClicked:(id)sender {
    NSLog(@"enterClicked Enter");
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://player.kaltura.com/docs/NativeCallout"]];
    
    NSLog(@"enterClicked Exit");
}

@end
