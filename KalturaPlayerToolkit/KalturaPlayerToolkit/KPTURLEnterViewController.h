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

@end
