//
//  TENTickleGestureRecognizer.h
//  TENGesture
//
//  Created by 444ten on 9/29/15.
//  Copyright © 2015 444ten. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum NSUInteger  {
    DirectionUnknown = 0,
    DirectionLeft,
    DirectionRight
} TENDirection;

@interface TENTickleGestureRecognizer : UIGestureRecognizer
@property (nonatomic, assign)   NSUInteger      tickleCount;
@property (nonatomic, assign)   CGPoint         currentTickleStart;
@property (nonatomic, assign)   TENDirection    lastDirection;

@end
