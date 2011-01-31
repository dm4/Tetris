//
//  ArrowButton.m
//  Tetris
//
//  Created by dm4 on 2011/1/29.
//  Copyright 2011 Meng-Han Lee (dm4). All rights reserved.
//

#import "ArrowButton.h"
#import "Constants.h"

@implementation ArrowButton

- (void) drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
	CGContextSetLineWidth(context, BUTTON_STROKE);
	CGRect buttonFrame = CGRectInset(self.bounds, BUTTON_STROKE/2, BUTTON_STROKE/2);
	CGContextAddEllipseInRect(context, buttonFrame);
	CGContextStrokePath(context);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.alpha = 1.0;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    self.alpha = 0.5;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.alpha = 0.5;
}

@end
