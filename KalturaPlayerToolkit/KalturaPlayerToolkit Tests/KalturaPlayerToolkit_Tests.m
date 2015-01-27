//
//  KalturaPlayerToolkit_Tests.m
//  KalturaPlayerToolkit Tests
//
//  Created by Nissim Pardo on 1/22/15.
//  Copyright (c) 2015 Kaltura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "KPTViewController.h"

@interface KalturaPlayerToolkit_Tests : XCTestCase {
    KPTViewController *testController;
}

@property (nonatomic, strong) XCTestExpectation *excectation;
@property (nonatomic, copy) NSMutableArray *eventLog;
@end

@implementation KalturaPlayerToolkit_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    testController = [storyBoard instantiateViewControllerWithIdentifier:@"KPTViewController"];
    [UIApplication sharedApplication].keyWindow.rootViewController = testController;
    
    [self eventsBinding];
}

- (NSMutableArray *)eventLog {
    if (!_eventLog) {
        _eventLog = [NSMutableArray new];
    }
    return _eventLog;
}

- (void)eventsBinding {
    if (testController.player) {
        [self addObserverToIMAEvents];
    } else {
        [self performSelector:@selector(eventsBinding) withObject:nil afterDelay:1];
    }
}

- (void)addObserverToIMAEvents {
    NSArray *eventNames = @[@"AdSupport_StartAdPlayback",
                            @"AdSupport_EndAdPlayback",
                            @"midSequenceComplete",
                            @"midSequenceStart",
                            @"preSequenceComplete",
                            @"preSequenceStart",
                            @"postSequenceComplete",
                            @"postSequenceStart",
                            @"AdSupport_PostSequence",
                            @"AdSupport_PostSequenceComplete",
                            @"onResumeAdPlayback",
                            @"onAdComplete",
                            @"onAdPlay",
                            @"onAdSkip",
                            @"onAllAdsCompleted",
                            @"adErrorEvent",
                            @"playerPlayed",
                            @"firstPlay"];
    __weak KalturaPlayerToolkit_Tests *weakSelf = self;
    for (NSString *eventName in eventNames) {
        [testController.player addEventListener:eventName eventID:eventName handler:^(NSString *eventName) {
            [weakSelf.eventLog removeObject:eventName];
            if (!weakSelf.eventLog.count) {
                [weakSelf.excectation fulfill];
            }
        }];
    }
}

- (void)appendEvent:(NSString *)event {
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPrerollIMA {
    [self.eventLog addObjectsFromArray:@[@"onAdPlay",
                                         @"preSequenceStart",
                                         @"AdSupport_StartAdPlayback",
                                         @"playerPlayed",
                                         @"onAdComplete",
                                         @"AdSupport_EndAdPlayback",
                                         @"preSequenceComplete",
                                         @"firstPlay",
                                         @"onAllAdsCompleted",
                                         @"AdSupport_PostSequence",
                                         @"AdSupport_PostSequenceComplete"]];
    //Expectation
    _excectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    // This is an example of a functional test case.
    [testController setIframeUrl: @"http://localhost/html5.kaltura/mwEmbed/mwEmbedFrame.php?&wid=_1091&uiconf_id=15068991&cache_st=1406638062&entry_id=0_0fq66zlh&flashvars%5BnativeCallout%5D=%7B%22plugin%22%3Atrue%7D&playerId=kaltura_player_1406638062&debug=true&forceMobileHTML5=true&urid=2.26.rc9&flashvars%5Bchromecast.plugin%5D=true"];
    
    __weak KalturaPlayerToolkit_Tests *weakSelf = self;
    [self waitForExpectationsWithTimeout:90.0 handler:^(NSError *error) {
        weakSelf.eventLog = nil;
        if(error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        } else {
            XCTAssert(YES, @"Pass");
        }
    }];
}

- (void)testPrerollIMASkip {
    [self.eventLog addObjectsFromArray:@[@"onAdPlay",
                                         @"preSequenceStart",
                                         @"AdSupport_StartAdPlayback",
                                         @"playerPlayed",
                                         @"AdSupport_EndAdPlayback",
                                         @"preSequenceComplete",
                                         @"firstPlay",
                                         @"onAllAdsCompleted",
                                         @"AdSupport_PostSequence",
                                         @"AdSupport_PostSequenceComplete"]];
    
    //Expectation
    _excectation = [self expectationWithDescription:@"Testing Async Method Works!"];
    // This is an example of a functional test case.
    [testController setIframeUrl: @"http://localhost/html5.kaltura/mwEmbed/mwEmbedFrame.php?&wid=_1091&uiconf_id=15068991&cache_st=1406638062&entry_id=0_0fq66zlh&flashvars%5BnativeCallout%5D=%7B%22plugin%22%3Atrue%7D&playerId=kaltura_player_1406638062&debug=true&forceMobileHTML5=true&urid=2.26.rc9&flashvars%5Bchromecast.plugin%5D=true"];
    __weak KalturaPlayerToolkit_Tests *weakSelf = self;
    [self waitForExpectationsWithTimeout:40.0 handler:^(NSError *error) {
        weakSelf.eventLog = nil;
        if(error) {
            XCTFail(@"Expectation Failed with error: %@", error);
        } else {
            XCTAssert(YES, @"Pass");
        }
    }];
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
