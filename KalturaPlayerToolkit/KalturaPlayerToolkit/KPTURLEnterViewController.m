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


- (IBAction)enterClicked: (id)sender {
    NSLog(@"enterClicked Enter");
    
    [self playWithUrl: self.urlTextField.text];
    
    NSLog(@"enterClicked Exit");
}

@end
