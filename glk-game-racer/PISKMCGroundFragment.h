//
//  PISKMCGroundFragment.h
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 18.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "PISKMapCompiller.h"
#import "PISKGameSegment.h"
#import "GameFunctions.h"

typedef enum  {
    PISKMCRectSegmentPointBL = 0,
    PISKMCRectSegmentPointBR = 1,
    PISKMCRectSegmentPointTR = 2,
    PISKMCRectSegmentPointTL = 3,
} PISKMCRectSegmentPointId;


@interface PISKMCGroundFragment : NSObject

@property (readonly) CGRect segmentRect;

- (instancetype) initForRect:(CGRect)rect;
- (void) setPoint:(PISKMCRectSegmentPointId)pointId Info:(PISKGameSegmentInfo)infoId Value:(GLfloat)value;
- (GLfloat) getPoint:(GLKVector2)point Info:(PISKGameSegmentInfo)infoId;
- (NSSet*)decompose;

+ (instancetype) create:(int)segmentId forTask:(PISKMapCompiller*) task;

@end
