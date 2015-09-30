//
//  TENTickleGestureRecognizer.m
//  TENGesture
//
//  Created by 444ten on 9/29/15.
//  Copyright © 2015 444ten. All rights reserved.
//

#import "TENTickleGestureRecognizer.h"

#import <math.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

static const NSUInteger TENRequiredTickles           = 2;
static const CGFloat TENMoveAmplitudePerTickle      = 25.0;

@interface TENTickleGestureRecognizer ()

- (void)resetState;

@end

@implementation TENTickleGestureRecognizer

#pragma mark -
#pragma mark Private

- (void)resetState {
    self.tickleCount = 0;
    self.currentTickleStart = CGPointZero;
    self.lastDirection = DirectionUnknown;
    
    if (UIGestureRecognizerStatePossible == self.state) {
        self.state = UIGestureRecognizerStateFailed;
    }
}

#pragma mark -
#pragma mark Overwrite

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    self.currentTickleStart = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint ticklePoint = [touch locationInView:self.view];
    CGFloat moveAmplitude = ticklePoint.x - self.currentTickleStart.x;
    
    if (fabs(moveAmplitude) < TENMoveAmplitudePerTickle) {
        return;
    }
    
    TENDirection currentDirection = (moveAmplitude < 0) ? DirectionLeft : DirectionRight;
    TENDirection lastDirection = self.lastDirection;
    
    if (DirectionUnknown == lastDirection ||
        (DirectionLeft == lastDirection && DirectionRight == currentDirection) ||
        (DirectionRight == lastDirection && DirectionLeft == currentDirection))
    {
        self.tickleCount += 1;
        self.currentTickleStart = ticklePoint;
        self.lastDirection = currentDirection;
        
        if (UIGestureRecognizerStatePossible == self.state && self.tickleCount > TENRequiredTickles) {
            self.state = UIGestureRecognizerStateEnded;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self resetState];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self resetState];
}

@end
