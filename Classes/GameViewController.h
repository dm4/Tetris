//
//  GameViewController.h
//  Tetris
//
//  Created by dm4 on 2011/1/27.
//  Copyright 2011 Meng-Han Lee, dm4. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ArrowButton;
@class FieldView;
@class FieldModel;
@class NextView;

@interface GameViewController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet ArrowButton *up;
    IBOutlet ArrowButton *down;
    IBOutlet ArrowButton *left;
    IBOutlet ArrowButton *right;
    IBOutlet ArrowButton *clockwise;
    IBOutlet ArrowButton *counter_clockwise;  
    IBOutlet FieldView *fieldView;
    IBOutlet NextView *nextView;
    IBOutlet UIView *pauseView;
    FieldModel *model;
}

@property (nonatomic, retain) FieldModel *model;

- (void)updateButtonPosition;
- (void)handleDoubleTapFrom:(UITapGestureRecognizer *)recognizer;
- (void)handleDownLongPress;
- (void)handleLeftLongPress;
- (void)handleRightLongPress;
- (void)pauseModel;
- (IBAction)back;
- (IBAction)pressUp;
- (IBAction)pressDown;
- (IBAction)pressLeft;
- (IBAction)pressRight;
- (IBAction)pressClockwise;
- (IBAction)pressCounterClockwise;
- (IBAction)pressResume;
- (IBAction)test;

@end
