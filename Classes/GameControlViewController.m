    //
//  GameControlViewController.m
//  Tetris
//
//  Created by dm4 on 2011/1/29.
//  Copyright 2011 Meng-Han Lee (dm4). All rights reserved.
//

#import "GameControlViewController.h"
#import "ArrowButton.h"

#define UP_BUTTON_TAG                   10
#define DOWN_BUTTON_TAG                 11
#define LEFT_BUTTON_TAG                 12
#define RIGHT_BUTTON_TAG                13
#define CLOCKWISE_BUTTON_TAG            14
#define COUNTER_CLOCKWISE_BUTTON_TAG    15

@implementation GameControlViewController

#pragma mark -
#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // add gesture
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    panGR.delegate = self;
    [self.view addGestureRecognizer:panGR];
    [panGR release];
    // adjust button position
    [self updateButtonPosition];
}

- (void)viewDidUnload {
    // remove gestures
    for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:recognizer];
    }
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark -

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    if ([recognizer state] == UIGestureRecognizerStateBegan || [recognizer state] == UIGestureRecognizerStateChanged) {
        CGPoint newCenter = [recognizer locationInView:self.view];
        recentMoveButton.center = newCenter;
        switch (recentMoveButton.tag) {
            case UP_BUTTON_TAG:
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.x forKey:@"up_x"];
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.y forKey:@"up_y"];
                break;
            case DOWN_BUTTON_TAG:
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.x forKey:@"down_x"];
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.y forKey:@"down_y"];
                break;
            case LEFT_BUTTON_TAG:
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.x forKey:@"left_x"];
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.y forKey:@"left_y"];
                break;
            case RIGHT_BUTTON_TAG:
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.x forKey:@"right_x"];
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.y forKey:@"right_y"];
                break;
            case CLOCKWISE_BUTTON_TAG:
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.x forKey:@"clockwise_x"];
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.y forKey:@"clockwise_y"];
                break;
            case COUNTER_CLOCKWISE_BUTTON_TAG:
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.x forKey:@"counter_clockwise_x"];
                [[NSUserDefaults standardUserDefaults] setFloat:newCenter.y forKey:@"counter_clockwise_y"];
                break;
            default:
                break;
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)updateButtonPosition {
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)reset {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"up_x"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"up_y"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"down_x"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"down_y"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"left_x"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"left_y"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"right_x"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"right_y"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"clockwise_x"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"clockwise_y"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"counter_clockwise_x"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"counter_clockwise_y"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self updateButtonPosition];
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[ArrowButton class]]) {
        recentMoveButton = (ArrowButton *)touch.view;
        return YES;
    }
    return NO;
}




@end
