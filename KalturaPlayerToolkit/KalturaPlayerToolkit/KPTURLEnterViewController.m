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

@interface KPTURLEnterViewController () {
    NSString *url;
}

@end

@implementation KPTURLEnterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
	// Do any additional setup after loading the view, typically from a nib.
  
}

- (void) playWithUrl:(NSString *)str {
    url = str;
    [self performSegueWithIdentifier:@"showPlayer" sender:self];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPlayer"]) {
        if (![segue.destinationViewController isKindOfClass:[KPTViewController class]]) {
            return;
        }
        [(KPTViewController *)segue.destinationViewController setUrl:url];
    }
}

- (void)appDidBecomeActive:(NSNotification *)notification {
    NSLog(@"did become active notification");
    KPTAppDelegate *delegate = (KPTAppDelegate *)[UIApplication sharedApplication].delegate;
    if (delegate.urlSchemeIframeUrlParam == nil) {
        return;
    }
    [self playWithUrl:delegate.urlSchemeIframeUrlParam];
    delegate.urlSchemeIframeUrlParam = nil;
    
    //    if (delegate.urlSchemeParameters) {
    //        // Came  from url.
    //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome from url!" message:[NSString stringWithFormat:@"Hello, %@. How is it in %@?", [delegate.urlSchemeParameters objectForKey:@"name"], [delegate.urlSchemeParameters objectForKey:@"city"]] delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    //        [alert show];
    //        delegate.urlSchemeParameters = nil;
    //    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)enterClicked:(id)sender {
    [self playWithUrl:self.urlTextField.text];
}
@end
