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
#import "NextView.h"

@implementation GameViewController

@synthesize model;

#pragma mark -
#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateButtonPosition];
    
    // 
    pauseView.alpha = 0.0;
    
    //bind view & model
    FieldModel *newModel = [[FieldModel alloc] init];
	newModel.fieldView = fieldView;
    newModel.nextView = nextView;
	fieldView.model = newModel;
    nextView.model = newModel;
    [newModel addObserver:self forKeyPath:@"isDead" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    self.model = newModel;
    [newModel release];
    
    // add long press gesture
    UILongPressGestureRecognizer *downLongPressGR;
    downLongPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleDownLongPress)];
    downLongPressGR.cancelsTouchesInView = NO;
    downLongPressGR.minimumPressDuration = [[NSUserDefaults standardUserDefaults] floatForKey:@"repeat"];
    [down addGestureRecognizer:downLongPressGR];
    [downLongPressGR release];
    UILongPressGestureRecognizer *leftLongPressGR;
    leftLongPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftLongPress)];
    leftLongPressGR.cancelsTouchesInView = NO;
    leftLongPressGR.minimumPressDuration = [[NSUserDefaults standardUserDefaults] floatForKey:@"repeat"];
    [left addGestureRecognizer:leftLongPressGR];
    [leftLongPressGR release];
    UILongPressGestureRecognizer *rightLongPressGR;
    rightLongPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightLongPress)];
    rightLongPressGR.cancelsTouchesInView = NO;
    rightLongPressGR.minimumPressDuration = [[NSUserDefaults standardUserDefaults] floatForKey:@"repeat"];
    [right addGestureRecognizer:rightLongPressGR];
    [rightLongPressGR release];
    
    // add double tap gesture
    UITapGestureRecognizer *doubleTapGR;
    doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapFrom:)];
    doubleTapGR.numberOfTapsRequired = 2;
    doubleTapGR.delegate = self;
    [self.view addGestureRecognizer:doubleTapGR];
    [doubleTapGR release];
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

- (void)pauseModel {
    [model pause];
    if (model.isPause) {
        [UIView transitionWithView:pauseView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromLeft
                        animations:^{ pauseView.alpha = 1.0; }
                        completion:nil];
    }
    else if (!model.isPause) {
        [UIView transitionWithView:pauseView
                          duration:0.5
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{ pauseView.alpha = 0.0; }
                        completion:nil];
    }
}

#pragma mark -
#pragma mark UIGestureRecognizer Handler

- (void)handleDoubleTapFrom:(UITapGestureRecognizer *)recognizer {
    [self pauseModel];
}

- (void)handleDownLongPress {
    [model downLongPress];
}

- (void)handleLeftLongPress {
    [model leftLongPress];
}

- (void)handleRightLongPress {
    [model rightLongPress];
}

#pragma mark -
#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]] && [touch.view isKindOfClass:[ArrowButton class]]) {
        return NO;
    }
    return YES;
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
    [model up];
}

- (IBAction)pressDown {
    [model down];
}

- (IBAction)pressLeft {
    [model left];
}

- (IBAction)pressRight {
    [model right];
}

- (IBAction)pressClockwise {
    [model clockwise];
}

- (IBAction)pressCounterClockwise {
    [model counter_clockwise];
}

- (IBAction)pressResume {
    [self pauseModel];
}

- (IBAction)test {
    NSLog(@"test");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"obs %@, %@", keyPath, change);
    if ([keyPath isEqualToString:@"isDead"]) {
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

@end
