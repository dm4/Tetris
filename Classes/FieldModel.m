//
//  FieldModel.m
//  Tetris
//
//  Created by dm4 on 2010/2/17.
//  Copyright 2010 Meng-Han Lee, dm4. All rights reserved.
//

#import "FieldModel.h"
#import "FieldView.h"
#import	"Block.h"

@implementation FieldModel

@synthesize fieldView;
//@synthesize nextView;
@synthesize timer;
@synthesize isDead;

- (id)init {
	if (self = [super init]) {
        [self newGame];
	}
	[self updateView];
	return self;
}

- (Block *)getNext {
	return next;
}

- (int)getX:(int)x Y:(int)y {
	return field[x][y];
}

- (Block *)getBlock {
	return now;
}

- (void)timerEvent {
//	NSLog(@"timer event");
	if (!isPause) {
		if (![self drop]) {
			[self solid];
			if (![self generate]) {
				[self gameOver];
			}
		}
		[self updateView];
	}
}

- (void)pause {
	isPause = !isPause;
}

- (void)upClick {
	if (!isPause) {
		[self dropTillEnd];
	}
}

- (void)downClick {
	if (!isPause) {
		[self drop];
	}
}

- (void)leftClick {
	if (!isPause) {
		[self left];
	}
}

- (void)rightClick {
	if (!isPause) {
		[self right];
	}
}

- (void)rotate1Click {
	if (!isPause) {
		[self rotateClockwise:YES];
	}
}

- (void)rotate2Click {
	if (!isPause) {
		[self rotateClockwise:NO];
	}
}

- (void)upTimer {}

- (void)downTimer {
	if (!isPause) {
		[self drop];
	}
}

- (void)leftTimer {
	if (!isPause) {
		[self leftTillEnd];
	}
}
- (void)rightTimer {
	if (!isPause) {
		[self rightTillEnd];
	}
}
- (void)rotate1Timer {}
- (void)rotate2Timer {}

- (BOOL)drop {
	State *center = now.center;
	NSMutableArray *blockStates = now.states;
	for (State *state in blockStates) {
		// reach bottom
		if (center.y + state.y == 0) {
			return NO;
		}
		// reach solided piece
		if (field[center.x+state.x][center.y+state.y-1] == 1) {
			return NO;
		}
	}
	for (State *state in blockStates) {
		field[center.x+state.x][center.y+state.y] = 0;
	}
	for (State *state in blockStates) {
		field[center.x+state.x][center.y+state.y-1] = 10 + now.type;
	}
	[now drop];
	[self updateView];
	return YES;
}

- (BOOL)left {
	State *center = now.center;
	NSArray *blockStates = now.states;
	for (State *state in blockStates) {
		// reach left bound
		if (center.x + state.x == 0) {
			return NO;
		}
		// reach solided piece
		if (field[center.x+state.x-1][center.y+state.y] == 1) {
			return NO;
		}
	}
	for (State *state in blockStates) {
		field[center.x+state.x][center.y+state.y] = 0;
	}
	for (State *state in blockStates) {
		field[center.x+state.x-1][center.y+state.y] = 10 + now.type;
	}
	[now left];
	[self updateView];
	return YES;
}

- (BOOL)right {
	State *center = now.center;
	NSMutableArray *blockStates = now.states;
	for (State *state in blockStates) {
		// reach left bound
		if (center.x + state.x == 9) {
			return NO;
		}
		// reach solided piece
		if (field[center.x+state.x+1][center.y+state.y] == 1) {
			return NO;
		}
	}
	// erease older piece
	for (State *state in blockStates) {
		field[center.x+state.x][center.y+state.y] = 0;
	}
	// draw new piece
	for (State *state in blockStates) {
		field[center.x+state.x+1][center.y+state.y] = 10 + now.type;
	}
	[now right];
	[self updateView];
	return YES;
}

- (void)dropTillEnd {
	while ([self drop]) {
	}
	[self solid];
	if (![self generate]) {
		[self gameOver];
	}
	[self updateView];
}

- (void)leftTillEnd {
	while([self left]);
}

- (void)rightTillEnd {
	while([self right]);
}

- (BOOL)generate {
	now = next;
	next = [[Block alloc] init];
	NSMutableArray *blockStates = now.states;
	for (State *state in blockStates) {
		if ([self getX:state.x+4 Y:state.y+18]) {
			isDead = YES;
		}
	}
	for (State *state in blockStates) {
		State *center = now.center;
		field[center.x+state.x][center.y+state.y] = 10 + now.type;
	}
	return !isDead;
}

- (void)solid {
	State *center = now.center;
	NSMutableArray *blockStates = now.states;
	for (State *state in blockStates) {
		field[center.x+state.x][center.y+state.y] = 1;
	}
	[self clearRow];
	[now release];
	if (ghost) {
		[ghost release];
		ghost = nil;
	}
}

- (int)clearRow {
	BOOL shouldClear;
	int lines = 0;
	for (int i=0; i<20; i++) {
		shouldClear = YES;
		for (int j=0; j<10; j++) {
			if(!field[j][i]) {
				shouldClear = NO;
			}
		}
		if (shouldClear) {
			lines++;
			for (int j=i; j<19; j++) {
				for (int k=0; k<10; k++) {
					field[k][j] = field[k][j+1];
				}
			}
			i--;
		}
	}
	return lines;
}

- (BOOL)rotateClockwise:(BOOL)isClockwise {
	if (now.type == 6) {
		return YES;
	}
	State *center = [now.center copy];
	NSMutableArray *newStates = [[NSMutableArray alloc] initWithCapacity:4];
	for (State *state in now.states) {
		State *rotatedState;
		rotatedState = isClockwise ? [[State alloc] initWithX:state.y Y:-state.x]
									:[[State alloc] initWithX:-state.y Y:state.x];
		[newStates addObject:rotatedState];
		[rotatedState release];
	}
	BOOL needsKickWall = NO;
	for (State *state in newStates) {
		if (center.x+state.x >= 10 || center.x+state.x < 0) {
			needsKickWall = YES;
			break;
		}
		if (center.y+state.y >= 20 || center.y+state.y < 0) {
			needsKickWall = YES;
			break;
		}
		if (field[center.x+state.x][center.y+state.y] == 1) {
			needsKickWall = YES;
			break;
		}
	}
	int kickWallOK = 0;
	if (needsKickWall) {
		for (int dx=-1; dx<=1; dx+=2) {
			NSLog(@"if dx = %d", dx);
			int successStates = 0;
			for (State *state in newStates) {
				NSLog(@"center.x+state.x+dx %d", center.x+state.x+dx);
				if (center.x+state.x+dx >= 10 || center.x+state.x+dx < 0) {
					break;
				}
				if (center.y+state.y >= 20 || center.y+state.y < 0) {
					break;
				}
				if (field[center.x+state.x+dx][center.y+state.y] == 1) {
					break;
				}
				successStates++;
			}
			if (successStates == 4) {
				kickWallOK = dx;
			}
			NSLog(@"set kickWallOK to %d", kickWallOK);
		}
		NSLog(@"kickwall = %d", kickWallOK);
		if (kickWallOK) {
			center.x += kickWallOK;
		}
		else {
			return NO;
		}

	}
	// erease older piece
	for (State *state in now.states) {
		field[now.center.x+state.x][now.center.y+state.y] = 0;
	}
	// draw new piece
	for (State *state in newStates) {
		field[center.x+state.x][center.y+state.y] = 10 + now.type;
	}
	now.states = newStates;
	now.center = center;

	[newStates release];
	[center release];
	[self updateView];
	return YES;
}

- (void)updateGhost {
	if (ghost) {
		for (State *state in ghost.states) {
			field[ghost.center.x+state.x][ghost.center.y+state.y] = 0;
		}
		[ghost release];
	}
	ghost = [now copy];
	BOOL ghostDropEnd = NO;
	while (!ghostDropEnd) {
		for (State *state in ghost.states) {
			if (ghost.center.y+state.y == 0 || field[ghost.center.x+state.x][ghost.center.y+state.y-1] == 1) {
				ghostDropEnd = YES;
				break;
			}
		}
		if (!ghostDropEnd) {
			ghost.center.y--;
		}
	}
	for (State *state in ghost.states) {
		field[ghost.center.x+state.x][ghost.center.y+state.y] = 20;
	}
	for (State *state in now.states) {
		field[now.center.x+state.x][now.center.y+state.y] = 10 + now.type;
	}
}

- (void)newGame {
    NSLog(@"New Game");
    self.isDead = NO;
    for (int i=0; i<WIDTH; i++) {
        for (int j=0; j<HEIGHT; j++) {
            field[i][j] = 0;
        }
    }
    isPause = NO;
    next = [[Block alloc] init];
    ghost = nil;
    [self generate];
    self.timer = [NSTimer timerWithTimeInterval:0.2
                                         target:self
                                       selector:@selector(timerEvent)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)gameOver {
    [timer invalidate];
	[self pause];
	[fieldView gameOver];
}

- (void)updateView {
	[self updateGhost];
	[fieldView setNeedsDisplay];
//	[nextView setNeedsDisplay];
}

- (void)dealloc {
	[now release];
	[next release];
	[ghost release];
//	[nextView release];
	[fieldView release];
	[timer release];
	[super dealloc];
}

@end
