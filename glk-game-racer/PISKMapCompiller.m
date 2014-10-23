//
//  PISKMapCompiller.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 18.10.14.
//  Copyright (c) 2014 Maxim Berezhnoy. All rights reserved.
//

#import "PISKMapCompiller.h"

@implementation PISKMapCompiller {
}

@synthesize mapJson;
@synthesize groundFragments;

- (instancetype) initWithJson:(NSDictionary*)map {
    self = [self init];
    mapJson = map;
    return self;
}

- (void) compile {
    
}

@end
