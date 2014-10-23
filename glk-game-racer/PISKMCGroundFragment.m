//
//  PISKMCGroundFragment.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 18.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import "PISKMCGroundFragment.h"

@implementation PISKMCGroundFragment {
    GLfloat pointInfo[4][PISKGameSegmentInfoMaxIndex];
    
    BOOL initFunctionIndexes;
    double functionIndexes[4][4];
    GLKVector2 lasInfoForPoint;
    double pointXPow[4];
    double pointYPow[4];
}

@synthesize segmentRect;

- (instancetype) initForRect:(CGRect)rect {
    self = [self init];
    if (self) {
        segmentRect = rect;
        initFunctionIndexes = NO;
        lasInfoForPoint = GLKVector2Make(NAN, NAN);
        pointXPow[0] = pointYPow[0] = 1.0;
        for (int i=0; i<PISKGameSegmentInfoMaxIndex; i++) {
            pointInfo[0][i] = pointInfo[1][i] = pointInfo[2][i] = pointInfo[3][i] = [self _getDefaultInfoValue:i];
        }
    }
    return self;
}

- (GLfloat) _getDefaultInfoValue:(PISKGameSegmentInfo)infoId {
    switch (infoId) {
        case PISKGameSegmentInfoZPosition:
        case PISKGameSegmentInfoNormalX:
        case PISKGameSegmentInfoNormalY:
            return 0.0;
        case PISKGameSegmentInfoNormalZ:
            return 1;
        case PISKGameSegmentInfoMaxSpeedFactor:
        case PISKGameSegmentInfoMaxAccelerationFactor:
            return 0.4;
            
        default:
            return NAN;
    }
    return NAN;
}

- (void) setPoint:(PISKMCRectSegmentPointId)pointId Info:(PISKGameSegmentInfo)infoId Value:(GLfloat)value {
    pointInfo[pointId][infoId] = value;
    initFunctionIndexes = NO;
}

- (GLfloat) getPoint:(GLKVector2)point Info:(PISKGameSegmentInfo)infoId {
    if ( !initFunctionIndexes ) {
        [self _initFunctionIndexes];
    }
    //usualy request info (PISKGameSegmentInfoZPosition,PISKGameSegmentInfoNormalX, PISKGameSegmentInfoNormalY) for same point => save position powers
    if (lasInfoForPoint.x != point.x) {
        pointXPow[1] = point.x-segmentRect.origin.x;
        pointXPow[2] = pointXPow[1]*pointXPow[1];
        pointXPow[3] = pointXPow[2]*pointXPow[1];
        lasInfoForPoint.x = point.x;
    }
    if (lasInfoForPoint.y != point.y) {
        pointYPow[1] = point.y-segmentRect.origin.y;
        pointYPow[2] = pointYPow[1]*pointYPow[1];
        pointYPow[3] = pointYPow[2]*pointYPow[1];
        lasInfoForPoint.y = point.y;
    }
    
    double result = 0.0;

    switch (infoId) {
        case PISKGameSegmentInfoZPosition:
            for (int px=0; px<4; px++) {
                for (int py=0; py<4; py++) {
                    result += functionIndexes[px][py]*pointXPow[px]*pointYPow[py];
                }
            }
            return (GLfloat)result;
        case PISKGameSegmentInfoNormalX:
            for (int px=1; px<4; px++) {
                for (int py=0; py<4; py++) {
                    result -= px*functionIndexes[px][py]*pointXPow[px-1]*pointYPow[py];
                }
            }
            return (GLfloat)result;
        case PISKGameSegmentInfoNormalY:
            for (int px=0; px<4; px++) {
                for (int py=1; py<4; py++) {
                    result -= py*functionIndexes[px][py]*pointXPow[px]*pointYPow[py-1];
                }
            }
            return (GLfloat)result;
        case PISKGameSegmentInfoNormalZ:
            return 1.0;
        default:
            return pointInfo[PISKMCRectSegmentPointBL][infoId];
    }
    return NAN;
}

- (void) _initFunctionIndexes {
    /*
     x1 - x0 = w = segmentRect.size.width
     y1 - y0 = h = segmentRect.size.height
     F(x) = A*(x-x0)^3+B*(x-x0)^2+C*(x-x0)+D
     F(x0) = z0    |   D = z0
     F`(x0) = nx0  |-\ C = nx0
     F(x1) = z1    |-/ B = (3*z1-3*z0-nx1*w-2*nx0*w)/w^2
     F`(x0) = nx1  |   A = (2*z0-2*z1+nx0*w+nx1*w)/w^3
     */
    double nxBL = -pointInfo[PISKMCRectSegmentPointBL][PISKGameSegmentInfoNormalX]/pointInfo[PISKMCRectSegmentPointBL][PISKGameSegmentInfoNormalZ];
    double nyBL = -pointInfo[PISKMCRectSegmentPointBL][PISKGameSegmentInfoNormalY]/pointInfo[PISKMCRectSegmentPointBL][PISKGameSegmentInfoNormalZ];
    double nxBR = -pointInfo[PISKMCRectSegmentPointBR][PISKGameSegmentInfoNormalX]/pointInfo[PISKMCRectSegmentPointBR][PISKGameSegmentInfoNormalZ];
    double nyBR = -pointInfo[PISKMCRectSegmentPointBR][PISKGameSegmentInfoNormalY]/pointInfo[PISKMCRectSegmentPointBR][PISKGameSegmentInfoNormalZ];
    double nxTL = -pointInfo[PISKMCRectSegmentPointTL][PISKGameSegmentInfoNormalX]/pointInfo[PISKMCRectSegmentPointTL][PISKGameSegmentInfoNormalZ];
    double nyTL = -pointInfo[PISKMCRectSegmentPointTL][PISKGameSegmentInfoNormalY]/pointInfo[PISKMCRectSegmentPointTL][PISKGameSegmentInfoNormalZ];
    double nxTR = -pointInfo[PISKMCRectSegmentPointTR][PISKGameSegmentInfoNormalX]/pointInfo[PISKMCRectSegmentPointTR][PISKGameSegmentInfoNormalZ];
    double nyTR = -pointInfo[PISKMCRectSegmentPointTR][PISKGameSegmentInfoNormalY]/pointInfo[PISKMCRectSegmentPointTR][PISKGameSegmentInfoNormalZ];
    double w = segmentRect.size.width;
    double h = segmentRect.size.height;
    double zBL = pointInfo[PISKMCRectSegmentPointBL][PISKGameSegmentInfoZPosition];
    double zBR = pointInfo[PISKMCRectSegmentPointBR][PISKGameSegmentInfoZPosition];
    double zTL = pointInfo[PISKMCRectSegmentPointTL][PISKGameSegmentInfoZPosition];
    double zTR = pointInfo[PISKMCRectSegmentPointTR][PISKGameSegmentInfoZPosition];
    double AB = (2*zBL-2*zBR+nxBL*w+nxBR*w)/(w*w*w);
    double BB = (3*zBR-3*zBL-nxBR*w-2*nxBL*w)/(w*w);
    double CB = nxBL;
    double DB = zBL;
    double AT = (2*zTL-2*zTR+nxTL*w+nxTR*w)/(w*w*w);
    double BT = (3*zTR-3*zTL-nxTR*w-2*nxTL*w)/(w*w);
    double CT = nxTL;
    double DT = zTL;
    
    /*
     F(x, y) = A(x)*(y-yBL)^3+B(x)*(y-yBL)^2+C(x)*(y-yBL)+D(x)
     F(x, yBL) = AB*(x-xBL)^3+BB*(x-xBL)^2+CB*(x-xBL)+DB         |z0
     F(x, yTL) = AT*(x-xBL)^3+BT*(x-xBL)^2+CT*(x-xBL)+DT         |z1
     dF(x, yBL)/dy = nyBR*(x-xBL)/w + nyBL                       |n0
     dF(x, yTL)/dy = nyTR*(x-xBL)/w + nyTL                       |n1
     ||
     \/
     D(x) = AB*(x-xBL)^3+BB*(x-xBL)^2+CB*(x-xBL)+DB
     C(x) = nyBR*(x-xBL)/w + nyBL
     B(x) = ( 3*(AT-AB)*(x-xBL)^3 + 3*(BT-BB)*(x-xBL)^2 + (3*CT-3*CB-nyTR*h/w-2*nyBR*h/w)*(x-xBL) + (3*DT-3*DB-nyTL*h-2*nyBL*h) )/h^2
     A(x) = ( 2*(AB-AT)*(x-xBL)^3 + 2*(BB-BT)*(x-xBL)^2 + (2*CB-2*CT+nyTR*h/w+nyBR*h/w)*(x-xBL) + (2*DB-2*DT+nyTL+nyBL) )/h^3
     
     F(x, y) = P33*(x-xBL)^3*(y-yBL)^3 + P32*(x-xBL)^3*(y-yBL)^2 + P31*(x-xBL)^3*(y-yBL) + P30*(x-xBL)^3 +
               P23*(x-xBL)^2*(y-yBL)^3 + P22*(x-xBL)^2*(y-yBL)^2 + P21*(x-xBL)^2*(y-yBL) + P20*(x-xBL)^2
               P13*(x-xBL)  *(y-yBL)^3 + P12*(x-xBL)  *(y-yBL)^2 + P11*(x-xBL)  *(y-yBL) + P20*(x-xBL)
               P03          *(y-yBL)^3 + P02*         *(y-yBL)^2 + P01          *(y-yBL) + P00
                  ||                        ||                        ||                      ||
                  \/                        \/                        \/                      \/
                 A(x)                      B(x)                      C(x)                    D(x)

     */
    functionIndexes[3][3] = 2*(AB-AT);
    functionIndexes[2][3] = 2*(BB-BT);
    functionIndexes[1][3] = 2*CB-2*CT+nyTR*h/w+nyBR*h/w;
    functionIndexes[0][3] = 2*DB-2*DT+nyTL+nyBL;
    
    functionIndexes[3][2] = 3*(AT-AB);
    functionIndexes[2][2] = 3*(BT-BB);
    functionIndexes[1][2] = 3*CT-3*CB-nyTR*h/w-2*nyBR*h/w;
    functionIndexes[0][2] = 3*DT-3*DB-nyTL*h-2*nyBL*h;
    
    functionIndexes[3][1] = 0;
    functionIndexes[2][1] = 0;
    functionIndexes[1][1] = nyBR/w;
    functionIndexes[0][1] = nyBL;
    
    functionIndexes[3][0] = AB;
    functionIndexes[2][0] = BB;
    functionIndexes[1][0] = CB;
    functionIndexes[0][0] = DB;
    
    initFunctionIndexes = YES;
}

- (NSSet*)decompose {
    return nil;
}

+ (instancetype) create:(int)segmentId forTask:(PISKMapCompiller*) task {
    return nil;
}

@end
