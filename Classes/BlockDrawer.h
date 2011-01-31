//
//  BlockDrawer.h
//  Tetris
//
//  Created by dm4 on 2010/2/24.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BlockDrawer : NSObject {
	CGContextRef context;
}

- (id)initWithContext:(CGContextRef)inContext;
- (void)drawType:(int)type atX:(float)x andY:(float)y;
- (void)drawType:(int)type atX:(float)x andY:(float)y fromOringin:(CGPoint)originPoint;

@end
