//
//  PISKGameSegment.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 18.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#include <math.h>
#import "PISKGameSegment.h"
#import "GameFunctions.h"

@implementation PISKGameSegment {
    BOOL pointsEqualInfo[PISKGameSegmentInfoMaxIndex];
    GLfloat pointInfo[3][PISKGameSegmentInfoMaxIndex];
}

@synthesize point1;
@synthesize point2;
@synthesize point3;

- (instancetype) init {
    //TODO: trace error: disable create segment without points
    return nil;
}

- (instancetype) initForPointsP1:(GLKVector2)p1 P2:(GLKVector2)p2 P3:(GLKVector2)p3 {
    self = [super init];
    if (self) {
        point1 = p1;
        point2 = p2;
        point3 = p3;
        for (int i=0; i<PISKGameSegmentInfoMaxIndex; i++) {
            pointsEqualInfo[i] = YES;
            for (int j=0; j<3; j++) {
                pointInfo[j][i] = NAN;
            }
        }
    }
    return self;
}

- (void) setPoint:(PISKGameSegmentPointId)point Info:(PISKGameSegmentInfo)infoId Value:(GLfloat)value {
    if ( isnan(pointInfo[0][infoId]) || isnan(value) ) {
        pointsEqualInfo[infoId] = YES;
        pointInfo[0][infoId] = pointInfo[1][infoId] = pointInfo[2][infoId] = value;
    }else {
        pointInfo[point][infoId] = value;
        pointsEqualInfo[infoId] = ((pointInfo[0][infoId]==pointInfo[1][infoId]) &&
                                   (pointInfo[1][infoId]==pointInfo[2][infoId]));
    }
}

- (GLfloat) getPoint:(GLKVector2)point Info:(PISKGameSegmentInfo)infoId {
    if ( pointsEqualInfo[infoId] || isnan(pointInfo[0][infoId]) ) {
        return pointInfo[0][infoId];
    }
    
    GLfloat dx1 = point1.x - point2.x;
    GLfloat dx2 = point1.x - point3.x;
    GLfloat dy1 = point1.y - point2.y;
    GLfloat dy2 = point1.y - point3.y;
    GLfloat dz1 = pointInfo[PISKGameSegmentPoint1][infoId] - pointInfo[PISKGameSegmentPoint2][infoId];
    GLfloat dz2 = pointInfo[PISKGameSegmentPoint1][infoId] - pointInfo[PISKGameSegmentPoint3][infoId];
    GLfloat a = (dz1*dy2-dz2*dy1)/(dy2*dx1-dy1*dx2);
    GLfloat b = (dz1*dx2-dz2*dx1)/(dy1*dx2-dy2*dx1);
    GLfloat c = pointInfo[PISKGameSegmentPoint1][infoId] - a*point1.x - b*point1.y;

    return a*point.x + b*point.y + c;
}

#pragma mark PISKGameSegmentInfoMaxIndex

- (BOOL) containPoint:(CGPoint)point {
    BOOL b1, b2, b3;
    b1 = PISK_sign(point.x, point.y, point1.x, point1.y, point2.x, point2.y) < 0.0f;
    b2 = PISK_sign(point.x, point.y, point2.x, point2.y, point3.x, point3.y) < 0.0f;
    b3 = PISK_sign(point.x, point.y, point3.x, point3.y, point1.x, point1.y) < 0.0f;
    return ((b1 == b2) && (b2 == b3));
}

- (BOOL) havePointInRect: (CGRect)rect {
    BOOL result = NO;
    result = result || [self containPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect))];
    result = result || [self containPoint:CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect))];
    result = result || [self containPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMinY(rect))];
    result = result || [self containPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect))];
    result = result || CGRectContainsPoint(rect, CGPointMake(point1.x, point1.y));
    result = result || CGRectContainsPoint(rect, CGPointMake(point2.x, point2.y));
    result = result || CGRectContainsPoint(rect, CGPointMake(point3.x, point3.y));
    return result;
}

- (BOOL) havePointOnLineFrom:(CGPoint)p1 To:(CGPoint)p2 {
    BOOL result = [self containPoint:p1];
    result = result || PISK_isLineIntersect(p1.x, p1.y, p2.x, p2.y, point1.x, point1.y, point2.x, point2.y);
    result = result || PISK_isLineIntersect(p1.x, p1.y, p2.x, p2.y, point1.x, point1.y, point3.x, point3.y);
    result = result || PISK_isLineIntersect(p1.x, p1.y, p2.x, p2.y, point3.x, point3.y, point2.x, point2.y);
    return result;
}

@end
