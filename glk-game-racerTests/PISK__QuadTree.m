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
}

- (void)testByRect {
}

- (void)testByLine {
}

@end
