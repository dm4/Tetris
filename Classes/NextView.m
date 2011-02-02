//
//  NextView.m
//  Tetris
//
//  Created by dm4 on 2010/2/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NextView.h"
#import "FieldModel.h"
#import "NextView.h"
#import "BlockDrawer.h"
#import "Block.h"


@implementation NextView

@synthesize model;

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	BlockDrawer *drawer = [[BlockDrawer alloc] initWithContext:context];
	if (model) {
		Block *next = [model getNext];
//		NSLog(@"next type %d", next.type);
		for (State *state in next.states) {
			if (next.type == 0) {
				[drawer drawType:next.type+10 atX:state.x+1 andY:1-state.y];
			}
			else if (next.type == 6) {
				[drawer drawType:next.type+10 atX:state.x+1 andY:1-state.y fromOringin:CGPointMake(0, 8)];
			}
			else {
				[drawer drawType:next.type+10 atX:state.x+1 andY:1-state.y fromOringin:CGPointMake(8, 8)];
			}

		}
	}	
	[drawer release];
}

- (void)dealloc {
	[model release];
    [super dealloc];
}


@end
