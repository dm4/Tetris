//
//  FieldModel.h
//  Tetris
//
//  Created by dm4 on 2010/2/17.
//  Copyright 2010 Meng-Han Lee, dm4. All rights reserved.
//

#import <Foundation/Foundation.h>

#define WIDTH 10
#define HEIGHT 20

@class FieldView;
@class NextView;
@class Block;

@interface FieldModel : NSObject {
	FieldView *fieldView;
	NextView *nextView;
	NSTimer *timer;
	Block *now;
	Block *next;
	Block *ghost;
	BOOL isPause;
    BOOL isDead;
	char field[WIDTH][HEIGHT];
}

@property (nonatomic, retain) FieldView *fieldView;
@property (nonatomic, retain) NextView *nextView;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, assign) BOOL isDead;

- (Block *)getNext;
- (int)getX:(int)x Y:(int)y;
- (Block *)getBlock;
- (void)timerEvent;

- (void)pause;

- (void)up;
- (void)down;
- (void)left;
- (void)right;
- (void)clockwise;
- (void)counter_clockwise;

- (void)downLongPress;
- (void)leftLongPress;
- (void)rightLongPress;

- (void)dropTillEnd;
- (void)leftTillEnd;
- (void)rightTillEnd;

- (BOOL)generate;
- (void)solid;
- (int)clearRow;
- (BOOL)rotateClockwise:(BOOL)isClockwise;
- (void)updateGhost;

- (void)newGame;
- (void)gameOver;
- (void)updateView;



@end
