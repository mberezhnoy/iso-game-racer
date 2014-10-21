//
//  PISK__QuadTree.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 20.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PISKGameQuadTree.h"
#import "PISKGameSegment.h"

@interface PISK__QuadTree : XCTestCase

@end

@implementation PISK__QuadTree {
    PISKGameSegment *segments[10][10][2];
    PISKGameQuadTree * tree1;
    PISKGameQuadTree * tree2;
}

- (void)setUp {
    [super setUp];
    
    tree1 = [[PISKGameQuadTree alloc] initWithRect:CGRectMake(0.5, 0.5, 1.0, 1.0)];
    tree2 = [[PISKGameQuadTree alloc] initWithRect:CGRectMake(0.0, 0.0, 10.0, 10.0)];
    GLKVector2 p1, p2, p3, p4;
    for (int i=0; i<10; i++){
        for (int j=0; j<10; j++){
            p1 = GLKVector2Make(1.0*i, 1.0*j);
            p2 = GLKVector2Make(1.0*i, 1.0*j+1.0);
            p3 = GLKVector2Make(1.0*i+1.0, 1.0*j);
            p4 = GLKVector2Make(1.0*i+1.0, 1.0*j+1.0);
            segments[i][j][0] = [[PISKGameSegment alloc] initForPointsP1:p1 P2:p2 P3:p4];
            segments[i][j][1] = [[PISKGameSegment alloc] initForPointsP1:p1 P2:p3 P3:p4];
            [tree1 insert:segments[i][j][0]];
            [tree1 insert:segments[i][j][1]];
            [tree2 insert:segments[i][j][0]];
            [tree2 insert:segments[i][j][1]];
        }
    }
}

- (void)tearDown {
    [super tearDown];
}

- (void)testByPoint {
    CGPoint p = CGPointMake(2.2, 2.4);
    XCTAssertEqualObjects([tree1 getOneForPoint:p], nil);
    XCTAssertEqualObjects([tree2 getOneForPoint:p], segments[2][2][0]);
    p = CGPointMake(1.2, 1.4);
    NSSet *items;
    items = [tree1 getAllForPoint:p];
    XCTAssertEqual([items count], 1);
    XCTAssertTrue([items containsObject:segments[1][1][0] ]);
    items = [tree2 getAllForPoint:p];
    XCTAssertEqual([items count], 1);
    XCTAssertTrue([items containsObject:segments[1][1][0] ]);
}

- (void)testByRect {
    NSSet *items = [tree2 getAllInRect:CGRectMake(1.1, 2.1, 4.8, 2.8)];
    XCTAssertEqual([items count], 30);
    for (int i=0; i<5; i++){
        for (int j=0; j<3; j++){
            XCTAssertTrue([items containsObject:segments[i+1][j+2][0] ], @"i=%d j=%d", i, j);
            XCTAssertTrue([items containsObject:segments[i+1][j+2][0] ], @"i=%d j=%d", i, j);
        }
    }
}

- (void)testByLine {
    NSSet *items = [tree2 getAllOnLineFrom:CGPointMake(2.9, 2.8) To:CGPointMake(1.2, 3.1)];
    XCTAssertEqual([items count], 5);
    XCTAssertTrue([items containsObject:segments[1][3][1] ]);
    XCTAssertTrue([items containsObject:segments[1][2][1] ]);
    XCTAssertTrue([items containsObject:segments[1][2][0] ]);
    XCTAssertTrue([items containsObject:segments[2][2][1] ]);
    XCTAssertTrue([items containsObject:segments[2][2][0] ]);
}

- (void)testRemove {
    CGPoint p = CGPointMake(2.2, 2.4);
    PISKGameSegment *item = [tree2 getOneForPoint:p];
    XCTAssertEqualObjects(item, segments[2][2][0]);
    [tree2 remove:item];
    XCTAssertEqualObjects([tree2 getOneForPoint:p], nil);
    [tree2 insert:item];
    XCTAssertEqualObjects([tree2 getOneForPoint:p], item);
}
@end
