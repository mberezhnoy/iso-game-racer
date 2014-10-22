//
//  PISKGameCar.h
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 22.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "GameProtocols.h"

@interface PISKGameCar : NSObject

@property (nonatomic) GLKVector2 position;
@property (nonatomic) GLfloat direction;
@property (nonatomic) GLfloat speed;
@property (nonatomic) GLfloat wheelStatus;
@property (nonatomic) GLfloat speedUpStatus;

@property (readonly) GLfloat maxSpeed;
@property (readonly) GLfloat maxAcceleration;
@property (readonly) GLfloat minTurnRadius;
@property (readonly) GLfloat maxTurnAcceleration;

@end
