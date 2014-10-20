//
//  PISKMCGroundFragment.h
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 18.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface PISKMCGroundFragment : NSObject

- (instancetype) initForX:(GLfloat)x Y:(GLfloat)x Width:(GLfloat)width Height:(GLfloat)height;
- (void) setNormales;

@end
