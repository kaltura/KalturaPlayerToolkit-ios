//
//  KPTAudioPlayerViewController.m
//  KalturaPlayerToolkit
//
//  Created by Nissim Pardo on 27/12/2015.
//  Copyright © 2015 Kaltura. All rights reserved.
//

#import "KPTAudioPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@interface KPTAudioPlayerViewController () <AVAudioPlayerDelegate> {
    id observer;
}
@property (nonatomic, strong) AVPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@end

@implementation KPTAudioPlayerViewController

- (void)viewDidLoad {
    __weak KPTAudioPlayerViewController *weakSelf = self;
    _audioPlayer = [[AVPlayer alloc] initWithURL:_audioURL];
    [_audioPlayer play];
    observer = [_audioPlayer addPeriodicTimeObserverForInterval:CMTimeMake(20, 100)
                                                          queue:dispatch_get_main_queue()
                                                     usingBlock:^(CMTime time) {
                                                         [weakSelf updateProgress:CMTimeGetSeconds(time)];
                                                        
                                             }];

}

- (IBAction)mutePressed:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"Mute"]) {
        _audioPlayer.volume = 0.0;
        sender.title = @"Unmute";
        _volumeSlider.enabled = NO;
    } else {
        _audioPlayer.volume = _volumeSlider.value;
        sender.title = @"Mute";
        _volumeSlider.enabled = YES;
    }
}


- (IBAction)changeVolume:(UISlider *)sender {
    _audioPlayer.volume = sender.value;
    _volumeLabel.text = [NSString stringWithFormat:@"%.02f", sender.value];
}

- (void)updateProgress:(NSTimeInterval)time {
    AVPlayerItem *item = _audioPlayer.currentItem;
    float progress = time / CMTimeGetSeconds(item.asset.duration);
    [_progressBar setProgress:progress animated:YES];
    int min = (progress * CMTimeGetSeconds(item.asset.duration)) / 60;
    int sec = ((progress * CMTimeGetSeconds(item.asset.duration)) - (min * 60));
    _timeLabel.text = [NSString stringWithFormat:@"%.02d:%.02d", min, sec];
    
}

@end
