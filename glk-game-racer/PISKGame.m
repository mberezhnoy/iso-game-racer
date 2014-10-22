//
//  PISKGame.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 17.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import "PISKGame.h"
#include <math.h>

@implementation PISKGame {
    PISKGameQuadTree *groundFragments;
    PISKGameQuadTree *staticObjects;
    NSMutableSet* cars;
}

- (void) loadMapFromJson:(NSDictionary*)mapJson {
    
}

- (void) addDinamicObject:(id)object {
    
}

- (void) getObjectsInRect:(CGRect)rect {

}

- (void) getGroundInfoForX:(CGFloat)x Y:(CGFloat)y {
    
}

- (void) update:(NSTimeInterval)dt {
    for (PISKGameCar *car in cars) {
        [self _updateCarPosition:car forInterval:dt];
    }
}

- (void)_updateCarPosition:(PISKGameCar*)car forInterval:(NSTimeInterval)dt {
    GLfloat newDirection = car.direction;
    GLfloat newSpeed = car.speed;
    GLKVector2 newPosition = car.position;
    if ( fabsf(car.wheelStatus) > 0.01 ) {
        GLfloat turnR = car.minTurnRadius/car.wheelStatus;
        if ( car.speed*car.speed > turnR*car.maxTurnAcceleration ) {
            turnR = car.speed*car.speed/car.maxTurnAcceleration;
        }
        newDirection = car.speed*dt/turnR;
    }
        
    PISKGameSegment *ground = [groundFragments getOneForPoint:CGPointMake(car.position.x, car.position.y)];
    if (ground==nil) {
        NSLog(@"Empty Grount For point %f %f", car.position.x, car.position.y);
        return;
    }else {
        GLfloat accFactor = [ground getPoint:car.position Info:PISKGameSegmentInfoMaxAccelerationFactor];
        if (isnan(accFactor)) {
            accFactor = 0.01;
        }
        GLfloat speedFactor = [ground getPoint:car.position Info:PISKGameSegmentInfoMaxSpeedFactor];
        if (isnan(speedFactor)) {
            speedFactor = 0.01;
        }
        GLfloat maxSpeed = speedFactor*car.maxSpeed;
        if ( car.speedUpStatus > 0 && car.speed < maxSpeed) {
            //accselerate
            newSpeed += (1-car.speed/maxSpeed)*accFactor*car.speedUpStatus*car.maxAcceleration;
            if ( newSpeed > maxSpeed ) {
                newSpeed = maxSpeed;
            }
        }else if ( car.speedUpStatus > 0 && car.speed > maxSpeed ) {
            //deceleration on ground
            newSpeed -= (car.speed/maxSpeed-1)*car.speedUpStatus*car.maxAcceleration;
            if ( newSpeed < maxSpeed ) {
                newSpeed = maxSpeed;
            }
        }else if ( car.speedUpStatus < 0 ) {
            //deceleration
            newSpeed -= (car.speed/maxSpeed+1)*car.speedUpStatus*car.maxAcceleration;
            if ( newSpeed < 0 ) {
                newSpeed = 0;
            }
        }
    }
    
    newPosition.x += car.speed*dt*sinf(car.direction);
    newPosition.y += car.speed*dt*cosf(car.direction);
    car.position = newPosition;
    car.direction = newDirection;
    car.speed = newSpeed;
}

- (void) clear {
    [groundFragments removeAll];
    [staticObjects removeAll];
    [cars removeAllObjects];
}

@end
