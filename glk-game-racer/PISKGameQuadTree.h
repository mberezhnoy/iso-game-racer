//
//  PISKGameQuadTree.h
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 17.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameProtocols.h"

@interface PISKGameQuadTree : NSObject

@property (readonly) CGRect rect;
@property (nonatomic) int deep;

- (instancetype) initWithRect:(CGRect)rect;
- (void) insert:(id<PISKGamePositionable>)object;
- (void) remove:(id<PISKGamePositionable>)object;
- (void) removeAll;
- (id<PISKGamePositionable>) getOneForPoint:(CGPoint)point;
- (NSMutableSet*) getAllForPoint:(CGPoint)point;
- (NSMutableSet*) getAllInRect:(CGRect)rect;
- (NSMutableSet*) getAllOnLineFrom:(CGPoint)p1 To:(CGPoint)p2;

@end
