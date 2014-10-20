//
//  PISKGame.h
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 17.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PISKGameQuadTree.h"

@interface PISKGame : NSObject

- (void) loadMapFromJson:(NSDictionary*)mapJson;
- (void) addDinamicObject:(id)object;
- (void) getObjectsInRect:(CGRect)rect;
- (void) getGroundInfoForX:(CGFloat)x Y:(CGFloat)y;
- (void) update:(NSTimeInterval)dt;
- (void) clear;

@end
