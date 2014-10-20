//
//  GameProtocols.h
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 17.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import <GLKit/GLKit.h>

#ifndef glk_game_racer_GameProtocols_h
#define glk_game_racer_GameProtocols_h

@protocol PISKGamePositionable <NSObject>

- (BOOL) containPoint:(CGPoint)point;
- (BOOL) havePointInRect: (CGRect)rect;
- (BOOL) havePointOnLineFrom:(CGPoint)p1 To:(CGPoint)p2;

@end


#endif
