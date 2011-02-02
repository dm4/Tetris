//
//  FieldView.m
//  Tetris
//
//  Created by dm4 on 2011/1/29.
//  Copyright 2011 Meng-Han Lee (dm4). All rights reserved.
//

#import "FieldView.h"
#import "BlockDrawer.h"
#import "FieldModel.h"

@implementation FieldView

@synthesize model;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    BlockDrawer *drawer = [[BlockDrawer alloc] initWithContext:context];
    for (int i=0; i<10; i++) {
        for (int j=0; j<20; j++) {
            int type = [model getX:i Y:j];
            [drawer drawType:type atX:i andY:19-j];
        }
    }
    [drawer release];
}

@end
