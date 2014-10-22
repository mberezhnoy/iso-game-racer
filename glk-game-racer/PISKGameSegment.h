//
//  PISKGameSegment.h
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 18.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameProtocols.h"

static const size_t PISKGameSegmentInfoMaxIndex = 8;

typedef enum {
    PISKGameSegmentInfoZPosition = 0,
    PISKGameSegmentInfoNormalX = 1,
    PISKGameSegmentInfoNormalY = 2,
    PISKGameSegmentInfoNormalZ = 3,
    PISKGameSegmentInfoTextureX = 4,
    PISKGameSegmentInfoTextureY = 5,
    PISKGameSegmentInfoMaxSpeedFactor = 6,
    PISKGameSegmentInfoMaxAccelerationFactor = 7,
} PISKGameSegmentInfo;

typedef enum  {
    PISKGameSegmentPoint1 = 0,
    PISKGameSegmentPoint2 = 1,
    PISKGameSegmentPoint3 = 2
} PISKGameSegmentPointId;

@interface PISKGameSegment : NSObject<PISKGamePositionable>

@property (readonly) GLKVector2 point1;
@property (readonly) GLKVector2 point2;
@property (readonly) GLKVector2 point3;

- (instancetype) initForPointsP1:(GLKVector2)p1 P2:(GLKVector2)p2 P3:(GLKVector2)p3;
- (void) setPoint:(PISKGameSegmentPointId)point Info:(PISKGameSegmentInfo)infoId Value:(GLfloat)value;
- (GLfloat) getPoint:(GLKVector2)point Info:(PISKGameSegmentInfo)infoId;

@end
