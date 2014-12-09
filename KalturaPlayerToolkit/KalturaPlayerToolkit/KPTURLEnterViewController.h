//
//  KPTURLEnterViewController.h
//  KalturaPlayerToolkit
//
//  Created by Eliza Sapir on 8/10/14.
//  Copyright (c) 2014 Kaltura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPTURLEnterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

- (IBAction)enterClicked: (id)sender;
- (IBAction)hereClicked:(id)sender;



/** Setter for the url scheme (used by the appDlegate)
 *
 *  @param NSURL the url from the urlScheme stored into static var
 */
+ (void)setURLScheme:(NSURL *)url;


@end
