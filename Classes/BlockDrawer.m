//
//  BlockDrawer.m
//  Tetris
//
//  Created by dm4 on 2010/2/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BlockDrawer.h"

#define EDGE		1.2
#define INNER_EDGE	2.0

#define CYAN	0
#define RED		1
#define ORANGE	2
#define BLUE	3
#define GREEN	4
#define PURPLE	5
#define YELLOW	6
#define GRAY	7
#define GHOST	8

#define LIGHT	0
#define DARK	1

static CGColorRef colors[9][2];

@implementation BlockDrawer

+ (void)initialize {
	CGColorSpaceRef space;
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat cyan[] = {0, 1, 1, 1};
	colors[CYAN][LIGHT] = CGColorCreate(space, cyan);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat cyanDark[] = {0, 0.7, 0.7, 1};
	colors[CYAN][DARK] = CGColorCreate(space, cyanDark);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat red[] = {1, 0, 0, 1};
	colors[RED][LIGHT] = CGColorCreate(space, red);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat redDark[] = {0.7, 0, 0, 1};
	colors[RED][DARK] = CGColorCreate(space, redDark);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat orange[] = {1, 0.5, 0, 1};
	colors[ORANGE][LIGHT] = CGColorCreate(space, orange);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat orangeDark[] = {0.7, 0.2, 0, 1};
	colors[ORANGE][DARK] = CGColorCreate(space, orangeDark);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat blue[] = {0.1, 0.1, 1, 1};
	colors[BLUE][LIGHT] = CGColorCreate(space, blue);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat blueDark[] = {0.1, 0.1, 0.8, 1};
	colors[BLUE][DARK] = CGColorCreate(space, blueDark);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat green[] = {0, 1, 0, 1};
	colors[GREEN][LIGHT] = CGColorCreate(space, green);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat greenDark[] = {0, 0.7, 0, 1};
	colors[GREEN][DARK] = CGColorCreate(space, greenDark);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat purple[] = {0.5, 0.1, 0.5, 1};
	colors[PURPLE][LIGHT] = CGColorCreate(space, purple);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat purpleDark[] = {0.35, 0.1, 0.35, 1};
	colors[PURPLE][DARK] = CGColorCreate(space, purpleDark);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat yellow[] = {1, 1, 0, 1};
	colors[YELLOW][LIGHT] = CGColorCreate(space, yellow);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat yellowDark[] = {0.7, 0.7, 0, 1};
	colors[YELLOW][DARK] = CGColorCreate(space, yellowDark);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat gray[] = {0.5, 0.5, 0.5, 1};
	colors[GRAY][LIGHT] = CGColorCreate(space, gray);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat grayDark[] = {0.2, 0.2, 0.2 , 1};
	colors[GRAY][DARK] = CGColorCreate(space, grayDark);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat ghost[] = {0.9, 0.9, 0.9, 1};
	colors[GHOST][LIGHT] = CGColorCreate(space, ghost);
	CGColorSpaceRelease(space);
	
	space = CGColorSpaceCreateDeviceRGB();
	CGFloat ghostDark[] = {0.7, 0.7, 0.7, 1};
	colors[GHOST][DARK] = CGColorCreate(space, ghostDark);
	CGColorSpaceRelease(space);
}

- (id)initWithContext:(CGContextRef)inContext {
	if (self = [super init]) {
		context = inContext;
	}
	return self;
}

- (void)drawType:(int)type atX:(float)x andY:(float)y {
	[self drawType:type atX:x andY:y fromOringin:CGPointMake(0, 0)];
}

- (void)drawType:(int)type atX:(float)x andY:(float)y fromOringin:(CGPoint)originPoint {
	if (!type) {
		return;
	}
	CGRect blackBlock, colorBlock, innerBlock;
	
	blackBlock.size = CGSizeMake(16, 16);
	colorBlock.size = CGSizeMake(16 - 2*EDGE, 16 - 2*EDGE);
	innerBlock.size = CGSizeMake(16 - 2*(EDGE+INNER_EDGE), 16 - 2*(EDGE+INNER_EDGE));
	
	blackBlock.origin.x = originPoint.x + 16*x;
	colorBlock.origin.x = blackBlock.origin.x + EDGE;
	innerBlock.origin.x = colorBlock.origin.x + INNER_EDGE;
	blackBlock.origin.y = originPoint.y + 16*y;
	colorBlock.origin.y = blackBlock.origin.y + EDGE;
	innerBlock.origin.y = colorBlock.origin.y + INNER_EDGE;
	
	if (type == 1) {
		CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
		CGContextFillRect(context, blackBlock);
		CGContextSetFillColorWithColor(context, colors[GRAY][DARK]);
		CGContextFillRect(context, colorBlock);						
		CGContextSetFillColorWithColor(context, colors[GRAY][LIGHT]);
		CGContextFillRect(context, innerBlock);
	}
	else if (type == 20) {//ghost
		CGContextSetRGBFillColor(context, 0.3, 0.3, 0.3, 1.0);
		CGContextFillRect(context, blackBlock);
		CGContextSetFillColorWithColor(context, colors[GHOST][DARK]);
		CGContextFillRect(context, colorBlock);
		CGContextSetFillColorWithColor(context, colors[GHOST][LIGHT]);
		CGContextFillRect(context, innerBlock);
	}
	else if (type >= 10){
		CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 1.0);
		CGContextFillRect(context, blackBlock);
		CGContextSetFillColorWithColor(context, colors[type-10][DARK]);
		CGContextFillRect(context, colorBlock);
		CGContextSetFillColorWithColor(context, colors[type-10][LIGHT]);
		CGContextFillRect(context, innerBlock);
	}
}

@end
