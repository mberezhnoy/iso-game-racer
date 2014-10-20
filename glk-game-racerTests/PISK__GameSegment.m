//
//  PISK__GameSegment.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 20.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PISKGameSegment.h"
#import "tests-common.h"

@interface PISK__GameSegment : XCTestCase {
    PISKGameSegment *segment;
}

@end

@implementation PISK__GameSegment

- (void)setUp {
    [super setUp];
    segment = [[PISKGameSegment alloc] initForPointsP1:GLKVector2Make(1.0, 2.0)
                                                    P2:GLKVector2Make(5.0, 1.0)
                                                    P3:GLKVector2Make(3.0, 7.0)];
    [segment setPoint:PISKGameSegmentPoint1 Info:PISKGameSegmentInfoNormalX Value:1.0];
    
    [segment setPoint:PISKGameSegmentPoint1 Info:PISKGameSegmentInfoNormalY Value:1.0];
    [segment setPoint:PISKGameSegmentPoint2 Info:PISKGameSegmentInfoNormalY Value:2.0];
    
    [segment setPoint:PISKGameSegmentPoint1 Info:PISKGameSegmentInfoNormalZ Value:1.0];
    [segment setPoint:PISKGameSegmentPoint2 Info:PISKGameSegmentInfoNormalZ Value:2.0];
    [segment setPoint:PISKGameSegmentPoint3 Info:PISKGameSegmentInfoNormalZ Value:-1.0];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNotSetInfo {
    XCTAssertTrue(isnan([segment getPoint:GLKVector2Make(1, 2) Info:PISKGameSegmentInfoZPosition]),
                  @"Key {PISKGameSegmentInfoZPosition} is Not Nan");
}

- (void)testGetInfo {
    XCTAssertFloatEquals([segment getPoint:GLKVector2Make(3.0, 3.0) Info:PISKGameSegmentInfoNormalX], 1.0,
                         @"{PISKGameSegmentInfoNormalX} is const");
    
    XCTAssertFloatEquals([segment getPoint:GLKVector2Make(1.0, 2.0) Info:PISKGameSegmentInfoNormalY], 1.0,
                         @"{PISKGameSegmentInfoNormalX} is const");
    XCTAssertFloatEquals([segment getPoint:GLKVector2Make(5.0, 1.0) Info:PISKGameSegmentInfoNormalY], 2.0,
                         @"{PISKGameSegmentInfoNormalX} is const");
    XCTAssertFloatEquals([segment getPoint:GLKVector2Make(3.0, 1.5) Info:PISKGameSegmentInfoNormalY], 1.5,
                         @"{PISKGameSegmentInfoNormalX} is const");
    
    XCTAssertFloatEquals([segment getPoint:GLKVector2Make(3.0, 1.5) Info:PISKGameSegmentInfoNormalZ], 1.5,
                         @"{PISKGameSegmentInfoNormalX} is const");
    XCTAssertFloatEquals([segment getPoint:GLKVector2Make(2.0, 4.5) Info:PISKGameSegmentInfoNormalZ], 0.0,
                         @"{PISKGameSegmentInfoNormalX} is const");
    XCTAssertFloatEquals([segment getPoint:GLKVector2Make(4.0, 4.0) Info:PISKGameSegmentInfoNormalZ], 0.5,
                         @"{PISKGameSegmentInfoNormalX} is const");
    XCTAssertFloatEquals([segment getPoint:GLKVector2Make(3.0, 10.0/3.0) Info:PISKGameSegmentInfoNormalZ], 2.0/3.0,
                         @"{PISKGameSegmentInfoNormalX} is const");
}

- (void) testContainPoint {
    XCTAssertTrue([segment containPoint:CGPointMake(1.0, 2.0)]);
    XCTAssertTrue([segment containPoint:CGPointMake(5.0, 1.0)]);
    XCTAssertTrue([segment containPoint:CGPointMake(3.0, 7.0)]);
    XCTAssertTrue([segment containPoint:CGPointMake(3.0, 3.0)]);
    XCTAssertFalse([segment containPoint:CGPointMake(1.0, 1.0)]);
}

- (void) testIntersectRect {
    XCTAssertTrue([segment havePointInRect:CGRectMake(2.0, 2.0, 1.0, 1.0)]);
    XCTAssertTrue([segment havePointInRect:CGRectMake(0.0, 1.0, 2.0, 2.0)]);
    XCTAssertTrue([segment havePointInRect:CGRectMake(0.0, 0.0, 6.0, 8.0)]);
    XCTAssertTrue([segment havePointInRect:CGRectMake(2.0, 6.0, 2.0, 2.0)]);
    XCTAssertTrue([segment havePointInRect:CGRectMake(0.0, 1.0, 2.0, 6.0)]);
    XCTAssertTrue([segment havePointInRect:CGRectMake(4.0, 0.0, 2.0, 7.0)]);
    XCTAssertFalse([segment havePointInRect:CGRectMake(5.0, 3.0, 2.0, 2.0)]);
}

- (void) testIntersectLine {
    XCTAssertTrue([segment havePointOnLineFrom:CGPointMake(3.0, 3.0) To:CGPointMake(0.0, 0.0)]);
    XCTAssertTrue([segment havePointOnLineFrom:CGPointMake(0.0, 4.0) To:CGPointMake(5.0, 4.0)]);
    XCTAssertFalse([segment havePointOnLineFrom:CGPointMake(0.0, 8.0) To:CGPointMake(5.0, 8.0)]);
}

@end
