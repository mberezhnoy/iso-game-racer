//
//  PISKMapCompiller.h
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 18.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import "PISKGameQuadTree.h"
#import "PISKGameSegment.h"

@interface PISKMapCompiller : NSObject

@property (readonly) NSDictionary *mapJson;
@property (readonly) PISKGameQuadTree *ground;

- (instancetype) initWithJson:(NSDictionary*)mapJson;
- (void) compile;

@end
