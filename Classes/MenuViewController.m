//
//  MenuViewController.m
//  Tetris
//
//  Created by dm4 on 2011/1/27.
//  Copyright 2011 Meng-Han Lee, dm4. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"
#import "OptionViewController.h"


@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark -
#pragma mark IBAction

- (IBAction)start:(id)sender {
    GameViewController *gameVC = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
    [self.navigationController pushViewController:gameVC animated:YES];
    [gameVC release];
}

- (IBAction)highscore:(id)sender {
}

- (IBAction)option:(id)sender {
    OptionViewController *optionVC = [[OptionViewController alloc] initWithNibName:@"OptionViewController" bundle:nil];
    [self.navigationController pushViewController:optionVC animated:YES];
    [optionVC release];
}

- (IBAction)test:(id)sender {
    NSLog(@"hi");
}

#pragma mark -

- (void)dealloc {
    [super dealloc];
}


@end
