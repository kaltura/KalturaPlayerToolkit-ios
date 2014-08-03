//
//  KPTViewController.m
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 7/30/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import "KPTViewController.h"
#import "KPTAppDelegate.h"

@interface KPTViewController ()

@end

@implementation KPTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    NSLog(@"did become active notification");
    KPTAppDelegate *delegate = (KPTAppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.urlSchemeParameters) {
        // Came  from url.
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome from url!" message:[NSString stringWithFormat:@"Hello, %@. How is it in %@?", [delegate.urlSchemeParameters objectForKey:@"name"], [delegate.urlSchemeParameters objectForKey:@"city"]] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
        delegate.urlSchemeParameters = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
