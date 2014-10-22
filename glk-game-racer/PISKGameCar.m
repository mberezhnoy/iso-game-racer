//
//  PISKGameCar.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 22.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import "PISKGameCar.h"

@implementation PISKGameCar

@synthesize maxAcceleration;
@synthesize maxSpeed;
@synthesize minTurnRadius;
@synthesize maxTurnAcceleration;

- (instancetype) init {
    self = [super init];
    if (self) {
        maxSpeed = 70.0;
        maxAcceleration = 20.0;
        minTurnRadius = 3;
        maxTurnAcceleration = 10;
    }
    return self;
}

@end
