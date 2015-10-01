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
//        NSArray *components = [url.absoluteString componentsSeparatedByString:@"?"];
//        if (components.count == 2) {
//            urlScheme = [NSURL URLWithString:components.lastObject];
//        } else {
//            urlScheme = nil;
//        }
        urlScheme = [NSURL URLWithString:[url.absoluteString stringByReplacingOccurrencesOfString:@"https://kalturaplay.appspot.com/play?" withString:@""]];
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
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test:) name:KPMediaPlaybackStateDidChangeNotification object:nil];
}

- (void)test:(NSNotification *)noti {
    
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
    config = [[KPPlayerConfig alloc] initWithDomain:@"https://cdnapisec.kaltura.com"
                                           uiConfID:@"26698911"
                                          partnerId:@"1831271"];
    config.entryId = @"1_1fncksnw";
//    [config addConfigKey:@"chromecast.plugin" withValue:@"true"];
//    [config addConfigKey:@"LeadWithHLSOnFlash" withValue:@"true"];
//    [config addConfigKey:@"ks"
//withValue:@"MGNiZDE3ODc2MzBkZTYyYjNkYTlmODIyNmY4MGMyYzdlZTZkNmI1OHwxNzgyMzkxOzE3ODIzOTE7MTQ0MzE2OTA0NzswOzE0NDMwODI2NDcuODU5NTtkb3VnLndvb2RhcmRAdmlzaW9ubWVkaWFtZ210LmNvbTtzdmlldzoqOzs="];
//    [config addConfigKey:@"referenceId" withValue:@"9780133965803-9780133965803-2015-03-11-21-05-53-808772"];
    
//     Video Entry
//    config.entryId = @"1_o426d3i4";
    
//    http://192.168.161.80/html5.kaltura/mwEmbed/mwEmbedFrame.php?&entry_id=0_uka1msg4&uiconf_id=12905712&wid=_243342&p=243342&cache_st=1292436446&flashvars%5BexternalInterfaceDisabled%5D=false&flashvars%5BnativeCallout%5D=%257B%2522plugin%2522%253Atrue%257D&playerId=kaltura_player&debug=true&forceMobileHTML5=true&urid=2.35&flashvars%5Bchromecast.plugin%5D=true
    
//     Double click params
//    [config addConfigKey:@"doubleClick.adTagUrl"
//               withValue:@"http://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=%2F3510761%2FadRulesSampleTags&ciu_szs=160x600%2C300x250%2C728x90&cust_params=adrule%3Dpremidpostwithpod&impl=s&gdfp_req=1&env=vp&ad_rule=1&vid=12345&cmsid=3601&output=xml_vast2&unviewed_position_start=1&url=[referrer_url]&correlator=[timestamp]"];
//    
//    [config addConfigKey:@"doubleClick.plugin"
//               withValue:@"true"];
//    
//    [config addConfigKey:@"doubleClick.path"
//               withValue:@"http://cdnbakmi.kaltura.com/content/uiconf/ps/veria/kdp3.9.1/plugins/doubleclickPlugin.swf"];
//    [config addConfigKey:@"adsOnReplay" withValue:@"true"];
//    
    
    // Configuration for Native app
//    [config addConfigKey:@"nativeCallout.plugin"
//               withValue:@"true"];
//    config.cacheSize = 0.8;
//    NSString *link = @"http://10.0.0.8/html5.kaltura/mwEmbed/mwEmbedFrame.php?&wid=_243342&uiconf_id=25550701&entry_id=0_uka1msg4&flashvars[doubleClick]={\"plugin\":true,\"path\":\"http://cdnbakmi.kaltura.com/content/uiconf/ps/veria/kdp3.9.1/plugins/doubleclickPlugin.swf\",\"adTagUrl\":\"http://pubads.g.doubleclick.net/gampad/ads?sz=640x480&iu=/3510761/adRulesSampleTags&ciu_szs=160x600,300x250,728x90&cust_params=adrule=premidpostwithpod&impl=s&gdfp_req=1&env=vp&ad_rule=1&vid=12345&cmsid=3601&output=xml_vast2&unviewed_position_start=1&url=[referrer_url]&correlator=[timestamp]\",\"disableCompanionAds\":false,\"debugMode\":false}&flashvars[adsOnReplay]=true&flashvars[nativeCallout]={\"plugin\":true}&playerId=myVideoTarget&debug=true&forceMobileHTML5=true&urid=2.35&flashvars[chromecast.plugin]=true";
//    link = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    urlScheme = [NSURL URLWithString:link];
    
    [self performSegueWithIdentifier: @"showPlayer" sender: self];
    KPLogTrace(@"Exit");
}

- (IBAction)hereClicked:(id)sender {
    KPLogTrace(@"Enter");
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: @"http://player.kaltura.com/docs/NativeCallout"]];
    KPLogTrace(@"Exit");
}

@end
