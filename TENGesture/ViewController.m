//
//  ViewController.m
//  TENGesture
//
//  Created by 444ten on 9/23/15.
//  Copyright © 2015 444ten. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

- (AVAudioPlayer *)loadWav:(NSString *)fileName;

@end

@implementation ViewController

#pragma mark -
#pragma mark View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.edgeSwipe requireGestureRecognizerToFail:self.squirellPan];
    [self.nutPan requireGestureRecognizerToFail:self.edgeSwipe];
    
    for (UIView *view in self.view.subviews) {
        UITapGestureRecognizer *recognizer =
            [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        recognizer.delegate = self;
        
        [view addGestureRecognizer:recognizer];
        
        [recognizer requireGestureRecognizerToFail:self.nutPan];
        
        TENTickleGestureRecognizer *tickleRecognizer =
            [[TENTickleGestureRecognizer alloc] initWithTarget:self action:@selector(handleTickle:)];
        tickleRecognizer.delegate = self;
        
        [view addGestureRecognizer:tickleRecognizer];
        [tickleRecognizer requireGestureRecognizerToFail:self.nutPan];
    }
    
    self.chompPlayer = [self loadWav:@"chomp"];
    self.hehePlayer = [self loadWav:@"hehehe1"];
}

#pragma mark -
#pragma mark Handle Recognizer

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
        
        [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
        } completion:nil];
        
    }
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)pinchRecognizer {
    CGFloat recognizerScale = pinchRecognizer.scale;
    
    pinchRecognizer.view.transform = CGAffineTransformScale(pinchRecognizer.view.transform,
                                                            recognizerScale,
                                                            recognizerScale);
    pinchRecognizer.scale = 1;
}

- (IBAction)handleRotate:(UIRotationGestureRecognizer *)rotateRecognizer {
    rotateRecognizer.view.transform = CGAffineTransformRotate(rotateRecognizer.view.transform, rotateRecognizer.rotation);
    
    rotateRecognizer.rotation = 0;
}

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)recognizer {
//    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform,
//                                                       2.0,
//                                                       2.0);
}

- (IBAction)swipe:(id)sender {
    NSLog(@"swipe");
}


- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self.chompPlayer play];
}

- (void)handleTickle:(TENTickleGestureRecognizer *)recognizer {
    [self.hehePlayer play];
}

#pragma mark -
#pragma mark Private

- (AVAudioPlayer *)loadWav:(NSString *)fileName {
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"wav"];
    NSError *error;
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    if (!player) {
        NSLog(@"Error loading %@: %@", url, error.localizedDescription);
    } else {
        [player prepareToPlay];
    }
    
    return player;
}



#pragma mark -
#pragma mark UIGestureRecognizerDelegate

- (BOOL)                            gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
   shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


@end
