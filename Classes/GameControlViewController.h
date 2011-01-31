//
//  GameControlViewController.h
//  Tetris
//
//  Created by dm4 on 2011/1/29.
//  Copyright 2011 Meng-Han Lee (dm4). All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArrowButton;

@interface GameControlViewController : UIViewController<UIGestureRecognizerDelegate> {
    ArrowButton *recentMoveButton;
    IBOutlet ArrowButton *up;
    IBOutlet ArrowButton *down;
    IBOutlet ArrowButton *left;
    IBOutlet ArrowButton *right;
    IBOutlet ArrowButton *clockwise;
    IBOutlet ArrowButton *counter_clockwise;
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer;
- (void)updateButtonPosition;
- (IBAction)back;
- (IBAction)reset;

@end
