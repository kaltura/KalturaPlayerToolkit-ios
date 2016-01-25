//
//  KPTRequestBuilder.h
//  KalturaPlayerToolkit
//
//  Created by Nissim Pardo on 27/12/2015.
//  Copyright © 2015 Kaltura. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KPTRequestBuilder : NSObject

+ (void)fetchAudioListForEntry:(NSString *)entryId
                    completion:(void(^)(NSArray *audios, NSError *error))completion;

+ (void)audioFor:(NSDictionary *)object
      completion:(void(^)(NSURL *url, NSError *error))completion;
@end
