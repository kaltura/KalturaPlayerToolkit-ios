//
//  KPTViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTViewController.h"
#import <KALTURAPlayerSDK/KPPlayerDatasource.h>

@interface KPTViewController () <KPViewControllerDatasource>

@property (nonatomic, copy) NSDictionary *urlSchemeQueryParams;
@property (nonatomic, strong) KPPlayerConfig *requestConfig;
@property (nonatomic, copy) NSString *domain;
@end


@implementation KPTViewController

@synthesize player;



- (KPPlayerConfig *)requestConfig {
    if (!_requestConfig) {
        _requestConfig = [KPPlayerConfig new];
    }
    return _requestConfig;
}

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
    
//    [[NSNotificationCenter defaultCenter] addObserver: self
//                                             selector: @selector(toggleFullscreen:)
//                                                 name: @"toggleFullscreenNotification"
//                                               object: nil];
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewDidAppear:(BOOL)animated {
    if ( self.player == nil ) {
        CGRect playerFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        self.player = [[KPViewController alloc] initWithFrame: playerFrame forView: self.view];
        [self.player setNativeFullscreen];
        [self.player setWebViewURL: iframeUrl];
        self.player.datasource = self;
        [self.player load];
    }
}

- (void)setIframeUrl: (NSString*)url {
    NSLog(@"setIframeUrl Enter");
    
    iframeUrl = url;
    
    NSLog(@"setIframeUrl Exit");
}

-(NSURL *)getInitialKIframeUrl {
    return [NSURL URLWithString: [iframeUrl stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
}

- (void)toggleFullscreen: (NSNotification *)note {
    NSLog(@"toggleFullscreen Enter");
    
    NSDictionary *theData = [note userInfo];
    if (theData != nil) {
        NSNumber *n = [theData objectForKey: @"isFullScreen"];
        BOOL isFullScreen = [n boolValue];
        
        if ( isFullScreen ) {
            [[[UIApplication sharedApplication] delegate].window addSubview: self.player.view];
        }
        else if( !isFullScreen ) {
            [self.view addSubview: self.player.view];
        }
    }
    
    NSLog(@"toggleFullscreen Exit");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark KPViewControllerDatasource
- (NSString *)root {
    return self.domain.copy;
}

- (NSString *)wid {
    return self.urlSchemeQueryParams[KPPlayerDatasourceWidKey];
}

- (NSString *)uiConfId {
    return self.urlSchemeQueryParams[KPPlayerDatasourceUiConfIdKey];
}

- (NSString *)cacheSt {
    return self.urlSchemeQueryParams[KPPlayerDatasourceCacheStKey];
}

- (NSString *)entryId {
    return self.urlSchemeQueryParams[KPPlayerDatasourceEntryId];
}

- (NSString *)playerId {
    return self.urlSchemeQueryParams[KPPlayerDatasourcePlayerIdKey];
}

- (NSString *)urid {
    return self.urlSchemeQueryParams[KPPlayerDatasourceUridKey];
}

- (KPPlayerConfig *)configFlags {
    return self.requestConfig;
}
@end
