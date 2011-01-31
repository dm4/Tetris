//
//  GameViewController.m
//  Tetris
//
//  Created by dm4 on 2011/1/27.
//  Copyright 2011 Meng-Han Lee, dm4. All rights reserved.
//

#import "GameViewController.h"
#import "ArrowButton.h"
#import "FieldModel.h"
#import "FieldView.h"

@implementation GameViewController

@synthesize model;

#pragma mark -
#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateButtonPosition];
    
    //bind view & model
    FieldModel *newModel = [[FieldModel alloc] init];
	newModel.fieldView = fieldView;
	fieldView.model = newModel;
    self.model = newModel;
    [newModel release];
    [self.view bringSubviewToFront:right];
    
    //
    NSLog(@"%@", up);
    [up addTarget:self action:@selector(pressUp) forControlEvents:UIControlEventTouchUpInside];
    [right addTarget:self action:@selector(pressRight) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidUnload {
    self.model = nil;
    [super viewDidUnload];
}

- (void)dealloc {
    [self.model release];
    [super dealloc];
}

#pragma mark -

- (void)updateButtonPosition {
    [[NSUserDefaults standardUserDefaults] synchronize];
    int x, y;
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"up_x"];
    y = [[NSUserDefaults standardUserDefaults] integerForKey:@"up_y"];
    up.center = CGPointMake(x, y);
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"down_x"];
    y = [[NSUserDefaults standardUserDefaults] integerForKey:@"down_y"];
    down.center = CGPointMake(x, y);
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"left_x"];
    y = [[NSUserDefaults standardUserDefaults] integerForKey:@"left_y"];
    left.center = CGPointMake(x, y);
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"right_x"];
    y = [[NSUserDefaults standardUserDefaults] integerForKey:@"right_y"];
    right.center = CGPointMake(x, y);
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"clockwise_x"];
    y = [[NSUserDefaults standardUserDefaults] integerForKey:@"clockwise_y"];
    clockwise.center = CGPointMake(x, y);
    x = [[NSUserDefaults standardUserDefaults] integerForKey:@"counter_clockwise_x"];
    y = [[NSUserDefaults standardUserDefaults] integerForKey:@"counter_clockwise_y"];
    counter_clockwise.center = CGPointMake(x, y);
}

#pragma mark -
#pragma mark Orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark IBAction

- (IBAction)back {
    [model pause];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)pressUp {
    NSLog(@"up");
    [model upClick];
}

- (IBAction)pressDown {
    NSLog(@"down");
    [model downClick];
}

- (IBAction)pressLeft {
    NSLog(@"left");
    [model leftClick];
}

- (IBAction)pressRight {
    NSLog(@"right");
    [model rightClick];
}

- (IBAction)pressClockwise {
    NSLog(@"clockwise");
    [model rotate1Click];
}

- (IBAction)pressCounterClockwise {
}

- (IBAction)test {
    NSLog(@"test");
}

@end
