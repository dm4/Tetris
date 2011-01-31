//
//  Block.m
//  Tetris
//
//  Created by dm4 on 2010/2/18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Block.h"
#import <time.h>

static NSArray *blockData = nil;

@implementation State
@synthesize x;
@synthesize y;
- (id)initWithX:(int)xIn Y:(int)yIn {
	x = xIn;
	y = yIn;
	return self;
}
- (id)copy {
	return [[State alloc] initWithX:x Y:y];
}
@end


@implementation Block

@synthesize center;
@synthesize states;
@synthesize type;

+ (void)initialize {
	if (!blockData) {
		NSMutableArray *ary = [[NSMutableArray alloc] initWithCapacity:7];
		//xoxx
		[ary addObject:[NSArray arrayWithObjects:
						[[[State alloc] initWithX:-1 Y:0] autorelease],
						[[[State alloc] initWithX:0 Y:0] autorelease],
						[[[State alloc] initWithX:1 Y:0] autorelease],
						[[[State alloc] initWithX:2 Y:0] autorelease], nil]];
		//xx
		// ox
		[ary addObject:[NSArray arrayWithObjects:
						[[[State alloc] initWithX:-1 Y:1] autorelease],
						[[[State alloc] initWithX:0 Y:1] autorelease],
						[[[State alloc] initWithX:0 Y:0] autorelease],
						[[[State alloc] initWithX:1 Y:0] autorelease], nil]];
		//  x
		//xox
		[ary addObject:[NSArray arrayWithObjects:
						[[[State alloc] initWithX:-1 Y:0] autorelease], 
						[[[State alloc] initWithX:0 Y:0] autorelease],
						[[[State alloc] initWithX:1 Y:1] autorelease],
						[[[State alloc] initWithX:1 Y:0] autorelease], nil]];
		//x
		//xox
		[ary addObject:[NSArray arrayWithObjects:
						[[[State alloc] initWithX:-1 Y:1] autorelease], 
						[[[State alloc] initWithX:-1 Y:0] autorelease],
						[[[State alloc] initWithX:0 Y:0] autorelease],
						[[[State alloc] initWithX:1 Y:0] autorelease], nil]];
		// xx
		//xo
		[ary addObject:[NSArray arrayWithObjects:
						[[[State alloc] initWithX:-1 Y:0] autorelease], 
						[[[State alloc] initWithX:0 Y:1] autorelease],
						[[[State alloc] initWithX:0 Y:0] autorelease],
						[[[State alloc] initWithX:1 Y:1] autorelease], nil]];
		// x
		//xox
		[ary addObject:[NSArray arrayWithObjects:
						[[[State alloc] initWithX:-1 Y:0] autorelease], 
						[[[State alloc] initWithX:0 Y:1] autorelease],
						[[[State alloc] initWithX:0 Y:0] autorelease],
						[[[State alloc] initWithX:1 Y:0] autorelease], nil]];
		//xx
		//ox
		[ary addObject:[NSArray arrayWithObjects:
						[[[State alloc] initWithX:0 Y:1] autorelease], 
						[[[State alloc] initWithX:0 Y:0] autorelease],
						[[[State alloc] initWithX:1 Y:1] autorelease],
						[[[State alloc] initWithX:1 Y:0] autorelease], nil]];
				
		blockData = [[NSArray alloc] initWithArray:ary];
		[ary release];
	}
}

- (id)init {
	if (self = [super init]) {
		type = random() % 7;
		center = [[State alloc] initWithX:4 Y:18];
		states = [[NSMutableArray alloc] initWithArray:[blockData objectAtIndex:type]];
	}
	return self;
}

- (id)initWithBlock:(Block *)oldBlock {
	if (self = [super init]) {
		type = oldBlock.type;
		center = [[State alloc] initWithX:oldBlock.center.x	Y:oldBlock.center.y];
		states = [[NSMutableArray alloc] initWithArray:oldBlock.states];
	}
	return self;
}

- (void)left {
	center.x -= 1;
}

- (void)right {
	center.x += 1;
}

- (void)drop {
	center.y -= 1;
}

- (id)copy {
	return [[Block alloc] initWithBlock:self];
}

- (void)dealloc {
	[center release];
	[states release];
	[super dealloc];
}

@end
