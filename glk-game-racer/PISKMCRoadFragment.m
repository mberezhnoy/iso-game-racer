//
//  PISKMCRoadFragment.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 23.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import "PISKMCRoadFragment.h"

@implementation PISKMCRoadFragment {
    BOOL initFunctionIndexes;
    double functionXIndexes[4];
    double functionYIndexes[4];
}

- (instancetype) init {
    self = [super init];
    if (self) {
        initFunctionIndexes = NO;
    }
    return self;
}

- (NSSet*)decompose {
    return nil;
}

- (GLKVector2)  getPosition:(double)t {
    if ( !initFunctionIndexes ) {
        [self _initFunctionIndexes];
    }
    
    double tpow=1,x=0,y=0;
    for (int i=0; i<4; i++) {
        x += functionXIndexes[i]*tpow;
        y += functionYIndexes[i]*tpow;
        tpow *= t;
    }
    return GLKVector2Make(0.0, 0.0);
}

- (GLKVector2)  getDirection:(double)t {
    if ( !initFunctionIndexes ) {
        [self _initFunctionIndexes];
    }
    
    double tpow=1,x=0,y=0;
    for (int i=1; i<4; i++) {
        x += i*functionXIndexes[i]*tpow;
        y += i*functionYIndexes[i]*tpow;
        tpow *= t;
    }
    return GLKVector2Make(x, y);
}

- (void) _initFunctionIndexes {
    /*
     P(t) = C3*t^3+C2*t2+C1*t+C0 ; tE[0,1]
     P(0) = point1      |   C0 = point1
     P(1) = point2      |-\ C1 = direction1
     P`(0) = direction1 |-/ C2 = 3*point2-3*point1-2*direction1-direction2
     p`(1) = direction2 |   C3 = 2*point1-2*point2+direction1+direction2
     */
    functionXIndexes[0] = self.point1.x;
    functionXIndexes[1] = self.direction1.x;
    functionXIndexes[2] = 3*self.point2.x-3*self.point1.x-2*self.direction1.x-self.direction2.x;
    functionXIndexes[3] = 2*self.point1.x-2*self.point2.x+self.direction1.x+self.direction2.x;
    functionYIndexes[0] = self.point1.y;
    functionYIndexes[1] = self.direction1.y;
    functionYIndexes[2] = 3*self.point2.y-3*self.point1.y-2*self.direction1.y-self.direction2.y;
    functionYIndexes[3] = 2*self.point1.y-2*self.point2.y+self.direction1.y+self.direction2.y;
    initFunctionIndexes = YES;
}

+ (instancetype) create:(int)segmentId forTask:(PISKMapCompiller*) task {
    return nil;
}

@end
