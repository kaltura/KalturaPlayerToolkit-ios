//
//  KPTAudioPlayerViewController.h
//  KalturaPlayerToolkit
//
//  Created by Nissim Pardo on 27/12/2015.
//  Copyright © 2015 Kaltura. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPTAudioPlayerViewController : UIViewController
@property (nonatomic, copy) NSURL *audioURL;
@property (nonatomic) NSTimeInterval currentTime;
@end
