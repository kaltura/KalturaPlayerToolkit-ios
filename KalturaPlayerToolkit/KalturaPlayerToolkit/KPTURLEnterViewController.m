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
    NSLog(@"did become active notification");

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
        
        [(KPTViewController *)segue.destinationViewController setIframeUrl: iframeUrl];
    }
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (IBAction)enterClicked: (id)sender {
    NSLog(@"enterClicked Enter");
    
    [self playWithUrl: @"http://localhost:80/html5.kaltura/mwEmbed/mwEmbedFrame.php/wid/_1831271/uiconf_id/26698911/entry_id/0_kxnolg69/?&flashvars%5BconfFilePath%5D=%7BlibPath%7D%2Fmodules%2FKalturaSupport%2Ftests%2FconfFiles%2FjsonConfig.json&flashvars%5BKaltura.UseAppleAdaptive%5D=false&flashvars%5BdjJ8MTgzMTI3MXxCr9fKa_8y6chkmClaI8bKMW_Lu_M0fmN5P5RbXlIVyOnsI2yQosYfLn7g0Ku9AagBk6eTgtqbJKKgRRDVjsnC_jNtikrWe8JKY5AAJMaqTmT_BH22x2-h5z7tGUPv3sQKTXjr95998R3wzZHjw7ch&flashvars%5Bchromecast.plugin%5D=true"];
    
    NSLog(@"enterClicked Exit");
}

- (IBAction)hereClicked:(id)sender {
    NSLog(@"enterClicked Enter");
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://player.kaltura.com/docs/NativeCallout"]];
    
    NSLog(@"enterClicked Exit");
}

@end
