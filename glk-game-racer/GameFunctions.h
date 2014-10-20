#import <CoreGraphics/CGGeometry.h>

#ifndef glk_game_racer_GameFunctions_h
#define glk_game_racer_GameFunctions_h

CG_INLINE float PISK_sign(float p1x, float p1y, float p2x, float p2y, float p3x, float p3y ) {
    return (p1x - p3x) * (p2y - p3y) - (p2x - p3x) * (p1y - p3y);
}

CG_INLINE BOOL PISK_isLineIntersect(float f1x, float f1y, float t1x, float t1y, float f2x, float f2y, float t2x, float t2y ) {
    CGFloat d = (t1x - f1x)*(t2y - f2y) - (t1y - f1y)*(t2x - f2x);
    if ( d==0 ) {
        return NO; // parallel lines
    }
    
    CGFloat u = ((f2x - f1x)*(t2y - f2y) - (f2y - f1y)*(t2x - f2x))/d;
    CGFloat v = ((f2x - f1x)*(t1y - f1y) - (f2y - f1y)*(t1x - f1x))/d;
    
    if (u < 0.0 || u > 1.0) {
        return NO;
    }

    if (v < 0.0 || v > 1.0) {
        return NO;
    }
    
    return YES;
}

#endif
