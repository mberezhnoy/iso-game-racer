//
//  PISKMCRoadFragment.h
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 23.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <GLKit/GLKit.h>
#import "PISKMapCompiller.h"
#import "PISKGameSegment.h"
#import "GameFunctions.h"

@interface PISKMCRoadFragment : NSObject

@property (nonatomic) GLKVector2 point1;
@property (nonatomic) GLKVector2 direction1;
@property (nonatomic) GLKVector2 point2;
@property (nonatomic) GLKVector2 direction2;
@property (nonatomic) GLfloat width;

- (NSSet*)decompose;

+ (instancetype) create:(int)segmentId forTask:(PISKMapCompiller*) task;

@end
