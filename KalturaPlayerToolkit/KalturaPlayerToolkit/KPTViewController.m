//
//  KPTViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTViewController.h"


@interface KPTViewController () <KPViewControllerDatasource>

@property (nonatomic, copy) NSDictionary *urlSchemeQueryParams;
@property (nonatomic, strong) KPPlayerConfig *requestConfig;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, strong) UIView *playerView;
@end


@implementation KPTViewController

@synthesize player;



- (KPPlayerConfig *)requestConfig {
    if (!_requestConfig) {
        _requestConfig = [KPPlayerConfig new];
    }
    return _requestConfig;
}


// Parses the params of the url scheme into NSDictionary
- (NSDictionary *)urlSchemeQueryParams {
    if (!_urlSchemeQueryParams) {
        NSMutableDictionary *queryDict = [NSMutableDictionary new];
        NSArray *paramsArray = [[NSURL URLWithString:iframeUrl].query componentsSeparatedByString:@"&"];
        for (NSString *param in paramsArray) {
            NSArray *keyValue = [param componentsSeparatedByString:@"="];
            if (keyValue.count == 2) {
                NSString *key = keyValue[0];
                NSString *value = keyValue.lastObject;
                if ([key hasPrefix:@"flashvars"]) {
                    key = [key stringByRemovingPercentEncoding];
                    key = [key stringByReplacingOccurrencesOfString:@"flashvars[" withString:@""];
                    key = [key stringByReplacingOccurrencesOfString:@"]" withString:@""];
                    [self.requestConfig addConfigKey:key withValue:value];
                } else {
                    queryDict[key] = value;
                }
            }
        }
        _urlSchemeQueryParams = queryDict.copy;
    }
    return _urlSchemeQueryParams;
}

// Extract the domain from the video url
- (NSString *)domain {
    NSArray *components = [iframeUrl componentsSeparatedByString:@"?"];
    if (!_domain && components.count == 2) {
        _domain = [iframeUrl componentsSeparatedByString:@"?"][0];
    }
    return _domain;
}



- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidAppear:(BOOL)animated {
    if ( self.player == nil ) {
        CGRect playerFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        KPViewController.logLevel = KPLogLevelAll;
        dispatch_async(dispatch_get_main_queue(), ^{
//            self.player = [[KPViewController alloc] initWithFrame: playerFrame forView: self.view];
            self.player = [[KPViewController alloc] initWithURL:[NSURL URLWithString:iframeUrl]];
            //[self.player setNativeFullscreen];
            //self.player
            //self.player.datasource = self;
            //[self.player load];
//            [self.player setWebViewURL:iframeUrl];
            [self presentViewController:self.player animated:YES completion:nil];
//            _playerView = [self.player playerViewForParentViewController:self frame:(CGRect){0, 100, 320, 180}];
            [self.view addSubview:_playerView];
        });
        
        
    }
}


- (void)setIframeUrl: (NSString*)url {
    KPLogTrace(@"Enter");
    
    iframeUrl = url;//[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    KPLogTrace(@"Exit");
}

//-(NSURL *)getInitialKIframeUrl {
//    return [NSURL URLWithString: [iframeUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
//}

- (void)toggleFullscreen: (NSNotification *)note {
    KPLogTrace(@"Enter");
//    NSDictionary *theData = [note userInfo];
//    if (theData != nil) {
//        NSNumber *n = [theData objectForKey: @"isFullScreen"];
//        BOOL isFullScreen = [n boolValue];
//        
//        if ( isFullScreen ) {
//            [[[UIApplication sharedApplication] delegate].window addSubview: self.player.view];
//        }
//        else if( !isFullScreen ) {
//            [self.view addSubview: self.player.view];
//        }
//    }
    KPLogTrace(@"Exit");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
//    _playerView.frame = (CGRect){0, UIInterfaceOrientationIsLandscape(toInterfaceOrientation) ? 0 : 100, 320, 180};
//}

//http://apache-testing.dev.kaltura.com/html5/html5lib/v2.24.rc5/mwEmbedFrame.php?&wid=_1091&uiconf_id=15065771&cache_st=1404213421&entry_id=0_0fq66zlh&flashvars%5BnativeCallout%5D=%7B%22plugin%22%3Atrue%7D&playerId=kaltura_player_1404213421&forceMobileHTML5=true&urid=2.24.rc5&flashvars%5Bchromecast.plugin%5D=true

@end
