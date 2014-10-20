//
//  PISKGameQuadTree.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 17.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import "PISKGameQuadTree.h"

@implementation PISKGameQuadTree {
    NSMutableSet *childs;
    PISKGameQuadTree *childsTree[4];
}

@synthesize rect = _rect;

const int PISKGameQuadTree_maxCilds = 4;
const int PISKGameQuadTree_maxDeep = 30;

- (instancetype) init {
    return [self initWithRect:CGRectMake(0, 0, 100, 100)];
}

- (instancetype) initWithRect:(CGRect)rect {
    self = [super init];
    if (self) {
        _rect = rect;
        childs = [[NSMutableSet alloc] init];
        for (int i=0; i<4; i++) {
            childsTree[i] = nil;
        }
        self.deep = 0;
    }
    return self;
}

- (void) insert:(id<PISKGamePositionable>)object {
    if ( ![object havePointInRect:_rect] ) {
        return;
    }
    
    [childs addObject:object];
    
    if ( [childs count]>PISKGameQuadTree_maxCilds && self.deep<PISKGameQuadTree_maxDeep ) {
        CGFloat halfW = CGRectGetWidth(_rect)/2;
        CGFloat halfH = CGRectGetHeight(_rect)/2;
        CGRect childRects[4];
        childRects[0] = CGRectMake(CGRectGetMinX(_rect), CGRectGetMinY(_rect), halfW, halfH);
        childRects[1] = CGRectMake(CGRectGetMinX(_rect), CGRectGetMidY(_rect), halfW, halfH);
        childRects[2] = CGRectMake(CGRectGetMidX(_rect), CGRectGetMinY(_rect), halfW, halfH);
        childRects[3] = CGRectMake(CGRectGetMidX(_rect), CGRectGetMidY(_rect), halfW, halfH);
        for (int i=0; i<4; i++) {
            if ( !childsTree[i] ) {
                childsTree[i] = [[PISKGameQuadTree alloc] initWithRect:childRects[i]];
            }
            [childsTree[i] insert:object];
        }
    }
}

- (void) remove:(id<PISKGamePositionable>)object {
    [childs removeObject:object];
    for (int i=0; i<4; i++) {
        if ( childsTree[i] && [object havePointInRect:childsTree[i].rect]) {
            [childsTree[i] remove:object];
        }
    }
}


- (id<PISKGamePositionable>) getOneForPoint:(CGPoint)point {
    id<PISKGamePositionable> object = nil;
    if ( CGRectContainsPoint(_rect, point) ) {
        return object;
    }
    
    if ( [childs count]<=PISKGameQuadTree_maxCilds ) {
        for (object in childs) {
            if ( [object containPoint:point] ) {
                return object;
            }
        }
        return nil;
    }
    
    for (int i=0; i<4; i++) {
        object = [childsTree[i] getOneForPoint:point];
        if (object) {
            return object;
        }
    }
    
    return object;
}

- (NSMutableSet*) getAllForPoint:(CGPoint)point {
    NSMutableSet *result = [[NSMutableSet alloc] init];
    if ( CGRectContainsPoint(_rect, point) ) {
        return result;
    }
    
    if ( [childs count]<=PISKGameQuadTree_maxCilds ) {
        for (id<PISKGamePositionable> object in childs) {
            if ( [object containPoint:point] ) {
                [result addObject:object];
            }
        }
        return result;
    }

    for (int i=0; i<4; i++) {
        [result unionSet:[childsTree[i] getAllForPoint:point]];
    }
    return result;
}

- (NSMutableSet*) getAllInRect:(CGRect)rect {
    NSMutableSet *result = [[NSMutableSet alloc] init];
    if( !CGRectIntersectsRect(rect, _rect) ) {
        return result;
    }
    
    if ( CGRectContainsRect(rect, _rect)) {
        return childs;
    }
    
    if ( [childs count]<=PISKGameQuadTree_maxCilds ) {
        for (id<PISKGamePositionable> object in childs) {
            if ( [object havePointInRect:rect] ) {
                [result addObject:object];
            }
        }
        return result;
    }

    for (int i=0; i<4; i++) {
        [result unionSet:[childsTree[i] getAllInRect:rect]];
    }
    return result;
}

- (NSMutableSet*) getAllOnLineFrom:(CGPoint)p1 To:(CGPoint)p2 {
    NSMutableSet *result = [[NSMutableSet alloc] init];

    BOOL isIntersect = CGRectContainsPoint(_rect, p1);
    isIntersect = isIntersect || CGRectContainsPoint(_rect, p1);
    isIntersect = isIntersect || PISK_isLineIntersect(p1.x, p1.y, p2.x, p2.y, _rect.origin.x,  _rect.origin.y, _rect.origin.x+_rect.size.width,  _rect.origin.y);
    isIntersect = isIntersect || PISK_isLineIntersect(p1.x, p1.y, p2.x, p2.y, _rect.origin.x,  _rect.origin.y, _rect.origin.x,  _rect.origin.y+_rect.size.height);
    isIntersect = isIntersect || PISK_isLineIntersect(p1.x, p1.y, p2.x, p2.y, _rect.origin.x+_rect.size.width,  _rect.origin.y, _rect.origin.x+_rect.size.width,  _rect.origin.y+_rect.size.height);
    isIntersect = isIntersect || PISK_isLineIntersect(p1.x, p1.y, p2.x, p2.y, _rect.origin.x,  _rect.origin.y+_rect.size.height, _rect.origin.x+_rect.size.width,  _rect.origin.y+_rect.size.height);
    
    if ( !isIntersect ) {
        return result;
    }
    
    if ( [childs count]<=PISKGameQuadTree_maxCilds ) {
        for (id<PISKGamePositionable> object in childs) {
            if ( [object havePointOnLineFrom:p1 To:p2] ) {
                [result addObject:object];
            }
        }
        return result;
    }
    
    for (int i=0; i<4; i++) {
        [result unionSet:[childsTree[i] getAllOnLineFrom:p1 To:p2]];
    }
    return result;
}

@end
