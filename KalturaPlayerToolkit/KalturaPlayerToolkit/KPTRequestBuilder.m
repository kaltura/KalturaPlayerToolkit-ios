//
//  KPTRequestBuilder.m
//  KalturaPlayerToolkit
//
//  Created by Nissim Pardo on 27/12/2015.
//  Copyright © 2015 Kaltura. All rights reserved.
//

#import "KPTRequestBuilder.h"

@interface NSDictionary (RequestBuilder)
@property (nonatomic, readonly) NSURLRequest *audioRequest;
@end

@implementation NSDictionary (RequestBuilder)

- (NSURLRequest *)audioRequest {
    NSError *error = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:self
                                                   options:0
                                                     error:&error];
    if (error) {
        NSLog(@"ERROR while building JSON %@", error);
        return nil;
    }
    NSURL *url = [NSURL URLWithString:@"http://dev-hudson7.kaltura.dev/api_v3/index.php"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setTimeoutInterval:20];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPBody = body;
    return request.copy;
}

@end

static NSMutableDictionary *requestBody;
static NSString *ks = @"YzNhMjMyNzQ5NzY0OGM3ODE5NWYzZmY0ZjhhMGQxNDBiYjUyN2Q0MnwxMDI7MTAyOzg2NTQ1MTMxNTAwNjsyOzE0NTEzMTUwMDYuNjg2Njt5b3NzaS5wYXBpYXNodmlsaUBrYWx0dXJhLmNvbTs7Ow==";

@interface KPTRequestBuilder ()
@property (nonatomic, copy) NSMutableDictionary *params;
@end

@implementation KPTRequestBuilder

+ (NSMutableDictionary *)requestBody {
    @synchronized(self) {
        if (!requestBody) {
            NSDictionary *temp = @{@"service": @"flavorAsset",
                                   @"action": @"list",
                                   @"format": @"1",
                                   @"filter:objectType": @"KalturaAssetFilter",
                                   @"filter:tagsMultiLikeOr": @"kast"};
            requestBody = [NSMutableDictionary dictionaryWithDictionary:temp];
        }
        return requestBody;
    }
}

+ (void)fetchAudioListForEntry:(NSString *)entryId completion:(void (^)(NSArray *, NSError *))completion {
    if (entryId && ks) {
        self.requestBody[@"filter:entryIdEqual"] = entryId;
        self.requestBody[@"ks"] = ks;
        [NSURLConnection sendAsynchronousRequest:self.requestBody.audioRequest
                                           queue:[NSOperationQueue new]
                               completionHandler:^(NSURLResponse * _Nullable response,
                                                   NSData * _Nullable data,
                                                   NSError * _Nullable connectionError) {
                                   if (connectionError) {
                                       completion(nil, connectionError);
                                   } else if (data) {
                                       NSError *parseError = nil;
                                       NSDictionary *parsed = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                                       if (parseError) {
                                           NSLog(@"PARSE error %@", parseError);
                                       } else if (parsed) {
                                           completion(parsed[@"objects"], nil);
                                       }
                                   }
        }];
    } else {
        completion(nil, nil);
    }
}

+ (void)audioFor:(NSDictionary *)object completion:(void (^)(NSURL *, NSError *))completion {
    NSDictionary *getURLObj = @{@"service": @"flavorAsset",
                                @"action": @"geturl",
                                @"format": @"1",
                                @"id": object[@"id"],
                                @"ks": ks};
    [NSURLConnection sendAsynchronousRequest:getURLObj.audioRequest queue:[NSOperationQueue new] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError) {
            completion(nil, connectionError);
        } else if (data) {
            NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            NSString *link = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            link = [link stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            link = [link stringByReplacingOccurrencesOfString:@"\\" withString:@""];
            link = [link stringByReplacingOccurrencesOfString:@".mp3" withString:@".aac"];
            link = [link stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [NSURL URLWithString:link];
            completion(url, nil);
        }
    }];
}
@end

