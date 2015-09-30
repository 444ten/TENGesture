//
//  ViewController.h
//  TENGesture
//
//  Created by 444ten on 9/23/15.
//  Copyright © 2015 444ten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#import "TENTickleGestureRecognizer.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate>
@property (nonatomic, strong)   AVAudioPlayer   *chompPlayer;
@property (nonatomic, strong)   AVAudioPlayer   *hehePlayer;

@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *nutPan;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *squirellPan;
@property (strong, nonatomic) IBOutlet UIScreenEdgePanGestureRecognizer *edgeSwipe;

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
- (IBAction)handlePinch:(UIPinchGestureRecognizer *)pinchRecognizer;
- (IBAction)handleRotate:(UIRotationGestureRecognizer *)rotateRecognizer;

- (IBAction)handleLongPress:(UILongPressGestureRecognizer *)recognizer;

- (IBAction)swipe:(id)sender;

- (void)handleTap:(UITapGestureRecognizer *)recognizer;
- (void)handleTickle:(TENTickleGestureRecognizer *)recognizer;

@end

