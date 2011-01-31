//
//  Block.h
//  Tetris
//
//  Created by dm4 on 2010/2/18.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface State : NSObject {
	int x;
	int y;
}

- (id)initWithX:(int)xIn Y:(int)yIn;
- (id)copy;

@property (nonatomic) int x;
@property (nonatomic) int y;

@end

@interface Block : NSObject {
	int type;
	State *center;
	NSMutableArray *states;
}

- (id)initWithBlock:(Block *)oldBlock;
- (void)left;
- (void)right;
- (void)drop;
- (id)copy;

@property (nonatomic) int type;
@property (nonatomic, retain) State *center;
@property (nonatomic, retain) NSMutableArray *states;

@end
