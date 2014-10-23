//
//  PISKViewController.m
//  glk-game-racer
//
//  Created by Maxim Berezhnoy on 17.10.14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "PISKViewController.h"

@implementation PISKViewController

@synthesize context = _context;
@synthesize effect = _effect;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    if (!self.context) {
        NSLog(@"Failed to create OpenGL ES 2.0 context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;

    [self setUpGL];
}

- (void)viewDidUnload {
    [self tearDownGL];
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
    [super viewDidUnload];
}

- (void)setUpGL {
    
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.texture2d0.enabled = GL_TRUE;
    self.effect.texture2d0.target = GLKTextureTarget2D;
    self.effect.texture2d0.envMode = GLKTextureEnvModeReplace;
    
    glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    glDepthMask(GL_TRUE);
    glEnable(GL_DEPTH_TEST);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    //@TODO:create game objects
}

- (void)tearDownGL {
    [EAGLContext setCurrentContext:self.context];
    self.effect = nil;
}

- (void)update {
    //self.timeSinceLastUpdate;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

    //prepare camera
    //render game
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //    self.paused = !self.paused;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    [_user touchesMoved:touches withEvent:event];
}

@end
