//
//  KPTAudioSelect.m
//  KalturaPlayerToolkit
//
//  Created by Nissim Pardo on 27/12/2015.
//  Copyright © 2015 Kaltura. All rights reserved.
//

#import "KPTAudioSelect.h"
#import "KPTRequestBuilder.h"
#import "KPTAudioPlayerViewController.h"

@interface KPTAudioSelect ()
@property (nonatomic, copy) NSArray *audios;

@end

@implementation KPTAudioSelect

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak KPTAudioSelect *weakSelf = self;
    [KPTRequestBuilder fetchAudioListForEntry:@"0_lrlvpaw9" completion:^(NSArray *audios, NSError *error) {
        weakSelf.audios = audios;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
        });
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    KPTAudioPlayerViewController *controller = segue.destinationViewController;
    controller.audioURL = sender;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _audios.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [_audios[indexPath.row] objectForKey:@"tags"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak KPTAudioSelect *weakSelf = self;
    [KPTRequestBuilder audioFor:_audios[indexPath.row] completion:^(NSURL *url, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf performSegueWithIdentifier:@"StartPlaying" sender:url];
        });
    }];
}
@end
